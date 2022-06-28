abstract type Rotation end


#
# Structure containing the director cossines and length for each element
#
struct Rotation3D <: Rotation

    # Cossenos diretores x'
    cos_xx::Float64
    cos_yx::Float64
    cos_zx::Float64
  
    # Cossenos diretores y'
    cos_xy::Float64
    cos_yy::Float64
    cos_zy::Float64
   
    # Cossenos diretores z'
    cos_xz::Float64
    cos_yz::Float64
    cos_zz::Float64
  
    # Comprimento
    #L::Float64 

    # fe
    fe::Float64
  
    # Rotação local
    α::Float64
  
    # Default constructor
    function Rotation3D(bmesh::Bmesh3D, ele::Int64, α=0.0)

        # Descobre os nós do elemento
        nos = Conect(bmesh,ele)

        # Descobre as coordenadas de cada um dos nós
        Xi = Coord(bmesh,nos[1] )
        Xj = Coord(bmesh,nos[2])
        
        # Calcula os Δs
        ΔX = Xj .- Xi
        
        # Comprimento do elemento
        L = norm(ΔX)

        # Cossenos diretores (X)
        cos_xx = ΔX[1] / L
        cos_yx = ΔX[2] / L
        cos_zx = ΔX[3] / L

        # Calcula "d"
        fe = sqrt(cos_xx^2 + cos_zx^2)
 
        # Duas situações
        if fe!=0.0

            # Eixo Y'
            cos_xy = -(cos_xx*cos_yx)/fe
            cos_yy =  (cos_zx^2+cos_xx^2)/fe
            cos_zy = -(cos_yx*cos_zx)/fe

            # Eixo Z´
            cos_xz = -cos_zx/fe
            cos_yz =  0.0
            cos_zz =  cos_xx/fe

        else

            # Eixo Y'
            # Para podermos usar direto no caso 2D
            cos_xy =  -cos_yx
            cos_yy =  0.0
            cos_zy =  0.0

            # Eixo Z´
            cos_xz =  0.0
            cos_yz =  0.0
            cos_zz =  0.0

        end

        # Cria o dado
        new(cos_xx, cos_yx, cos_zx, cos_xy, cos_yy, cos_zy, cos_xz, cos_yz, cos_zz, fe, α)

    end

  end




#
# Structure containing the director cossines and length for each element
#
struct Rotation2D <: Rotation

    # Cossenos diretores x'
    cos_xx::Float64
    cos_yx::Float64
  
    # Cossenos diretores y'
    cos_xy::Float64
    cos_yy::Float64
  
    # Comprimento
    #L::Float64 

    # fe
    #fe::Float64
  
    # Default constructor
    function Rotation2D(bmesh::Bmesh2D, ele::Int64)

        # Descobre os nós do elemento
        nos = Conect(bmesh,ele)

        # Descobre as coordenadas de cada um dos nós
        Xi = Coord(bmesh,nos[1])
        Xj = Coord(bmesh,nos[2])
        
        # Calcula os Δs
        ΔX = Xj .- Xi
        
        #Θ = atan(ΔX[2], ΔX[1])  
        
        # Comprimento do elemento
        L = norm(ΔX)

        # Cossenos diretores (X)
        # cos
        #cos_xx = cos(Θ) 
        cos_xx = ΔX[1] / L
        # -sin
        #cos_yx = -sin(Θ) 
        cos_yx = -ΔX[2] / L
        # cos
        cos_yy = cos_xx
        # sin
        cos_xy = -cos_yx
       
        # Cria o dado
        new(cos_xx, cos_yx, cos_xy, cos_yy)

    end

  end
  
  #
  # General driver for rotation
  #
  function Rotations(bmesh::Bmesh,ele::Int64,α=0.0)
    
    if isa(bmesh,Bmesh2D)
       return Rotation2D(bmesh,ele)
    else
       return Rotation3D(bmesh,ele,α)
    end
        
 end

  #
  # Rotação 2D
  # 
  function T_matrix(r::Rotation2D)

      T = @SMatrix [r.cos_xx   r.cos_xy   0.0       0.0     ;
                    r.cos_yx   r.cos_yy   0.0       0.0     ;  
                      0.0        0.0    r.cos_xx   r.cos_xy ;
                      0.0        0.0    r.cos_yx   r.cos_yy ]
  end


  #
  # Rotação 3D
  #
  function T_matrix(r::Rotation3D)

       # Rotação total
       T = zeros(6,6)
    
       # Bloco de zeros
       z = @SMatrix zeros(3,3)
    
        # Temos um caso particular, onde o elemento está rotacionando em torno do eixo Y
        if r.fe == 0.0 
      
            mox = r.cos_yx
        
            # Caso particular em que x local do elemento está na direção Y
            R =  @SMatrix [     0.0         mox          0.0;
                            -mox*cosd(r.α)   0.0     mox*sind(r.α);
                              sind(r.α)       0.0       cosd(r.α)]
            
          else
        
            # Matriz de rotação z' paralelo ao plano XZ
            T1 = @SMatrix [r.cos_xx r.cos_yx r.cos_zx;
                           r.cos_xy r.cos_yy r.cos_zy;
                           r.cos_xz r.cos_yz r.cos_zz]
        
            # Rotaciona em torno de X
            T2 = @SMatrix [1.0        0.0           0.0;
                           0.0     cosd(r.α)       sind(r.α);   
                           0.0    -sind(r.α)       cosd(r.α)]
                   
            # rotacionamos => Primeiro em X e depois em z'    
            R = T1*T2
        
            end
        
            # Posiciona R em T (aqui temos 4 blocos 3x3 pois temos 2 nós c 6 gdl cada)
            T = SMatrix{6,6,Float64}([R z ; z R])
            
            # Retorna a matriz de rotação
            return T

  end

  #
  # General call to T_matrix
  #
  function T_matrix(bmesh::Bmesh, ele::Int64, α=0.0)
    
       r = Rotations(bmesh,ele,α)
       T_matrix(r)
    
  end

