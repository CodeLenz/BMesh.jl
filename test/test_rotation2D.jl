@testset "Rotation2D" begin

    
    # truss2D 0 degrees
    b2 = Bmesh_truss_2D(1.0,1,1.0,1)

    # First element is at zero degrees
    refer = 1.0*I(4)

    # Direct
    @test all(T_matrix(b2,1).≈ refer)

    @test_nowarn @report_opt target_modules=(@__MODULE__,) T_matrix(b2,1)

    # Using r and T_matrix
    r = Rotation2D(b2,1)
    @test r.cos_xx ≈ 1.0
    @test r.cos_yx ≈ 0.0
    @test r.cos_xy ≈ 0.0
    @test r.cos_yy ≈ 1.0
    @test all(T_matrix(r).≈ refer)
    @test_nowarn @report_opt target_modules=(@__MODULE__,) Rotation2D(b2,1)

    # Third element is at 90 degrees
    refer = [0.0 1.0  0.0 0.0 ;
            -1.0 0.0  0.0 0.0 ;
             0.0 0.0  0.0 1.0 ;
             0.0 0.0 -1.0 0.0  ]

    # Direct
    @test all(isapprox(T_matrix(b2,3),refer;atol=1E-12))
    @test_nowarn @report_opt target_modules=(@__MODULE__,) T_matrix(b2,3)

    # Using r and T_matrix
    r = Rotation2D(b2,3)
    @test isapprox(r.cos_xx,0.0;atol=1E-12)
    @test isapprox(r.cos_yx,-1.0;atol=1E-12)
    @test isapprox(r.cos_xy,1.0;atol=1E-12)
    @test isapprox(r.cos_yy,0.0;atol=1E-12)
    @test all(isapprox(T_matrix(r),refer;atol=1E-12))
    @test_nowarn @report_opt target_modules=(@__MODULE__,) Rotation2D(b2,3)


    # Fifth  element is at 45 degrees
    c45 = cosd(45)
    s45 = sind(45)
    refer = [ c45 s45  0.0 0.0 ;
             -s45 c45  0.0 0.0 ;
              0.0 0.0  c45 s45 ;
              0.0 0.0 -s45 c45  ]

    # Direct
    @test all(T_matrix(b2,5).≈ refer )

    r = Rotation2D(b2,5)
    @test isapprox(r.cos_xx,c45;atol=1E-12)
    @test isapprox(r.cos_yx,-s45;atol=1E-12)
    @test isapprox(r.cos_xy,s45;atol=1E-12)
    @test isapprox(r.cos_yy,c45;atol=1E-12)
    @test all(isapprox(T_matrix(r),refer;atol=1E-12))


    # Sixth  element is at 135 degrees
    c135 = cosd(135)
    s135 = sind(135)
    refer = [ c135 s135   0.0 0.0 ;
             -s135 c135   0.0 0.0 ;
                0.0 0.0  c135 s135 ;
                0.0 0.0 -s135 c135  ]

    # Direct
    @test all(T_matrix(b2,6).≈ refer )

    r = Rotation2D(b2,6)
    @test isapprox(r.cos_xx,c135;atol=1E-12)
    @test isapprox(r.cos_yx,-s135;atol=1E-12)
    @test isapprox(r.cos_xy,s135;atol=1E-12)
    @test isapprox(r.cos_yy,c135;atol=1E-12)
    @test all(isapprox(T_matrix(r),refer;atol=1E-12))


    # Set one element to 180 degrees
    nn = 2
    ne = 1
    coord = [0.0 0.0 ;
             1.0 0.0 ]
             
    connect = [2 1]
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1
    etype = :truss2D

    # truss2D
    b2_inv = Bmesh2D(etype,nn,ne,coord,connect,Lx,Ly,nx,ny)

    # 180 degrees
    c180 = cosd(180)
    s180 = sind(180)
    refer = [ c180 s180  0.0 0.0 ;
             -s180 c180  0.0 0.0 ;
              0.0 0.0  c180 s180 ;
              0.0 0.0 -s180 c180  ]

    # Direct
    @test all(isapprox.(T_matrix(b2_inv,1),refer;atol=1E-12))

    r = Rotation2D(b2_inv,1)
    @test isapprox(r.cos_xx,c180;atol=1E-12)
    @test isapprox(r.cos_yx,-s180;atol=1E-12)
    @test isapprox(r.cos_xy,s180;atol=1E-12)
    @test isapprox(r.cos_yy,c180;atol=1E-12)
    @test all(isapprox(T_matrix(r),refer;atol=1E-12))


    # Set one element to -90

    nn = 2
    ne = 1
    coord = [0.0 0.0 ;
             0.0 1.0 ]
             
    connect = [2 1]
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1
    etype = :truss2D

    # truss2D
    b2_m90 = Bmesh2D(etype,nn,ne,coord,connect,Lx,Ly,nx,ny)

    # -90 degrees
    cm90 = cosd(-90)
    sm90 = sind(-90)
    refer = [ cm90 sm90  0.0 0.0 ;
             -sm90 cm90  0.0 0.0 ;
              0.0 0.0  cm90 sm90 ;
              0.0 0.0 -sm90 cm90  ]

    # Direct
    @test all(isapprox.(T_matrix(b2_m90,1),refer;atol=1E-12))

    r = Rotation2D(b2_m90,1)
    @test isapprox(r.cos_xx,cm90;atol=1E-12)
    @test isapprox(r.cos_yx,-sm90;atol=1E-12)
    @test isapprox(r.cos_xy,sm90;atol=1E-12)
    @test isapprox(r.cos_yy,cm90;atol=1E-12)
    @test all(isapprox(T_matrix(r),refer;atol=1E-12))


    # Set one element to -45

    nn = 2
    ne = 1
    coord = [0.0 1.0 ;
             1.0 0.0 ]
             
    connect = [1 2]
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1
    etype = :truss2D

    # truss2D
    b2_m45 = Bmesh2D(etype,nn,ne,coord,connect,Lx,Ly,nx,ny)

    # -45 degrees
    cm45 = cosd(-45)
    sm45 = sind(-45)
    refer = [ cm45 sm45  0.0 0.0 ;
             -sm45 cm45  0.0 0.0 ;
              0.0 0.0  cm45 sm45 ;
              0.0 0.0 -sm45 cm45  ]

    # Direct
    @test all(isapprox.(T_matrix(b2_m45,1),refer;atol=1E-12))

    r = Rotation2D(b2_m45,1)
    @test isapprox(r.cos_xx,cm45;atol=1E-12)
    @test isapprox(r.cos_yx,-sm45;atol=1E-12)
    @test isapprox(r.cos_xy,sm45;atol=1E-12)
    @test isapprox(r.cos_yy,cm45;atol=1E-12)
    @test all(isapprox(T_matrix(r),refer;atol=1E-12))


    # Final test, if Rotations is dispatching the proper method
    r = Rotations(b2_m45,1)
    @test isa(r,Rotation2D)

    
    # Test for L==0
    b2 = Bmesh_truss_2D(1.0,1,1.0,1)
    b2.coord[2,1] = 0.0
    @test_throws String Rotations(b2,1)
    
    
end # Rotation2D
