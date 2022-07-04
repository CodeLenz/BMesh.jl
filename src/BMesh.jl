
module BMesh

   # Dependencies
   using LinearAlgebra, StaticArrays, Plots
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
   include("show.jl")
   

   export Bmesh, Bmesh2D, Bmesh3D
   export Bmesh_truss_2D, Bmesh_truss_3D
   export Bmesh_solid_2D, Bmesh_solid_3D
   export Rotation, Rotation2D, Rotation3D, Rotations, T_matrix
   export Coord, Connect, DOFs, Length
   export Plot_structure

   #
   # Precompilations
   # 
   
   precompile(Rotations,(Bmesh2D,Int64,Float64))
   precompile(Rotations,(Bmesh3D,Int64,Float64))

   precompile(T_matrix, (Bmesh2D,Int64,Float64)) 
   precompile(T_matrix, (Bmesh3D,Int64,Float64)) 
   precompile(T_matrix, (Rotation2D,)) 
   precompile(T_matrix, (Rotation3D,)) 

   precompile(Connect, (Bmesh2D,Int64))
   precompile(Connect, (Bmesh3D,Int64))

   precompile(Coord, (Bmesh2D,Int64))
   precompile(Coord, (Bmesh3D,Int64))

   precompile(Length, (Bmesh2D,Int64,Tuple{Int64,Int64}))
   precompile(Length, (Bmesh3D,Int64,Tuple{Int64,Int64}))
   
   precompile(DOFs, (Bmesh2D,Int64))
   precompile(DOFs, (Bmesh3D,Int64))

   
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
