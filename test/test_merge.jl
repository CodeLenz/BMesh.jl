@testset "Test merge" begin


                               # Test 1 (solid2D)
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1

    #
    #  b1(3)   b1(4)
    #
    #  b1(1)   b1(2)
    #
    b1 = Bmesh_solid_2D(Lx,nx,Ly,ny)

    # offset para a direita
    #
    #        b2(3)   b2(4)
    #
    #        b2(1)   b2(2)
    #
    b2 = Bmesh_solid_2D(Lx,nx,Ly,ny,origin=(1.0,0.0))

    # Test merge
    #
    #   b1(3)   b1(4)b2(3)   b2(4)
    #
    #
    #   b1(1)   b1(2)b2(1)   b2(2)
    #
    # Então os nós vão ser
    #
    #  (3)   (4)   (6)
    #
    #  (1)   (2)   (5)
    #
    #
    @isinferred(Merge(b1,b2))
    @test_nowarn @report_opt target_modules=(@__MODULE__,) Merge(b1,b2)

    # Merge
    b = Merge(b1,b2)

    @test b.nn == 6
    @test b.ne == 2
    @test all(b.coord .== [0.0 0.0;
                            1.0 0.0;
                            0.0 1.0;
                            1.0 1.0;
                            2.0 0.0;
                            2.0 1.0])

    @test all(b.connect .== [1 2 4 3 ; 
                             2 5 6 4])



    #              Test 2 (truss 2D)
    #             There are some repeted elements
    #             deleted during merge
    #
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1

    #
    #  b1(3) -  b1(4)
    #    |   \/    |
    #  b1(1) - b1(2)
    #
    b1 = Bmesh_truss_2D(Lx,nx,Ly,ny)

    # offset para a direita
    #
    #        b2(3) -  b2(4)
    #          |   \/     |   
    #        b2(1) -  b2(2)
    #
    b2 = Bmesh_truss_2D(Lx,nx,Ly,ny,origin=(1.0,0.0))

    # Test merge
    #
    #   b1(3) -  b1(4)b2(3) -  b2(4)
    #     |   \/    |   \/     | 
    #     |         |          |
    #   b1(1) -  b1(2)b2(1) -  b2(2)
    #
    # Então os nós vão ser
    #
    #  (3)   (4)   (6)
    #
    #  (1)   (2)   (5)
    #
    # E os elementos entre os nós 2 e 4 são repetidos e devem
    # ser deletados
    #
    #
    b = Merge(b1,b2)

    @test b.nn == 6
    @test b.ne == 11

    @test all(b.coord .== [0.0 0.0;
    1.0 0.0;
    0.0 1.0;
    1.0 1.0;
    2.0 0.0;
    2.0 1.0])

    @test all(b.connect .==   [ 1 2 ;
                                3 4 ;
                                1 3 ;
                                2 4 ; 
                                1 4 ;
                                2 3 ;
                                2 5 ;
                                4 6 ;
                                5 6 ;
                                2 6 ;
                                5 4] )


    #            Test 3 (truss 2D)
    #           More complex merge (L shape) 
    #
                            
    # [=========]
    Lx = 10.0
    Ly = 1.0
    nx = 10
    ny = 1
    b1 = Bmesh_truss_2D(Lx,nx,Ly,ny)

    #
    # []
    # [] 
    # [] 
    #
    Lx = 1.0
    Ly = 10.0
    nx = 1
    ny = 10
    b2 = Bmesh_truss_2D(Lx,nx,Ly,ny,origin=(0.0,1.0))

    # Test merge
    @test isa(Merge(b1,b2),Bmesh2D)



    #            Test 4 (truss 3D)
    #           More complex merge (L shape) 
    #


    # [=========]
    Lx = 10.0
    Ly = 1.0
    Lz = 1.0
    nx = 10
    ny = 1
    nz = 1
    b1 = Bmesh_truss_3D(Lx,nx,Ly,ny,Lz,nz)

    
    #
    # []
    # [] 
    # [] 
    #
    Lx = 1.0
    Ly = 10.0
    Lz = 1.0
    nx = 1
    ny = 10
    nz = 1
    b2 = Bmesh_truss_3D(Lx,nx,Ly,ny,Lz,nz,origin=(0.0,1.0,0.0))

    # Test merge
    @test isa(Merge(b1,b2),Bmesh3D)
    @test_nowarn @report_opt target_modules=(@__MODULE__,) Merge(b1,b2)

    # 
    #            TEST ASSERTIONS
    #
    # 

    # Different Bmeshes
    b1 = Bmesh_truss_2D(1.0,1,1.0,1)
    b2 = Bmesh_truss_3D(1.0,1,1.0,1,1.0,1)
    @test_throws AssertionError  Merge(b1,b2)
    

    # Different etypes
    b1 = Bmesh_truss_2D(1.0,1,1.0,1)
    b2 = Bmesh_solid_2D(1.0,1,1.0,1)
    @test_throws AssertionError Merge(b1,b2)


    # No common nodes
    b1 = Bmesh_truss_2D(1.0,1,1.0,1)
    b2 = Bmesh_truss_2D(1.0,1,1.0,1,origin=(10.0,10.0))
    @test_throws String Merge(b1,b2)


end
