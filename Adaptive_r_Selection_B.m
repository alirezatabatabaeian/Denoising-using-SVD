function [ r , frobenius_error ] = Adaptive_r_Selection_B( Main_Data , Noisy_Data , window_length , L )
     
    N = length( Main_Data ) ;  % Length of Data Vector Definition
    Embed_Noisy_Data = Embed_B( Noisy_Data , window_length , L ) ;
    [R , C] = size( Embed_Noisy_Data ) ;
    frobenius_error = zeros( 1 , min(R,C) );
    
    
    for r = 1 : min(R,C)
            approximated_matrix_data = low_rank_approx( Embed_Noisy_Data , r ) ;
            DeEmbeded_Data = DeEmbed_B( approximated_matrix_data , N , window_length , L ) ;
            frobenius_error(1,r) = norm( ( Main_Data - DeEmbeded_Data ) , 'fro' );
    end
    
    [~,r] = min(frobenius_error);
    

end