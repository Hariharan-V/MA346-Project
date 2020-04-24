function [f,parameters] = LinearRegressionUsingSRPP(X_data,Y_data)
%   This function takes the explanatory data (X_data) and the output data (Y_data)
% It should output a function f which takes in a parameter X and gives a
% prediction that models Y_data. It should also return the parameters of
% the given linear model.
[n,m] = size(X_data);
X_data = [X_data ones(n,1)];
T = transpose(X_data);
A = T*X_data;
% disp(size(A))
B = T*Y_data;
 A = [A B];
parameters = gauss_eli_srpp_modified(A);
f = @(x) x*parameters(1:m)+parameters(m+1);
end

