%import data
%apply kfold on each model
%graph metrics to compare

%% Import data from text file
% Script for importing data from the following text file:
%
%   
%
% Auto-generated by MATLAB on 23-Apr-2020 15:52:04

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 22);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["subject", "age", "sex", "test_time", "motor_UPDRS", "total_UPDRS", "Jitter", "JitterAbs", "JitterRAP", "JitterPPQ5", "JitterDDP", "Shimmer", "ShimmerdB", "ShimmerAPQ3", "ShimmerAPQ5", "ShimmerAPQ11", "ShimmerDDA", "NHR", "HNR", "RPDE", "DFA", "PPE"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Import the data
parkinsonsupdrs = readtable(fullfile(cd, "/Data/parkinsons_updrs.csv"), opts);


%% Clear temporary variables
clear opts

data = parkinsonsupdrs{:,:};
X_data = parkinsonsupdrs(:,{'subject','age','sex','test_time','Jitter','JitterAbs','JitterRAP','JitterPPQ5','JitterDDP','Shimmer','ShimmerdB','ShimmerAPQ3','ShimmerAPQ5','ShimmerAPQ11','ShimmerDDA','NHR','HNR','RPDE','DFA','PPE'});
Y_data1 = parkinsonsupdrs(:,{'total_UPDRS'});
% Y_data2 = parkinsonsupdrs(:,{'motor_UPDRS'});

Y_data1 = Y_data1{:,:};
X_data = X_data{:,:};
 [f1,p1] = LinearRegressionUsingSRPP(X_data,Y_data1);
  [f2,p2,loss2] = LinearRegressionUsingRichardsonMethod(X_data, Y_data1,.01,.01);
 [f3,p3,loss3] = cg(X_data, Y_data1,.01);
  [f4,p4,loss4] = SGD(X_data,Y_data1,300,50,.01);

 Metrics(f1,X_data,Y_data1)
   Metrics(f2,X_data,Y_data1)
   Metrics(f3,X_data,Y_data1)
 Metrics(f4,X_data,Y_data1)
  mdl = fitlm(X_data,Y_data1)
% scatter([1:5875],Y_data1-f1(X_data))
% disp(mdl);
% disp(Kfold(7,X_data,Y_data,"srpp"));
% disp(Kfold(7,X_data,Y_data,"richardson",.1,.001)); 
% works, just takes forever

% disp(p1)
% disp(p2)