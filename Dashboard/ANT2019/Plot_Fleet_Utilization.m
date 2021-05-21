load VehXDist_sum1.mat
VehXDist_sum2=VehXDist_sum;
% % load VehXDist_sum2.mat
% % VehXDist_sum2=VehXDist_sum;
% load VehXDist_sum3.mat
% VehXDist_sum3=VehXDist_sum;
load VehXDist_sum4.mat
VehXDist_sum4=VehXDist_sum;
% % load VehXDist_sum5.mat
% % VehXDist_sum5=VehXDist_sum;
% load VehXDist_sum6.mat
% VehXDist_sum6=VehXDist_sum;
% load VehXDist_sum7.mat
% VehXDist_sum7=VehXDist_sum;
% % load VehXDist_sum8.mat
% % VehXDist_sum8=VehXDist_sum;
% load VehXDist_sum9.mat
% VehXDist_sum9=VehXDist_sum;


VehXDist_sum = sortrows(VehXDist_sum,1);
plot(1:numel(VehXDist_sum1(:,2)),VehXDist_sum1(:,1),'r');    %Plot the 1st simulation Fleet utilization
hold on
plot(1:numel(VehXDist_sum4(:,2)),VehXDist_sum4(:,1),'b');    %Plot the 4th simulation Fleet utilization
title('Fleet Utilization 1');
ylabel('Vehicle * Km');
xlabel('VehId');
hold off