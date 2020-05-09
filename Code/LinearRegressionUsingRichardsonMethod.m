function [f,parameters,loss] = LinearRegressionUsingRichardsonMethod(X_data,Y_data,tolerance,step)
%   This function takes the explanatory data (X_data) and the output data (Y_data)
% It should output a function f which takes in a parameter X and gives a
% prediction that models Y_data. It should also return the parameters of
% the given linear model.
[n,m] = size(X_data);
X_data = [X_data ones(n,1)];
current = zeros(m+1,1);
T = transpose(X_data);
A = T*X_data;
B = T*Y_data;
p = diag(inv(diag(diag(A))));% this is the preconditioner
parameters = current+step*(p.*(B-(A)*current));
%for graphing
% y =[];
% x = [];
i = 1;
 loss = [];
    while norm(current-parameters,2)>tolerance
        current = parameters;
        parameters = current+step*(p.*(B-(A)*current));
        %for graphing
%        disp(parameters)
%          if i % 1000
             loss =[loss norm(X_data*parameters-Y_data,2)^2/n];
%             x = [x i];
%          end
%           i = i+1;
    end
    %for graphing
   
%     x = [x i];
%     plot(x,y);
%     hold on 
f = @(x) x*parameters(1:m)+parameters(m+1);
end

