%AVERAGE COST PER VOT PLOT

load RevenueVOT1.mat;
load RevenueVOT3.mat;
load RevenueVOT4.mat;
load RevenueVOT6.mat;
load RevenueVOT7.mat;
load RevenueVOT9.mat;
load RevenueVOT11.mat;
load RevenueVOT12.mat;
load RevenueVOT13.mat;
load RevenueVOT14.mat;


%Evaluate the differences between two simulations based on the VOT
%Sim1
Revenue_VOT_1 = Revenue_VOT_1(:,[3 4]);                       %Take the 2 column that are important

[Revenue_VOT_1_unique,~,idx] = unique(Revenue_VOT_1(:,2));    %create unique matrix and id the same values
nu = numel(Revenue_VOT_1_unique);
Revenue_VOT_1_sum = zeros(nu,size(Revenue_VOT_1,2));          %initialize the matrix
for ii = 1:nu
  Revenue_VOT_1_sum(ii,:) = mean(Revenue_VOT_1(idx==ii,:));    %sum the same time with the same VOT
end
Revenue_VOT_1_sum(:,2) = Revenue_VOT_1_unique;                %finalize the matrix setting the VOT

%Sim 4
Revenue_VOT_4 = Revenue_VOT_4(:,[3 4]);                       %Take the 2 column that are important

[Revenue_VOT_4_unique,~,idx] = unique(Revenue_VOT_4(:,2));    %create unique matrix and id the same values
nu = numel(Revenue_VOT_4_unique);
Revenue_VOT_4_sum = zeros(nu,size(Revenue_VOT_4,2));          %initialize the matrix
for ii = 1:nu
  Revenue_VOT_4_sum(ii,:) = mean(Revenue_VOT_4(idx==ii,:));    %sum the same time with the same VOT
end
Revenue_VOT_4_sum(:,2) = Revenue_VOT_4_unique;                %finalize the matrix setting the VOT

%DELTA 1-4
Revenue_Delta_1_4 = Revenue_VOT_1_sum(:,1)-Revenue_VOT_4_sum(:,1);   %Check the delta between the 2 simulations


%Sim7
Revenue_VOT_7 = Revenue_VOT_7(:,[3 4]);                       %Take the 2 column that are important

[Revenue_VOT_7_unique,~,idx] = unique(Revenue_VOT_7(:,2));    %create unique matrix and id the same values
nu = numel(Revenue_VOT_7_unique);
Revenue_VOT_7_sum = zeros(nu,size(Revenue_VOT_7,2));          %initialize the matrix
for ii = 1:nu
  Revenue_VOT_7_sum(ii,:) = mean(Revenue_VOT_7(idx==ii,:));    %sum the same time with the same VOT
end
Revenue_VOT_7_sum(:,2) = Revenue_VOT_7_unique;                %finalize the matrix setting the VOT

%DELTA 1-7
Revenue_Delta_4_7 = Revenue_VOT_4_sum(:,1)-Revenue_VOT_7_sum(:,1);   %Check the delta between the 2 simulation

%Sim11
Revenue_VOT_11 = Revenue_VOT_11(:,[3 4]);                       %Take the 2 column that are important

[Revenue_VOT_11_unique,~,idx] = unique(Revenue_VOT_11(:,2));    %create unique matrix and id the same values
nu = numel(Revenue_VOT_11_unique);
Revenue_VOT_11_sum = zeros(nu,size(Revenue_VOT_11,2));          %initialize the matrix
for ii = 1:nu
  Revenue_VOT_11_sum(ii,:) = mean(Revenue_VOT_11(idx==ii,:));    %sum the same time with the same VOT
end
Revenue_VOT_11_sum(:,2) = Revenue_VOT_11_unique;                %finalize the matrix setting the VOT

%DELTA 4-11
Revenue_Delta_4_11 = Revenue_VOT_4_sum(:,1)-Revenue_VOT_11_sum(:,1);   %Check the delta between the 2 simulation

% %Sim13
% Revenue_VOT_13 = Revenue_VOT_13(:,[3 4]);                       %Take the 2 column that are important
% 
% [Revenue_VOT_13_unique,~,idx] = unique(Revenue_VOT_13(:,2));    %create unique matrix and id the same values
% nu = numel(Revenue_VOT_13_unique);
% Revenue_VOT_13_sum = zeros(nu,size(Revenue_VOT_13,2));          %initialize the matrix
% for ii = 1:nu
%   Revenue_VOT_13_sum(ii,:) = mean(Revenue_VOT_13(idx==ii,:));    %sum the same time with the same VOT
% end
% Revenue_VOT_13_sum(:,2) = Revenue_VOT_1_unique;                %finalize the matrix setting the VOT
% 
% %DELTA 4-13
% Revenue_Delta_4_13 = Revenue_VOT_4_sum(:,1)-Revenue_VOT_13_sum(:,1);   %Check the delta between the 2 simulation

%Sim
Revenue_VOT_3 = Revenue_VOT_3(:,[3 4]);                       %Take the 2 column that are important

[Revenue_VOT_3_unique,~,idx] = unique(Revenue_VOT_3(:,2));    %create unique matrix and id the same values
nu = numel(Revenue_VOT_3_unique);
Revenue_VOT_3_sum = zeros(nu,size(Revenue_VOT_3,2));          %initialize the matrix
for ii = 1:nu
  Revenue_VOT_3_sum(ii,:) = mean(Revenue_VOT_3(idx==ii,:));    %sum the same time with the same VOT
end
Revenue_VOT_3_sum(:,2) = Revenue_VOT_3_unique;                %finalize the matrix setting the VOT

%Sim6
Revenue_VOT_6 = Revenue_VOT_6(:,[3 4]);                       %Take the 2 column that are important

[Revenue_VOT_6_unique,~,idx] = unique(Revenue_VOT_6(:,2));    %create unique matrix and id the same values
nu = numel(Revenue_VOT_6_unique);
Revenue_6_VOT_sum = zeros(nu,size(Revenue_VOT_6,2));          %initialize the matrix
for ii = 1:nu
  Revenue_6_VOT_sum(ii,:) = mean(Revenue_VOT_6(idx==ii,:));    %sum the same time with the same VOT
end
Revenue_6_VOT_sum(:,2) = Revenue_VOT_6_unique;                %finalize the matrix setting the VOT

%DELTA3-6
Revenue_Delta_3_6 = Revenue_VOT_3_sum(:,1)-Revenue_6_VOT_sum(:,1);   %Check the delta between the 2 simulation


%Sim9
Revenue_VOT_9 = Revenue_VOT_9(:,[3 4]);                       %Take the 2 column that are important

[Revenue_VOT_9_unique,~,idx] = unique(Revenue_VOT_9(:,2));    %create unique matrix and id the same values
nu = numel(Revenue_VOT_9_unique);
Revenue_9_VOT_sum = zeros(nu,size(Revenue_VOT_9,2));          %initialize the matrix
for ii = 1:nu
  Revenue_9_VOT_sum(ii,:) = mean(Revenue_VOT_9(idx==ii,:));    %sum the same time with the same VOT
end
Revenue_9_VOT_sum(:,2) = Revenue_VOT_9_unique;                %finalize the matrix setting the VOT

%DELTA6-9
Revenue_Delta_6_9 = Revenue_6_VOT_sum(:,1)-Revenue_9_VOT_sum(:,1);   %Check the delta between the 2 simulation

%Sim12
Revenue_VOT_12 = Revenue_VOT_12(:,[3 4]);                       %Take the 2 column that are important

[Revenue_VOT_12_unique,~,idx] = unique(Revenue_VOT_12(:,2));    %create unique matrix and id the same values
nu = numel(Revenue_VOT_12_unique);
Revenue_VOT_12_sum = zeros(nu,size(Revenue_VOT_12,2));          %initialize the matrix
for ii = 1:nu
  Revenue_VOT_12_sum(ii,:) = mean(Revenue_VOT_12(idx==ii,:));    %sum the same time with the same VOT
end
Revenue_VOT_12_sum(:,2) = Revenue_VOT_12_unique;                %finalize the matrix setting the VOT

%DELTA6-12
Revenue_Delta_6_12 = Revenue_6_VOT_sum(:,1)-Revenue_VOT_12_sum(:,1);   %Check the delta between the 2 simulation

%Sim14
Revenue_VOT_14 = Revenue_VOT_14(:,[3 4]);                       %Take the 2 column that are important

[Revenue_VOT_14_unique,~,idx] = unique(Revenue_VOT_14(:,2));    %create unique matrix and id the same values
nu = numel(Revenue_VOT_14_unique);
Revenue_VOT_14_sum = zeros(nu,size(Revenue_VOT_14,2));          %initialize the matrix
for ii = 1:nu
  Revenue_VOT_14_sum(ii,:) = mean(Revenue_VOT_14(idx==ii,:));    %sum the same time with the same VOT
end
Revenue_VOT_14_sum(:,2) = Revenue_VOT_14_unique;                %finalize the matrix setting the VOT

%DELTA6-14
Revenue_Delta_6_14 = Revenue_6_VOT_sum(:,1)-Revenue_VOT_14_sum(:,1);   %Check the delta between the 2 simulation

filename = ('AvgCostDelta.mat');
save(filename, 'Revenue_Delta_1_4','Revenue_Delta_4_7','Revenue_Delta_4_11','Revenue_Delta_3_6','Revenue_Delta_6_9','Revenue_Delta_6_12','Revenue_Delta_6_14');


%Scatter AvgCostVOT
%Boxplot CostVOT



%Plot the Revenue_Delta_ time 1-4
scatter(Revenue_VOT_1_unique,Revenue_Delta_1_4);
hold on
plot(0);
title('Differential Revenue 1-4');
xticks(Revenue_VOT_1_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Revenue mean [€]');
hold off
filename = sprintf('Revenue_Delta_ Revenue 1-4.png');
saveas(gca,filename);

%Plot the Revenue_Delta_ time 4-7
scatter(Revenue_VOT_4_unique,Revenue_Delta_4_7);
hold on
plot(0);
title('Differential Revenue 4-7');
xticks(Revenue_VOT_4_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Revenue mean [€]');
filename = sprintf('Revenue_Delta_ Revenue 4-7.png');
saveas(gca,filename);
hold off

%Plot the Revenue_Delta_ time 4-11
scatter(Revenue_VOT_4_unique,Revenue_Delta_4_11);
hold on
plot(0);
title('Differential Revenue 4-11');
xticks(Revenue_VOT_4_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Revenue mean [€]');
filename = sprintf('Revenue_Delta_ Revenue 4-11.png');
saveas(gca,filename);
hold off

% %Plot the Revenue_Delta_ time 4-13
% scatter(Revenue_VOT_4_unique,Revenue_Delta_4_13);
% hold on
% plot(0);
% title('Differential Revenue 4-13');
% xticks(Revenue_VOT_4_unique);
% xtickangle(90);
% xlabel('VOT');
% ylabel('Revenue mean [€]');
% filename = sprintf('Revenue_Delta_ Revenue 4-13.png');
% saveas(gca,filename);
% hold off

%Plot the Revenue_Delta_ time 3-6
scatter(Revenue_VOT_3_unique,Revenue_Delta_3_6);
hold on
plot(0);
title('Differential Revenue 3-6');
xticks(Revenue_VOT_3_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Revenue mean [€]');
filename = sprintf('Revenue_Delta_ Revenue 3-6.png');
saveas(gca,filename);
hold off

%Plot the Revenue_Delta_ time 6-9
scatter(Revenue_VOT_6_unique,Revenue_Delta_6_9);
hold on
plot(0);
title('Differential Revenue 6-9');
xticks(Revenue_VOT_6_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Revenue mean [€]');
filename = sprintf('Revenue_Delta_ Revenue 6-9.png');
saveas(gca,filename);
hold off

%Plot the Revenue_Delta_ time 6-12
scatter(Revenue_VOT_6_unique,Revenue_Delta_6_12);
hold on
plot(0);
title('Differential Revenue 6-12');
xticks(Revenue_VOT_6_unique);
xtickangle(120);
xlabel('VOT');
ylabel('Revenue mean [€]');
filename = sprintf('Revenue_Delta_ Revenue 6-12.png');
saveas(gca,filename);
hold off

%Plot the Revenue_Delta_ time 6-14
scatter(Revenue_VOT_6_unique,Revenue_Delta_6_14);
hold on
plot(0);
title('Differential Revenue 6-14');
xticks(Revenue_VOT_6_unique);
xtickangle(140);
xlabel('VOT');
ylabel('Revenue mean [€]');
filename = sprintf('Revenue_Delta_ Revenue 6-14.png');
saveas(gca,filename);
hold off

%%%%%%%%%%
%BOXPLOTS%
%%%%%%%%%%


%BOXPLOT Revenue_1-4

subplot(2,1,1);
boxplot(Revenue_VOT_1(:,1),Revenue_VOT_1(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 1')
grid on

subplot(2,1,2);
boxplot(Revenue_VOT_4(:,1),Revenue_VOT_4(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 4');
grid on

filename = sprintf('Boxplot_Revenue_VOT1-4.png');
saveas(gca,filename);

%BOXPLOT Revenue_3-6

subplot(2,1,1);
boxplot(Revenue_VOT_3(:,1),Revenue_VOT_3(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 3')
grid on

subplot(2,1,2);
boxplot(Revenue_VOT_6(:,1),Revenue_VOT_6(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 6');
grid on

filename = sprintf('Boxplot_Revenue_VOT_3-6.png');
saveas(gca,filename);

%BOXPLOT Revenue_4-7

subplot(2,1,1);
boxplot(Revenue_VOT_4(:,1),Revenue_VOT_4(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 4')
grid on

subplot(2,1,2);
boxplot(Revenue_VOT_7(:,1),Revenue_VOT_7(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 7');
grid on

filename = sprintf('Boxplot_Revenue_VOT_4-7.png');
saveas(gca,filename);

%BOXPLOT Revenue_6-9

subplot(2,1,1);
boxplot(Revenue_VOT_6(:,1),Revenue_VOT_6(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 6')
grid on

subplot(2,1,2);
boxplot(Revenue_VOT_9(:,1),Revenue_VOT_9(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 9');
grid on

filename = sprintf('Boxplot_Revenue_VOT_6-9.png');
saveas(gca,filename);

%BOXPLOT Revenue_4-11

subplot(2,1,1);
boxplot(Revenue_VOT_4(:,1),Revenue_VOT_4(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 4')
grid on

subplot(2,1,2);
boxplot(Revenue_VOT_11(:,1),Revenue_VOT_11(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 11');
grid on

filename = sprintf('Boxplot_Revenue_VOT_4-11.png');
saveas(gca,filename);

%BOXPLOT Revenue_4-13

subplot(2,1,1);
boxplot(Revenue_VOT_4(:,1),Revenue_VOT_4(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 4')
grid on

subplot(2,1,2);
boxplot(Revenue_VOT_13(:,1),Revenue_VOT_13(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 13');
grid on

filename = sprintf('Boxplot_Revenue_VOT_4-13.png');
saveas(gca,filename);

%BOXPLOT Revenue_6-12

subplot(2,1,1);
boxplot(Revenue_VOT_6(:,1),Revenue_VOT_6(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 6')
grid on

subplot(2,1,2);
boxplot(Revenue_VOT_12(:,1),Revenue_VOT_12(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 12');
grid on

filename = sprintf('Boxplot_Revenue_VOT_6-12.png');
saveas(gca,filename);

%BOXPLOT Revenue_6-14

subplot(2,1,1);
boxplot(Revenue_VOT_6(:,1),Revenue_VOT_6(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 6')
grid on

subplot(2,1,2);
boxplot(Revenue_VOT_14(:,1),Revenue_VOT_14(:,2));
xlabel('Revenue [€]');
ylabel('VOT');
% ylim([0 500]);
title('Revenue 14');
grid on

filename = sprintf('Boxplot_Revenue_VOT_6-14.png');
saveas(gca,filename);