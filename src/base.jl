#
# Retorna os nós de um elemento
#
function Conect(bmesh::Bmesh,ele::Int64)

    # Consistência do elemento
    0 < ele <= bmesh.ne || throw("Conec::elemento $ele não é válido")

    # Retorna os nós do elemento
    return bmesh.connect[ele,:]

end

#
# Retorna as coordenadas de um nó
#
function Coord(bmesh::Bmesh2D,node::Int64)

   # Consistência do nó
   0 < node <= bmesh.nn || throw("Coord::nó $node não é válido")

   # Coordenadas
   x = bmesh.coord[node,1]
   y = bmesh.coord[node,2]
  
   # Retorna as coordenadas
   return x,y

end

function Coord(bmesh::Bmesh3D,node::Int64)

  # Consistência do nó
  0 < node <= bmesh.nn || throw("Coord::nó $node não é válido")

  # Coordenadas
  x = bmesh.coord[node,1]
  y = bmesh.coord[node,2]
  z = bmesh.coord[node,3]
       
  # Retorna as coordenadas
  return x,y,z

end


#
# Monta o vetor de graus de liberdade do elemento
#
function DOFs(bmesh::Bmesh2D,ele::Int64)

  # Determina quais são os gls GLOBAIS que são "acessados"
  # por esse elemento
  nodes = Conect(bmesh,ele)


  # Loop para gerar a saída
  dofs = Vector{Int64}(undef,2*length(nodes))

  cont = 1
  for i in nodes
    for j=1:dim
        dofs[cont] = 2*(i-1)+j
        cont += 1
    end
  end
 
  return dofs

end

#
# Monta o vetor de graus de liberdade do elemento
#
function DOFs(bmesh::Bmesh3D,ele::Int64)

  # Determina quais são os gls GLOBAIS que são "acessados"
  # por esse elemento
  nodes = Conect(bmesh,ele)

  # Loop para gerar a saída
  dofs = Vector{Int64}(undef,3*length(nodes))

  cont = 1
  for i in nodes
    for j=1:dim
        dofs[cont] = 3*(i-1)+j
        cont += 1
    end
  end
 
  return dofs
  
end
