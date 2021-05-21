%clear all

%Output for every simulation:
%Access time with VOT
%Scatter delta mean access time
%Boxplot access time

load AccessTime1.mat
load AccessTime3.mat
load AccessTime4.mat
load AccessTime6.mat
load AccessTime7.mat
load AccessTime9.mat
load AccessTime11.mat
load AccessTime12.mat
load AccessTime13.mat
load AccessTime14.mat
load VOT_ID.mat
VOT_ID= str2double(VOT_ID);

Y1 = 1:numel(AccessTime1(:,2));
Y1 = Y1';
Y3 = 1:numel(AccessTime3(:,2));
Y3 = Y3';
Y4 = 1:numel(AccessTime4(:,2));
Y4 = Y4';
Y6 = 1:numel(AccessTime6(:,2));
Y6 = Y6';
Y7 = 1:numel(AccessTime7(:,2));
Y7 = Y7';
Y9 = 1:numel(AccessTime9(:,2));
Y9 = Y9';
Y11 = 1:numel(AccessTime11(:,2));
Y11 = Y11';
Y12 = 1:numel(AccessTime12(:,2));
Y12 = Y12';
Y13 = 1:numel(AccessTime13(:,2));
Y13 = Y13';
Y14 = 1:numel(AccessTime14(:,2));
Y14 = Y14';

% %Plot ACCESS TIME
% %Create the graph
% plot(Y1,AccessTime1(:,1),'r');
% hold on
% % plot(Y2,AccessTime2(:,1),'b');
% plot(Y3,AccessTime3(:,1),'g');
% plot(Y4,AccessTime4(:,1),'b');
% legend('AccessTimeSim1','AccessTimeSim3','AccessTimeSim4','Location','northwest');
% plot(Y4,AccessTime4(:,1),'c');
% % plot(Y5,AccessTime5(:,1),'m');
% plot(Y6,AccessTime6(:,1),'y');
% plot(Y7,AccessTime7(:,1),'m');
% plot(Y9,AccessTime9(:,1),'k');
% % ylim([0 24]);
% set(gca,'XTick',0:1:numel(AccessTime1));
% %view([90 -90]);
% ylabel('Access Time [s]');
% xlabel('Vehicle #');
% hold off
% 
% filename = 'AccessTime_ALL.png';
% saveas(gca,filename);


%DELTA ACCESS TIME

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #1
AccessTime1 = sortrows(AccessTime1,2);                      %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,AccessTime1);               %Check same ID in VOT_ID and AccessTime
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
AccessTime1_VOT = [AccessTime1 VOT_ID_Rented(:,2)];         %Put them together
AccessTime1_VOT = sortrows(AccessTime1_VOT,3,'ascend');     %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #3
AccessTime3 = sortrows(AccessTime3,2);                      %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,AccessTime3);               %Check same ID in VOT_ID and AccessTime
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
AccessTime3_VOT = [AccessTime3 VOT_ID_Rented(:,2)];         %Put them together
AccessTime3_VOT = sortrows(AccessTime3_VOT,3,'ascend');     %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #4
AccessTime4 = sortrows(AccessTime4,2);                      %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,AccessTime4);               %Check same ID in VOT_ID and AccessTime
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
AccessTime4_VOT = [AccessTime4 VOT_ID_Rented(:,2)];         %Put them together
AccessTime4_VOT = sortrows(AccessTime4_VOT,3,'ascend');     %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #6
AccessTime6 = sortrows(AccessTime6,2);                      %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,AccessTime6);               %Check same ID in VOT_ID and AccessTime
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
AccessTime6_VOT = [AccessTime6 VOT_ID_Rented(:,2)];         %Put them together
AccessTime6_VOT = sortrows(AccessTime6_VOT,3,'ascend');     %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #7
AccessTime7 = sortrows(AccessTime7,2);                      %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,AccessTime7);               %Check same ID in VOT_ID and AccessTime
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
AccessTime7_VOT = [AccessTime7 VOT_ID_Rented(:,2)];         %Put them together
AccessTime7_VOT = sortrows(AccessTime7_VOT,3,'ascend');     %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #9
AccessTime9 = sortrows(AccessTime9,2);                      %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,AccessTime9);               %Check same ID in VOT_ID and AccessTime
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
AccessTime9_VOT = [AccessTime9 VOT_ID_Rented(:,2)];         %Put them together
AccessTime9_VOT = sortrows(AccessTime9_VOT,3,'ascend');     %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #11
AccessTime11 = sortrows(AccessTime11,2);                      %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,AccessTime11);               %Check same ID in VOT_ID and AccessTime
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
AccessTime11_VOT = [AccessTime11 VOT_ID_Rented(:,2)];         %Put them together
AccessTime11_VOT = sortrows(AccessTime11_VOT,3,'ascend');     %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #12
AccessTime12 = sortrows(AccessTime12,2);                      %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,AccessTime12);               %Check same ID in VOT_ID and AccessTime
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
AccessTime12_VOT = [AccessTime12 VOT_ID_Rented(:,2)];         %Put them together
AccessTime12_VOT = sortrows(AccessTime12_VOT,3,'ascend');     %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #13
AccessTime13 = sortrows(AccessTime13,2);                      %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,AccessTime13);               %Check same ID in VOT_ID and AccessTime
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
AccessTime13_VOT = [AccessTime13 VOT_ID_Rented(:,2)];         %Put them together
AccessTime13_VOT = sortrows(AccessTime13_VOT,3,'ascend');     %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #14
AccessTime14 = sortrows(AccessTime14,2);                      %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,AccessTime14);               %Check same ID in VOT_ID and AccessTime
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
AccessTime14 = AccessTime14(1:numel(VOT_ID_Rented(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
AccessTime14_VOT = [AccessTime14 VOT_ID_Rented(:,2)];         %Put them together
AccessTime14_VOT = sortrows(AccessTime14_VOT,3,'ascend');     %sort by the VOT

%Evaluate the differences between two simulations based on the VOT
%Sim1
AccessTime1_VOT = AccessTime1_VOT(:,[1 3]);                       %Take the 2 column that are important

[AccessTime1_VOT_unique,~,idx] = unique(AccessTime1_VOT(:,2));    %create unique matrix and id the same values
nu = numel(AccessTime1_VOT_unique);
AccessTime1_sum = zeros(nu,size(AccessTime1_VOT,2));          %initialize the matrix
for ii = 1:nu
  AccessTime1_sum(ii,:) = mean(AccessTime1_VOT(idx==ii,:));    %sum the same time with the same VOT
end
AccessTime1_sum(:,2) = AccessTime1_VOT_unique;                %finalize the matrix setting the VOT

%Sim4
AccessTime4_VOT = AccessTime4_VOT(:,[1 3]);                       %Take the 2 column that are important

[AccessTime4_VOT_unique,~,idx] = unique(AccessTime4_VOT(:,2));    %create unique matrix and id the same values
nu = numel(AccessTime4_VOT_unique);
AccessTime4_VOT_sum = zeros(nu,size(AccessTime4_VOT,2));          %initialize the matrix
for ii = 1:nu
  AccessTime4_VOT_sum(ii,:) = mean(AccessTime4_VOT(idx==ii,:));    %sum the same time with the same VOT
end
AccessTime4_VOT_sum(:,2) = AccessTime4_VOT_unique;                %finalize the matrix setting the VOT

%DELTA
Delta1_4 = AccessTime1_sum(:,1)-AccessTime4_VOT_sum(:,1);   %Check the delta between the 2 simulations


%Sim7
AccessTime7_VOT = AccessTime7_VOT(:,[1 3]);                       %Take the 2 column that are important

[AccessTime7_VOT_unique,~,idx] = unique(AccessTime7_VOT(:,2));    %create unique matrix and id the same values
nu = numel(AccessTime7_VOT_unique);
AccessTime7_VOT_sum = zeros(nu,size(AccessTime7_VOT,2));          %initialize the matrix
for ii = 1:nu
  AccessTime7_VOT_sum(ii,:) = mean(AccessTime7_VOT(idx==ii,:));    %sum the same time with the same VOT
end
AccessTime7_VOT_sum(:,2) = AccessTime7_VOT_unique;                %finalize the matrix setting the VOT

%DELTA
Delta4_7 = AccessTime4_VOT_sum(:,1)-AccessTime7_VOT_sum(:,1);   %Check the delta between the 2 simulation

%Sim11
AccessTime11_VOT = AccessTime11_VOT(:,[1 3]);                       %Take the 2 column that are important

[AccessTime11_VOT_unique,~,idx] = unique(AccessTime11_VOT(:,2));    %create unique matrix and id the same values
nu = numel(AccessTime11_VOT_unique);
AccessTime11_VOT_sum = zeros(nu,size(AccessTime11_VOT,2));          %initialize the matrix
for ii = 1:nu
  AccessTime11_VOT_sum(ii,:) = mean(AccessTime11_VOT(idx==ii,:));    %sum the same time with the same VOT
end
AccessTime11_VOT_sum(:,2) = AccessTime11_VOT_unique;                %finalize the matrix setting the VOT

%DELTA
Delta4_11 = AccessTime4_VOT_sum(:,1)-AccessTime11_VOT_sum(:,1);   %Check the delta between the 2 simulation

%Sim13
AccessTime13_VOT = AccessTime13_VOT(:,[1 3]);                       %Take the 2 column that are important

[AccessTime13_VOT_unique,~,idx] = unique(AccessTime13_VOT(:,2));    %create unique matrix and id the same values
nu = numel(AccessTime13_VOT_unique);
AccessTime13_VOT_sum = zeros(nu,size(AccessTime13_VOT,2));          %initialize the matrix
for ii = 1:nu
  AccessTime13_VOT_sum(ii,:) = mean(AccessTime13_VOT(idx==ii,:));    %sum the same time with the same VOT
end
AccessTime13_VOT_sum(:,2) = AccessTime13_VOT_unique;                %finalize the matrix setting the VOT

%DELTA
Delta4_13 = AccessTime4_VOT_sum(:,1)-AccessTime13_VOT_sum(:,1);   %Check the delta between the 2 simulation

%Sim3
AccessTime3_VOT = AccessTime3_VOT(:,[1 3]);                       %Take the 2 column that are important

[AccessTime3_VOT_unique,~,idx] = unique(AccessTime3_VOT(:,2));    %create unique matrix and id the same values
nu = numel(AccessTime3_VOT_unique);
AccessTime3_VOT_sum = zeros(nu,size(AccessTime3_VOT,2));          %initialize the matrix
for ii = 1:nu
  AccessTime3_VOT_sum(ii,:) = mean(AccessTime3_VOT(idx==ii,:));    %sum the same time with the same VOT
end
AccessTime3_VOT_sum(:,2) = AccessTime3_VOT_unique;                %finalize the matrix setting the VOT

%Sim6
AccessTime6_VOT = AccessTime6_VOT(:,[1 3]);                       %Take the 2 column that are important

[AccessTime6_VOT_unique,~,idx] = unique(AccessTime6_VOT(:,2));    %create unique matrix and id the same values
nu = numel(AccessTime6_VOT_unique);
AccessTime6_VOT_sum = zeros(nu,size(AccessTime6_VOT,2));          %initialize the matrix
for ii = 1:nu
  AccessTime6_VOT_sum(ii,:) = mean(AccessTime6_VOT(idx==ii,:));    %sum the same time with the same VOT
end
AccessTime6_VOT_sum(:,2) = AccessTime6_VOT_unique;                %finalize the matrix setting the VOT

%DELTA
Delta3_6 = AccessTime3_VOT_sum(:,1)-AccessTime6_VOT_sum(:,1);   %Check the delta between the 2 simulation


%Sim9
AccessTime9_VOT = AccessTime9_VOT(:,[1 3]);                       %Take the 2 column that are important

[AccessTime9_VOT_unique,~,idx] = unique(AccessTime9_VOT(:,2));    %create unique matrix and id the same values
nu = numel(AccessTime9_VOT_unique);
AccessTime9_VOT_sum = zeros(nu,size(AccessTime9_VOT,2));          %initialize the matrix
for ii = 1:nu
  AccessTime9_VOT_sum(ii,:) = mean(AccessTime9_VOT(idx==ii,:));    %sum the same time with the same VOT
end
AccessTime9_VOT_sum(:,2) = AccessTime9_VOT_unique;                %finalize the matrix setting the VOT

%DELTA
Delta6_9 = AccessTime6_VOT_sum(:,1)-AccessTime9_VOT_sum(:,1);   %Check the delta between the 2 simulation

%Sim12
AccessTime12_VOT = AccessTime12_VOT(:,[1 3]);                       %Take the 2 column that are important

[AccessTime12_VOT_unique,~,idx] = unique(AccessTime12_VOT(:,2));    %create unique matrix and id the same values
nu = numel(AccessTime12_VOT_unique);
AccessTime12_VOT_sum = zeros(nu,size(AccessTime12_VOT,2));          %initialize the matrix
for ii = 1:nu
  AccessTime12_VOT_sum(ii,:) = mean(AccessTime12_VOT(idx==ii,:));    %sum the same time with the same VOT
end
AccessTime12_VOT_sum(:,2) = AccessTime12_VOT_unique;                %finalize the matrix setting the VOT

%DELTA
Delta6_12 = AccessTime6_VOT_sum(:,1)-AccessTime12_VOT_sum(:,1);   %Check the delta between the 2 simulation

%Sim14
AccessTime14_VOT = AccessTime14_VOT(:,[1 3]);                       %Take the 2 column that are important

[AccessTime14_VOT_unique,~,idx] = unique(AccessTime14_VOT(:,2));    %create unique matrix and id the same values
nu = numel(AccessTime14_VOT_unique);
AccessTime14_VOT_sum = zeros(nu,size(AccessTime14_VOT,2));          %initialize the matrix
for ii = 1:nu
  AccessTime14_VOT_sum(ii,:) = mean(AccessTime14_VOT(idx==ii,:));    %sum the same time with the same VOT
end
AccessTime14_VOT_sum(:,2) = AccessTime14_VOT_unique;                %finalize the matrix setting the VOT

%DELTA
Delta6_14 = AccessTime6_VOT_sum(:,1)-AccessTime14_VOT_sum(:,1);   %Check the delta between the 2 simulation

%Plot the Delta time 1-4
scatter(AccessTime1_VOT_unique,Delta1_4);
hold on
plot(0);
title('Differential Access Time 1-4');
xticks(AccessTime1_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Access Time mean [s]');
hold off
filename = sprintf('Delta Access Time 1-4.png');
saveas(gca,filename);

%Plot the Delta time 4-7
scatter(AccessTime4_VOT_unique,Delta4_7);
hold on
plot(0);
title('Differential Access Time 4-7');
xticks(AccessTime4_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access Time 4-7.png');
saveas(gca,filename);
hold off

%Plot the Delta time 4-11
scatter(AccessTime4_VOT_unique,Delta4_11);
hold on
plot(0);
title('Differential Access Time 4-11');
xticks(AccessTime4_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access Time 4-11.png');
saveas(gca,filename);
hold off

%Plot the Delta time 4-13
scatter(AccessTime4_VOT_unique,Delta4_13);
hold on
plot(0);
title('Differential Access Time 4-13');
xticks(AccessTime4_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access Time 4-13.png');
saveas(gca,filename);
hold off

%Plot the Delta time 3-6
scatter(AccessTime3_VOT_unique,Delta3_6);
hold on
plot(0);
title('Differential Access Time 3-6');
xticks(AccessTime3_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access time 3-6.png');
saveas(gca,filename);
hold off

%Plot the Delta time 6-9
scatter(AccessTime6_VOT_unique,Delta6_9);
hold on
plot(0);
title('Differential Access Time 6-9');
xticks(AccessTime6_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access Time 6-9.png');
saveas(gca,filename);
hold off

%Plot the Delta time 6-12
scatter(AccessTime6_VOT_unique,Delta6_12);
hold on
plot(0);
title('Differential Access Time 6-12');
xticks(AccessTime6_VOT_unique);
xtickangle(120);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access Time 6-12.png');
saveas(gca,filename);
hold off

%Plot the Delta time 6-14
scatter(AccessTime6_VOT_unique,Delta6_14);
hold on
plot(0);
title('Differential Access Time 6-14');
xticks(AccessTime6_VOT_unique);
xtickangle(140);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access Time 6-14.png');
saveas(gca,filename);
hold off

%Plot the Delta time 1-7
Delta1_7 = AccessTime1_sum(:,1)-AccessTime7_VOT_sum(:,1); 
scatter(AccessTime1_VOT_unique,Delta1_7);
hold on
plot(0);
title('Differential Access Starting Time 1-7');
xticks(AccessTime6_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access Time 1-7.png');
saveas(gca,filename);
hold off

%Plot the Delta time 3-9
Delta3_9 = AccessTime3_VOT_sum(:,1)-AccessTime9_VOT_sum(:,1); 
scatter(AccessTime3_VOT_unique,Delta3_9);
hold on
plot(0);
title('Differential Access Starting Time 3-9');
xticks(AccessTime6_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access Time 3-9.png');
saveas(gca,filename);
hold off


%BOXPLOT AccessTime1_VOT

boxplot(AccessTime6_VOT(:,1),AccessTime6_VOT(:,2),'b');
hold on
boxplot(AccessTime9_VOT(:,1),AccessTime9_VOT(:,2),'r');
legend ('6','9');
hold off