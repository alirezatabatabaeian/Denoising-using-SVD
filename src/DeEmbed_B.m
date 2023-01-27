function Vector = DeEmbed_B( Matrix , N , window_length , L )
    
    Vector = zeros(1,N);
    K = window_length - L + 1 ;
    window_rows = N / window_length ;
    [V_temp , H_temp] = size( Matrix ) ;
    Vertical_Blocks = V_temp / L ;
    Horizontal_Blocks = H_temp / K ;
    
    % DeEmbedding & Summation
    
    for i = 1 : Horizontal_Blocks
        
        for j = 1 : Vertical_Blocks
    
             Sub_Vector = DeEmbed_A( Matrix( 1 + (j-1)*L : j*L , 1 + (i-1)*K : i*K ) ) ;
             
             Vector = add_submatrix_to_matrix( Vector , Sub_Vector , 1 , 1 + (j-1)*window_length + (i-1)*window_length ) ;
            
        end
            
    end    
          
    
    % Division
    
    if rem(window_rows,2) == 0
        
        var_temp = window_rows / 2 ;
    
    else
        
        var_temp = ( window_rows - 1 ) / 2 ;
        
        k = ( window_rows + 1 ) / 2 ;
        Vector( 1 , (k-1)*window_length + 1 : k*window_length ) = Vector( 1 , (k-1)*window_length + 1 : k*window_length ) / k ;
        
    end
    
    
    for i = 1 : var_temp
        
        Vector( 1 , 1 + (i-1)*window_length : i*window_length ) = Vector( 1 , 1 + (i-1)*window_length : i*window_length ) / i ;
        
        Vector( 1 , N - (i-1)*window_length : -1 : N - (i)*window_length + 1 ) = Vector( 1 , N - (i-1)*window_length : -1 : N - (i)*window_length + 1 ) / i ;
        
    end
    
    
end