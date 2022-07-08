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


"""
Find element close to a given point. The metric is the 
length between the centroid of ele and the coordinates of 
the point

    Find_element(bmesh::Bmesh2D,x,y)

"""
function Find_element(bmesh::Bmesh2D,x::Float64,y::Float64)

    # Convert to aray 
    point = SVector{2}(x,y)
    centroid = MVector{2}(x,y)

    element = 0
    min_dist = maxintfloat(1.0)
    @inbounds for ele=1:bmesh.ne

        # Centroid
        centroid .= Centroid(bmesh,ele)

        # Distance between point and centroid
        dist = norm(centroid.-point)

        if dist<min_dist
            element = ele
            min_dist=dist
        end

    end

    return element

end


"""
Find element close to a given point. The metric is the 
length between the centroid of ele and the coordinates of 
the point

    Find_element(bmesh::Bmesh3D,x,y,z)

"""
function Find_element(bmesh::Bmesh3D,x::Float64,y::Float64,z::Float64)

    # Convert to aray 
    point = SVector{3}(x,y,z)
    centroid = MVector{3}(x,y,z)

    element = 0
    min_dist = maxintfloat(1.0)
    @inbounds for ele=1:bmesh.ne

        # Centroid
        centroid .= Centroid(bmesh,ele)

        # Distance between point and centroid
        dist = norm(centroid.-point)

        if dist<min_dist
            element = ele
            min_dist=dist
        end

    end

    return element

end




"""
Find the elements with centroid inside a given rectangle

    Find_elements_in_rectangle(bmesh::Bmesh2D,x1,y1,x2,y2)

    __________________(x2,y2)  
   |                     |
   |                     |
   (x1,y1)_______________| 


"""
function Find_elements_in_rectangle(bmesh::Bmesh2D,x1,y1,x2,y2)


    # Check if it is a rectangle
    @assert x2>x1 "Find_elements_in_rectangle:: x2 must be > then x1"
    @assert y2>y1 "Find_elements_in_rectangle:: y2 must be > then y1"

    elements = Int64[]
    @inbounds for ele=1:bmesh.ne

        # Centroid
        c1, c2 = Centroid(bmesh,ele)

        # Conditions
        cond1 = x1<=c1<=x2
        cond2 = y1<=c2<=y2
        if cond1 && cond2
           push!(elements,ele)
        end

    end

    return elements

end

"""
Find elements with centroid inside a given 3D box

    Find_elements_in_box(bmesh::Bmesh3D,x1,y1,z1,x2,y2,z2)


"""
function Find_elements_in_box(bmesh::Bmesh3D,x1,y1,z1,x2,y2,z2)

    # Check if it is a box
    @assert x2>x1 "Find_elements_in_box:: x2 must be > then x1"
    @assert y2>y1 "Find_elements_in_box:: y2 must be > then y1"
    @assert z2>z1 "Find_elements_in_box:: z2 must be > then z1"

    elements = Int64[]
    @inbounds for ele=1:bmesh.ne

        # Centroid
        c1, c2, c3 = Centroid(bmesh,ele)

        # Conditions
        cond1 = x1<=c1<=x2
        cond2 = y1<=c2<=y2
        cond3 = z1<=c3<=z2
        if cond1 && cond2 && cond3
           push!(elements,ele)
        end

    end

    return elements

end

