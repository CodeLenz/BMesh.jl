@testset "Rotation3D" begin

    #
    #                          Single element - x //  X
    #
    nn = 2
    ne = 1
    coord = [0.0 0.0 0.0;
             1.0 0.0 0.0]
             
    connect = [1 2]
    Lx = 1.0
    Ly = 1.0
    Lz = 1.0
    nx = 1
    ny = 1
    nz = 1
    etype = :truss3D

    # truss2D
    b3 = Bmesh3D(etype,nn,ne,coord,connect,Lx,Ly,Lz,nx,ny,nz)

    # First element is at zero degrees
    refer = 1.0*I(6)

    # Direct
    @test all(T_matrix(b3,1).≈ refer)

    r = Rotation3D(b3,1)
    @test isapprox(r.cos_xx,1.0,atol=1E-12)
    @test isapprox(r.cos_yx,0.0,atol=1E-12)
    @test isapprox(r.cos_zx,0.0,atol=1E-12)
    @test isapprox(r.fe,1.0,atol=1E-12)
    @test isapprox(r.cos_xy,0.0,atol=1E-12)
    @test isapprox(r.cos_yy,1.0,atol=1E-12)
    @test isapprox(r.cos_zy,0.0,atol=1E-12)
    @test isapprox(r.cos_xz,0.0,atol=1E-12)
    @test isapprox(r.cos_yz,0.0,atol=1E-12)
    @test isapprox(r.cos_zz,1.0,atol=1E-12)
    
    #  Indirect
    @test all(T_matrix(r).≈ refer)

    #
    #                          Single element - x // -X
    #                        Equivalent to rotate around Y in 180 degress
    #                                 Flipping both X and Z
    #
    nn = 2
    ne = 1
    coord = [0.0 0.0 0.0;
            -1.0 0.0 0.0]
             
    connect = [1 2]
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1
    etype = :truss3D

    # truss2D
    b3 = Bmesh3D(etype,nn,ne,coord,connect,Lx,Ly,Lz,nx,ny,nz)

    # Expected result
    refer = [-1.0 0.0  0.0   0.0  0.0  0.0;
              0.0 1.0  0.0   0.0  0.0  0.0;
              0.0 0.0 -1.0   0.0  0.0  0.0;
              0.0 0.0  0.0  -1.0  0.0  0.0;
              0.0 0.0  0.0   0.0  1.0  0.0;
              0.0 0.0  0.0   0.0  0.0 -1.0]
    # Direct
    @test all(T_matrix(b3,1).≈ refer)

    r = Rotation3D(b3,1)
    @test isapprox(r.cos_xx,-1.0,atol=1E-12)
    @test isapprox(r.cos_yx,0.0,atol=1E-12)
    @test isapprox(r.cos_zx,0.0,atol=1E-12)
    @test isapprox(r.fe,1.0,atol=1E-12)
    @test isapprox(r.cos_xy,0.0,atol=1E-12)
    @test isapprox(r.cos_yy,1.0,atol=1E-12)
    @test isapprox(r.cos_zy,0.0,atol=1E-12)
    @test isapprox(r.cos_xz,0.0,atol=1E-12)
    @test isapprox(r.cos_yz,0.0,atol=1E-12)
    @test isapprox(r.cos_zz,-1.0,atol=1E-12)
    
    #  Indirect
    @test all(T_matrix(r).≈ refer)


    #
    #                          Particular case - x//Y
    #                   This corresponds to Flip:
    #                            Y->x
    #                           -X->y
    #                            Z->z 
    #
    #
    #
    nn = 2
    ne = 1
    coord = [0.0 0.0 0.0;
             0.0 1.0 0.0]
             
    connect = [1 2]
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1
    etype = :truss3D

    # truss2D
    b3 = Bmesh3D(etype,nn,ne,coord,connect,Lx,Ly,Lz,nx,ny,nz)

    # Expected result
    refer = [ 0.0 1.0  0.0   0.0  0.0  0.0;
             -1.0 0.0  0.0   0.0  0.0  0.0;
              0.0 0.0  1.0   0.0  0.0  0.0;
              0.0 0.0  0.0   0.0  1.0  0.0;
              0.0 0.0  0.0  -1.0  0.0  0.0;
              0.0 0.0  0.0   0.0  0.0  1.0]
    # Direct
    @test all(T_matrix(b3,1).≈ refer)

    r = Rotation3D(b3,1)
    @test isapprox(r.cos_xx,0.0,atol=1E-12)
    @test isapprox(r.cos_yx,1.0,atol=1E-12)
    @test isapprox(r.cos_zx,0.0,atol=1E-12)
    @test isapprox(r.fe,0.0,atol=1E-12)
    @test isapprox(r.cos_xy,-1.0,atol=1E-12)
    @test isapprox(r.cos_yy,0.0,atol=1E-12)
    @test isapprox(r.cos_zy,0.0,atol=1E-12)
    @test isapprox(r.cos_xz,0.0,atol=1E-12)
    @test isapprox(r.cos_yz,0.0,atol=1E-12)
    @test isapprox(r.cos_zz,0.0,atol=1E-12)
    
    #  Indirect
    @test all(T_matrix(r).≈ refer)

    #
    #                          Particular case - x//-Y
    #                   This corresponds to Flip:
    #                           -Y->x
    #                            X->y
    #                            Z->z 
    #
    #
    #
    nn = 2
    ne = 1
    coord = [0.0  0.0 0.0;
             0.0 -1.0 0.0]
             
    connect = [1 2]
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1
    etype = :truss3D

    # truss2D
    b3 = Bmesh3D(etype,nn,ne,coord,connect,Lx,Ly,Lz,nx,ny,nz)

    # Expected result
    refer = [ 0.0 -1.0  0.0   0.0  0.0  0.0;
              1.0  0.0  0.0   0.0  0.0  0.0;
              0.0  0.0  1.0   0.0  0.0  0.0;
              0.0  0.0  0.0   0.0 -1.0  0.0;
              0.0  0.0  0.0   1.0  0.0  0.0;
              0.0  0.0  0.0   0.0  0.0  1.0]

    # Direct
    @test all(isapprox(T_matrix(b3,1),refer;atol=1E-12))

    r = Rotation3D(b3,1)
    @test isapprox(r.cos_xx,0.0,atol=1E-12)
    @test isapprox(r.cos_yx,-1.0,atol=1E-12)
    @test isapprox(r.cos_zx,0.0,atol=1E-12)
    @test isapprox(r.fe,0.0,atol=1E-12)
    @test isapprox(r.cos_xy,1.0,atol=1E-12)
    @test isapprox(r.cos_yy,0.0,atol=1E-12)
    @test isapprox(r.cos_zy,0.0,atol=1E-12)
    @test isapprox(r.cos_xz,0.0,atol=1E-12)
    @test isapprox(r.cos_yz,0.0,atol=1E-12)
    @test isapprox(r.cos_zz,0.0,atol=1E-12)
    
    #  Indirect
    @test all(T_matrix(r).≈ refer)

    #
    #                          Single element - x // Z
    #                             Z -> x
    #                            -X -> z
    nn = 2
    ne = 1
    coord = [0.0 0.0 0.0;
             0.0 0.0 1.0]
             
    connect = [1 2]
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1
    etype = :truss3D

    # truss2D
    b3 = Bmesh3D(etype,nn,ne,coord,connect,Lx,Ly,Lz,nx,ny,nz)

    # Expected result
    refer = [ 0.0 0.0  1.0   0.0  0.0  0.0;
              0.0 1.0  0.0   0.0  0.0  0.0;
             -1.0 0.0  0.0   0.0  0.0  0.0;
              0.0 0.0  0.0   0.0  0.0  1.0;
              0.0 0.0  0.0   0.0  1.0  0.0;
              0.0 0.0  0.0  -1.0  0.0  0.0]
    # Direct
    @test all(T_matrix(b3,1).≈ refer)

    r = Rotation3D(b3,1)
    @test isapprox(r.cos_xx,0.0,atol=1E-12)
    @test isapprox(r.cos_yx,0.0,atol=1E-12)
    @test isapprox(r.cos_zx,1.0,atol=1E-12)
    @test isapprox(r.fe,1.0,atol=1E-12)
    @test isapprox(r.cos_xy,0.0,atol=1E-12)
    @test isapprox(r.cos_yy,1.0,atol=1E-12)
    @test isapprox(r.cos_zy,0.0,atol=1E-12)
    @test isapprox(r.cos_xz,-1.0,atol=1E-12)
    @test isapprox(r.cos_yz,0.0,atol=1E-12)
    @test isapprox(r.cos_zz,0.0,atol=1E-12)
    
    #  Indirect
    @test all(T_matrix(r).≈ refer)


    #
    #                          Single element - x // -Z
    #                            -Z -> x
    #                             X -> z
    nn = 2
    ne = 1
    coord = [0.0 0.0  0.0;
             0.0 0.0 -1.0]
             
    connect = [1 2]
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1
    etype = :truss3D

    # truss2D
    b3 = Bmesh3D(etype,nn,ne,coord,connect,Lx,Ly,Lz,nx,ny,nz)

    # Expected result
    refer = [ 0.0 0.0 -1.0   0.0  0.0  0.0;
              0.0 1.0  0.0   0.0  0.0  0.0;
              1.0 0.0  0.0   0.0  0.0  0.0;
              0.0 0.0  0.0   0.0  0.0 -1.0;
              0.0 0.0  0.0   0.0  1.0  0.0;
              0.0 0.0  0.0   1.0  0.0  0.0]
    # Direct
    @test all(T_matrix(b3,1).≈ refer)

    r = Rotation3D(b3,1)
    @test isapprox(r.cos_xx,0.0,atol=1E-12)
    @test isapprox(r.cos_yx,0.0,atol=1E-12)
    @test isapprox(r.cos_zx,-1.0,atol=1E-12)
    @test isapprox(r.fe,1.0,atol=1E-12)
    @test isapprox(r.cos_xy,0.0,atol=1E-12)
    @test isapprox(r.cos_yy,1.0,atol=1E-12)
    @test isapprox(r.cos_zy,0.0,atol=1E-12)
    @test isapprox(r.cos_xz,1.0,atol=1E-12)
    @test isapprox(r.cos_yz,0.0,atol=1E-12)
    @test isapprox(r.cos_zz,0.0,atol=1E-12)
    
    #  Indirect
    @test all(T_matrix(r).≈ refer)


end # Rotation3D
