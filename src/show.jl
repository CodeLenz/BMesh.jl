
#
# 2D
#
import Plots:plot
"""
  Plot the background mesh (2D)

    plot(bmesh::Bmesh2D;  name="" )

  A png file "name.png" is generated if name is not empty.
"""
function plot(bmesh::Bmesh2D;  name="" )
   
  
    # Local aliases
    ne = bmesh.ne
 
    # Create the plot
    plot();
 
    println("Generating the visualization...please wait")
  
    # Loop over the elements, extracting the nodes
    # and their coordinates  
    for ele=1:ne

        # recover the nodes
        nodes = Connect(bmesh,ele)
        
        # recover the coordinates
        c1 = Coord(bmesh,nodes[1])
        c2 = Coord(bmesh,nodes[2])

        # Adds a line to the plot
        # só mostra a linha se o x[ele] > do que o valor de corte
        plot!([c1[1],c2[1]],[c1[2],c2[2]],legend=false)
        
    end #ele
  
    # Display the plot
    display(plot!())

    # If name is not empty, saves the image
    if !isempty(name)
        savefig(name*".png")
    end

end



#
# 3D
#
"""
  Plot the background mesh (3D)

    plot(bmesh::Bmesh3D;  name="" )

  A png file "name.png" is generated if name is not empty.
"""
function plot(bmesh::Bmesh3D; name="")


    # Local aliases
    ne = bmesh.ne
 
    # Starts the plot
    plot3d();

    println("Generating the visualization...please wait")


    # Loop over the elements, extracting the nodes
    # and their coordinates
    for ele=1:ne

        # recover the nodes
        nodes = Connect(bmesh,ele)
                
        # recover the coordinates
        c1 = Coord(bmesh,nodes[1])
        c2 = Coord(bmesh,nodes[2])

        # Adds a line to the plot
        # só mostra a linha se o x[ele] > do que o valor de corte
        plot3d!([c1[1],c2[1]],[c1[2],c2[2]],[c1[3],c2[3]],legend=false)

    end #ele

    # Display the plot
    display(plot3d!())

    # If name is not empty, saves the image
    if !isempty(name)
        savefig(name*".png")
    end

end

