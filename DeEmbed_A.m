function Vector = DeEmbed_A ( Matrix )
    
    % This function is able to De-Embed a Matrix into a Vector Usin anti-Diagonal Averaging
    %      L , K = Number of Rows of Matrix , Number of Columns of Matrix
    %      N = Length of Data Vector
    %      Vector = De-Hankelized Matrix
    
    [L , K] = size( Matrix ) ;  % Number of Rows and Columns of Matrix
    N = K + L -1 ;  % Length of Vector Definition
    Vector = zeros(1, N) ;  % Vector Definition
    
    for i = 1 : K
        for j = i : L + i - 1
            Vector(1 , j) = Vector(1 , j) + Matrix( j - i + 1 , i) ;  % Matrix into Vector Elements Substitution
        end
    end
    
    % Averaging anti-Diagonal Elements
    for i = 1 : min(L,K)
         Vector(1 , i) =  ( Vector(1 , i) ) / i ;
    end
    
    if min(L,K) + 1 <= N - min(L,K)  % Dispart Two Different Possible Situations
        
         for i = min(L,K) + 1 : N - min(L,K)
             Vector(1 , i) = ( Vector(1 , i) ) / ( min(L,K) ) ;
         end
         
         for i = N - min(L,K) + 1 : N
             Vector(1 , i) =  ( Vector(1 , i) ) / ( N - i + 1 ) ;
         end
         
    else
        
         for i = min(L,K) + 1 : N
             Vector(1 , i) =  ( Vector(1 , i) ) / ( N - i + 1 ) ;
         end
         
    end
    
    
end