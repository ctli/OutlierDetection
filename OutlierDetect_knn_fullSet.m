clear; clc; close all; format compact;

load('satimage-2.mat');

k_range = [2, 5:5:100];
auc = zeros(1, length(k_range)); % Area under curve
tic;
for m = 1:length(k_range)
    m
    n_neighbor = k_range(m);
    outlier_score = my_knn(X, n_neighbor); % KNN algorithm
    
    % ====================
    % Compute the ROC curve
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
    
    figure(2); clf;
    plot(FPR, TPR, 'x-', 'linewidth', 1);
    grid on;
    axis equal;
    axis([-0.02 1.02 -0.02 1.02]);
    title(['ROC: k=', num2str(n_neighbor), '; AUC=' , num2str(auc(m))]);
    xlabel('FPR');
    ylabel('TPR');
    toc;
    
    save(['fullDataSet_k', num2str(n_neighbor)], 'FPR', 'TPR');
end % for m
save('fullDataSet_increasingK', 'auc', 'k_range');

figure(3); clf;
plot(k_range, auc, 'o-', 'linewidth', 1, 'markersize', 3, 'color', default_blue);
ylabel('ROC AUC');
xlabel('k');
title('Use the Full Data Set');
grid on;
set(gca, 'xtick', 0:25:100);

% export_fig('fullDataSet_increasingK.png');


