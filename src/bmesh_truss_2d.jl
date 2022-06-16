#
# Generates a backgound strucure (cross pattern)
#
# Lx -> length in X
# Ly -> length in Y
# nx -> number of cells in x direction
# ny -> number of cells in y direction
# show -> false/true
#
#     ____   
#     |\/|
#     |/\|  dy
#     ----
#      dx
#
#
#
function Bmesh_truss_2D(Lx::Float64,nx::Int64,Ly::Float64,ny::Int64,
                       showtruss=false)

    # Assertions
    @assert Lx>0 "Bmesh_truss_2D:: Lx must be > 0"
    @assert Ly>0 "Bmesh_truss_2D:: Ly must be > 0"
    @assert nx>=1 "Bmesh_truss_2D:: nx must be >= 1"
    @assert ny>=1 "Bmesh_truss_2D:: ny must be >= 1"

    # The number of nodes is a function of both nx and ny
    nn = (nx+1)*(ny+1)

    # The number of elements is also a function of nx and ny, and also
    # of the connectivity among the nodes. Lets consider a simple X
    # connectivity
    #      barras h     barras vert   barras diagonais
    ne =   nx*(ny+1) +   ny*(nx+1) +      2*nx*ny

    # Now lets define two arrays. The first one contains the node
    # coordinates and the second one the connectivities
    coord = zeros(nn,2)
    connect = zeros(Int64,ne,2)

    # Increments of each coordinate
    dx = Lx/nx
    dy = Ly/ny

    # Initial coordinates
    x = -dx
    y = -dy

    # Lets generate the coordinates, bottom to top, left to rigth
    cont = 0
    # Loop na altura (y)
    for i=1:ny+1
        # Increment y (row)
        y += dy
        for j=1:nx+1
            # increment x (column)
            x += dx
            # Increment counter
            cont += 1
            # Store the coordinate
            coord[cont,1] = x
            coord[cont,2] = y
        end #j
        # reset x
        x = -dx
    end #i

    # Now that we have the coordinates, lets generate the connectivities.
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
    no1 = 0
    no2 = 1
    cont = 0
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

    # Now, lets generate the vertical bars
    no1 = 0
    no2 = nx+1
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
    no1 = 0
    no2 = nx+2
    for i=1:ny
        for j=1:nx
            #truss Increment node numbers
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
    no1 = 1
    no2 = nx+1
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

    # Creates the datatype
    bmesh = Bmesh2D(:truss2D,nn,ne,coord,connect,Lx, Ly, 0.0, nx, ny, 0)

    # Show the conectivities
    if showtruss
        Plot_structure(bmesh)
    end

    # Return bmesh
    return bmesh

end


