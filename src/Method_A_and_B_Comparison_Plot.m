%% Main Body

close all ; clear ; clc ;  % close all

N = 500 ;  % Length of The Signal Definition

L_A = N / 5 ;  % Length of the Hankelization Window Definition

window_length_B = N / 5 ;  % Window Length for Partitions Method B

L_B = window_length_B / 5 ;  % Length of the Window Definition

MainData = load_normalization( 'chb01_01_edfm' , N ) ;  % First N Samples of the Main Date Load & Normalization

SIGMA = 0.5 ;  % Standard Deviation of AWGN

P_MainData = sum(MainData.^2)/N ;  % Main Data Power

SNR = 10*log10(P_MainData/((SIGMA).^2)) ;  % Input SNR for Noisy Signal Definition

NoisyData = awgn( MainData , SNR , 'measured' ) ;  % Make a Noisy Signal

[r_A , frobenius_error_A] = Adaptive_r_Selection_A( MainData , NoisyData , L_A ) ;  % Find the Optimum Number of Remaining Singular Values

[r_B , frobenius_error_B] = Adaptive_r_Selection_B( MainData , NoisyData , window_length_B , L_B ) ;  % Find the Optimum Number of Remaining Singular Values

Hankel_NoisyData_A = Embed_A( NoisyData , L_A ) ;  % Embedding Noisy Signal

Hankel_NoisyData_B = Embed_B( NoisyData , window_length_B , L_B ) ;  % Embedding Noisy Signal

approximated_matrix_data_A = low_rank_approx( Hankel_NoisyData_A , r_A );  % Low Rank Approximation

approximated_matrix_data_B = low_rank_approx( Hankel_NoisyData_B , r_B ) ;  % Low Rank Approximation

DeNoised_Vector_A = DeEmbed_A( approximated_matrix_data_A );  % De-Embedding De-Noised Data

DeNoised_Vector_B = DeEmbed_B( approximated_matrix_data_B , N , window_length_B , L_B ) ;  % De-Embedding De-Noised Data

%% Plot Time Response
figure(1);
hold on;
n = 0 : 1 : N-1;
plot(n,MainData,'color',[0, 0, 1]); %blue
plot(n,DeNoised_Vector_A,'color',[0.4660, 0.6740, 0.1880]); %green
plot(n,DeNoised_Vector_B,'color',"red"); %red
title('Time Response','color','[0.9 0.5 0.7]');
legend("Main Data","DeNoised Data A","DeNoised Data B");
%% Plot Frequency Response
figure(2);
hold on;
[h1,w]=freqz(MainData,1);
[h2,~]=freqz(DeNoised_Vector_A,1);
[h3,~]=freqz(DeNoised_Vector_B,1);
plot(w'/pi,abs(h1'),'color',[0, 0, 1]); %blue
plot(w'/pi,abs(h2'),'color',[0.4660, 0.6740, 0.1880]); %green
plot(w'/pi,abs(h3'),'color',"red"); %red
title('Magnitude Frequency Response','color','[0.9 0.5 0.7]');
legend("Main Data","DeNoised Data A","DeNoised Data B");