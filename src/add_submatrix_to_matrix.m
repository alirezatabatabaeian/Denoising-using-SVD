function Out_Matrix = add_submatrix_to_matrix ( Matrix , SubMatrix , Row_Position , Column_Position )
     
     % This function is able to add an smaller matrix to another matrix into an special position of it
     %      Matrix = the Big Matrix
     %      Sub_Matrix = Smaller Matrix
     %      Out_Matrix = Add of matrix and sub matrix
     %      Row Position , Column Position = Positions 

     [R , C] = size ( SubMatrix ) ;  % Find the Size of Matrix
     Out_Matrix = Matrix ;  % Matrix = Output Matrix
     
     for i = 1 : R  % Add SubMatrix to Output Matrix
         
         for j = 1 : C
             
            Out_Matrix( i - 1 + Row_Position , j - 1 + Column_Position ) = ...
                Matrix( i - 1 + Row_Position , j - 1 + Column_Position ) + SubMatrix( i , j ) ;
         
         end
         
     end
     
end