clear; clc; close all; format compact;

%% Full data set
load('fullDataSet_varyK');

figure(1); clf;
plot(k_range, auc, 'o-', 'linewidth', 1, 'markersize', 3);
ylabel('ROC AUC');
xlabel('k');
title('Full Data Set with Increasing k');
grid on;
set(gca, 'xtick', 0:25:100);
ylim([0.49 1.01]);

% export_fig('fullDataSet.png');


%% Subsample with fixed k
% f_range = 0.1:0.1:1; % Sample fraction
% auc_map = zeros(100, length(f_range));
% for ff = 1:length(f_range)
%     f = f_range(ff);
%     file_name = ['f0p', num2str(f*10), '.mat'];
%     load(file_name);
%     auc_map(:,ff) = auc;
% end % for f
% 
% figure(2); clf;
% boxplot(auc_map, f_range, 'PlotStyle', 'compact')
% xlabel('Sample Fraction');
% ylabel('ROC AUC');
% title('Subsample with Fixed k=2');
% box on;
% ylim([0.49 1.01]);
% 
% % export_fig('subsampleWithFixedK.png');


%% Subsample with proportional k
% f_range = 0.1:0.1:1; % Sample fraction
% auc_map = zeros(100, length(f_range));
% for ff = 1:length(f_range)
%     f = f_range(ff);
%     file_name = ['Subsampling_f0p', num2str(f*10), '.mat'];
%     load(file_name);
%     auc_map(:,ff) = auc;
% end % for f
% 
% figure(2); clf;
% boxplot(auc_map, f_range, 'PlotStyle', 'compact')
% xlabel('Sample Fraction');
% ylabel('ROC AUC');
% title('Subsample with k=20*f');
% box on;
% ylim([0.49 1.01]);
% 
% % export_fig('subsampleWithProportionalK.png');
