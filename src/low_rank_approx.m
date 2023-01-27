function approx = low_rank_approx( Matrix , r )

    % This function is able to Approximate a Matrix Using Singular Value Decomposition
    %      Matrix = Data Matrix
    %      r = Number of Remaining Singular Values
    %      L , K = Number of Rows of Matrix , Number of Columns of Matrix
    %      U , S , V = Left Singular Vector Unitary Matrix , Singular Values Matrix , Right Singular Vector Unitary Matrix
    %      S_new = New Singular Value Matrix
    %      approx = Approximated Matrix

    [L , K] = size( Matrix ) ;  % Number of Rows and Columns of Matrix
    [U, S, V] = svd( Matrix ) ;  % Matrix Singular Value Decomposition
    S_new = zeros(L, K) ;  % New Singular value Definition
    
    if r ~= 0
        for i = 1 : r
            S_new(i, i) = S(i, i) ;  % Low Rank Approximation ( By Omitting Lower Singular Values)
        end
    end
    
    approx = U * S_new * V' ;  % Approximated Matrix Reconstruction
    
end

