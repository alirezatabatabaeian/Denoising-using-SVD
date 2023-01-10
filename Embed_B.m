function Block_Hankel = Embed_B ( Vector , window_length , L )

    % Windowing
    Vector_Length = length( Vector )  ;
    window_rows = Vector_Length / window_length ;
    Window = zeros( window_rows , window_length );
    
    for i = 1 : window_rows 
        for j = 1 : window_length
            Window(i , j) = Vector( ( i - 1 ) * window_length + j );
        end
    end
    
    % Block Hankelization
    if rem( window_rows , 2 ) == 0
        Vertical_Blocks   = ( window_rows ) / 2 ;
        Horizontal_Blocks = ( Vertical_Blocks + 1 ) ;        
    else
        Vertical_Blocks   = ( window_rows + 1 ) / 2 ;
        Horizontal_Blocks = ( window_rows + 1 ) / 2 ; 
    end
    
    K = window_length - L + 1 ;
    Block_Hankel = zeros( L * Vertical_Blocks , K * Horizontal_Blocks ) ;
    
    for i = 1 : Horizontal_Blocks        
        for j = 1 : Vertical_Blocks   
            Block_Hankel = add_submatrix_to_matrix( Block_Hankel , Embed_A( Window( i - 1 + j , : ) , L ) , (j-1)*L + 1 , (i-1)*K + 1 );     
        end   
    end
    
end