
# BMesh
Background mesh and utilities for topology optimization

https://codelenz.github.io/BMesh/

```julia
using BMesh, Plots

# 2D background mesh in a 1 x 1  domain with 2 divisions in X and 3 in Y
b2 = Bmesh_truss_2D(1.0,2,1.0,3)

# 3D background mesh in a 1 x 1 x 1 domain with 3 divisions in X, 2 in Y and 4 in Z
b3 = Bmesh_truss_3D(1.0,3,1.0,2,1.0,4)

# 2D background mesh in a 1 x 1  solid domain with 10 divisions in X and 10 in Y
bs2 = Bmesh_solid_2D(1.0,10,1.0,10)

# 3D background mesh in a 1 x 1 x 1 solid domain with 10 divisions in each direction
bs3 = Bmesh_solid_3D(1.0,10,1.0,10,1.0,10)

# Plots:plot is overloaded to bmesh
# Just for truss by now
plot(b3)

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
   
```
