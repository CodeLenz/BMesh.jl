
#
# 2D
#
function Plot_structure(bmesh::Bmesh2D;
                        U=[],
                        dscale = 0.0,
                        x=[],
                        N = [],
                        cutout = 1E-3,
                        name=""
                        )
   
  
    # Local aliases
    ne = bmesh.ne
 
    # Create the plot
    plot();
  
    # Testa por x. Se o usuário não informou, usamos unitário
    if length(x)==0
        x = ones(ne)
    end

    println("Generating the visualization...please wait")

    # Se o vetor N for vazio, enchemos com 1.0
    if isempty(N)
         N = ones(ne)
    end
    

    # Loop over the elements, extracting the nodes
    # and their coordinates
    
    for ele=1:ne

        # recover the nodes
        nodes = Conect(bmesh,ele)
        
        # recover the coordinates
        c1 = Coord(bmesh,nodes[1])
        c2 = Coord(bmesh,nodes[2])

        # Tolerância para comparação
        tol = 1.0/1E6 

        # Se N[ele] <0.0 -> azul
        # Se N[ele] >0.0 -> vermelho
        # Se N[ele] = 0.0 -> verde
        cor = :blue
        if N[ele]>0.0 
            cor = :red
        end    

        # Se for numericamente próximo de zero
        if isapprox(abs(N[ele]),0.0,atol=1E-3)
            cor = :green
        end

        # Adds a line to the plot
        # só mostra a linha se o x[ele] > do que o valor de corte
        if x[ele]>cutout+tol 
               plot!([c1[1],c2[1]],[c1[2],c2[2]],
                      color=cor,linewidth=(0.1+5*x[ele]),legend=false)
         end

    end #ele

    # If the displacement vector is given
    if length(U)>0

        # Check size
        @assert length(U)==2*bmesh.nn "Plot_structure:: length of U must be 2*number of nodes
    
        # Normalize
        U ./= norm(U)

        # Loop over the elements. Now, the coordinates of each
        # node are given by the initial coordinates
        # plus the displacement*dscale
        for ele=1:ne

            # recover the nodes
            nodes = Conect(bmesh,ele)
            
            # recover the coordinates
            c1 = Coord(bmesh,nodes[1])
            c2 = Coord(bmesh,nodes[2])

            # Add the displacements
            pos = 2*(nodes[1]-1)+1; c1[1] +=  U[pos]*dscale
            pos = 2*(nodes[1]-1)+2; c1[2] +=  U[pos]*dscale
            pos = 2*(nodes[2]-1)+1; c2[1] +=  U[pos]*dscale
            pos = 2*(nodes[2]-1)+2; c2[2] +=  U[pos]*dscale

            
            # Tolerância para comparação
            tol = 1.0/1E6 

            # Adds a line to the plot
            if x[ele] >cutout + tol
                plot!([c1[1],c2[1]],[c1[2],c2[2]],
                    color=:red,linewidth=(0.1+5*x[ele]),legend=false)
            end

        end #ele

    end #if length

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
function Plot_structure(bmesh::Bmesh3D;
                        U=[],
                        dscale = 0.0,
                        x=[],
                        N = [],
                        cutout = 1E-3,
                        name=""
                        )


    # Local aliases
    ne = bmesh.ne
 
    # Starts the plot
    plot3d();

    # Testa por x. Se o usuário não informou, usamos unitário
    if length(x)==0
        x = ones(ne)
    end

    println("Generating the visualization...please wait")

    # Se o vetor N for vazio, enchemos com 1.0
    if isempty(N)
        N = ones(ne)
    end


    # Loop over the elements, extracting the nodes
    # and their coordinates

    for ele=1:ne

        # recover the nodes
        nodes = Conect(bmesh,ele)
                
        # recover the coordinates
        c1 = Coord(bmesh,nodes[1])
        c2 = Coord(bmesh,nodes[2])

        # Tolerância para comparação
        tol = 1.0/1E6 

        # Se N[ele] <0.0 -> azul
        # Se N[ele] >0.0 -> vermelho
        # Se N[ele] = 0.0 -> verde
        cor = :blue
        if N[ele]>0.0 
            cor = :red
        end    

        # Se for numericamente próximo de zero
        if isapprox(abs(N[ele]),0.0,atol=1E-3)
            cor = :green
        end

        # Adds a line to the plot
        # só mostra a linha se o x[ele] > do que o valor de corte
        if x[ele]>cutout+tol 
            plot3d!([c1[1],c2[1]],[c1[2],c2[2]],[c1[3],c2[3]],
                    color=cor,linewidth=(0.1+5*x[ele]),legend=false)
        end

    end #ele

    # If the displacement vector is given
    if length(U)>0

        # Check size
        @assert length(U)==3*bmesh.nn "Plot_structure:: length of U must be 3*number of nodes
    
        # Normalize
        U ./= norm(U)

        # Loop over the elements. Now, the coordinates of each
        # node are given by the initial coordinates
        # plus the displacement*dscale
        for ele=1:ne

            # recover the nodes
            nodes = Conect(bmesh,ele)
                    
      @show nodes
      
            # recover the coordinates
            c1 = Coord(bmesh,nodes[1])
            c2 = Coord(bmesh,nodes[2])

            # Add the displacements
            pos = 3*(nodes[1]-1)+1; c1[1] +=  U[pos]*dscale
            pos = 3*(nodes[1]-1)+2; c1[2] +=  U[pos]*dscale
            pos = 3*(nodes[1]-1)+3; c1[3] +=  U[pos]*dscale
  
            pos = 3*(nodes[2]-1)+1; c2[1] +=  U[pos]*dscale
            pos = 3*(nodes[2]-1)+2; c2[2] +=  U[pos]*dscale
            pos = 3*(nodes[2]-1)+3; c2[3] +=  U[pos]*dscale

            # Tolerância para comparação
            tol = 1.0/1E6 

            # Adds a line to the plot
            if x[ele] >cutout + tol
                plot3d!([c1[1],c2[1]],[c1[2],c2[2]],[c1[3],c2[3]],
                        color=:red,linewidth=(0.1+5*x[ele]),legend=false)
            end
        
        end #ele

    end #if length

    # Display the plot
    display(plot3d!())

    # If name is not empty, saves the image
    if !isempty(name)
        savefig(name*".png")
    end

end

