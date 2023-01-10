function Output = load_normalization( File , N )

    % This function is able to load and normalize the first N samples 
    %      File = Data File Name
    %      N = Number of Needed Samples
    %      temp = all the samples
    %      Samples = First N Samples
    %      Output = Normalized First N Samples
    
    
    temp = load( [File , '.mat'] ) ;  % Data Loading
    temp = temp.val ;
    Samples = zeros (1, N) ;  % Output Matrix Definition
    
    for n = 1 : N
        Samples(1,n) = temp(1,n) ;  % Needed Samples Transferation to Output
    end
    
    Output = Samples / max( abs( Samples )) ;  % Data Normalization (Dividing by the Maximum Absolute Value )
    
end