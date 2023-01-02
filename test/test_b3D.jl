@testset "Bmesh3D" begin

    #
    #    Valid inputs (no error)
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

    # truss3D
    @test isa(Bmesh3D(etype,nn,ne,coord,connect,Lx,Ly,Lz,nx,ny,nz),Bmesh3D)
    @test_nowarn @report_opt target_modules=(@__MODULE__,) Bmesh3D(etype,nn,ne,coord,connect,Lx,Ly,Lz,nx,ny,nz)

    # Solid 3D
    @test isa(Bmesh3D(:solid3D,nn,ne,coord,connect,Lx,Ly,Lz,nx,ny,nz),Bmesh3D)
    @test_nowarn @report_opt target_modules=(@__MODULE__,) Bmesh3D(:solid3D,nn,ne,coord,connect,Lx,Ly,Lz,nx,ny,nz)

    #
    # Should throw assertion error 
    # @assert size(coord,1)==nn "Bmesh3D:: number of rows in coord must be equal to the number of nodes
    # 
    @test_throws AssertionError Bmesh3D(etype,10,ne,coord,connect,Lx,Ly,Lz,nx,ny,nz)

    #
    # Should throw assertion error 
    # @assert size(coord,2)==3 "Bmesh3D:: number of columns in coord must be equal to 3"
    #
    wcoord = [0.0 0.0 ; 1.0 0.0]
    @test_throws AssertionError Bmesh3D(etype,nn,ne,wcoord,connect,Lx,Ly,Lz,nx,ny,nz)

    #
    # Should throw assertion error 
    # @assert size(connect,1)==ne "Bmesh3D:: number of rows in connect must be equal to the number of elements"
    wconnect = [1 2 ; 3 4]
    @test_throws AssertionError Bmesh3D(etype,nn,ne,coord,wconnect,Lx,Ly,Lz,nx,ny,nz)

    #
    # Should throw assertion error 
    # @assert etype==:truss3D "Bmesh3D:: wrong element type
    @test_throws AssertionError Bmesh3D(:other,nn,ne,coord,connect,Lx,Ly,Lz,nx,ny,nz)

end # Bmesh3D


