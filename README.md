
# BMesh
Background mesh for topology optimization

```julia
julia> using BMesh

# 2D background mesh in a 1 x 1  domain with 2 divisions in X and 3 in Y
julia> b2 = Bmesh_truss_2D(1.0,2,1.0,3)

# 3D background mesh in a 1 x 1 x 1 domain with 3 divisions in X, 2 in Y and 4 in Z
julia> b3 = Bmesh_truss_3D(1.0,3,1.0,2,1.0,4)

# 2D background mesh in a 1 x 1 x 0.1 solid domain with 10 divisions in X and 10 in Y
julia> bs2 = Bmesh_solid_2D(1.0,10,1.0,10,0.1)

# 3D background mesh in a 1 x 1 x 1.0 solid domain with 10 divisions in X, 10 in Y and 10 in Z
julia> bs3 = Bmesh_solid_3D(1.0,10,1.0,10,1.0,10)

# Visualize 
julia> Plot_structure(b3)

# Data type
julia> typeof(b2)
Bmesh2D

# Data type
julia> typeof(b3)
Bmesh3D

```
There are some tools to use with Bmesh


```julia 
   
   # Nodes of element 2
  julia> Conect(b2,2)
  2-element Vector{Int64}:
   2
   3
 
   # Coordinates of node 6
   julia> Coord(b3,6)
   (0.3333333333333333, 0.5, 0.0)

   # Evaluate the director cossine and Length of element 6
   julia> r = Rotation3D(b3,6)
   Rotation3D(1.0, 0.0, 0.0, -0.0, 1.0, -0.0, -0.0, 0.0, 1.0, 0.33333333333333337, 1.0, 0.0)

   
   # Evaluate the rotation matrix for this element
   julia> T = T_matrix(r,b3)
   6×6 Matrix{Float64}:
   1.0  0.0  0.0  0.0  0.0  0.0
   0.0  1.0  0.0  0.0  0.0  0.0
   0.0  0.0  1.0  0.0  0.0  0.0
   0.0  0.0  0.0  1.0  0.0  0.0
   0.0  0.0  0.0  0.0  1.0  0.0
   0.0  0.0  0.0  0.0  0.0  1.0

   # Vector with director cossines and lengths for all elements
   julia> vr = Vector{Rotation3D}(undef,b3.ne);

   julia> for e=1:b3.ne
              vr[e] = Rotation3D(b3,e)
          end 
          
   julia> vr[6]
   Rotation3D(1.0, 0.0, 0.0, -0.0, 1.0, -0.0, -0.0, 0.0, 1.0, 0.33333333333333337, 1.0, 0.0)


```
