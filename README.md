
# BMesh
Background mesh and utilities for topology optimization

https://codelenz.github.io/BMesh.jl/

```julia
using BMesh

# 2D background mesh in a 1 x 1  domain with 2 divisions in X and 3 in Y
b2 = Bmesh_truss_2D(1.0,2,1.0,3)

# 3D background mesh in a 1 x 1 x 1 domain with 3 divisions in X, 2 in Y and 4 in Z
b3 = Bmesh_truss_3D(1.0,3,1.0,2,1.0,4)

# 2D background mesh in a 1 x 1  solid domain with 10 divisions in X and 10 in Y
bs2 = Bmesh_solid_2D(1.0,10,1.0,10)

# 3D background mesh in a 1 x 1 x 1 solid domain with 10 divisions in each direction
bs3 = Bmesh_solid_3D(1.0,10,1.0,10,1.0,10)

# Export mesh to gmsh for visualization
# 
Lgmsh_export_init("bmesh.pos",bs3)

```
There are some tools to use with Bmesh


```julia 
   
   # Nodes of element 2
   Conect(b2,2)
  
   # Coordinates of node 6
   Coord(b3,6)
   
   # Length of element 2
   Lenght(b3,2)
   
   # Evaluate the director cossine and Length of element 6
   r = Rotations(b3,6)
   
   # Evaluate the rotation matrix for this element
   T = T_matrix(r)
   
   # T can also be used directly (without calling Rotations)
   T = T_matrix(b3,6)
   
   # Global degrees of freedom for a given element
   DOFs(b3,20)
   
   # Node close to point (x,y)
   x = 0.0;  y = 0.0
   node = Find_node(b2,x,y)

   # Nodes inside a rectangle with left bottom coordinate (x1,y1) 
   # and right top coordinate (x2,y2)
   x1 = 0.0; y1 = 0.0
   x2 = 0.5; y2 = 0.5
   nodes = Find_nodes_in_rectangle(b2,x1,y1,x2,y2)

   # Nodes inside a box with left bottom coordinate (x1,y1,z1) 
   # and right top coordinate (x2,y2,z2)
   x1 = 0.0; y1 = 0.0; z1 = 0.0
   x2 = 0.5; y2 = 0.5; z2 = 0.5
   nodes = Find_nodes_in_box(b3,x1,y1,z1,x2,y2,z2)

   # Element with centroid close to a given point
   x = 0.0;  y = 0.0
   element = Find_element(b2s,x,y)

   # Elements with centroid inside rectangle with left bottom coordinate (x1,y1) 
   # and right top coordinate (x2,y2)
   x1 = 0.0; y1 = 0.0
   x2 = 0.5; y2 = 0.5
   elements = Find_elements_in_rectangle(b2s,x1,y1,x2,y2)

   # Elements with centroid inside a box with left bottom coordinate (x1,y1,z1) 
   # and right top coordinate (x2,y2,z2)
   x1 = 0.0; y1 = 0.0; z1 = 0.0
   x2 = 0.5; y2 = 0.5; z2 = 0.5
   elements = Find_elements_in_box(b3,x1,y1,z1,x2,y2,z2)

   # Return a vector of vectors, with nn positions, containing the elements sharing
   # each node
   elems = Elements_sharing_nodes(b2)

```

It is possible to merge two Bmeshes, creating a new one. Each Bmesh
can be translated by changing the origin (coordinates of node 1).

Lets create a 3D "L" shape by merging two blocks of 3D trusses

```julia

    # Horizontal bmesh 
    # [=========]
    Lx = 10.0
    Ly = 1.0
    Lz = 1.0
    nx = 10
    ny = 1
    nz = 1
    b1 = Bmesh_truss_3D(Lx,nx,Ly,ny,Lz,nz)
    
    # Vertical bmesh with origin in x0=0.0 y0=1.0 and z0=0.0
    #
    # []
    # [] 
    # [] 
    #
    #
    Lx = 1.0
    Ly = 10.0
    Lz = 1.0
    nx = 1
    ny = 10
    nz = 1
    b2 = Bmesh_truss_3D(Lx,nx,Ly,ny,Lz,nz,origin=(0.0,1.0,0.0))

    # Merge into a single Bmesh
    bL = Merge(b1,b2)

```
