
function result = gauss_eli_srpp_inverse (A)
  [n,m] = size(A);

  if n~=(m)
    error('This function requires a square matrix as an input!')
  end
  if det(A)==0 
    error('this matrix is singular!')
  end
  nn = 2*n;
  A = [A,diag(diag(ones(n)))];
  p = (1:n)';	 % the permutation vector
  s = max(abs(A(:,1:end-n)'));    % scale for each row
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
  
%   P = zeros(n,n);
%   for i = 1:size(p)
%     P(i,p(i)) = 1;
%   end
  U = triu(A(p,:));
  result = backward_sub_modified (U(:,1:end-n), U(:,n+1:end));
end
function x = backward_sub_modified (U, b)
  [m,n] = size(U);

  for j = n:-1:1
     m = U(j,j);
    for i = 1:n
      b(j,i) = b(j,i)/m;
    end
 
    for i = (j-1):-1:1
        m = U(i,j);
        for k = (1:n)
           
            b(i,k) = b(i,k)-m*b(j,k);
           
        end
       
    end
  
  end
   x = b;
end 