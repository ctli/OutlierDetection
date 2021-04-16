clear; clc; close all; format compact;

load('satimage-2.mat');
X0 = X;
y0 = y;

n0 = size(X0,1); % Size of full data

f_range = 0.1:0.1:1; % Sample fraction
for ff = 3%:length(f_range)
    ff
f = f_range(ff); % Sample fraction
ni = fix(n0*f); % Subsample size

n_trail = 100; % 100 trails
auc = zeros(1, n_trail); % Area under curve
tic;
for m = 1:n_trail
  id_training = randperm(n0, ni);
  X = X0(id_training,:);
  y = y0(id_training,:);
  
while ~any(y==1) % Take samples until the set contains some outliers
  id_training = randperm(n0, ni);
  X = X0(id_training,:);
  y = y0(id_training,:);
%  outlier_location = find(y==1)
end
  
%% ====================
% KNN algorithm  
n_neighbor = fix(20*f);
outlier_score = my_knn(X, n_neighbor);

% ====================
threshold_range = fliplr(unique(outlier_score));
FPR = zeros(1, length(threshold_range));
TPR = zeros(1, length(threshold_range));
for i = 1:length(threshold_range)
  y_predict = zeros(size(y));
  threshold = threshold_range(i);
  outlier_id = find(outlier_score>=threshold);
  y_predict(outlier_id) = 1;
  [TP, FP, TN, FN] = calError(y, y_predict);
  FPR(i) = FP/(TN+FP+eps);
  TPR(i) = TP/(TP+FN+eps);
end % for i
auc(m) = trapz(FPR, TPR);

%figure(3); clf;
%plot(FPR, TPR, 'x-');
%grid on;
%axis([-0.02 1.02 -0.02 1.02]);
%title(['m=', num2str(m), '; AUC=' , num2str(auc(m))]);
end % for m

file_name = ['Subsampling_f0p', num2str(f*10), '.mat'];
save(file_name, 'auc');
toc;
end % for f


