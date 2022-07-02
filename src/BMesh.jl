
module BMesh

   # Dependencies
   using LinearAlgebra, StaticArrays, Plots
   using Test:@inferred
   

   # Local imports
   include("types.jl")
   include("bmesh_truss_2d.jl")
   include("bmesh_truss_3d.jl")
   include("bmesh_solid_2d.jl")
   include("bmesh_solid_3d.jl")
   include("base.jl")
   include("rotation.jl")
   include("show.jl")
   

   export Bmesh, Bmesh2D, Bmesh3D
   export Bmesh_truss_2D, Bmesh_truss_3D
   export Bmesh_solid_2D, Bmesh_solid_3D
   export Rotation, Rotation2D, Rotation3D, Rotations, T_matrix
   export Coord, Connect, DOFs, Length
   export Plot_structure

   # Define macros to help in testing
   macro isinferred(ex)
    quote try
             @inferred $ex
             true
          catch err
            false
          end
    end
   end
   
   export @isinferred

 macro to_bool(ex)
    quote  try
           $ex
             true
          catch err
            false
          end
    end
 end
   
 export @to_bool
end #module
