#
# Wrappers for Lgmsh
#
#
#                            Export
#
import Lgmsh:Lgmsh_export_init
function Lgmsh_export_init(filename::String,bmesh::Bmesh)

    # aliases
    nn = bmesh.nn
    ne = bmesh.ne
    coord = bmesh.coord
    connect = bmesh.connect

    # Element types depend on the element type 
    if bmesh.etype==:solid2D
        etype = 3*ones(Int64,ne)
    elseif bmesh.etype==:solid3D
        etype = 5*ones(Int64,ne)
    else
        etype = ones(Int64,ne)
    end

    # Call Lgmsh 
    Lgmsh.Lgmsh_export_init(filename,nn,ne,coord,etype,connect)

end

