
#
# Structure containing the director cossines and length for each element
#
struct Rotation

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
    L::Float64 

    # fe
    fe::Float64
  
    # Rotação local
    α::Float64
  
    # Default constructor
    function Rotation(bmesh::Bmesh, ele::Int64, α=0.0)

        # Descobre os nós do elemento
        nos = Conect(bmesh,ele)

        # Descobre as coordenadas de cada um dos nós
        Xi = Coord(bmesh,nos[1])
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
            cos_yy =  (-cos_zx^2+cos_xx^2)/fe
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
        new(cos_xx, cos_yx, cos_zx, cos_xy, cos_yy, cos_zy, cos_xz, cos_yz, cos_zz, L, fe, α)

    end

  end
  
  #
  # Rotação 2D
  # 
  function T2(r::Rotation)

      T = [r.cos_xx   r.cos_xy   0.0       0.0     ;
           r.cos_yx   r.cos_yy   0.0       0.0     ;  
             0.0        0.0    r.cos_xx   r.cos_xy ;
             0.0        0.0    r.cos_yx   r.cos_yy ]
  end


  #
  # Rotação 3D
  #
  function T3(r::Rotation)

       # Rotação em cada nó
       R = zeros(3,3)

       # Rotação total
       T = zeros(6,6)
    
        # Temos um caso particular, onde o elemento está rotacionando em torno do eixo Y
        if r.fe == 0.0 
      
            # Caso particular em que o elemento está na direção Y
            R =  [     0.0        1.0        0.0;
                   -cos(r.α)      0.0     sin(r.α);
                    sin(r.α)      0.0     cos(r.α)]
            
          else
        
            # Matriz de rotação z' paralelo ao plano XZ
            T1 = [r.cos_xx r.cos_yx r.cos_zx;
                  r.cos_xy r.cos_yy r.cos_zy;
                  r.cos_xz r.cos_yz r.cos_zz]
        
            # Rotaciona em torno de X
            T2 = [1.0        0.0           0.0;
                  0.0     cos(r.α)       sin(r.α);   
                  0.0    -sin(r.α)       cos(r.α)]
                   
            # rotacionamos => Primeiro em X e depois em z'    
            R = T1*T2
        
            end
        
            # Posiciona R em T (aqui temos 4 blocos 3x3 pois temos 2 nós c 6 gdl cada)
            T[1:3,1:3] .= R
            T[4:6,4:6] .= R
        
            
            # Retorna a matriz de rotação
            return T

  end



  #
  # Monta a matriz de rotação para um elemento 
  #
  function Monta_T(r::Rotation, bmesh::Bmesh)

        if bmesh.dimension==2
            return  T2(r)
        else
            return  T3(r)
        end

   end    
