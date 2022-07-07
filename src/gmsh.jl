#
# Cria o cabecalho com informacoes da malha
# para posterior adicao de vistas com saidas
#
function Gmsh_init(nome_arquivo::String,bmesh::Bmesh)

    # Verifica se já existe o arquivo, se sim, remove
    if isfile(nome_arquivo); rm(nome_arquivo); end

    # Abre o arquivo para escrita
    saida = open(nome_arquivo,"a")

    # Dimension (2/3)
    dim = 2
    if isa(bmesh,Bmesh3D)
        dim = 3
    end
    
    # Number of nodes
    nn = bmesh.nn

    # Number of elements
    ne = bmesh.ne

    # Cabecalho do gmsh
    println(saida,"\$MeshFormat")
    println(saida,"2.2 0 8")
    println(saida,"\$EndMeshFormat")

    # Nodes
    println(saida,"\$Nodes")
    println(saida,nn)
    if dim==2
        for i=1:nn
            println(saida,i," ",bmesh.coord[i,1]," ",bmesh.coord[i,2]," 0.0 ")
        end
    else
        for i=1:nn
            println(saida,i," ",bmesh.coord[i,1]," ",bmesh.coord[i,2]," ",bmesh.coord[i,3])
        end
    end    
    println(saida,"\$EndNodes")

    # Element type (gmsh code)
    tipo_elemento = 1
    if bmesh.etype==:solid2D
        tipo_elemento = 3
    elseif bmesh.etype==:solid3D
        tipo_elemento = 5    
    end

    println(saida,"\$Elements")
    println(saida,ne)
    for i=1:ne 
        con = string(i)*" "*string(tipo_elemento)*" 0 "*string(bmesh.connect[i,1])
        for j=2:size(bmesh.connect,2)
            con = con * " " * string(bmesh.connect[i,j])
        end
        println(saida,con)
    end
    println(saida,"\$EndElements")

    # Fecha o arquivo ... por hora
    close(saida)


end 
