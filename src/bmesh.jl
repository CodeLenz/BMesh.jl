# Supertype
abstract type Bmesh end

#
# basic structure 2D
#
struct Bmesh2D <: Bmesh
 
    # Element type
    # :truss2D, :solid2D
    etype::Symbol

    # Number of nodes
    nn::Int64
    
    # Number of elements
    ne::Int64
    
    # Nodal coordinates
    coord::Matrix{Float64}
    
    # Element connectivities
    connect::Matrix{Int64}

    # Dimensions
    Lx::Float64
    Ly::Float64
    Lz::Float64
    nx::Int64
    ny::Int64
    nz::Int64
 
    # Default constructor
    function Bmesh2D(etype::Symbol,nn::Int64,ne::Int64,
                   coord::Matrix{Float64},connect::Matrix{Int64},
                   Lx::Float64, Ly::Float64, Lz::Float64,nx::Int64, ny::Int64, nz::Int64)

        @assert size(coord,1)==nn "Bmesh2D:: number of rows in coord must be equal to the number of nodes"
        @assert size(coord,2)==2 "Bmesh2D:: number of columns in coord must be equal to 2"
        @assert size(connect,1)==ne "Bmesh2D:: number of rows in connect must be equal to the number of elements"
              
  
        # This should be relaxed for different elements
        @assert etype==:truss2D || etype==:solid2D  "Bmesh2D:: just :truss2D and :solid2D by now"
        
        # Creates the data type
        new(etype,nn,ne,coord,connect, Lx, Ly, Lz, nx, ny, nz)
    end

end

#
# basic structure 3D
#
struct Bmesh3D <: Bmesh
 
    # Element type
    # :truss3D, :solid3D
    etype::Symbol

    # Number of nodes
    nn::Int64
    
    # Number of elements
    ne::Int64
    
    # Nodal coordinates
    coord::Matrix{Float64}
    
    # Element connectivities
    connect::Matrix{Int64}

    # Dimensions
    Lx::Float64
    Ly::Float64
    Lz::Float64
    nx::Int64
    ny::Int64
    nz::Int64
 
    # Default constructor
    function Bmesh3D(etype::Symbol,nn::Int64,ne::Int64,
                   coord::Matrix{Float64},connect::Matrix{Int64},
                   Lx::Float64, Ly::Float64, Lz::Float64,nx::Int64, ny::Int64, nz::Int64)

        @assert size(coord,1)==nn "Bmesh3D:: number of rows in coord must be equal to the number of nodes"
        @assert size(coord,2)==3 "Bmesh3D:: number of columns in coord must be equal to 3"
        @assert size(connect,1)==ne "Bmesh3D:: number of rows in connect must be equal to the number of elements"
              
  
        # This should be relaxed for different elements
        @assert etype==:truss3D  "Bmesh3D:: just :truss3D  by now"
        
        # Creates the data type
        new(etype,nn,ne,coord,connect, Lx, Ly, Lz, nx, ny, nz)
    end

end
