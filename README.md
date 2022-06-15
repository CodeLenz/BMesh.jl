# BMesh
Background mesh for topology optimization

```julia
using BMesh

# 2D background mesh in a 1 x 1  domain with 2 divisions in X and 3 in Y
b2 = Bmesh_truss_2D(1.0,2,1.0,3)

# 3D background mesh in a 1 x 1 x 1 domain with 3 divisions in X, 2 in Y and 4 in Z
b3 = Bmesh_truss_3D(1.0,3,1.0,2,1.0,4)

# Visualize 
Plot_structure(b3)

```
