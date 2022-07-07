@testset "Test util" begin


            # Test 1 - Find node
Lx = 1.0
Ly = 1.0
nx = 50
ny = 50
b1 = Bmesh_solid_2D(Lx,nx,Ly,ny)

# Find node close to (0.0,0.0)
node = Find_node(b1,0.0,0.0)
@test node==1

@isinferred Find_node(b1,0.0,0.0)

# Find node close to (1.0,1.0)
node = Find_node(b1,1.0,1.0)
@test node==(nx+1)*(ny+1)


            #  Test 2 - Find nodes in rectangle
            #             All node


#atol = max(Lx/(nx+1)/10, Ly/(ny+1)/10)
#@show atol
nodes = Find_nodes_in_rectangle(b1,0.0,0.0,Lx,Ly)
@test length(nodes)==b1.nn
@test all(nodes.==collect(1:b1.nn))


            #  Test 3 - Find nodes in square
            #             Bottom line 


 #           atol = max(Lx/(nx+1)/10, Ly/(ny+1)/10)
 #           @show atol
 nodes = Find_nodes_in_rectangle(b1,0.0,0.0,Lx,Ly/(ny)/2)
 @test length(nodes)==nx+1
 @test all(nodes.==collect(1:nx+1))

 
            # Test 4 - Find node 3D

Lx = 1.0
Ly = 1.0
Lz = 1.0
nx = 50
ny = 70
nz = 2
b3 = Bmesh_solid_3D(Lx,nx,Ly,ny,Lz,nz)
            
# Find node close to (0.0,0.0,0.0)
node = Find_node(b3,0.0,0.0,0.0)
@test node==1

@isinferred Find_node(b3,0.0,0.0,0.0)

# Find node close to (1.0,1.0,1.0)
node = Find_node(b3,1.0,1.0,1.0)
@test node==(nx+1)*(ny+1)*(nz+1)


            #  Test 5 - Find nodes in box
            #           All


 nodes = Find_nodes_in_box(b3,0.0,0.0,0.0,Lx,Ly,Lz)
 @test length(nodes)==b3.nn
 @test all(nodes.==collect(1:b3.nn))



     #  Test 6 - Find nodes in box
     #           lower plane


nodes = Find_nodes_in_box(b3,0.0,0.0,0.0,Lx,Ly,Lz/(nz)/2)
@test length(nodes) == (nx+1)*(ny+1)
@test all(nodes.==collect(1: (nx+1)*(ny+1)))
           
           
      
   #                               ASSERTIONS 

   # x2<x1
   @test_throws AssertionError  Find_nodes_in_rectangle(b1,1.0,0.0,0.0,1.0)

   # y2<y1
   @test_throws AssertionError  Find_nodes_in_rectangle(b1,0.0,1.0,1.0,0.0)


   # x2<x1
   @test_throws AssertionError  Find_nodes_in_box(b3,1.0,0.0,0.0,0.0,1.0,0.0)

   # y2<y1
   @test_throws AssertionError  Find_nodes_in_box(b3,0.0,1.0,0.0,1.0,0.0,0.0)

   # z2<z1
   @test_throws AssertionError  Find_nodes_in_box(b3,0.0,0.0,1.0,1.0,1.0,0.0)


end


