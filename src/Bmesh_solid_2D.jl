function Bmesh_solid_2D(Lx::Float64, nx::Int64, Ly::Float64, ny::Int64, thickness::Float64)

     # Primeiro geramos os nós de baixo para cima, esquerda para a direita
     nn = (nx+1)*(ny+1)
     coord = zeros(nn,2)

     # Dimensões de cada elemento
     dx = Lx / nx
     dy = Ly / ny

     # Gera a matrix de coordenadas nodais
     x = -dx
     y = -dy
     cont = 0
     for j=1:ny+1
         y += dy
         for i=1:nx+1
             x += dx
             cont += 1
             coord[cont,:] = [x y]
         end #i
         x = -dx
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
    bmesh = Bmesh(2,:solid2D,nn,ne,coord,connect,Lx,Ly,thickness,nx,ny,0)

    # Return bmesh
    return bmesh
     
