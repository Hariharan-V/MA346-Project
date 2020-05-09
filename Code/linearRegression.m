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
names = opts.VariableNames;
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Import the data
parkinsonsupdrs = readtable(fullfile(cd, "/Data/parkinsons_updrs.csv"), opts);


%% Clear temporary variables
clear opts

 data = parkinsonsupdrs{:,:};
X_data = parkinsonsupdrs(:,{'subject','age','sex','test_time','Jitter','JitterAbs','JitterRAP','JitterPPQ5','JitterDDP','Shimmer','ShimmerdB','ShimmerAPQ3','ShimmerAPQ5','ShimmerAPQ11','ShimmerDDA','NHR','HNR','RPDE','DFA','PPE'});
%'age'
output = 'total_UPDRS';
Y_data1 = parkinsonsupdrs(:,{output});%change this to motor_updrs for predicting motor updrs
used_vars = {'subject','age','sex','test_time','Jitter','JitterAbs','JitterRAP','JitterPPQ5','JitterDDP','Shimmer','ShimmerdB','ShimmerAPQ3','ShimmerAPQ5','ShimmerAPQ11','ShimmerDDA','NHR','HNR','RPDE','DFA','PPE'};

[data_size,m] = size(data);
tiledlayout(5,5)
log_trans = [];
log_it_trans=[];
for i = 1:m
    ax = nexttile;    
    h =histogram(ax,data(:,i));
    title(names(i));
    disp(names(i));
    fprintf(" min:%.9f max:%.9f  \n",min(data(:,i)),max(data(:,i)))
    if min(data(:,i))>0 && ( names(i) ~= "total_UPDRS"&&names(i) ~= "motor_UPDRS")
        
        if max(data(:,1))<1
          log_it_trans = [log_it_trans names(i)]   
        else
            log_trans = [log_trans names(i)];
        end
    end
end

Y_data1 = Y_data1{:,:};
 X_data = X_data{:,:};
 m_ = mean(X_data);
 [~,n] = size(m_);
 
 X_data = [X_data cos(X_data) sin(X_data) exp(1).^X_data  ];

%  for i = 1:n
%    X_data = [X_data arrayfun( @(x) exp(x-m_(i))/(exp(x-m_(i))+1),X_data(:,i))];
%  end

[~,n] = size(log_trans);
for i = 1:n
%     disp(log_trans(i))
    col = parkinsonsupdrs(:,log_trans(i));
    col = col{:,:};
    X_data =[X_data log(col)./log(10) sin(log(col)./log(10)) cos(log(col)./log(10)) exp(1).^(log(col)./log(10))];
    
end


 
 [f,p] = LinearRegressionUsingSRPP(X_data,Y_data1);
% [f,p] = cg(X_data, Y_data1,.01);
M = Metrics(f,X_data,Y_data1);
disp("Metrics:")

% % [~,n] = size(used_vars);
% % 
% %  equation =output+" = "+ p(1)+"*"+used_vars(1);
% % for i=2:n
% %    equation = equation+" + "+p(i)+"*"+used_vars(i);
% % end
% % 
% % m = n+1;
% % 
% % [~,n] = size(log_trans);
% % for i = m:n+m-1
% %     equation = equation + " + log10( "+log_trans(i-m+1)+")*"+p(i);
% % end
% % 
% % equation = equation+ " + "+p(m+n);
% disp(equation)
disp(M)
figure(2)
scatter([1:data_size],Y_data1-f(X_data));
title("Residual plot for "+output);
