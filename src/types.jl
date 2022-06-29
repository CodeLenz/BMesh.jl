# Supertype
"""
Supertype for BMesh2D and BMesh3D 
"""
abstract type Bmesh end

#
# basic structure 2D
#
"""
Basic structure for 2D meshes

    Bmesh2D(etype::Symbol,nn::Int64,ne::Int64,coord::Matrix{Float64},connect::Matrix{Int64},
            Lx::Float64, Ly::Float64, nx::Int64, ny::Int64)  

where:

    etype   = :truss2D or :solid2D
    nn      = number of nodes
    ne      = number of elements
    coord   = nn x 2 matrix with nodal coordinates (x y)
    connect = ne x {2,4} matrix with element connectivities. 2 for :truss2D and 4 for :solid2D
    Lx      = horizontal (X) length (if using a rectangular domain)
    nx      = number of divisions (elements) in the horizontal direction 
    Ly      = vectival (Y) length (if using a rectangular domain)
    ny      = number of divisions (elements) in the vertical direction 
"""
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
    nx::Int64
    ny::Int64
 
    # Default constructor
    function Bmesh2D(etype::Symbol,nn::Int64,ne::Int64,
                   coord::Matrix{Float64},connect::Matrix{Int64},
                   Lx::Float64, Ly::Float64, nx::Int64, ny::Int64)

        @assert size(coord,1)==nn "Bmesh2D:: number of rows in coord must be equal to the number of nodes"
        @assert size(coord,2)==2 "Bmesh2D:: number of columns in coord must be equal to 2"
        @assert size(connect,1)==ne "Bmesh2D:: number of rows in connect must be equal to the number of elements"
              
  
        # This should be relaxed for different elements
        @assert etype==:truss2D || etype==:solid2D  "Bmesh2D:: just :truss2D and :solid2D by now"
        
        # Creates the data type
        new(etype,nn,ne,coord,connect, Lx, Ly, nx, ny)
    end

end

#
# basic structure 3D
#
"""
Basic structure for 3D meshes

    Bmesh3D(etype::Symbol,nn::Int64,ne::Int64,coord::Matrix{Float64},connect::Matrix{Int64},
            Lx::Float64, Ly::Float64, Lz::Float64,nx::Int64, ny::Int64, nz::Int64)
    
where:

    etype   = :truss2D or :solid2D
    nn      = number of nodes
    ne      = number of elements
    coord   = nn x 3 matrix with nodal coordinates (x y z)
    connect = ne x {2,8} matrix with element connectivities. 2 for :truss3D and 8 for :solid3D
    Lx      = horizontal (X) length (if using a cubic domain)
    nx      = number of divisions (elements) in the horizontal X direction 
    Ly      = horizontal (Y) length (if using a cubic domain)
    ny      = number of divisions (elements) in the horizontal Y direction 
    Lz      = vertical (Z) length (if using a cubic domain)
    nz      = number of divisions (elements) in the vertical direction 
"""
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
        @assert etype==:truss3D || etype==:solid3D "Bmesh3D:: invalid element type $etype"
        
        # Creates the data type
        new(etype,nn,ne,coord,connect, Lx, Ly, Lz, nx, ny, nz)
    end

end
