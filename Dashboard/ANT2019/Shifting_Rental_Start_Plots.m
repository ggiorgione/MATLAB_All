load SRS1.mat
%load SRS2.mat
load SRS3.mat
load SRS4.mat
%load SRS5.mat
load SRS6.mat
load SRS7.mat
%load SRS8.mat
load SRS9.mat
%load SRS10.mat
load SRS11.mat
load SRS12.mat
load SRS13.mat
load SRS14.mat
load VOT_ID.mat
VOT_ID= str2double(VOT_ID);


% %Create the graph
% % plot(SRS1(:,2),'r');    %Plot the 1st simulation Shifting Rental Starts
% hold on
% plot(SRS2(:,2),'b');    %Plot the 2nd simulation Shifting Rental Starts
% plot(SRS3(:,2),'m');    %Plot the 3rd simulation Shifting Rental Starts
% % plot(SRS4(:,2),'c');    %Plot the 2nd simulation Shifting Rental Starts
% % plot(SRS5(:,2),'p');    %Plot the 2nd simulation Shifting Rental Starts
% title('Rental Starting Time per Simulation');
% ylim([0 24]);
% set(gca,'YTick',0:1:24) %Set the Ytick to 1 from 0 to 24
% view([90 -90]);         %flip everything of 90˚
% legend('SRS1','SRS2','SRS3');
% ylabel('Time [h]');
% xlabel('# Person');
% hold off
% 
% filename = sprintf('Shifting_Rental_Start_ALL.png');
% saveas(gca,filename);


%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #1
SRS1 = sortrows(SRS1);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,SRS1);              %Check same ID in VOT_ID and SRS1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
SRS1_VOT = [SRS1 VOT_ID_Rented(:,2)];               %Put them together
SRS1_VOT = sortrows(SRS1_VOT,3,'ascend');           %sort by the VOT


% %Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #2
% SRS2 = sortrows(SRS2);                              %Sort by the ID
% VOT_ID_Rented = ismember(VOT_ID,SRS2);              %Check same ID in VOT_ID and SRS1
% VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
% VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
% VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
% SRS2_VOT = [SRS2 VOT_ID_Rented(:,2)];               %Put them together
% SRS2_VOT = sortrows(SRS2_VOT,3,'ascend');           %sort by the VOT


%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #3
SRS3 = sortrows(SRS3);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,SRS3);              %Check same ID in VOT_ID and SRS1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
SRS3_VOT = [SRS3 VOT_ID_Rented(:,2)];               %Put them together
SRS3_VOT = sortrows(SRS3_VOT,3,'ascend');           %sort by the VOT


%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #4
SRS4 = sortrows(SRS4);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,SRS4);              %Check same ID in VOT_ID and SRS1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
SRS4_VOT = [SRS4 VOT_ID_Rented(:,2)];               %Put them together
SRS4_VOT = sortrows(SRS4_VOT,3,'ascend');           %sort by the VOT


% %Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #5
% SRS5 = sortrows(SRS5);                              %Sort by the ID
% VOT_ID_Rented = ismember(VOT_ID,SRS5);              %Check same ID in VOT_ID and SRS1
% VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
% VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
% VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
% SRS5_VOT = [SRS5 VOT_ID_Rented(:,2)];               %Put them together
% SRS5_VOT = sortrows(SRS5_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #6
SRS6 = sortrows(SRS6);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,SRS6);              %Check same ID in VOT_ID and SRS1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
SRS6_VOT = [SRS6 VOT_ID_Rented(:,2)];               %Put them together
SRS6_VOT = sortrows(SRS6_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
SRS7 = sortrows(SRS7);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,SRS7);              %Check same ID in VOT_ID and SRS1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
SRS7_VOT = [SRS7 VOT_ID_Rented(:,2)];               %Put them together
SRS7_VOT = sortrows(SRS7_VOT,3,'ascend');           %sort by the VOT

% %Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
% SRS8 = sortrows(SRS8);                              %Sort by the ID
% VOT_ID_Rented = ismember(VOT_ID,SRS8);              %Check same ID in VOT_ID and SRS1
% VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
% VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
% VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
% SRS8_VOT = [SRS8 VOT_ID_Rented(:,2)];               %Put them together
% SRS8_VOT = sortrows(SRS8_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
SRS9 = sortrows(SRS9);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,SRS9);              %Check same ID in VOT_ID and SRS1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
SRS9_VOT = [SRS9 VOT_ID_Rented(:,2)];               %Put them together
SRS9_VOT = sortrows(SRS9_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
SRS11 = sortrows(SRS11);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,SRS11);              %Check same ID in VOT_ID and SRS1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [1011x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
SRS11_VOT = [SRS11 VOT_ID_Rented(:,2)];               %Put them together
SRS11_VOT = sortrows(SRS11_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
SRS12 = sortrows(SRS12);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,SRS12);              %Check same ID in VOT_ID and SRS1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [1012x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
SRS12_VOT = [SRS12 VOT_ID_Rented(:,2)];               %Put them together
SRS12_VOT = sortrows(SRS12_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
SRS13 = sortrows(SRS13);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,SRS13);              %Check same ID in VOT_ID and SRS1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [1013x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
SRS13_VOT = [SRS13 VOT_ID_Rented(:,2)];               %Put them together
SRS13_VOT = sortrows(SRS13_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
SRS14 = sortrows(SRS14);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,SRS14);              %Check same ID in VOT_ID and SRS1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [1014x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
SRS14 = SRS14(1:numel(VOT_ID_Rented(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
SRS14_VOT = [SRS14 VOT_ID_Rented(:,2)];               %Put them together
SRS14_VOT = sortrows(SRS14_VOT,3,'ascend');           %sort by the VOT


%Evaluate the differences between two simulations based on the VOT ###1-2

%Sim1
SRS1_VOT = SRS1_VOT(:,[2 3]);                       %Take the 2 column that are important

[SRS1_VOT_unique,~,idx] = unique(SRS1_VOT(:,2));    %create unique matrix and id the same values
nu = numel(SRS1_VOT_unique);
SRS1_VOT_sum = zeros(nu,size(SRS1_VOT,2));          %initialize the matrix
for ii = 1:nu
  SRS1_VOT_sum(ii,:) = mean(SRS1_VOT(idx==ii,:));    %sum the same time with the same VOT
end
SRS1_VOT_sum(:,2) = SRS1_VOT_unique;                %finalize the matrix setting the VOT

%Sim4
SRS4_VOT = SRS4_VOT(:,[2 3]);                       %Take the 2 column that are important

[SRS4_VOT_unique,~,idx] = unique(SRS4_VOT(:,2));    %create unique matrix and id the same values
nu = numel(SRS4_VOT_unique);
SRS4_VOT_sum = zeros(nu,size(SRS4_VOT,2));          %initialize the matrix
for ii = 1:nu
  SRS4_VOT_sum(ii,:) = mean(SRS4_VOT(idx==ii,:));    %sum the same time with the same VOT
end
SRS4_VOT_sum(:,2) = SRS4_VOT_unique;                %finalize the matrix setting the VOT

Delta1_4 = SRS1_VOT_sum(:,1)-SRS4_VOT_sum(:,1);   %Check the delta between the 2 simulations


%Sim7
SRS7_VOT = SRS7_VOT(:,[2 3]);                       %Take the 2 column that are important

[SRS7_VOT_unique,~,idx] = unique(SRS7_VOT(:,2));    %create unique matrix and id the same values
nu = numel(SRS7_VOT_unique);
SRS7_VOT_sum = zeros(nu,size(SRS7_VOT,2));          %initialize the matrix
for ii = 1:nu
  SRS7_VOT_sum(ii,:) = mean(SRS7_VOT(idx==ii,:));    %sum the same time with the same VOT
end
SRS7_VOT_sum(:,2) = SRS7_VOT_unique;                %finalize the matrix setting the VOT

Delta4_7 = SRS4_VOT_sum(:,1)-SRS7_VOT_sum(:,1);   %Check the delta between the 2 simulation

%Sim11
SRS11_VOT = SRS11_VOT(:,[2 3]);                       %Take the 2 column that are important

[SRS11_VOT_unique,~,idx] = unique(SRS11_VOT(:,2));    %create unique matrix and id the same values
nu = numel(SRS11_VOT_unique);
SRS11_VOT_sum = zeros(nu,size(SRS11_VOT,2));          %initialize the matrix
for ii = 1:nu
  SRS11_VOT_sum(ii,:) = mean(SRS11_VOT(idx==ii,:));    %sum the same time with the same VOT
end
SRS11_VOT_sum(:,2) = SRS11_VOT_unique;                %finalize the matrix setting the VOT

Delta4_11 = SRS4_VOT_sum(:,1)-SRS11_VOT_sum(:,1);   %Check the delta between the 2 simulation

% %Sim13
% SRS13_VOT = SRS13_VOT(:,[2 3]);                       %Take the 2 column that are important
% 
% [SRS13_VOT_unique,~,idx] = unique(SRS13_VOT(:,2));    %create unique matrix and id the same values
% nu = numel(SRS13_VOT_unique);
% SRS13_VOT_sum = zeros(nu,size(SRS13_VOT,2));          %initialize the matrix
% for ii = 1:nu
%   SRS13_VOT_sum(ii,:) = mean(SRS13_VOT(idx==ii,:));    %sum the same time with the same VOT
% end
% SRS13_VOT_sum(:,2) = SRS13_VOT_unique;                %finalize the matrix setting the VOT
% Delta4_13 = SRS4_VOT_sum(:,1)-SRS13_VOT_sum(:,1);   %Check the delta between the 2 simulation

%Sim3
SRS3_VOT = SRS3_VOT(:,[2 3]);                       %Take the 2 column that are important

[SRS3_VOT_unique,~,idx] = unique(SRS3_VOT(:,2));    %create unique matrix and id the same values
nu = numel(SRS3_VOT_unique);
SRS3_VOT_sum = zeros(nu,size(SRS3_VOT,2));          %initialize the matrix
for ii = 1:nu
  SRS3_VOT_sum(ii,:) = mean(SRS3_VOT(idx==ii,:));    %sum the same time with the same VOT
end
SRS3_VOT_sum(:,2) = SRS3_VOT_unique;                %finalize the matrix setting the VOT

%Sim6
SRS6_VOT = SRS6_VOT(:,[2 3]);                       %Take the 2 column that are important

[SRS6_VOT_unique,~,idx] = unique(SRS6_VOT(:,2));    %create unique matrix and id the same values
nu = numel(SRS6_VOT_unique);
SRS6_VOT_sum = zeros(nu,size(SRS6_VOT,2));          %initialize the matrix
for ii = 1:nu
  SRS6_VOT_sum(ii,:) = var(SRS6_VOT(idx==ii,:));    %sum the same time with the same VOT
end
SRS6_VOT_sum(:,2) = SRS6_VOT_unique;                %finalize the matrix setting the VOT

Delta3_6 = SRS3_VOT_sum(:,1)-SRS6_VOT_sum(:,1);   %Check the delta between the 2 simulation

%Sim9
SRS9_VOT = SRS9_VOT(:,[2 3]);                       %Take the 2 column that are important

[SRS9_VOT_unique,~,idx] = unique(SRS9_VOT(:,2));    %create unique matrix and id the same values
nu = numel(SRS9_VOT_unique);
SRS9_VOT_sum = zeros(nu,size(SRS9_VOT,2));          %initialize the matrix
for ii = 1:nu
  SRS9_VOT_sum(ii,:) = var(SRS9_VOT(idx==ii,:));    %sum the same time with the same VOT
end
SRS9_VOT_sum(:,2) = SRS9_VOT_unique;                %finalize the matrix setting the VOT

Delta6_9 = SRS6_VOT_sum(:,1)-SRS9_VOT_sum(:,1);   %Check the delta between the 2 simulation

%Sim12
SRS12_VOT = SRS12_VOT(:,[2 3]);                       %Take the 2 column that are important

[SRS12_VOT_unique,~,idx] = unique(SRS12_VOT(:,2));    %create unique matrix and id the same values
nu = numel(SRS12_VOT_unique);
SRS12_VOT_sum = zeros(nu,size(SRS12_VOT,2));          %initialize the matrix
for ii = 1:nu
  SRS12_VOT_sum(ii,:) = mean(SRS12_VOT(idx==ii,:));    %sum the same time with the same VOT
end
SRS12_VOT_sum(:,2) = SRS12_VOT_unique;                %finalize the matrix setting the VOT

Delta6_12 = SRS6_VOT_sum(:,1)-SRS12_VOT_sum(:,1);   %Check the delta between the 2 simulation

%Sim14
SRS14_VOT = SRS14_VOT(:,[2 3]);                       %Take the 2 column that are important

[SRS14_VOT_unique,~,idx] = unique(SRS14_VOT(:,2));    %create unique matrix and id the same values
nu = numel(SRS14_VOT_unique);
SRS14_VOT_sum = zeros(nu,size(SRS14_VOT,2));          %initialize the matrix
for ii = 1:nu
  SRS14_VOT_sum(ii,:) = mean(SRS14_VOT(idx==ii,:));    %sum the same time with the same VOT
end
SRS14_VOT_sum(:,2) = SRS14_VOT_unique;                %finalize the matrix setting the VOT

Delta6_14 = SRS6_VOT_sum(:,1)-SRS14_VOT_sum(:,1);   %Check the delta between the 2 simulation


%DELTA STARTING TIME
%Plot the Delta time 1-4
scatter(SRS1_VOT_unique,Delta1_4);
hold on
plot(0);
title('Shifting in Rental Starting Time 1-4');
xticks(SRS1_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Shifting Rental Starting Time mean [s]');
hold off
filename = sprintf('Delta time 1-4.png');
saveas(gca,filename);

%Plot the Delta time 4-7
scatter(SRS4_VOT_unique,Delta4_7);
hold on
plot(0);
title('Shifting in Rental Starting Time 4-7');
xticks(SRS4_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Shifting Rental Starting Time mean [s]');
filename = sprintf('Delta time 4-7.png');
saveas(gca,filename);
hold off

%Plot the Delta time 4-11
scatter(SRS4_VOT_unique,Delta4_11);
hold on
plot(0);
title('Shifting in Rental Starting Time 4-11');
xticks(SRS4_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Shifting Rental Starting Time mean [s]');
filename = sprintf('Delta time 4-11.png');
saveas(gca,filename);
hold off

% %Plot the Delta time 4-13
% scatter(SRS4_VOT_unique,Delta4_13);
% hold on
% plot(0);
% title('Shifting in Rental Starting Time 4-13');
% xticks(SRS4_VOT_unique);
% xtickangle(90);
% xlabel('VOT');
% ylabel('Shifting Rental Starting Time mean [s]');
% filename = sprintf('Delta time 4-13.png');
% saveas(gca,filename);
% hold off

%Plot the Delta time 3-6
scatter(SRS3_VOT_unique,Delta3_6);
hold on
plot(0);
title('Shifting in Rental Starting Time 3-6');
xticks(SRS3_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Shifting Rental Starting Time mean [s]');
filename = sprintf('Delta time 3-6.png');
saveas(gca,filename);
hold off

%Plot the Delta time 6-9
scatter(SRS6_VOT_unique,Delta6_9);
hold on
plot(0);
title('Shifting in Rental Starting Time 6-9');
xticks(SRS6_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Shifting Rental Starting Time mean [s]');
filename = sprintf('Delta time 6-9.png');
saveas(gca,filename);
hold off

%Plot the Delta time 6-12
scatter(SRS6_VOT_unique,Delta6_12);
hold on
plot(0);
title('Shifting in Rental Starting Time 6-12');
xticks(SRS6_VOT_unique);
xtickangle(120);
xlabel('VOT');
ylabel('Shifting Rental Starting Time mean [s]');
filename = sprintf('Delta time 6-12.png');
saveas(gca,filename);
hold off

%Plot the Delta time 6-14
scatter(SRS6_VOT_unique,Delta6_14);
hold on
plot(0);
title('Shifting in Rental Starting Time 6-14');
xticks(SRS6_VOT_unique);
xtickangle(140);
xlabel('VOT');
ylabel('Shifting Rental Starting Time mean [s]');
filename = sprintf('Delta time 6-14.png');
saveas(gca,filename);
hold off

%Plot the Delta time 1-7
Delta1_7 = SRS1_VOT_sum(:,1)-SRS7_VOT_sum(:,1); 
scatter(SRS1_VOT_unique,Delta1_7);
hold on
plot(0);
title('Shifting in Rental Starting Time 1-7');
xticks(SRS6_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Shifting Rental Starting Time mean [s]');
filename = sprintf('Delta time 1-7.png');
saveas(gca,filename);
hold off

%Plot the Delta time 3-9
Delta3_9 = SRS3_VOT_sum(:,1)-SRS9_VOT_sum(:,1); 
scatter(SRS3_VOT_unique,Delta3_9);
hold on
plot(0);
title('Shifting in Rental Starting Time 3-9');
xticks(SRS6_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Shifting Rental Starting Time mean [s]');
filename = sprintf('Delta time 3-9.png');
saveas(gca,filename);
hold off