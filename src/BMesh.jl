
module BMesh

   # Dependencies
   using LinearAlgebra, StaticArrays
   using Lgmsh
   using Statistics:mean
   using Test:@inferred
   
   if isdefined(Base, :Experimental) && isdefined(Base.Experimental, Symbol("@optlevel"))
       @eval Base.Experimental.@optlevel 3
   end

   # Local imports
   include("types.jl")
   include("bmesh_truss_2d.jl")
   include("bmesh_truss_3d.jl")
   include("bmesh_solid_2d.jl")
   include("bmesh_solid_3d.jl")
   include("base.jl")
   include("rotation.jl")
   include("gmsh.jl")
   include("merge.jl")
   include("util.jl")
   

   export Bmesh, Bmesh2D, Bmesh3D
   export Bmesh_truss_2D, Bmesh_truss_3D
   export Bmesh_solid_2D, Bmesh_solid_3D
   export Rotation, Rotation2D, Rotation3D, Rotations, T_matrix
   export Coord, Connect, DOFs, Length, Centroid, Nodal_coordinates
   export Lgmsh_export_init
   export Merge
   export Find_node, Find_nodes_in_rectangle, Find_nodes_in_box
   export Find_element, Find_elements_in_rectangle, Find_elements_in_box
   export Elements_sharing_nodes

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

end #module
