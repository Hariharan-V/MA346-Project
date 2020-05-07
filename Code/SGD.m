function [f,parameters] = SGD(X_data,Y_data,epoch,batch_size,step,step_reducer)
%   This function takes the explanatory data (X_data) and the output data (Y_data)
% It should output a function f which takes in a parameter X and gives a
% prediction that models Y_data. It should also return the parameters of
% the given linear model.
[n,m] = size(X_data);
  X_data = [X_data ones(n,1) Y_data];
X_data = X_data(randperm(size(X_data, 1)), :);
  Y_data = X_data(:,m+2);
  X_data = X_data(:,1:m+1);
current = zeros(m+1,1);
%for graphing
%  X = zeros(epoch,1);
%  Y = zeros(epoch,1);
v = zeros(m+1,1);
for j = 1:epoch

    for k = 1:ceil(n/batch_size)
        gradient = zeros(m+1,1);
       for i = batch_size*(k-1)+1:min(batch_size*k,n)   
        gradient = gradient +( (X_data(i,:)'*X_data(i,:))*current-X_data(i,:)'*Y_data(i,:)); 
     
       end
      %rms prop 
      v = 0.9*v+0.1*gradient.^2;
      %using rms prop, we can adjust step size for each epoch
       parameters = current - (step*((v+10e-8).^-0.5)).*(gradient);
       
       current = parameters;
       
    end
%for graphing
%      X(j) = j;
% 
%      Y(j) = norm(X_data*parameters-Y_data,2)^2/n;
   

end

%for graphing
  
%  plot(X,Y);

f = @(x) x*parameters(1:m)+parameters(m+1);

end

