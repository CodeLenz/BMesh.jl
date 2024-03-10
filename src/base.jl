#
# Retorna os nós de um elemento
#
"""
  Return the connectivities of element ele

    Connect(bmesh::Bmesh,ele::Int64)

  as an Int64 vector.  
"""
function Connect(bmesh::Bmesh,ele::Int64)

    # Consistência do elemento
    0 < ele <= bmesh.ne || throw("Connect::invalid element $ele")

    # Retorna os nós do elemento
    return bmesh.connect[ele,:]

end


"""
  Return the coordinates of node 

    Coord(bmesh::Bmesh,node::Int64)

  as a vector [x;y];z]
"""
function Coord(bmesh::Bmesh,node::Int64)

  # Consistência do nó
  0 < node <= bmesh.nn || throw("Coord::invalid node $node")

  # Coordenadas
  return bmesh.coord[node,:]

end


#
# Calcula o comprimento entre os nós nodes[1] e nodes[2]
# de um elemento
#
"""
  Return the distance between two nodes of the element

    Length(bmesh::Bmesh,ele::Int64;nodes=(1,2))

  where the default is the distance between (local) nodes 1 and 2
"""
function Length(bmesh::Bmesh,ele::Int64;nodes=(1,2))
    
    # Nodes
    n = Connect(bmesh,ele)
    
    # Basic assertions
    nodes[1] <= maximum(n) || throw("Length::nodes[1] is larger than the maximum number of nodes for this element")
    nodes[2] <= maximum(n) || throw("Length::nodes[2] is larger than the maximum number of nodes for this element")
    
    # Coordinates
    c1 = Coord(bmesh,n[nodes[1]])
    c2 = Coord(bmesh,n[nodes[2]])
    
    # Length
    return norm(c1.-c2)
    
end

#
# Monta o vetor de graus de liberdade do elemento
#
"""
Return a 2*n vector with the global DOFs of element ele

    DOFs(bmesh::Bmesh2D,ele::Int64)

where n is the number of nodes of ele.
"""
function DOFs(bmesh::Bmesh2D,ele::Int64)

  # Determina quais são os gls GLOBAIS que são "acessados"
  # por esse elemento
  nodes = Connect(bmesh,ele)

  # Loop para gerar a saída
  dofs = Vector{Int64}(undef,2*length(nodes))

  cont = 1
  for i in nodes
    for j=1:2
        dofs[cont] = 2*(i-1)+j
        cont += 1
    end
  end
 
  return dofs

end

#
# Monta o vetor de graus de liberdade do elemento
#
"""
Return a 3*n vector with the global DOFs of element ele

    DOFs(bmesh::Bmesh3D,ele::Int64)

where n is the number of nodes of ele.
"""
function DOFs(bmesh::Bmesh3D,ele::Int64)

  # Determina quais são os gls GLOBAIS que são "acessados"
  # por esse elemento
  nodes = Connect(bmesh,ele)

  # Loop para gerar a saída
  dofs = Vector{Int64}(undef,3*length(nodes))

  cont = 1
  for i in nodes
    for j=1:3
        dofs[cont] = 3*(i-1)+j
        cont += 1
    end
  end
 
  return dofs
  
end


"""
Return vectors x and y with the nodal coordinates of element ele

   Nodal_coordinates(bm::Bmesh2D,ele::Int64)

where b is a Bmesh2 and ele a valid element.
"""
function Nodal_coordinates(bm::Bmesh2D,ele::Int64)

    # Nodes
    nodes = Connect(bm,ele)

    # Number of nodes
    nn = length(nodes)

    # Coordinates 
    x = Vector{Float64}(undef,nn)
    y = Vector{Float64}(undef,nn)
    @inbounds for i=1:nn

        # Local coordinates
        x[i],y[i] = Coord(bm,nodes[i])

    end

   return x, y
end


#
# Find the coordinates x and y of a given element
#
"""
Return vectors x, y and z with the nodal coordinates of element ele

   Nodal_coordinates(bm::Bmesh3D,ele::Int64)

where m is a Bmesh3D and ele a valid element.
"""
function Nodal_coordinates(bm::Bmesh3D,ele::Int64)

    # Nodes
    nodes = Connect(bm,ele)

    # Number of nodes
    nn = length(nodes)

    # Coordinates 
    x = Vector{Float64}(undef,nn)
    y = Vector{Float64}(undef,nn)
    z = Vector{Float64}(undef,nn)
    
    @inbounds for i=1:nn

        # Local coordinates
        x[i],y[i],z[i] = Coord(bm,nodes[i])

    end

   return x, y, z
end

"""
Return a vector with the centroidal coordinates of element ele

   Centroid(bm::Bmesh2D,ele::Int64)

"""
function Centroid(bm::Bmesh2D,ele::Int64)

    # Coordinates
    x,y = Nodal_coordinates(bm,ele)

    # Return mean values
    [mean(x); mean(y)]

end

# Centroid for a given element
"""
Return a vector with the centroidal coordinates of element ele

   Centroid(bm::Bmesh3D,ele::Int64)
   
"""
function Centroid(bm::Bmesh3D,ele::Int64)

    # Coordinates
    x,y,z = Nodal_coordinates(bm,ele)

    # Return mean values
    [mean(x); mean(y); mean(z)]

end
