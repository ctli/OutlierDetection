clear; clc; close all; format compact;

pkg load statistics;

load('satimage-2.mat');

id_inliner = find(y==0);
id_outliner = find(y==1);

%% ====================
figure(1); clf;
mesh(X);

%% ====================
figure(2); clf;
b = boxplot(X(id_inliner,:), 'Whisker', 1.5, 'PlotStyle', 'compact');
ylim([20 160]);

%% ====================
m = median(X(id_inliner,:));
Q1 = quantile(X(id_inliner,:), 0.25);
Q3 = quantile(X(id_inliner,:), 0.75);
IQR = Q3 - Q1;
wL = Q1 - 1.5*IQR;
wH = Q3 + 1.5*IQR;

%% ====================
% Plot exemplary inliner
figure(3); clf;

x1 = 1:36;
x2 = fliplr(x1);
y1 = Q3;
y2 = fliplr(Q1);
fill([x1, x2]', [y1, y2]', [0.65 0.9 1], 'linestyle', 'none', 'FaceAlpha', 0.5); hold on;

x1 = 1:36;
x2 = fliplr(x1);
y1 = Q3;
y2 = fliplr(wH);
fill([x1, x2]', [y1, y2]', [1 0.7 0.85], 'linestyle', 'none', 'FaceAlpha', 0.5); hold on;

x1 = 1:36;
x2 = fliplr(x1);
y1 = Q1;
y2 = fliplr(wL);
fill([x1, x2]', [y1, y2]', [0.675 1 0.675], 'linestyle', 'none', 'FaceAlpha', 0.5); hold on;

h1 = plot(m, 'color', [1 1 1]*0.8, 'linewidth', 2); hold on;
ylim([20 160]);
xlim([0 37]);
% title('Inliner');

h2 = plot(X(3989,:), 'o-', 'markersize', 3, 'color', [0.8500 0.3250 0.0980], 'markerfacecolor', [0.8500 0.3250 0.0980]); %high
h3 = plot(X(4377,:), 'o-', 'markersize', 3, 'color', [0 0.4470 0.7410], 'markerfacecolor', [0 0.4470 0.7410]); %mid
h4 = plot(X(2161,:), 'o-', 'markersize', 3, 'color', [0.9290 0.6940 0.1250], 'markerfacecolor', [0.9290 0.6940 0.1250]); %Low

legend([h1, h2, h3, h4], 'Median', 'Sample #3989', 'Sample #4377', 'Sample #3198')
set(legend, 'orientation', 'horizontal');
set(legend, 'location', 'northoutside');

%% ====================
%% Plot exemplary outliner
figure(4); clf;

x1 = 1:36;
x2 = fliplr(x1);
y1 = Q3;
y2 = fliplr(Q1);
fill([x1, x2]', [y1, y2]', [0.65 0.9 1], 'linestyle', 'none', 'FaceAlpha', 0.5); hold on;

x1 = 1:36;
x2 = fliplr(x1);
y1 = Q3;
y2 = fliplr(wH);
fill([x1, x2]', [y1, y2]', [1 0.7 0.85], 'linestyle', 'none', 'FaceAlpha', 0.5); hold on;

x1 = 1:36;
x2 = fliplr(x1);
y1 = Q1;
y2 = fliplr(wL);
fill([x1, x2]', [y1, y2]', [0.675 1 0.675], 'linestyle', 'none', 'FaceAlpha', 0.5); hold on;

h1 = plot(m, 'color', [1 1 1]*0.8, 'linewidth', 2); hold on;
ylim([20 160]);
xlim([0 37]);

%id_take = id_outliner(53);

%id_take = id_outliner(4);
%id_take = id_outliner(38);
% id_take = id_outliner(18);
% id_take = id_outliner(46);
id_take = id_outliner(67);



h2 = plot(X(id_take,:), 'ko-', 'markersize', 3, 'markerfacecolor', 'k');

legend([h1, h2], 'Median', ['Sample #', num2str(id_outliner(1))]);
set(legend, 'orientation', 'horizontal');
set(legend, 'location', 'northoutside');
