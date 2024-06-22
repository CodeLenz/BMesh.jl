@testset "Gmsh" begin


    # 2D background mesh in a 1 x 1  domain with 2 divisions in X and 3 in Y
    b2 = Bmesh_truss_2D(1.0,2,1.0,3)

    # Export
    Lgmsh_export_init("truss2D.pos",b2)

    # 3D background mesh in a 1 x 1 x 1 domain with 3 divisions in X, 2 in Y and 4 in Z
    b3 = Bmesh_truss_3D(1.0,3,1.0,2,1.0,4)

    # Export
    Lgmsh_export_init("truss3D.pos",b3)

    # 2D background mesh in a 1 x 1  solid domain with 10 divisions in X and 10 in Y
    bs4 = Bmesh_solid_2D(1.0,10,1.0,10)

    # Export
    Lgmsh_export_init("solid2D.pos",b4)

    # 3D background mesh in a 1 x 1 x 1 solid domain with 10 divisions in each direction
    bs5 = Bmesh_solid_3D(1.0,10,1.0,10,1.0,10)

    # Export
    Lgmsh_export_init("solid3D.pos",b5)

end