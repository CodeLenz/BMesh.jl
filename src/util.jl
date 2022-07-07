#
# Find the closest node to a given coordinate
#

function Find_node(bmesh::Bmesh2D,x,y,atol=1E-5)

    node = 0
    for i=1:bmesh.nn
        c1,c2 = bmesh.coord[i,:]
        if isapprox(c1,x,atol=atol) && isapprox(c2,y,atol=atol)
           node = i
           break
        end
    end

    return node

end

function Find_node(bmesh::Bmesh3D,x,y,z,atol=1E-5)

    node = 0
    for i=1:bmesh.nn
        c1,c2,c3 = bmesh.coord[i,:]
        if isapprox(c1,x,atol=atol) && isapprox(c2,y,atol=atol) && isapprox(c3,z,atol=atol)
           node = i
           break
        end
    end

    return node

end
