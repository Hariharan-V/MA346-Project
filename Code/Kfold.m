function avg = Kfold(k,X_data,Y_data,method,tolerance,step)
%shuffle data randomly and split the data into training and testing,
%train model, produce averaged metrics 

% shuffle
len = length(X_data);
shuffler = randperm(len);
X_data = X_data(shuffler,:);
Y_data = Y_data(shuffler);

% size of test array
c = (len + (k - rem(len,k)))/k;

total = zeros(1,5);

% train and test k times
for i = 1:k
  % divide em up into train and test
  if i == k
    X_test = X_data(c*(i-1)+1:len,:);
    Y_test = Y_data(c*(i-1)+1:len);
    
    X_train = X_data;
    Y_train = Y_data;
    X_train(c*(i-1)+1:len,:) = [];
    Y_train(c*(i-1)+1:len) = [];
  else
    X_test = X_data(c*(i-1)+1:c*i,:);
    Y_test = Y_data(c*(i-1)+1:c*i);
    
    X_train = X_data;
    Y_train = Y_data;
    X_train(c*(i-1)+1:c*i,:) = [];
    Y_train(c*(i-1)+1:c*i) = [];
  end
  
  % train ya model
  if method == "srpp"
    [f,p] = LinearRegressionUsingSRPP(X_train,Y_train);
  elseif method == "richardson"
    [f,p] = LinearRegressionUsingRichardsonMethod(X_train,Y_train,tolerance,step);
  else
    error("invalid method");
  end
  
  % get ya metrics
  [n,m] = size(X_test);
  Y_result = f(X_test);
  MAE = norm(Y_result-Y_test)/n;
  residual = norm(Y_result-Y_test,2)^2;
  MSE = residual/n;
  RMSE = MSE^0.5;
  average = mean(Y_test);
  R_sq = 1-residual/norm(Y_test-average,2)^2;
  R_sq_adj = 1-(1-R_sq)*(n-1)/(n-m-1);
  
  total = total + [MAE,MSE,RMSE,R_sq,R_sq_adj];
end
avg = array2table(total/k, 'VariableNames',{'MAE','MSE','RMSE','R_sq','R_sq_ad'});


end

