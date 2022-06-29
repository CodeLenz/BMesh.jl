#
# Generates a background strucure  in 3D (Hexaedra)
#
# Lx -> length in X
# Ly -> length in Y
# Lz -> lenght in Z
# nx -> number of cells in x direction
# ny -> number of cells in y direction
# nz -> number of cells in z direction
# show -> false/true
#
#  We first create the mesh in the z=0 (xy) plane
#  advancing plane by plane. 
#
#
"""
Generate a 3D background mesh for 8-node solid elements (:solid3D)

    Bmesh_solid_3D(Lx::Float64,nx::Int64,Ly::Float64,ny::Int64,Lz::Float64,nz::Int64)

where

    Lx  = length in X (horizonal direction)
    nx  = number of divisions (elements) in X
    Ly  = length in Y (horizonal direction)
    ny  = number of divisions (elements) in Y
    Lz  = lenght in Z (vertical direction)
    nz  = number of divisions (elements) in Z

returns

    Bmesh3D(:solid3D,nn,ne,coord,connect,Lx,Ly,Lz,nx,ny,nz)

where

    nn      = number of nodes 
    ne      = number of elements
    coord   = matrix nn x 3 with nodal coordinates (x y z) 
    connect = matrix ne x 8 with connectivities.


Nodes are generated plane by plane, from z=0 to z=Lz.    
Connectivities follow the same pattern.

"""
function Bmesh_solid_3D(Lx::Float64,nx::Int64,Ly::Float64,ny::Int64,Lz::Float64,nz::Int64)

    # Assertions
    @assert Lx>0 "Bmesh_solid_3D:: Lx must be > 0"
    @assert Ly>0 "Bmesh_solid_3D:: Ly must be > 0"
    @assert Lz>0 "Bmesh_solid_3D:: Lz must be > 0"

    @assert nx>=1 "Bmesh_solid_3D:: nx must be >= 1"
    @assert ny>=1 "Bmesh_solid_3D:: ny must be >= 1"
    @assert nz>=1 "Bmesh_solid_3D:: nz must be >= 1"

    # number of nodes in each Z (XY planes)
    nn_plane = (nx+1)*(ny+1)

    # The number of nodes is a function of both nx, ny and nz
    nn = (nz+1)*nn_plane

    # The number of elements is also a function of nx and ny, and also
    # of the connectivity among the nodes. 

    # Number of elements in each Z (XY planes)
    ne_plane =   (nx)*(ny) 

    # Total number of elements
    ne = (nz)*ne_plane 

    # Now lets define two arrays. The first one contains the node
    # coordinates and the second one the connectivities
    coord = zeros(nn,3)
    connect = zeros(Int64,ne,2)

    # Increments of each coordinate
    dx = Lx/nx
    dy = Ly/ny
    dz = Lz/nz

    # Initial coordinates
    x = -dx
    y = -dy
    z = -dz

    # Lets generate the coordinates, bottom to top, left to rigth
    cont = 0
    # Loop em Z
    for k=1:nz+1
        z += dz
        # Loop em Y
        for i=1:ny+1
            # Increment y (row)
            y += dy
            # Loop em X
            for j=1:nx+1
                # increment x (column)
                x += dx
                # Increment counter
                cont += 1
                # Store the coordinate
                coord[cont,1] = x
                coord[cont,2] = y
                coord[cont,3] = z
            end #j
            # reset x
            x = -dx
        end #i
        # Reset both x and y (start a new plane) 
        x = -dx
        y = -dy
    end #k

    #
    #
    # Now that we have the coordinates, lets generate the connectivities.
    #
    #
    # Connective matrix
    connect = zeros(Int64,ne,8)

    # Initial nodes
    no1 = 1
    no2 = 2
    no3 = (nx+1)+2
    no4 = no3-1
    no5 = no1 + nn_plane
    no6 = no2 + nn_plane
    no7 = no3 + nn_plane
    no8 = no4 + nn_plane
    cont = 0
    for k=1:nz
        for j=1:ny
            for i=1:nx

                # Element counter
                cont += 1

                # nodes
                no1 = i + (j-1)*(nx+1) + (k-1)*(nn_plane)
                no2 = (i+1) + (j-1)*(nx+1) + (k-1)*(nn_plane)
                no3 = (i+1) + (j)*(nx+1) + (k-1)*(nn_plane)
                no4 =  i + (j)*(nx+1) + (k-1)*(nn_plane)

                no5 = i + (j-1)*(nx+1) + (k)*(nn_plane)
                no6 = (i+1) + (j-1)*(nx+1) + (k)*(nn_plane)
                no7 = (i+1) + (j)*(nx+1) + (k)*(nn_plane)
                no8 = i + (j)*(nx+1) + (k)*(nn_plane)

                connect[cont,:] = [no1 no2 no3 no4 no5 no6 no7 no8]
            
            end #i
            
        end #j
    end #k


    # Create the datatype
    bmesh = Bmesh3D(:solid3D,nn,ne,coord,connect, Lx, Ly, Lz, nx, ny, nz)

    # Return bmesh
    return bmesh

end
