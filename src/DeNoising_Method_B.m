%% Main Body 

close all ; clear ; clc ;  % close all

N = 500 ;  % Length of The Signal Definition

window_length = N / 5 ;  % Window Length for Partitions

L = window_length / 5 ;  % Window Length for Hankelization

MainData = load_normalization( 'chb01_01_edfm' , N ) ;  % First N Samples of the Main Date Load & Normalization

SIGMA = 0.4 ;  % Standard Deviation of AWGN

P_MainData = sum(MainData.^2)/N ;  % Main Data Power

SNR = 10*log10(P_MainData/((SIGMA).^2)) ;  % Input SNR for Noisy Signal Definition

NoisyData = awgn( MainData , SNR , 'measured' ) ;  % Make a Noisy Signal

[r , frobenius_error] = Adaptive_r_Selection_B( MainData , NoisyData , window_length , L ) ;  % Find the Optimum Number of Remaining Singular Values

Hankel_NoisyData = Embed_B( NoisyData , window_length , L ) ;  % Embedding Noisy Signal

approximated_matrix_data = low_rank_approx( Hankel_NoisyData , r ) ;  % Low Rank Approximation

DeNoised_Vector = DeEmbed_B( approximated_matrix_data , N , window_length , L ) ;  % De-Embedding De-Noised Data

%% Plot Time Response
figure(5);
hold on;
n = 0 : 1 : N-1;
plot(n,MainData,'color',[0, 0, 1]); %blue
plot(n,NoisyData,'color',[0.4660, 0.6740, 0.1880]); %green
plot(n,DeNoised_Vector,'color',"red"); %red
title('Time Response','color','[0.9 0.5 0.7]');
legend("Main Data","Noisy Data","DeNoised Data");
%% Plot Frequency Response
figure(6);
hold on;
[h1,w]=freqz(MainData,1);
[h2,~]=freqz(NoisyData,1);
[h3,~]=freqz(DeNoised_Vector,1);
plot(w'/pi,abs(h1'),'color',[0, 0, 1]); %blue
plot(w'/pi,abs(h2'),'color',[0.4660, 0.6740, 0.1880]); %green
plot(w'/pi,abs(h3'),'color',"red"); %red
title('Magnitude Frequency Response','color','[0.9 0.5 0.7]');
legend("Main Data","Noisy Data","DeNoised Data");
%% Plot Frobenius Error & Main Data and Noisy Data Singular Values
figure(7);
hold on;
Hankel_MainData = Embed_B( MainData , window_length , L ) ;
[R , C] = size( Hankel_MainData ) ;
p = 1 : min(R,C) ;
stem(p,frobenius_error,'filled','color','[0.2 0.5 0.3]');
title('Frobenius Error & Main Data and Noisy Data Singular Values','color','[0.9 0.5 0.7]');
[~,S_main_data,~] = svd (Hankel_MainData);
[~,S_noisy_data,~] = svd (Hankel_NoisyData);
[~,S_denoised_data,~] = svd (approximated_matrix_data);
if R <= C
    I = ones(C,1);
    S_main_data = (S_main_data*I)';
    S_noisy_data = (S_noisy_data*I)';
    S_denoised_data = (S_denoised_data*I)';
else
    I = ones(1,R);
    S_main_data = I*S_main_data;
    S_noisy_data = I*S_noisy_data;
    S_denoised_data = I*S_denoised_data;
end
q = 1 :  min(R,C) ;
stem(q,S_main_data,'filled','color','[0.5 0.5 0.1]');
stem(q,S_noisy_data,'filled','color','[0.5 0.5 0.9]');
legend("Frobenius Error","Main Data Singular Values","Noisy Data Singular Values");
%% Plot Lisagor Curves against MainData
figure(8);
hold on;
plot(MainData,MainData,'color','b');
plot(MainData,NoisyData,'color','g');
plot(MainData,DeNoised_Vector,'color','r');
title('Lisagor Curves','color','[0.9 0.5 0.7]');
legend("MainData-MainData","NoisyData-MainData","DeNoisedData-MainData");