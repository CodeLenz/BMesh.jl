function Plot_structure(bmesh::Bmesh;
                        U=[],
                        dscale = 0.0,
                        x=[],
                        N = [],
                        cutout = 1E-3,
                        name=""
                        )
   
  
    # Local aliases
    ne = bmesh.ne
    nn = bmesh.nn
    coord = bmesh.coord
    connect = bmesh.connect

    # Alias
    dimen = bmesh.dimension

    # Ainda só para 2D (generalizar depois)
    #@assert bmesh.dimension==2 
    @assert bmesh.etype==:truss2D || bmesh.etype==:truss3D "Ainda só para treliça 2D e 3D"

    # Starts the plot
    if dimen==2
       plot();
    else
       plot3d();
    end

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
        node1, node2 = connect[ele,:]
        
        # recover the coordinates
        c1 = coord[node1,:]
        c2 = coord[node2,:]

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
            if dimen==2
               plot!([c1[1],c2[1]],[c1[2],c2[2]],
                      color=cor,linewidth=(0.1+5*x[ele]),legend=false)
            else
                plot3d!([c1[1],c2[1]],[c1[2],c2[2]],[c1[3],c2[3]],
                      color=cor,linewidth=(0.1+5*x[ele]),legend=false)
            end
        end

    end #ele

    # If the displacement vector is given
    if length(U)>0

        # Normalize
        U ./= norm(U)

        # Loop over the elements. Now, the coordinates of each
        # node are given by the initial coordinates
        # plus the displacement*dscale
        for ele=1:ne

            # recover the nodes
            node1, node2 = connect[ele,:]

            # recover the coordinates
            c1 = coord[node1,:]
            c2 = coord[node2,:]

            # Add the displacements
            pos = dimen*(node1-1)+1; c1[1] +=  U[pos]*dscale
            pos = dimen*(node1-1)+2; c1[2] +=  U[pos]*dscale
            pos = dimen*(node2-1)+1; c2[1] +=  U[pos]*dscale
            pos = dimen*(node2-1)+2; c2[2] +=  U[pos]*dscale

            if dimen==3
                pos = dimen*(node1-1)+3; c1[3] +=  U[pos]*dscale
                pos = dimen*(node2-1)+3; c2[3] +=  U[pos]*dscale
            end
            
            # Tolerância para comparação
            tol = 1.0/1E6 

            # Adds a line to the plot
            if x[ele] >cutout + tol
                if dimen==2
                    plot!([c1[1],c2[1]],[c1[2],c2[2]],
                    color=:red,linewidth=(0.1+5*x[ele]),legend=false)
                else
                    plot3d!([c1[1],c2[1]],[c1[2],c2[2]],[c1[3],c2[3]],
                    color=:red,linewidth=(0.1+5*x[ele]),legend=false)
                end
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

