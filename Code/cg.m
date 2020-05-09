function [f,parameters,loss] = cg(X_data,Y_data,tolerance)
%   This function takes the explanatory data (X_data) and the output data (Y_data)
% It should output a function f which takes in a parameter X and gives a
% prediction that models Y_data. It should also return the parameters of
% the given linear model.
[n,m] = size(X_data);
X_data = [X_data ones(n,1)];

A = X_data'*X_data;
B= X_data'*Y_data;
x= zeros(m+1,1);
%for graphing
% X = [];
loss = [];
r0 = B-A*x;
p0 = r0;
% i = 1;%for graphing
while true
    a = (r0'*r0)/(p0'*A*p0);
    x = x+ a*p0;
    r1 = r0 - a*A*p0;
%     %for graphing
       loss = [loss norm(X_data*x-Y_data,2)^2/n];
%     X = [X i];
%     i = i+1;
    if norm(r1,2) <tolerance
        break
    end
    B = (r1'*r1)/(r0'*r0);
    p0 = r1+B*p0;
    r0 = r1;
end
%for graphing
% plot(X,Y);
parameters = x;
f = @(x) x*parameters(1:m)+parameters(m+1); 
end
