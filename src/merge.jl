"""
Merge two BMeshes and return a new one

    Merge(b1::Bmesh, b2::Bmesh; atol=1E-5)

The first bmesh is kept and the second bmesh is edited
to delete repeated nodes end elments.

"""
function Merge(b1::Bmesh, b2::Bmesh; atol=1E-5)

    # The two meshes must be 2D or 3D
    #isa(b1,Bmesh2D) && isa(b2,Bmesh2D) || throw("Merge: both Bmeshes must have the same dimensionality")
    #isa(b1,Bmesh3D) && isa(b2,Bmesh3D) || throw("Merge: both Bmeshes must have the same dimensionality")

    # The first thing is to compare all nodes and find the ones with the "same" 
    # coordinates. Lets use two lists

    # First mesh is the "reference"
    nn1 = b1.nn
    nn2 = b2.nn

    # Element types
    etype1 = b1.etype
    etype2 = b2.etype

    @assert typeof(b1)==typeof(b2) "Merge:: Bmeshes must be the same type"
    @assert etype1==etype2     "Merge::element types must be the same"
    
    # Lets create a vector with -1. If some node of b2 is approx
    # we mark this position
    refer = -1*ones(Int64,nn1)

    # This is gonna be hard
    @inbounds for i=1:nn1
        
        # Coordinates of node i, reference mesh
        c1 = b1.coord[i,:]

        # Loop in the other mesh
        @inbounds for j=1:nn2

            # Coordinates of node j, second mesh
            c2 = b2.coord[j,:]

            # Check if simmilar
            if isapprox(c1,c2,atol=atol)
               refer[i] = j
               break
            end

        end #j
    end #if

    # We have our map. Lets see the number of common nodes
    pos_ref_clean = refer.>0
    ref_clean = refer[pos_ref_clean]
    nnc = length(ref_clean)

    if nnc==0
        throw("Merge:: no nodes in common between both meshes")
    end
    
    # The final number of nodes is
    nn = nn1 + nn2 - nnc
    
    # Dimension
    ncol = size(b1.coord,2)

    # The logic is the following. Using b1 as reference, the first 
    # n1 nodes are the same as b1 and the next nodes are the ones
    # in b2, but with the redundant nodes deleted. 
    
    # New coordinates are
    ncoord = Array{Float64}(undef,nn,ncol)

    # copy the n1 first coordinates
    ncoord[1:nn1,:].=b1.coord
 
    # Iterate over b2 skipping nodes in ref_clean
    cont = nn1 + 1
    @inbounds for j=1:nn2
        if !(j in ref_clean)
            ncoord[cont,:] .= b2.coord[j,:]
            cont += 1
        end
    end

    @assert cont-1==nn "Merge:: it should not happen"
    
    #
    # Now we merge the elements. Again, we use b1 as reference, but we do not now
    # if some elements are duplicate
    # 

    # First we change node numbers in b2
    # but putting a negative sign to avoid sobreposition
    connect2 = copy(b2.connect)

    # Loop in refer
    for p=1:nn1
        # access refer[p]
        rp = refer[p]  
        # If it is a valid information
        if rp>0
            # node rp in b2 is now node p
            for i in LinearIndices(connect2)
                if connect2[i]==rp
                    connect2[i]=-p
                end #if 
            end #for i
        end #if rp
    end

    # The problem now is to find the correct number for the other
    # nodes in connect2. Lets make another map
    cont = nn1
    newnodes2 = -1*ones(Int64,nn2)
    @inbounds for i=1:nn2
        if !(i in ref_clean)
           cont+=1
           newnodes2[i]=cont
        end
    end #i

    # Now we loop in coonect2
    @inbounds for i in LinearIndices(connect2)
        no = connect2[i]
        if no>0
            connect2[i]=newnodes2[no]
        end
    end

    # Drop the -
    connect2 .= abs.(connect2)

    # Look for duplicate elements. 
    dups = -1*ones(Int64,b2.ne)
    @inbounds for i=1:b2.ne
        cc2 = sort(connect2[i,:])
        @inbounds for j=1:b1.ne
            cc1 = sort(b1.connect[j,:])
            if all(cc1.==cc2)
               dups[i] = j
            end
        end #j
    end#i

   # Check for duplicates
   vdups = dups[dups.>0]
   ndups = length(vdups)

   # If no duplicates, just merge
   if ndups==0
      nconnect = vcat(b1.connect,connect2)
   else
      ncol = size(connect2,2)
      nconnect_ = Array{Int64}(undef,b1.ne+b2.ne,ncol)
      nconnect_[1:b1.ne,:] .= b1.connect
      cont = b1.ne
      for i=1:b2.ne
          if dups[i]==-1
            cont += 1
            nconnect_[cont,:] .= connect2[i,:]
          end
      end
      #resize
      nconnect = nconnect_[1:cont,:]
    end  

    # Create the Bmesh
    nne = size(nconnect,1)

    if isa(b1,Bmesh2D)
       bm = Bmesh2D(etype1,nn,nne,ncoord,nconnect,1.0,1.0,1,1)
    else
       bm = Bmesh3D(etype1,nn,nne,ncoord,nconnect,1.0,1.0,1.0,1,1,1)
    end

end

