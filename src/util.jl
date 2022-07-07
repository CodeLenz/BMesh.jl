"""
Find the closest node to a given coordinate (x,y)

    Find_node(bmesh::Bmesh2D,x,y;atol=1E-5)


"""
function Find_node(bmesh::Bmesh2D,x,y;atol=1E-5)

    node = 0
    @inbounds for i=1:bmesh.nn
        c1,c2 = bmesh.coord[i,:]
        if isapprox(c1,x,atol=atol) && isapprox(c2,y,atol=atol)
           node = i
           break
        end
    end

    return node

end

"""
Find the closest node to a given coordinate (x,y)

    Find_node(bmesh::Bmesh3D,x,y,z;atol=1E-5)


"""
function Find_node(bmesh::Bmesh3D,x,y,z;atol=1E-5)

    node = 0
    @inbounds for i=1:bmesh.nn
        c1,c2,c3 = bmesh.coord[i,:]
        if isapprox(c1,x,atol=atol) && isapprox(c2,y,atol=atol) && isapprox(c3,z,atol=atol)
           node = i
           break
        end
    end

    return node

end


"""
Find the nodes inside a given rectangle

    Find_nodes_in_rectangle(bmesh::Bmesh2D,x1,y1,x2,y2;atol=1E-5)

    __________________(x2,y2)  
   |                     |
   |                     |
   (x1,y1)_______________| 


"""
function Find_nodes_in_rectangle(bmesh::Bmesh2D,x1,y1,x2,y2; atol=1E-5)


    # Check if it is a rectangle
    @assert x2>x1 "Find_nodes_in_rectangle:: x2 must be > then x1"
    @assert y2>y1 "Find_nodes_in_rectangle:: y2 must be > then y1"

    nodes = Int64[]
    @inbounds for i=1:bmesh.nn

        # Coordinates
        c1,c2 = bmesh.coord[i,:]

        # Conditions
        cond1 = x1-atol<=c1<=x2+atol
        cond2 = y1-atol<=c2<=y2+atol
        if cond1 && cond2
           push!(nodes,i)
        end

    end

    return nodes

end


"""
Find the nodes inside a given 3D box

    Find_nodes_in_box(bmesh::Bmesh3D,x1,y1,z1,x2,y2,z2;atol=1E-5)


"""
function Find_nodes_in_box(bmesh::Bmesh3D,x1,y1,z1,x2,y2,z2;atol=1E-5)

    # Check if it is a box
    @assert x2>x1 "Find_nodes_in_box:: x2 must be > then x1"
    @assert y2>y1 "Find_nodes_in_box:: y2 must be > then y1"
    @assert z2>z1 "Find_nodes_in_box:: z2 must be > then z1"

    nodes = Int64[]
    @inbounds for i=1:bmesh.nn

        # Coordinates
        c1,c2,c3 = bmesh.coord[i,:]

        # Conditions
        cond1 = x1-atol<=c1<=x2+atol
        cond2 = y1-atol<=c2<=y2+atol
        cond3 = z1-atol<=c3<=z2+atol
        if cond1 && cond2 && cond3
           push!(nodes,i)
        end

    end

    return nodes

end

