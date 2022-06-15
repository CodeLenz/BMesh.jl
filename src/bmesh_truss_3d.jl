#
# Generates a background strucure (cross pattern) in 3D
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
#  advancing plane by plane. THEN, the connections
#  between planes are added to the mesh
# 
#     ____   
#     |\/|
#     |/\|  dy
#     ----
#      dx
#
#
#
function Bmesh_truss_3D(Lx::Float64,nx::Int64,Ly::Float64,ny::Int64,Lz::Float64,nz::Int64,
                        showtruss=false)

    # Assertions
    @assert Lx>0 "Bmesh_truss_3D:: Lx must be > 0"
    @assert Ly>0 "Bmesh_truss_3D:: Ly must be > 0"
    @assert Lz>0 "Bmesh_truss_3D:: Lz must be > 0"
    
    @assert nx>=1 "Bmesh_truss_3D:: nx must be >= 1"
    @assert ny>=1 "Bmesh_truss_3D:: ny must be >= 1"
    @assert nz>=1 "Bmesh_truss_3D:: nz must be >= 1"

    # number of nodes in each Z (XY planes)
    nn_plane = (nx+1)*(ny+1)

    # The number of nodes is a function of both nx, ny and nz
    nn = (nz+1)*nn_plane

    # The number of elements is also a function of nx and ny, and also
    # of the connectivity among the nodes. Lets consider a simple X
    # connectivity in each Z plane and additional cross links
    # in each "cube"
    #
    # TODO
    #

    # Number of elements in each Z (XY planes)
    #      barras h     barras vert   barras diagonais
    ne_plane =   nx*(ny+1) +   ny*(nx+1) +      2*nx*ny

    # Number of "vertical" Z elements
    ne_vz = (nx+1)*(ny+1)*nz

    # Number of "diagonal" / YZ elements (planes em X)
    # the number of \ elements is the same in this plane
    ne_d_yz = 2*nz*(nx+1)*ny

    # Number of "diagonal" \ XZ elements (planes em Y)
    # the number of / elements is the same in this plane
    ne_d_xz = 2*nz*(nx)*(ny+1)
  
    # Number of inner elements (in each "cube)
    ne_int = 4*(nx*ny*nz)

    # Total number of elements
    ne = (nz+1)*ne_plane + ne_vz + ne_d_yz + ne_d_xz + ne_int

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
    # The basic block is generated for each Z plane (horizontal (X), vertical (Y) and 
    #  diagonals in the plane XY (Z constant)). We then move to the next Z plane and 
    #  so on. Then, we proceed with the interplane connectivities
    #
    #
    #
    #
    
    # First, lets generate horizontal bars
    #
    #   nx = 3 e ny = 2
    #
    #
    #   (9)----(10)-----(11)-----(12)
    #    |       |       |        |
    #   (5)-----(6)-----(7)------(8)
    #    |       |       |        | 
    #   (1)-----(2)-----(3)------(4)
    #
    #

    # Element counter
    cont = 0

    # Loop
    for k=0:nz

        # Start a new plane
        no1 = 0 + k*nn_plane
        no2 = 1 + k*nn_plane

        # Horizontal elements (X)
        for i=1:ny+1
            for j=1:nx

                # Increment node numbers
                no1 += 1
                no2 += 1

                # Increment counter
                cont += 1

                # Store the connectivity
                connect[cont,1] = no1
                connect[cont,2] = no2
            end #j

            # We finished a row. Lets increment the nodes by 1
            no1 += 1
            no2 += 1
        end #i

        # Vertical elements (Y)
        no1 = 0 + k*nn_plane
        no2 = nx+1 + k*nn_plane
        for i=1:ny
            for j=1:nx+1

                # Increment node numbers
                no1 += 1
                no2 += 1

                # Increment counter
                cont += 1
                
                # Store the connectivity
                connect[cont,1] = no1
                connect[cont,2] = no2
            end #j
        end #i

        # Now, lets generate the / bars
        no1 = 0 + k*nn_plane
        no2 = nx+2 + k*nn_plane
        for i=1:ny
            for j=1:nx

                # Increment node numbers
                no1 += 1
                no2 += 1

                # Increment counter
                cont += 1

                # Store the connectivity
                connect[cont,1] = no1
                connect[cont,2] = no2
            end #j
            no1 += 1
            no2 += 1
        end #i

        # And, finally, the \ bars
        no1 = 1 + k*nn_plane
        no2 = nx+1 + k*nn_plane
        for i=1:ny
            for j=1:nx

                # Increment node numbers
                no1 += 1
                no2 += 1

                # Increment counter
                cont += 1

                # Store the connectivity
                connect[cont,1] = no1
                connect[cont,2] = no2
            end #j
            no1 += 1
            no2 += 1
        end #i

    end #k

    #
    # OK. Inter plane elements
    #

    # Vertical (Z) direction
    # Loop
    for k=1:nz

        # Start between planes k and k+1 and 
        no1 = (k-1)*nn_plane
        no2 = k*nn_plane
       
        # Vertical elements (Z)
        for i=1:ny+1
            for j=1:nx+1

                # Increment node numbers
                no1 += 1
                no2 += 1

                # Increment counter
                cont += 1

                # Store the connectivity
                connect[cont,1] = no1
                connect[cont,2] = no2
            end #j
            
        end #i

    end

   ######################################## YZ ##############################################

    # Diagonals / in the YZ planes
    # as looking from the positive X axis
    # Loop
    for k=1:nz
               
        # / in YZ planes
        for j=1:nx+1

            for i=1:ny

                # Nodes
                no1 = j + (nx+1)*(i-1) + (k-1)*nn_plane
                no2 = k*nn_plane + j + (nx+1)*i


                # Increment counter
                cont += 1

                # Store the connectivity
                connect[cont,1] = no1
                connect[cont,2] = no2
            end #j
            
        end #i

    end


    # Diagonals \ in the YZ planes
    # as looking from the positive X axis
    # Loop
    for k=1:nz
               
        # / in YZ planes
        for j=1:nx+1

            for i=1:ny

                # Nodes
                no1 = j + (nx+1)*i + (k-1)*nn_plane
                no2 = k*nn_plane + j + (nx+1)*(i-1)

                # Increment counter
                cont += 1

                # Store the connectivity
                connect[cont,1] = no1
                connect[cont,2] = no2
            end #j
            
        end #i

    end

    ########################################### XZ #####################################

    # Diagonals \ in the XZ planes
    # as looking from the positive Y axis
    # Loop
    for k=1:nz
               
        # / in YZ planes
        for i=1:ny+1

            for j=1:nx

                # Nodes
                no1 = j + (nx+1)*(i-1) + (k-1)*nn_plane
                no2 = no1 + nn_plane + 1
                
                # Increment counter
                cont += 1

                # Store the connectivity
                connect[cont,1] = no1
                connect[cont,2] = no2
            end #j
            
        end #i

    end

    # Diagonals / in the XZ planes
    # as looking from the positive Y axis
    # Loop
    for k=1:nz
               
        # / in YZ planes
        for i=1:ny+1

            for j=1:nx

                # Nodes
                no1 = j + (nx+1)*(i-1) + (k-1)*nn_plane + 1
                no2 = no1 + nn_plane - 1
                
                # Increment counter
                cont += 1

                # Store the connectivity
                connect[cont,1] = no1
                connect[cont,2] = no2
            end #j
            
        end #i

    end

    
    ################################# INTERNALS ####################################
    #
    # Each "cube" has 4 internal elements linking the four corner nodes
    #
    # Loop
    for k=1:nz
            
        for i=1:ny

            for j=1:nx

                #
                # First element - Forward (X) diagonal
                #
                no1 = j + (nx+1)*(i-1) + (k-1)*nn_plane
                no2 = k*nn_plane + j + (nx+1)*i + 1

                # Increment counter
                cont += 1

                # Store the connectivity
                connect[cont,1] = no1
                connect[cont,2] = no2

                #
                # Second element - Backward (X) diagonal
                #
                no1 = no1 + 1
                no2 = no2 - 1

                # Increment counter
                cont += 1

                # Store the connectivity
                connect[cont,1] = no1
                connect[cont,2] = no2

                #
                # Third element - Forward (Y) diagonal
                #
                no1 = no1 + nn_plane
                no2 = no2 - nn_plane
              
                # Increment counter
                cont += 1

                # Store the connectivity
                connect[cont,1] = no1
                connect[cont,2] = no2

                #
                # Fourth element - Backward (Y) diagonal
                #
                no1 = no1 - 1
                no2 = no2 + 1
              
                # Increment counter
                cont += 1

                # Store the connectivity
                connect[cont,1] = no1 
                connect[cont,2] = no2 

            end #j
            
        end #i

    end


    # Creates the datatype
    bmesh = Bmesh(3,:truss3D,nn,ne,coord,connect, Lx, Ly, Lz, nx, ny, nz)

    # Show the conectivities
    if showtruss
      Plot_structure(bmesh)
    end

    # Return bmesh
    return bmesh

end
