function [ r , frobenius_error ] = Adaptive_r_Selection_A ( Main_Data , Noisy_Data , L )
    
    % This function is able to Find The Best Low Rank Approximation According to Main Data Vector
    %      N = Length of Data Vector
    %      L , K = Number of Rows of Matrix , Number of Columns of Matrix
    %      frobenius_error = Frobenius Error With Remaining Different Singular Values
    %      Hankel_NoisyData = Noisy Data Hankelization
    %      Approximated_Matrix = Approximated Matrix
    %      DeEmbed_NoisyData = DeEmbeded Noisy Data
    %      r = Number of Remaining Singular Values
    
    N = length( Main_Data ) ;  % Length of Data Vector Definition
    K = N - L + 1 ;  % Number of Matrix Columns Definition
    frobenius_error = zeros(1 , min(L,K)) ;  % Frobenius Error Vector Definition
    Hankel_NoisyData = Embed_A( Noisy_Data , L ) ;  % Embedding Noisy Data
        
        for r = 1 : min(L,K)  % Different Low Rank Approximations
            
             Approximated_Matrix = low_rank_approx( Hankel_NoisyData , r ) ;  % Low Rank Approximation
             DeEmbed_NoisyData = DeEmbed_A( Approximated_Matrix ) ;  % DeEmbedding Noiseless Data
             frobenius_error(1 , r) = norm( ( Main_Data - DeEmbed_NoisyData ) , 'fro' ) ;  % Norm of Difference Between Two Vectors
             
        end
        
    [~,r] = min( frobenius_error ) ;  % Find The Best r According to Lowest Frobenius Norm
    
end

