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
function Coord(bmesh::Bmesh,node::Int64)

   # Consistência do nó
   0 < node <= bmesh.nn || throw("Coord::nó $node não é válido")

   # Coordenadas
   x = bmesh.coord[node,1]
   y = bmesh.coord[node,2]
   z = 0.0 
   if bmesh.dimension==3
     z = bmesh.coord[node,3]
   end
        
   # Retorna as coordenadas
   return x,y,z

end
