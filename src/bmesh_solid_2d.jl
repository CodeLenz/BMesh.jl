"""
Generate a 2D background mesh for 4-node solid (planar) elements (:solid2D)

    Bmesh_solid_2D(Lx::Float64, nx::Int64, Ly::Float64, ny::Int64;
                   origin=(0.0,0.0) )

where

    Lx  = length in X (horizonal direction)
    nx  = number of divisions (elements) in X
    Ly  = lenght in Y (vertical direction)
    ny  = number of divisions (elements) in Y
    origin = coordinates of node 1

returns

    Bmesh2D(:solid2D,nn,ne,coord,connect,Lx,Ly, nx,ny)

where

    nn      = number of nodes 
    ne      = number of elements
    coord   = matrix nn x 2 with nodal coordinates (x y) 
    connect = matrix ne x 4 with connectivities

"""
function Bmesh_solid_2D(Lx::Float64, nx::Int64, Ly::Float64, ny::Int64;
                        origin=(0.0,0.0))

     # Assertions
     @assert Lx>0  "Bmesh_solid_2D:: Lx must be > 0"
     @assert Ly>0  "Bmesh_solid_2D:: Ly must be > 0"
     @assert nx>=1 "Bmesh_solid_2D:: nx must be >= 1"
     @assert ny>=1 "Bmesh_solid_2D:: ny must be >= 1"

     # Primeiro geramos os nós de baixo para cima, esquerda para a direita
     nn = (nx+1)*(ny+1)
     coord = zeros(nn,2)

     # Dimensões de cada elemento
     dx = Lx / nx
     dy = Ly / ny

     # Gera a matrix de coordenadas nodais
     x = origin[1]-dx
     y = origin[2]-dy
     cont = 0
     for j=1:ny+1
         y += dy
         for i=1:nx+1
             x += dx
             cont += 1
             coord[cont,:] = [x y]
         end #i
         x = origin[1]-dx
     end #j

     # Gera a matrix de conectividades
     ne = (nx)*(ny)
     connect = zeros(Int64,ne,4)
     no1 = 1
     no2 = 2
     no3 = (nx+1)+2
     no4 = no3-1
     cont = 0
     for j=1:ny
         for i=1:nx
             cont += 1
             connect[cont,:] = [no1 no2 no3 no4]
             no1 += 1; no2 += 1; no3 += 1; no4 += 1
         end #i
         no1 += 1; no2 += 1; no3 += 1; no4 += 1
     end #j
     
      # Creates the datatype
    bmesh = Bmesh2D(:solid2D,nn,ne,coord,connect,Lx,Ly, nx,ny)

    # Return bmesh
    return bmesh
     
end
