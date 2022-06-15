module BMesh

   # Dependencies
   using LinearAlgebra, Plots

   # Local imports
   include("bmesh.jl")
   include("bmesh_truss_2d.jl")
   include("bmesh_truss_3d.jl")
   include("base.jl")
   include("rotation.jl")
   include("show.jl")
   

   export Bmesh, Bmesh_truss_2D, Bmesh_truss_3D
   export Rotation, T_matrix
   export Coord, Conect
   export Plot_structure

end #module
