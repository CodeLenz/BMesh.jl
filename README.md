
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

# #D background mesh in a 1 x 1 x 1.0 solid domain with 10 divisions in X, 10 in Y and 10 in Z
julia> bs3 = Bmesh_solid_#D(1.0,10,1.0,10,1.0,10)

# Visualize 
julia> Plot_structure(b3)

# Data type
julia> typeof(b2)
Bmesh
```
where Bmesh is a struct containing 
```julia 
   # Dimension (2/3)
    dimension::Int64

    # Element type
    # :truss2D, :truss3D,...
    etype::Symbol

    # Number of nodes
    nn::Int64
 
    # Number of elements
    ne::Int64

    # Nodal coordinates
    coord::Matrix{Float64}

    # Element connectivities
    connect::Matrix{Int64}
```
