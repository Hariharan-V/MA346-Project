function [f,parameters] = LinearRegressionUsingRichardsonMethod(X_data,Y_data,tolerance,step)
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
p = diag(diag(A));
parameters = current+step*(p\(B-(A)*current));
% % % disp(parameters)
    while norm(B-A*parameters,2)>tolerance
        current = parameters;
        parameters = current+step*(p\(B-(A)*current));
%        disp(parameters)
       
    end
f = @(x) x*parameters(1:m)+parameters(m+1);
end

