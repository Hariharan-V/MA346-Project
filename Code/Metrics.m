function A = Metrics(f,X_test, Y_test)
%Takes model f, test data X and Y
% returns relevant metrics with labels such as mse, rsme, r^2, adjusted
% R^2, mae, training times, 
[n,m] = size(X_test);
% size(X_test)
Y_result = f(X_test);
MAE = norm(Y_result-Y_test)/n;
residual = norm(Y_result-Y_test,2)^2;
MSE = residual/n;
RMSE = MSE^0.5;
average = mean(Y_test);
R_sq = 1-residual/norm(Y_test-average,2)^2;
R_sq_adj = 1-(1-R_sq)*(n-1)/(n-m-1);
A = table(MAE,MSE,RMSE,R_sq,R_sq_adj);
end

