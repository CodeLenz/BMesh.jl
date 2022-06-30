@testset "Base::truss2D" begin

    #                               2D 

    #
    #    Valid inputs (no error)
    #             Cross
    #
    nn = 4
    ne = 6
    coord = [0.0 0.0 ;
             1.0 0.0 ;
             1.0 1.0 ;
             0.0 1.0 ]
             
    connect = [1 2 ;
               2 3 ;
               3 4 ;
               4 1 ;
               1 3 ;
               4 2 ]
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1
    etype = :truss2D

    # truss2D
    b2 = Bmesh2D(etype,nn,ne,coord,connect,Lx,Ly,nx,ny)

    #
    # Conect
    #
    # Should throw
    @test_throws String Conect(b2,7) 
    @test_throws String Conect(b2,-1) 
    
    for i=1:ne
        @test all(Conect(b2,i).==connect[i,:])
    end

    # Check type stability
    @isinferred Conect(b2,1)
    
    #
    # Coord
    #

    # Should throw 
    @test_throws String Coord(b2,5) 
    @test_throws String Coord(b2,-1) 

    for i=1:nn
        @test all(Coord(b2,i).==vec(coord[i,:]))
    end

    
    # Check type stability
    @isinferred  Coord(b2,1)
        
    #
    # Length
    #

    # Should throw (by calling Conect)
    @test_throws String Length(b2,7)
    @test_throws String Length(b2,-1)

    @test Length(b2,1)==1.0
    @test Length(b2,2)==1.0
    @test Length(b2,3)==1.0
    @test Length(b2,4)==1.0
    @test Length(b2,5) ≈ sqrt(2.0)
    @test Length(b2,6) ≈ sqrt(2.0)
    
    
    # Check type stability
    @isinferred  Length(b2,1)
        
    #
    # DOFs(bmesh::Bmesh2D,ele::Int64)
    #
    # Should throw (by calling Conect)
    @test_throws String DOFs(b2,7)
    @test_throws String DOFs(b2,-1)

    @test all(DOFs(b2,1) .== [1 ;2; 3; 4])
    @test all(DOFs(b2,2) .== [3 ;4; 5; 6])
    @test all(DOFs(b2,3) .== [5 ;6; 7; 8])
    @test all(DOFs(b2,4) .== [7 ;8; 1; 2])
    @test all(DOFs(b2,5) .== [1 ;2; 5; 6])
    @test all(DOFs(b2,6) .== [7 ;8; 3; 4])
    
    
    # Check type stability
    @isinferred  DOFs(b2,1)
        
end
