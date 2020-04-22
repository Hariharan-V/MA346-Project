function result = gauss_eli_srpp_modified (A)
  [n,m] = size(A);
  nn = m;
  if n~=(m-1)
    error('This function requires a n by n+1 matrix (for gaussian elimination) as an input!')
  end
  p = (1:n)';	 % the permutation vector
  s = max(abs(A(:,1:end-1)'));    % scale for each row
  for k = 1:(n-1) % k-th step of Gaussian Elimination
    d_s = abs(A(p(k),k))/s(p(k));
    pivot_index = k;
    
    %% Find next Pivot row
    for i = k+1:n
      z = abs(A(p(i),k))/s(p(i)); 
      if z > d_s  
        d_s = z;  
        pivot_index = i;  
      end
    end    
    
    %% Change the permutation vector indicating row-swaps
    curr_index = p(k); 
    p(k)= p(pivot_index);  
    p(pivot_index) = curr_index; 
    
    %% Gaussian Elimination for step-k. 
    for i = (k+1):n
      m = A(p(i),k)/A(p(k),k); % The multiplier for row k+1, ...
      
      %%change elements of every column in row i
      for j = (k+1):nn
        A(p(i),j) = A(p(i),j)- m*A(p(k),j);
        
      end
      
%       A(p(i),k) = m; % We can save the multiplier right in A in place of L
    end
    
  end
 U = triu(A(p,:));
  result = backward_sub (U(:,1:end-1), U(:,end));
end
function x = backward_sub (U, b)
  [m,n] = size(U);
  x = zeros(n,1);        % initialize x to be a column vector
  
  %% The last variable calculated directly
  x(n) = b(n)/U(n,n); 
  
  %% Back-substitution for remaining variables.
  %% ---This could alsobe accomplished without loop by using .*
  for i = (n-1):-1:1 
    x(i) = b(i); % Remember back-sub: x_i = (b_i - sum of A_ij*x_j )/A_ii
    for j = (i+1):n
      x(i) = x(i)-U(i,j)*x(j);
    end
    x(i) = x(i)/U(i,i);
  end

end
