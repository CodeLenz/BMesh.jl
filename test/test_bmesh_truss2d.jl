@testset "bmesh_truss_2d" begin


    # Create mesh 
    Lx = 1.0
    Ly = 1.0
    nx = 2
    ny = 3

    # Default origin
    bm1 = Bmesh_truss_2D(Lx,nx,Ly,ny)

    @test isa(bm1,BMesh2D)

    @test bm1.coord[1,1]==0.0
    @test bm1.coord[1,2]==0.0

    @test bm1.coord[end,1]==Lx
    @test bm1.coord[end,2]==Ly
    
    # Origin
    origin = (1.0,1.0)
    
    bm1 = Bmesh_truss_2D(Lx,nx,Ly,ny, origin=origin)

    @test isa(bm1,BMesh2D)

    @test bm1.coord[1,1] == origin[1]
    @test bm1.coord[1,2] == origin[2]

    @test bm1.coord[end,1] == Lx + origin[1]
    @test bm1.coord[end,2] == Ly + origin[2]
    

    #
    # Test assertions
    #
    #@assert Lx>0 "Bmesh_truss_2D:: Lx must be > 0"
    #@assert Ly>0 "Bmesh_truss_2D:: Ly must be > 0"
    #@assert nx>=1 "Bmesh_truss_2D:: nx must be >= 1"
    #@assert ny>=1 "Bmesh_truss_2D:: ny must be >= 1"

    @test_throws AssertionError Bmesh_truss_2D(0.0,nx,Ly,ny)
    @test_throws AssertionError Bmesh_truss_2D(-1.0,nx,Ly,ny)

    @test_throws AssertionError Bmesh_truss_2D(Lx,0,Ly,ny)
    @test_throws AssertionError Bmesh_truss_2D(Lx,-1,Ly,ny)

    @test_throws AssertionError Bmesh_truss_2D(Lx,nx,0.0,ny)
    @test_throws AssertionError Bmesh_truss_2D(Lx,nx,-1.0,ny)

    @test_throws AssertionError Bmesh_truss_2D(Lx,nx,Ly,0)
    @test_throws AssertionError Bmesh_truss_2D(Lx,nx,Ly,-1)
    
end
