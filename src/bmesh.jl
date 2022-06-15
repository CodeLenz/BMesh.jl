#
# basic structure
#
struct Bmesh
 
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

    # Dimensions
    Lx::Float64
    Ly::Float64
    Lz::Float64
    nx::Int64
    ny::Int64
    nz::Int64
 
    # Default constructor
    function Bmesh(dimension::Int64,etype::Symbol,nn::Int64,ne::Int64,
                   coord::Matrix{Float64},connect::Matrix{Int64},
                   Lx::Float64, Ly::Float64, Lz::Float64,nx::Int64, ny::Int64, nz::Int64)

        # Basic assertions
        @assert (dimension==2 || dimension==3) "Bmesh::dimension must be 2 or 3"

        @assert size(coord,1)==nn "Bmesh:: number of rows in coord must be equal to the number of nodes"
        @assert size(coord,2)==dimension "Bmesh:: number of columns in coord must be equal to dimension"
        @assert size(connect,1)==ne "Bmesh:: number of rows in connect must be equal to the number of elements"
        @assert (etype==:truss2D || etype==:truss3D) && size(connect,2)==2  "Bmesh:: number of columns in connect must be equal to 2 for truss elements"
        @assert (etype==:solid2D) && size(connect,2)==4 "Bmesh:: number of columns in connect must be equal to 4 for solid2D elements"
              
  
        # This should be relaxed for different elements
        @assert etype==:truss2D || etype==:truss3D || etype==:solid2D  "Bmesh:: just truss (2D and 3D) and solid 2D by now"
        
        # Creates the data type
        new(dimension,etype,nn,ne,coord,connect, Lx, Ly, Lz, nx, ny, nz)
    end

end
