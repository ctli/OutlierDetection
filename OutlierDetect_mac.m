clear; clc; close all; format compact;

load('satimage-2.mat');
X0 = X;
y0 = y;
n0 = size(X0,1); % Size of full data

%ni = 2000;
%ni = n0;
ni = 20;

id_training = randperm(n0, ni);
X = X0(id_training,:);
y = y0(id_training,:);

a = 1;
while ~any(y==1) % Take samples until the set contains some outliers
  id_training = randperm(n0, ni);
  X = X0(id_training,:);
  y = y0(id_training,:);
  a = a+1;
  if a>50
    break;
  end
end

id_outlier = find(y==1)

%% MAC algorithm
output = 1 - my_mac(X'); % Note MAC assumes samples are stored in columns, not rows!
outlier_score = (sum(output));
outlier_score_normalized = (sum(output))/ni;

%% Select threshold
threshold = 0.1;
y_predict = zeros(size(outlier_score_normalized));
y_predict(outlier_score_normalized>threshold) = 1;
id_outlier_predict = find(y_predict==1);

%% Compute f1 score
[TP, FP, TN, FN] = calError(y, y_predict');
precision = TP/(TP+FP);
recall = TP/(TP+FN);
f1score = 2*(recall*precision)/(recall+precision)

% ====================
figure(3); clf;
plot(outlier_score_normalized, '-', 'linewidth', 1, 'markersize', 4); hold on;
h1 = plot([0 ni+1], [1 1]*threshold, '--', 'color', 'g');
h2 = plot(id_outlier, outlier_score_normalized(id_outlier), 'xr', 'markersize', 10, 'linewidth', 1);
h3 = plot(id_outlier_predict, outlier_score_normalized(id_outlier_predict), 'o', 'markersize', 10, 'linewidth', 1, 'color', [0.9290 0.6940 0.1250]);
xlim([0 ni+1]);
ylabel('Normalized Outlier Score = \Sigma(1-MAC)/ni');
xlabel('Sample #');
grid on;
title(['Sample Size: ni=', num2str(ni), '; f1 Score=', num2str(f1score)]);
ylim([0 0.25]);
legend([h1, h2, h3], 'Threshold', 'True Outlier', 'Predicted Outlier');


