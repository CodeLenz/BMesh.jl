@testset "Base::truss3D" begin

    #                               3D 

    #
    #    Valid inputs (no error)
    #             Cross
    #
    nn = 8
    ne = 18
    
    # Two planes (z=0) and (z=1)
    # with four nodes
    coord = [0.0 0.0 0.0;
             1.0 0.0 0.0;
             1.0 1.0 0.0;
             0.0 1.0 0.0;
             0.0 0.0 1.0;
             1.0 0.0 1.0;
             1.0 1.0 1.0;
             0.0 1.0 1.0 ]
             

    # Incomplete "Cube" 
    # with cross in z=0 (xy) -> elements 1:6
    connect = [1 2 ;
               2 3 ;
               3 4 ;
               4 1 ; # end of square in z=0
               1 3 ;
               4 2 ; # end of plane Z=0 (with / and \)
               5 6 ;
               6 7 ;
               7 8 ;
               8 5 ; # end of plane z=1 (no cross)
               2 7 ;
               3 6 ; # cross in x=1, plane ZY
               1 5 ; # vertical (z) bars
               2 6 ;
               3 7 ;
               4 8 ;
               2 8 ; # 3D diagonal
               1 7 ] # 3D diagonal
    Lx = 1.0
    Ly = 1.0
    Lz = 1.0
    nx = 1
    ny = 1
    nz = 1
    etype = :truss3D

    # truss3D
    b3 = Bmesh3D(etype,nn,ne,coord,connect,Lx,Ly,Lz,nx,ny,nz)

    #
    # Conect
    #
    # Should throw
    @test_throws String Conect(b3,20) 
    @test_throws String Conect(b3,-1) 
    
    for i=1:ne
        @test all(Conect(b3,i).==connect[i,:])
    end

    # Check type stability
    @isinferred Conect(b3,1)
    
    #
    # Coord
    #

    # Should throw 
    @test_throws String Coord(b3,10) 
    @test_throws String Coord(b3,-1) 

    for i=1:nn
        @test all(Coord(b3,i).==vec(coord[i,:]))
    end

    # Check type stability
    @isinferred Coord(b3,1)    
        
    #
    # Length
    #

    # Should throw (by calling Conect)
    @test_throws String Length(b3,20)
    @test_throws String Length(b3,-1)

    @test Length(b3,1)==1.0
    @test Length(b3,2)==1.0
    @test Length(b3,3)==1.0
    @test Length(b3,4)==1.0
    @test Length(b3,5) ≈ sqrt(2.0)
    @test Length(b3,6) ≈ sqrt(2.0)
    @test Length(b3,7)==1.0
    @test Length(b3,8)==1.0
    @test Length(b3,9)==1.0
    @test Length(b3,10)==1.0
    @test Length(b3,11) ≈ sqrt(2.0)
    @test Length(b3,12) ≈ sqrt(2.0)
    @test Length(b3,13)==1.0
    @test Length(b3,14)==1.0
    @test Length(b3,15)==1.0
    @test Length(b3,16)==1.0
    @test Length(b3,17) ≈ sqrt(3.0)
    @test Length(b3,18) ≈ sqrt(3.0)
    
    # Check type stability
    @isinferred Length(b3,1)
    
    
    #
    # DOFs(bmesh::Bmesh2D,ele::Int64)
    #
    # Should throw (by calling Conect)
    @test_throws String DOFs(b3,20)
    @test_throws String DOFs(b3,-1)

    # Plane (z=0)
    @test all(DOFs(b3,1) .== [1;2;3;4;5;6])
    @test all(DOFs(b3,2) .== [4;5;6;7;8;9])
    @test all(DOFs(b3,3) .== [7;8;9;10;11;12])
    @test all(DOFs(b3,4) .== [10;11;12;1;2;3])
    @test all(DOFs(b3,5) .== [1;2;3;7;8;9])
    @test all(DOFs(b3,6) .== [10;11;12;4;5;6])

    @test all(DOFs(b3,18) .== [1;2;3;19;20;21])
    
    # Check type stability
    @isinferred DOFs(b3,1)
    
end
