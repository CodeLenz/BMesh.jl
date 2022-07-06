@testset "bmesh_truss_3d" begin


    # Create mesh 
    Lx = 1.0
    Ly = 1.0
    Lz = 1.0
    nx = 2
    ny = 3
    nz = 4

    # Default origin
    bm1 = Bmesh_truss_3D(Lx,nx,Ly,ny,Lz,nz)

    @test isa(bm1,Bmesh3D)

    @test bm1.coord[1,1]==0.0
    @test bm1.coord[1,2]==0.0
    @test bm1.coord[1,3]==0.0
    

    @test bm1.coord[end,1]==Lx
    @test bm1.coord[end,2]==Ly
    @test bm1.coord[end,3]==Lz
    
    
    # Origin
    origin = (1.0,1.0,1.0)
    
    bm1 = Bmesh_truss_3D(Lx,nx,Ly,ny,Lz,nz, origin=origin)

    @test isa(bm1,Bmesh3D)

    @test bm1.coord[1,1] == origin[1]
    @test bm1.coord[1,2] == origin[2]
    @test bm1.coord[1,3] == origin[3]

    @test isapprox(bm1.coord[end,1] , Lx + origin[1])
    @test isapprox(bm1.coord[end,2] , Ly + origin[2])
    @test isapprox(bm1.coord[end,3] , Lz + origin[3])


        #
        # Test assertions
        #
         
        #@assert Lx>0 "Bmesh_truss_3D:: Lx must be > 0"
        #@assert Ly>0 "Bmesh_truss_3D:: Ly must be > 0"
        #@assert Lz>0 "Bmesh_truss_3D:: Lz must be > 0"
        #@assert nx>=1 "Bmesh_truss_3D:: nx must be >= 1"
        #@assert ny>=1 "Bmesh_truss_3D:: ny must be >= 1"
        #@assert nz>=1 "Bmesh_truss_3D:: nz must be >= 1"

        @test_throws AssertionError Bmesh_truss_3D(0.0,nx,Ly,ny,Lz,nz)
        @test_throws AssertionError Bmesh_truss_3D(-1.0,nx,Ly,ny,Lz,nz)
    
        @test_throws AssertionError Bmesh_truss_3D(Lx,0,Ly,ny,Lz,nz)
        @test_throws AssertionError Bmesh_truss_3D(Lx,-1,Ly,ny,Lz,nz)
    
        @test_throws AssertionError Bmesh_truss_3D(Lx,nx,0.0,ny,Lz,nz)
        @test_throws AssertionError Bmesh_truss_3D(Lx,nx,-1.0,ny,Lz,nz)
     
        @test_throws AssertionError Bmesh_truss_3D(Lx,nx,Ly,0,Lz,nz)
        @test_throws AssertionError Bmesh_truss_3D(Lx,nx,Ly,-1,Lz,nz)
     
        @test_throws AssertionError Bmesh_truss_3D(Lx,nx,Ly,ny,0.0,nz)
        @test_throws AssertionError Bmesh_truss_3D(Lx,nx,Ly,ny,-1.0,nz)

        @test_throws AssertionError Bmesh_truss_3D(Lx,nx,Ly,ny,Lz,0)
        @test_throws AssertionError Bmesh_truss_3D(Lx,nx,Ly,ny,Lz,-1)
     
    
end
