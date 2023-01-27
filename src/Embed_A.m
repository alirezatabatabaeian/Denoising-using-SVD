function Hankelized = Embed_A ( Data , L )

    % This function is able to Embed a Vector into a Hankel Matrix
    %      Data = Information Samples
    %      L = Length of Window ( Number of Rows in Hankelized Matrix )
    %      N = Length of Data Vector
    %      K = Number of Columns in Hankelized Matrix
    %      Hankelized = Embeded Matrix

    N = length( Data ) ;  % Length of Signal Definition
    K = N - L + 1 ;  % Number of Columns of Embeded Matrix Definition
    Hankelized  = zeros(L, K) ;  % Hankelized Matrix Definition
    for i = 1 : K
        for j = 1 : L
            Hankelized(j, i)  = Data( i + j - 1 ) ;  % Vector to Trajectory( Hankelized ) Matrix Transformation
        end
    end
    
end

