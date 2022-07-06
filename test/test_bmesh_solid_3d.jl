@testset "bmesh_solid_3d" begin


    # Create mesh 
    Lx = 1.0
    Ly = 1.0
    Lz = 1.0
    nx = 2
    ny = 3
    nz = 4

    # Default origin
    bm1 = Bmesh_solid_3D(Lx,nx,Ly,ny,Lz,nz)

    @test isa(bm1,BMesh3D)

    @test bm1.coord[1,1]==0.0
    @test bm1.coord[1,2]==0.0
    @test bm1.coord[1,3]==0.0
    
    @test bm1.coord[end,1]==Lx
    @test bm1.coord[end,2]==Ly
    @test bm1.coord[end,3]==Lz
    
    # Origin
    origin = (1.0,1.0,1.0)
    
    bm1 = Bmesh_solid_3D(Lx,nx,Ly,ny,Lz,nz, origin=origin)

    @test isa(bm1,BMesh3D)

    @test bm1.coord[1,1] == origin[1]
    @test bm1.coord[1,2] == origin[2]
    @test bm1.coord[1,3] == origin[3]

    @test bm1.coord[end,1] == Lx + origin[1]
    @test bm1.coord[end,2] == Ly + origin[2]
    @test bm1.coord[end,3] == Lz + origin[3]

end
