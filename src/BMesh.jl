module BMesh

   # Dependencies
   using LinearAlgebra, Plots

   # Local imports
   include("bmesh.jl")
   include("bmesh_truss_2d.jl")
   include("bmesh_truss_3d.jl")
   include("bmesh_solid_2d.jl")
   include("base.jl")
   include("rotation.jl")
   include("show.jl")
   

   export Bmesh
   export Bmesh_truss_2D, Bmesh_truss_3D
   export Bmesh_solid_2D
   export Rotation, T_matrix
   export Coord, Conect
   export Plot_structure

end #module
