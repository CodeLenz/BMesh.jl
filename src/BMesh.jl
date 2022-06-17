
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
   

   export Bmesh, Bmesh2D, Bmesh3D
   export Bmesh_truss_2D, Bmesh_truss_3D
   export Bmesh_solid_2D
   export Rotation, Rotation2D, Rotation3D, Rotations, T_matrix
   export Coord, Conect, DOFs, Length
   export Plot_structure

end #module
