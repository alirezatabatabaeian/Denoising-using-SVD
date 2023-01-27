%% Main Body

close all ; clear ; clc ;  % close all

figure(1);

% SNR varies between -20 to 20 and each experiment repeats 10 times
for i = -20 : 1 : 20
    
    for j = 1 : 2
        
        N = 500 ;  % Length of The Signal Definition

        L_A = N / 5 ;  % Length of the Hankelization Window Definition for Method A

        window_length_B = N / 5 ;  % Window Length for Partitions Method B

        L_B = window_length_B / 5 ;  %  Length of the Hankelization Window Definition for Method A

        MainData = load_normalization( 'chb01_01_edfm' , N ) ;  % First N Samples of the Main Date Load & Normalization

    %     SIGMA = 0.5 ;  % Standard Deviation of AWGN
        
        P_MainData = sum(MainData.^2)/N ;  % Main Data Power
         
    %     SNR = 10*log10(P_MainData/((SIGMA).^2)) ;  % Input SNR for Noisy Signal Definition

        SNR = i ;

        NoisyData = awgn( MainData , SNR , 'measured' ) ;  % Make a Noisy Signal
        
        Noise = NoisyData - MainData ;  % Noise Definition
        
        P_Noise = sum(Noise.^2)/N ;  % Power of the Noise Definition
        
        Real_SNR = 10*log10(P_MainData/P_Noise) ;  % Real SNR Calculation in dB

        [r_A , frobenius_error_A] = Adaptive_r_Selection_A( MainData , NoisyData , L_A ) ;  % Find the Optimum Number of Remaining Singular Values

        [r_B , frobenius_error_B] = Adaptive_r_Selection_B( MainData , NoisyData , window_length_B , L_B ) ;  % % Find the Optimum Number of Remaining Singular Values

        Hankel_NoisyData_A = Embed_A( NoisyData , L_A ) ;  % Embedding Noisy Signal

        Hankel_NoisyData_B = Embed_B( NoisyData , window_length_B , L_B ) ;  % Embedding Noisy Signal

        approximated_matrix_data_A = low_rank_approx( Hankel_NoisyData_A , r_A );  % Low Rank Approximation

        approximated_matrix_data_B = low_rank_approx( Hankel_NoisyData_B , r_B ) ;  % Low Rank Approximatio

        DeNoised_Vector_A = DeEmbed_A( approximated_matrix_data_A );  % De-Embedding De-Noised Data

        DeNoised_Vector_B = DeEmbed_B( approximated_matrix_data_B , N , window_length_B , L_B ) ;  % De-Embedding De-Noised Data
        
        % Plot Forbenius Error - SNR
        hold on;
        stem(Real_SNR,frobenius_error_A(r_A),'filled','linestyle','none','color','green');

        hold on;
        stem(Real_SNR,frobenius_error_B(r_B),'filled','linestyle','none','color','red');
        legend("Method A : (Frobenius Error(y)-SNR(x))" , "Method B : (Frobenius Error(y)-SNR(x))");
    end
    
end