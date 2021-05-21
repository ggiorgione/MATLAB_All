%DURATION RESERVATION FOR VOT

load Driving_Time_1.mat
Driving_Time_1 = DrivingTimePercentage;
% %load Driving_Time_2.mat
% Driving_Time_2 = DrivingTimePercentage;
load Driving_Time_3.mat
Driving_Time_3 = DrivingTimePercentage;
load Driving_Time_4.mat
Driving_Time_4 = DrivingTimePercentage;
% %load Driving_Time_5.mat
% Driving_Time_5 = DrivingTimePercentage;
load Driving_Time_6.mat
Driving_Time_6 = DrivingTimePercentage;
load Driving_Time_7.mat
Driving_Time_7 = DrivingTimePercentage;
%load Driving_Time_8.mat
% Driving_Time_8 = DrivingTimePercentage;
load Driving_Time_9.mat
Driving_Time_9 = DrivingTimePercentage;
% load Driving_Time_10.mat
% Driving_Time_10 = DrivingTimePercentage;
load Driving_Time_11.mat
Driving_Time_11 = DrivingTimePercentage;
load Driving_Time_12.mat
Driving_Time_12 = DrivingTimePercentage;
load Driving_Time_13.mat
Driving_Time_13 = DrivingTimePercentage;
load Driving_Time_14.mat
Driving_Time_14 = DrivingTimePercentage;

load Booking_Time_1.mat
Booking_Time_1 = BookingTimePercentage;
%load Booking_Time_2.mat
% Booking_Time_2 = BookingTimePercentage;
load Booking_Time_3.mat
Booking_Time_3 = BookingTimePercentage;
load Booking_Time_4.mat
Booking_Time_4 = BookingTimePercentage;
%load Booking_Time_5.mat
% Booking_Time_5 = BookingTimePercentage;
load Booking_Time_6.mat
Booking_Time_6 = BookingTimePercentage;
load Booking_Time_7.mat
Booking_Time_7 = BookingTimePercentage;
%load Booking_Time_8.mat
% Booking_Time_8 = BookingTimePercentage;
load Booking_Time_9.mat
Booking_Time_9 = BookingTimePercentage;
% load Booking_Time_10.mat
% Booking_Time_10 = BookingTimePercentage;
load Booking_Time_11.mat
Booking_Time_11 = BookingTimePercentage;
load Booking_Time_12.mat
Booking_Time_12 = BookingTimePercentage;
load Booking_Time_13.mat
Booking_Time_13 = BookingTimePercentage;
load Booking_Time_14.mat
Booking_Time_14 = BookingTimePercentage;

load VOT_ID.mat
VOT_ID= str2double(VOT_ID);

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #1
Driving_Time_1(:,1) = [];
Driving_Time_1 = sortrows(Driving_Time_1,2);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Driving_Time_1);              %Check same ID in VOT_ID and Driving_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before 
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Driving_Time_1(:,1)),:);                                                                                     %remove if "Dimensions of arrays being concatenated are not consistent."
Driving_Time_1_VOT = [Driving_Time_1 VOT_ID_Rented(:,2)];               %Put them together
Driving_Time_1_VOT = sortrows(Driving_Time_1_VOT,3,'ascend');           %sort by the VOT

% %Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #2
% Driving_Time_2(:,1) = [];
% Driving_Time_2 = sortrows(Driving_Time_2);                              %Sort by the ID
% VOT_ID_Rented = ismember(VOT_ID,Driving_Time_2);              %Check same ID in VOT_ID and Driving_Time_1
% VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
% VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
% VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
% Driving_Time_2_VOT = [Driving_Time_2 VOT_ID_Rented(:,2)];               %Put them together
% Driving_Time_2_VOT = sortrows(Driving_Time_2_VOT,3,'ascend');           %sort by the VOT


%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #3
Driving_Time_3(:,1) = [];
Driving_Time_3 = sortrows(Driving_Time_3);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Driving_Time_3);              %Check same ID in VOT_ID and Driving_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Driving_Time_3(:,1)),:);                                                                                      %remove if "Dimensions of arrays being concatenated are not consistent."
Driving_Time_3_VOT = [Driving_Time_3 VOT_ID_Rented(:,2)];               %Put them together
Driving_Time_3_VOT = sortrows(Driving_Time_3_VOT,3,'ascend');           %sort by the VOT


%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #4
Driving_Time_4(:,1) = [];
Driving_Time_4 = sortrows(Driving_Time_4);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Driving_Time_4);              %Check same ID in VOT_ID and Driving_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
Driving_Time_4_VOT = [Driving_Time_4 VOT_ID_Rented(:,2)];               %Put them together
Driving_Time_4_VOT = sortrows(Driving_Time_4_VOT,3,'ascend');           %sort by the VOT


% %Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #5
% Driving_Time_5(:,1) = [];
% Driving_Time_5 = sortrows(Driving_Time_5);                              %Sort by the ID
% VOT_ID_Rented = ismember(VOT_ID,Driving_Time_5);              %Check same ID in VOT_ID and Driving_Time_1
% VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
% VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
% VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
% Driving_Time_5_VOT = [Driving_Time_5 VOT_ID_Rented(:,2)];               %Put them together
% Driving_Time_5_VOT = sortrows(Driving_Time_5_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #6
Driving_Time_6(:,1) = [];
Driving_Time_6 = sortrows(Driving_Time_6);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Driving_Time_6);              %Check same ID in VOT_ID and Driving_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Driving_Time_6(:,1)),:);                                                                                     %remove if "Dimensions of arrays being concatenated are not consistent."
Driving_Time_6_VOT = [Driving_Time_6 VOT_ID_Rented(:,2)];               %Put them together
Driving_Time_6_VOT = sortrows(Driving_Time_6_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
Driving_Time_7(:,1) = [];
Driving_Time_7 = sortrows(Driving_Time_7);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Driving_Time_7);              %Check same ID in VOT_ID and Driving_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Driving_Time_7(:,1)),:);                                                                                     %remove if "Dimensions of arrays being concatenated are not consistent."
Driving_Time_7_VOT = [Driving_Time_7 VOT_ID_Rented(:,2)];               %Put them together
Driving_Time_7_VOT = sortrows(Driving_Time_7_VOT,3,'ascend');           %sort by the VOT

% %Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
% Driving_Time_8(:,1) = [];
% Driving_Time_8 = sortrows(Driving_Time_8);                              %Sort by the ID
% VOT_ID_Rented = ismember(VOT_ID,Driving_Time_8);              %Check same ID in VOT_ID and Driving_Time_1
% VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
% VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
% VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
% Driving_Time_8_VOT = [Driving_Time_8 VOT_ID_Rented(:,2)];               %Put them together
% Driving_Time_8_VOT = sortrows(Driving_Time_8_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
Driving_Time_9(:,1) = [];
Driving_Time_9 = sortrows(Driving_Time_9);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Driving_Time_9);              %Check same ID in VOT_ID and Driving_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Driving_Time_9(:,1)),:);                                                                                     %remove if "Dimensions of arrays being concatenated are not consistent."
Driving_Time_9_VOT = [Driving_Time_9 VOT_ID_Rented(:,2)];               %Put them together
Driving_Time_9_VOT = sortrows(Driving_Time_9_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
Driving_Time_11(:,1) = [];
Driving_Time_11 = sortrows(Driving_Time_11);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Driving_Time_11);              %Check same ID in VOT_ID and Driving_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Driving_Time_11(:,1)),:);                                                                                     %remove if "Dimensions of arrays being concatenated are not consistent."
Driving_Time_11_VOT = [Driving_Time_11 VOT_ID_Rented(:,2)];               %Put them together
Driving_Time_11_VOT = sortrows(Driving_Time_11_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
Driving_Time_12(:,1) = [];
Driving_Time_12 = sortrows(Driving_Time_12);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Driving_Time_12);              %Check same ID in VOT_ID and Driving_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Driving_Time_12(:,1)),:);                                                                                      %remove if "Dimensions of arrays being concatenated are not consistent."
Driving_Time_12_VOT = [Driving_Time_12 VOT_ID_Rented(:,2)];               %Put them together
Driving_Time_12_VOT = sortrows(Driving_Time_12_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
Driving_Time_13(:,1) = [];
Driving_Time_13 = sortrows(Driving_Time_13);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Driving_Time_13);              %Check same ID in VOT_ID and Driving_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Driving_Time_13(:,1)),:);
Driving_Time_13_VOT = [Driving_Time_13 VOT_ID_Rented(:,2)];               %Put them together
Driving_Time_13_VOT = sortrows(Driving_Time_13_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
Driving_Time_14(:,1) = [];
Driving_Time_14 = sortrows(Driving_Time_14);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Driving_Time_14);              %Check same ID in VOT_ID and Driving_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Driving_Time_14(:,1)),:);                                                                                      %remove if "Dimensions of arrays being concatenated are not consistent."
Driving_Time_14_VOT = [Driving_Time_14 VOT_ID_Rented(:,2)];               %Put them together
Driving_Time_14_VOT = sortrows(Driving_Time_14_VOT,3,'ascend');           %sort by the VOT

%Evaluate the differences between two simulations based on the VOT

%Sim1
Driving_Time_1_VOT = Driving_Time_1_VOT(:,[1 3]);                       %Take the 2 column that are important

[Driving_Time_1_VOT_unique,~,idx] = unique(Driving_Time_1_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Driving_Time_1_VOT_unique);
Driving_Time_1_VOT_sum = zeros(nu,size(Driving_Time_1_VOT,2));          %initialize the matrix
for ii = 1:nu
  Driving_Time_1_VOT_sum(ii,:) = mean(Driving_Time_1_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Driving_Time_1_VOT_sum(:,2) = Driving_Time_1_VOT_unique;                %finalize the matrix setting the VOT

%Sim4
Driving_Time_4_VOT = Driving_Time_4_VOT(:,[1 3]);                       %Take the 2 column that are important

[Driving_Time_4_VOT_unique,~,idx] = unique(Driving_Time_4_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Driving_Time_4_VOT_unique);
Driving_Time_4_VOT_sum = zeros(nu,size(Driving_Time_4_VOT,2));          %initialize the matrix
for ii = 1:nu
  Driving_Time_4_VOT_sum(ii,:) = mean(Driving_Time_4_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Driving_Time_4_VOT_sum(:,2) = Driving_Time_4_VOT_unique;                %finalize the matrix setting the VOT

Delta_Driving1_4 = Driving_Time_1_VOT_sum(:,1)-Driving_Time_4_VOT_sum(:,1);   %Check the Delta_Driving between the 2 simulations


%Sim7
Driving_Time_7_VOT = Driving_Time_7_VOT(:,[1 3]);                       %Take the 2 column that are important

[Driving_Time_7_VOT_unique,~,idx] = unique(Driving_Time_7_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Driving_Time_7_VOT_unique);
Driving_Time_7_VOT_sum = zeros(nu,size(Driving_Time_7_VOT,2));          %initialize the matrix
for ii = 1:nu
  Driving_Time_7_VOT_sum(ii,:) = mean(Driving_Time_7_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Driving_Time_7_VOT_sum(:,2) = Driving_Time_7_VOT_unique;                %finalize the matrix setting the VOT

Delta_Driving4_7 = Driving_Time_4_VOT_sum(:,1)-Driving_Time_7_VOT_sum(:,1);   %Check the Delta_Driving between the 2 simulation

%Sim11
Driving_Time_11_VOT = Driving_Time_11_VOT(:,[1 3]);                       %Take the 2 column that are important

[Driving_Time_11_VOT_unique,~,idx] = unique(Driving_Time_11_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Driving_Time_11_VOT_unique);
Driving_Time_11_VOT_sum = zeros(nu,size(Driving_Time_11_VOT,2));          %initialize the matrix
for ii = 1:nu
  Driving_Time_11_VOT_sum(ii,:) = mean(Driving_Time_11_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Driving_Time_11_VOT_sum(:,2) = Driving_Time_11_VOT_unique;                %finalize the matrix setting the VOT

Delta_Driving4_11 = Driving_Time_4_VOT_sum(:,1)-Driving_Time_11_VOT_sum(:,1);   %Check the Delta_Driving between the 2 simulation

% %Sim13
% Driving_Time_13_VOT = Driving_Time_13_VOT(:,[1 3]);                       %Take the 2 column that are important
% 
% [Driving_Time_13_VOT_unique,~,idx] = unique(Driving_Time_13_VOT(:,2));    %create unique matrix and id the same values
% nu = numel(Driving_Time_13_VOT_unique);
% Driving_Time_13_VOT_sum = zeros(nu,size(Driving_Time_13_VOT,2));          %initialize the matrix
% for ii = 1:nu
%   Driving_Time_13_VOT_sum(ii,:) = mean(Driving_Time_13_VOT(idx==ii,:));    %sum the same time with the same VOT
% end
% Driving_Time_13_VOT_sum(:,2) = Driving_Time_13_VOT_unique;                %finalize the matrix setting the VOT
% 
% Delta_Driving4_13 = Driving_Time_4_VOT_sum(:,1)-Driving_Time_13_VOT_sum(:,1);   %Check the Delta_Driving between the 2 simulation

%Sim3
Driving_Time_3_VOT = Driving_Time_3_VOT(:,[1 3]);                       %Take the 2 column that are important

[Driving_Time_3_VOT_unique,~,idx] = unique(Driving_Time_3_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Driving_Time_3_VOT_unique);
Driving_Time_3_VOT_sum = zeros(nu,size(Driving_Time_3_VOT,2));          %initialize the matrix
for ii = 1:nu
  Driving_Time_3_VOT_sum(ii,:) = mean(Driving_Time_3_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Driving_Time_3_VOT_sum(:,2) = Driving_Time_3_VOT_unique;                %finalize the matrix setting the VOT

%Sim6
Driving_Time_6_VOT = Driving_Time_6_VOT(:,[1 3]);                       %Take the 2 column that are important

[Driving_Time_6_VOT_unique,~,idx] = unique(Driving_Time_6_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Driving_Time_6_VOT_unique);
Driving_Time_6_VOT_sum = zeros(nu,size(Driving_Time_6_VOT,2));          %initialize the matrix
for ii = 1:nu
  Driving_Time_6_VOT_sum(ii,:) = mean(Driving_Time_6_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Driving_Time_6_VOT_sum(:,2) = Driving_Time_6_VOT_unique;                %finalize the matrix setting the VOT

Delta_Driving3_6 = Driving_Time_3_VOT_sum(:,1)-Driving_Time_6_VOT_sum(:,1);   %Check the Delta_Driving between the 2 simulation

%Sim9
Driving_Time_9_VOT = Driving_Time_9_VOT(:,[1 3]);                       %Take the 2 column that are important

[Driving_Time_9_VOT_unique,~,idx] = unique(Driving_Time_9_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Driving_Time_9_VOT_unique);
Driving_Time_9_VOT_sum = zeros(nu,size(Driving_Time_9_VOT,2));          %initialize the matrix
for ii = 1:nu
  Driving_Time_9_VOT_sum(ii,:) = mean(Driving_Time_9_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Driving_Time_9_VOT_sum(:,2) = Driving_Time_9_VOT_unique;                %finalize the matrix setting the VOT

Delta_Driving6_9 = Driving_Time_6_VOT_sum(:,1)-Driving_Time_9_VOT_sum(:,1);   %Check the Delta_Driving between the 2 simulation

%Sim12
Driving_Time_12_VOT = Driving_Time_12_VOT(:,[1 3]);                       %Take the 2 column that are important

[Driving_Time_12_VOT_unique,~,idx] = unique(Driving_Time_12_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Driving_Time_12_VOT_unique);
Driving_Time_12_VOT_sum = zeros(nu,size(Driving_Time_12_VOT,2));          %initialize the matrix
for ii = 1:nu
  Driving_Time_12_VOT_sum(ii,:) = mean(Driving_Time_12_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Driving_Time_12_VOT_sum(:,2) = Driving_Time_12_VOT_unique;                %finalize the matrix setting the VOT

Delta_Driving6_12 = Driving_Time_6_VOT_sum(:,1)-Driving_Time_12_VOT_sum(:,1);   %Check the Delta_Driving between the 2 simulation

%Sim14
Driving_Time_14_VOT = Driving_Time_14_VOT(:,[1 3]);                       %Take the 2 column that are important

[Driving_Time_14_VOT_unique,~,idx] = unique(Driving_Time_14_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Driving_Time_14_VOT_unique);
Driving_Time_14_VOT_sum = zeros(nu,size(Driving_Time_14_VOT,2));          %initialize the matrix
for ii = 1:nu
  Driving_Time_14_VOT_sum(ii,:) = mean(Driving_Time_14_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Driving_Time_14_VOT_sum(:,2) = Driving_Time_14_VOT_unique;                %finalize the matrix setting the VOT

Delta_Driving6_14 = Driving_Time_6_VOT_sum(:,1)-Driving_Time_14_VOT_sum(:,1);   %Check the Delta_Driving between the 2 simulation


%Delta_Driving STARTING TIME
%Plot the Delta_Driving time 1-4
scatter(Driving_Time_1_VOT_unique,Delta_Driving1_4);
hold on
plot(0);
title('Differential in Driving Time 1-4');
xticks(Driving_Time_1_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Driving Time mean [s]');
hold off
filename = sprintf('Delta_Driving time 1-4.png');
saveas(gca,filename);

%Plot the Delta_Driving time 4-7
scatter(Driving_Time_4_VOT_unique,Delta_Driving4_7);
hold on
plot(0);
title('Differential in Driving Time 4-7');
xticks(Driving_Time_4_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Driving Time mean [s]');
filename = sprintf('Delta_Driving time 4-7.png');
saveas(gca,filename);
hold off

%Plot the Delta_Driving time 4-11
scatter(Driving_Time_4_VOT_unique,Delta_Driving4_11);
hold on
plot(0);
title('Differential in Driving Time 4-11');
xticks(Driving_Time_4_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Driving Time mean [s]');
filename = sprintf('Delta_Driving time 4-11.png');
saveas(gca,filename);
hold off

% %Plot the Delta_Driving time 4-13
% scatter(Driving_Time_4_VOT_unique,Delta_Driving4_13);
% hold on
% plot(0);
% title('Differential in Driving Time 4-13');
% xticks(Driving_Time_4_VOT_unique);
% xtickangle(90);
% xlabel('VOT');
% ylabel('Driving Time mean [s]');
% filename = sprintf('Delta_Driving time 4-13.png');
% saveas(gca,filename);
% hold off

%Plot the Delta_Driving time 3-6
scatter(Driving_Time_3_VOT_unique,Delta_Driving3_6);
hold on
plot(0);
title('Differential in Driving Time 3-6');
xticks(Driving_Time_3_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Driving Time mean [s]');
filename = sprintf('Delta_Driving time 3-6.png');
saveas(gca,filename);
hold off

%Plot the Delta_Driving time 6-9
scatter(Driving_Time_6_VOT_unique,Delta_Driving6_9);
hold on
plot(0);
title('Differential in Driving Time 6-9');
xticks(Driving_Time_6_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Driving Time mean [s]');
filename = sprintf('Delta_Driving time 6-9.png');
saveas(gca,filename);
hold off

%Plot the Delta_Driving time 6-12
scatter(Driving_Time_6_VOT_unique,Delta_Driving6_12);
hold on
plot(0);
title('Differential in Driving Time 6-12');
xticks(Driving_Time_6_VOT_unique);
xtickangle(120);
xlabel('VOT');
ylabel('Driving Time mean [s]');
filename = sprintf('Delta_Driving time 6-12.png');
saveas(gca,filename);
hold off

%Plot the Delta_Driving time 6-14
scatter(Driving_Time_6_VOT_unique,Delta_Driving6_14);
hold on
plot(0);
title('Differential in Driving Time 6-14');
xticks(Driving_Time_6_VOT_unique);
xtickangle(140);
xlabel('VOT');
ylabel('Driving Time mean [s]');
filename = sprintf('Delta_Driving time 6-14.png');
saveas(gca,filename);
hold off

%Plot the Delta_Driving time 1-7
Delta_Driving1_7 = Driving_Time_1_VOT_sum(:,1)-Driving_Time_7_VOT_sum(:,1); 
scatter(Driving_Time_1_VOT_unique,Delta_Driving1_7);
hold on
plot(0);
title('Differential in Driving Time 1-7');
xticks(Driving_Time_6_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Driving Time mean [s]');
filename = sprintf('Delta_Driving time 1-7.png');
saveas(gca,filename);
hold off

%Plot the Delta_Driving time 3-9
Delta_Driving3_9 = Driving_Time_3_VOT_sum(:,1)-Driving_Time_9_VOT_sum(:,1); 
scatter(Driving_Time_3_VOT_unique,Delta_Driving3_9);
hold on
plot(0);
title('Differential in Driving Time 3-9');
xticks(Driving_Time_6_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Driving Time mean [s]');
filename = sprintf('Delta_Driving time 3-9.png');
saveas(gca,filename);
hold off


%For the booking 
%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #1
Booking_Time_1(:,1) = [];
Booking_Time_1 = sortrows(Booking_Time_1,2);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Booking_Time_1);              %Check same ID in VOT_ID and Booking_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before 
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Booking_Time_1(:,1)),:);
Booking_Time_1_VOT = [Booking_Time_1 VOT_ID_Rented(:,2)];               %Put them together
Booking_Time_1_VOT = sortrows(Booking_Time_1_VOT,3,'ascend');           %sort by the VOT

% %Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #2
% Booking_Time_2(:,1) = [];
% Booking_Time_2 = sortrows(Booking_Time_2);                              %Sort by the ID
% VOT_ID_Rented = ismember(VOT_ID,Booking_Time_2);              %Check same ID in VOT_ID and Booking_Time_1
% VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
% VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
% VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
% Booking_Time_2_VOT = [Booking_Time_2 VOT_ID_Rented(:,2)];               %Put them together
% Booking_Time_2_VOT = sortrows(Booking_Time_2_VOT,3,'ascend');           %sort by the VOT


%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #3
Booking_Time_3(:,1) = [];
Booking_Time_3 = sortrows(Booking_Time_3);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Booking_Time_3);              %Check same ID in VOT_ID and Booking_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Booking_Time_3(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
Booking_Time_3_VOT = [Booking_Time_3 VOT_ID_Rented(:,2)];               %Put them together
Booking_Time_3_VOT = sortrows(Booking_Time_3_VOT,3,'ascend');           %sort by the VOT


%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #4
Booking_Time_4(:,1) = [];
Booking_Time_4 = sortrows(Booking_Time_4);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Booking_Time_4);              %Check same ID in VOT_ID and Booking_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Booking_Time_4(:,1)),:); 
Booking_Time_4_VOT = [Booking_Time_4 VOT_ID_Rented(:,2)];               %Put them together
Booking_Time_4_VOT = sortrows(Booking_Time_4_VOT,3,'ascend');           %sort by the VOT


% %Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #5
% Booking_Time_5(:,1) = [];
% Booking_Time_5 = sortrows(Booking_Time_5);                              %Sort by the ID
% VOT_ID_Rented = ismember(VOT_ID,Booking_Time_5);              %Check same ID in VOT_ID and Booking_Time_1
% VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
% VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
% VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
% Booking_Time_5_VOT = [Booking_Time_5 VOT_ID_Rented(:,2)];               %Put them together
% Booking_Time_5_VOT = sortrows(Booking_Time_5_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #6
Booking_Time_6(:,1) = [];
Booking_Time_6 = sortrows(Booking_Time_6);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Booking_Time_6);              %Check same ID in VOT_ID and Booking_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Booking_Time_6(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
Booking_Time_6_VOT = [Booking_Time_6 VOT_ID_Rented(:,2)];               %Put them together
Booking_Time_6_VOT = sortrows(Booking_Time_6_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
Booking_Time_7(:,1) = [];
Booking_Time_7 = sortrows(Booking_Time_7);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Booking_Time_7);              %Check same ID in VOT_ID and Booking_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
Booking_Time_7_VOT = [Booking_Time_7 VOT_ID_Rented(:,2)];               %Put them together
Booking_Time_7_VOT = sortrows(Booking_Time_7_VOT,3,'ascend');           %sort by the VOT

% %Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
% Booking_Time_8(:,1) = [];
% Booking_Time_8 = sortrows(Booking_Time_8);                              %Sort by the ID
% VOT_ID_Rented = ismember(VOT_ID,Booking_Time_8);              %Check same ID in VOT_ID and Booking_Time_1
% VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
% VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
% VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
% Booking_Time_8_VOT = [Booking_Time_8 VOT_ID_Rented(:,2)];               %Put them together
% Booking_Time_8_VOT = sortrows(Booking_Time_8_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
Booking_Time_9(:,1) = [];
Booking_Time_9 = sortrows(Booking_Time_9);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Booking_Time_9);              %Check same ID in VOT_ID and Booking_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Booking_Time_9(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
Booking_Time_9_VOT = [Booking_Time_9 VOT_ID_Rented(:,2)];               %Put them together
Booking_Time_9_VOT = sortrows(Booking_Time_9_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
Booking_Time_11(:,1) = [];
Booking_Time_11 = sortrows(Booking_Time_11);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Booking_Time_11);              %Check same ID in VOT_ID and Booking_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [1011x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
Booking_Time_11_VOT = [Booking_Time_11 VOT_ID_Rented(:,2)];               %Put them together
Booking_Time_11_VOT = sortrows(Booking_Time_11_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
Booking_Time_12(:,1) = [];
Booking_Time_12 = sortrows(Booking_Time_12);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Booking_Time_12);              %Check same ID in VOT_ID and Booking_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [1012x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Booking_Time_12(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
Booking_Time_12_VOT = [Booking_Time_12 VOT_ID_Rented(:,2)];               %Put them together
Booking_Time_12_VOT = sortrows(Booking_Time_12_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
Booking_Time_13(:,1) = [];
Booking_Time_13 = sortrows(Booking_Time_13);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Booking_Time_13);              %Check same ID in VOT_ID and Booking_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [1013x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Driving_Time_13(:,1)),:);                                                                                     %remove if "Dimensions of arrays being concatenated are not consistent."
Booking_Time_13_VOT = [Booking_Time_13 VOT_ID_Rented(:,2)];               %Put them together
Booking_Time_13_VOT = sortrows(Booking_Time_13_VOT,3,'ascend');           %sort by the VOT

%Add the VOT to AccessTime# to check the VOT of people walking for SHIFTING RENTAL STARTS #
Booking_Time_14(:,1) = [];
Booking_Time_14 = sortrows(Booking_Time_14);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,Booking_Time_14);              %Check same ID in VOT_ID and Booking_Time_1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [1014x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
VOT_ID_Rented = VOT_ID_Rented(1:numel(Booking_Time_14(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
Booking_Time_14_VOT = [Booking_Time_14 VOT_ID_Rented(:,2)];               %Put them together
Booking_Time_14_VOT = sortrows(Booking_Time_14_VOT,3,'ascend');           %sort by the VOT

%Evaluate the differences between two simulations based on the VOT

%Sim1
Booking_Time_1_VOT = Booking_Time_1_VOT(:,[1 3]);                       %Take the 2 column that are important

[Booking_Time_1_VOT_unique,~,idx] = unique(Booking_Time_1_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Booking_Time_1_VOT_unique);
Booking_Time_1_VOT_sum = zeros(nu,size(Booking_Time_1_VOT,2));          %initialize the matrix
for ii = 1:nu
  Booking_Time_1_VOT_sum(ii,:) = mean(Booking_Time_1_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Booking_Time_1_VOT_sum(:,2) = Booking_Time_1_VOT_unique;                %finalize the matrix setting the VOT

%Sim4
Booking_Time_4_VOT = Booking_Time_4_VOT(:,[1 3]);                       %Take the 2 column that are important

[Booking_Time_4_VOT_unique,~,idx] = unique(Booking_Time_4_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Booking_Time_4_VOT_unique);
Booking_Time_4_VOT_sum = zeros(nu,size(Booking_Time_4_VOT,2));          %initialize the matrix
for ii = 1:nu
  Booking_Time_4_VOT_sum(ii,:) = mean(Booking_Time_4_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Booking_Time_4_VOT_sum(:,2) = Booking_Time_4_VOT_unique;                %finalize the matrix setting the VOT

Delta_Booking1_4 = Booking_Time_1_VOT_sum(:,1)-Booking_Time_4_VOT_sum(:,1);   %Check the Delta_Booking between the 2 simulations


%Sim7
Booking_Time_7_VOT = Booking_Time_7_VOT(:,[1 3]);                       %Take the 2 column that are important

[Booking_Time_7_VOT_unique,~,idx] = unique(Booking_Time_7_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Booking_Time_7_VOT_unique);
Booking_Time_7_VOT_sum = zeros(nu,size(Booking_Time_7_VOT,2));          %initialize the matrix
for ii = 1:nu
  Booking_Time_7_VOT_sum(ii,:) = mean(Booking_Time_7_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Booking_Time_7_VOT_sum(:,2) = Booking_Time_7_VOT_unique;                %finalize the matrix setting the VOT

Delta_Booking4_7 = Booking_Time_4_VOT_sum(:,1)-Booking_Time_7_VOT_sum(:,1);   %Check the Delta_Booking between the 2 simulation

%Sim11
Booking_Time_11_VOT = Booking_Time_11_VOT(:,[1 3]);                       %Take the 2 column that are important

[Booking_Time_11_VOT_unique,~,idx] = unique(Booking_Time_11_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Booking_Time_11_VOT_unique);
Booking_Time_11_VOT_sum = zeros(nu,size(Booking_Time_11_VOT,2));          %initialize the matrix
for ii = 1:nu
  Booking_Time_11_VOT_sum(ii,:) = mean(Booking_Time_11_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Booking_Time_11_VOT_sum(:,2) = Booking_Time_11_VOT_unique;                %finalize the matrix setting the VOT

Delta_Booking4_11 = Booking_Time_4_VOT_sum(:,1)-Booking_Time_11_VOT_sum(:,1);   %Check the Delta_Booking between the 2 simulation

% %Sim13
% Booking_Time_13_VOT = Booking_Time_13_VOT(:,[1 3]);                       %Take the 2 column that are important
% 
% [Booking_Time_13_VOT_unique,~,idx] = unique(Booking_Time_13_VOT(:,2));    %create unique matrix and id the same values
% nu = numel(Booking_Time_13_VOT_unique);
% Booking_Time_13_VOT_sum = zeros(nu,size(Booking_Time_13_VOT,2));          %initialize the matrix
% for ii = 1:nu
%   Booking_Time_13_VOT_sum(ii,:) = mean(Booking_Time_13_VOT(idx==ii,:));    %sum the same time with the same VOT
% end
% Booking_Time_13_VOT_sum(:,2) = Booking_Time_13_VOT_unique;                %finalize the matrix setting the VOT
% 
% Delta_Booking4_13 = Booking_Time_4_VOT_sum(:,1)-Booking_Time_13_VOT_sum(:,1);   %Check the Delta_Booking between the 2 simulation

%Sim3
Booking_Time_3_VOT = Booking_Time_3_VOT(:,[1 3]);                       %Take the 2 column that are important

[Booking_Time_3_VOT_unique,~,idx] = unique(Booking_Time_3_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Booking_Time_3_VOT_unique);
Booking_Time_3_VOT_sum = zeros(nu,size(Booking_Time_3_VOT,2));          %initialize the matrix
for ii = 1:nu
  Booking_Time_3_VOT_sum(ii,:) = mean(Booking_Time_3_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Booking_Time_3_VOT_sum(:,2) = Booking_Time_3_VOT_unique;                %finalize the matrix setting the VOT

%Sim6
Booking_Time_6_VOT = Booking_Time_6_VOT(:,[1 3]);                       %Take the 2 column that are important

[Booking_Time_6_VOT_unique,~,idx] = unique(Booking_Time_6_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Booking_Time_6_VOT_unique);
Booking_Time_6_VOT_sum = zeros(nu,size(Booking_Time_6_VOT,2));          %initialize the matrix
for ii = 1:nu
  Booking_Time_6_VOT_sum(ii,:) = mean(Booking_Time_6_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Booking_Time_6_VOT_sum(:,2) = Booking_Time_6_VOT_unique;                %finalize the matrix setting the VOT

Delta_Booking3_6 = Booking_Time_3_VOT_sum(:,1)-Booking_Time_6_VOT_sum(:,1);   %Check the Delta_Booking between the 2 simulation

%Sim9
Booking_Time_9_VOT = Booking_Time_9_VOT(:,[1 3]);                       %Take the 2 column that are important

[Booking_Time_9_VOT_unique,~,idx] = unique(Booking_Time_9_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Booking_Time_9_VOT_unique);
Booking_Time_9_VOT_sum = zeros(nu,size(Booking_Time_9_VOT,2));          %initialize the matrix
for ii = 1:nu
  Booking_Time_9_VOT_sum(ii,:) = mean(Booking_Time_9_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Booking_Time_9_VOT_sum(:,2) = Booking_Time_9_VOT_unique;                %finalize the matrix setting the VOT

Delta_Booking6_9 = Booking_Time_6_VOT_sum(:,1)-Booking_Time_9_VOT_sum(:,1);   %Check the Delta_Booking between the 2 simulation

%Sim12
Booking_Time_12_VOT = Booking_Time_12_VOT(:,[1 3]);                       %Take the 2 column that are important

[Booking_Time_12_VOT_unique,~,idx] = unique(Booking_Time_12_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Booking_Time_12_VOT_unique);
Booking_Time_12_VOT_sum = zeros(nu,size(Booking_Time_12_VOT,2));          %initialize the matrix
for ii = 1:nu
  Booking_Time_12_VOT_sum(ii,:) = mean(Booking_Time_12_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Booking_Time_12_VOT_sum(:,2) = Booking_Time_12_VOT_unique;                %finalize the matrix setting the VOT

Delta_Booking6_12 = Booking_Time_6_VOT_sum(:,1)-Booking_Time_12_VOT_sum(:,1);   %Check the Delta_Booking between the 2 simulation

%Sim14
Booking_Time_14_VOT = Booking_Time_14_VOT(:,[1 3]);                       %Take the 2 column that are important

[Booking_Time_14_VOT_unique,~,idx] = unique(Booking_Time_14_VOT(:,2));    %create unique matrix and id the same values
nu = numel(Booking_Time_14_VOT_unique);
Booking_Time_14_VOT_sum = zeros(nu,size(Booking_Time_14_VOT,2));          %initialize the matrix
for ii = 1:nu
  Booking_Time_14_VOT_sum(ii,:) = mean(Booking_Time_14_VOT(idx==ii,:));    %sum the same time with the same VOT
end
Booking_Time_14_VOT_sum(:,2) = Booking_Time_14_VOT_unique;                %finalize the matrix setting the VOT

Delta_Booking6_14 = Booking_Time_6_VOT_sum(:,1)-Booking_Time_14_VOT_sum(:,1);   %Check the Delta_Booking between the 2 simulation


%Delta_Booking STARTING TIME
%Plot the Delta_Booking time 1-4
scatter(Booking_Time_1_VOT_unique,Delta_Booking1_4);
hold on
plot(0);
title('Differential in Booking Time 1-4');
xticks(Booking_Time_1_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Booking Time mean [s]');
hold off
filename = sprintf('Delta_Booking time 1-4.png');
saveas(gca,filename);

%Plot the Delta_Booking time 4-7
scatter(Booking_Time_4_VOT_unique,Delta_Booking4_7);
hold on
plot(0);
title('Differential in Booking Time 4-7');
xticks(Booking_Time_4_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Booking Time mean [s]');
filename = sprintf('Delta_Booking time 4-7.png');
saveas(gca,filename);
hold off

%Plot the Delta_Booking time 4-11
scatter(Booking_Time_4_VOT_unique,Delta_Booking4_11);
hold on
plot(0);
title('Differential in Booking Time 4-11');
xticks(Booking_Time_4_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Booking Time mean [s]');
filename = sprintf('Delta_Booking time 4-11.png');
saveas(gca,filename);
hold off

% %Plot the Delta_Booking time 4-13
% scatter(Booking_Time_4_VOT_unique,Delta_Booking4_13);
% hold on
% plot(0);
% title('Differential in Booking Time 4-13');
% xticks(Booking_Time_4_VOT_unique);
% xtickangle(90);
% xlabel('VOT');
% ylabel('Booking Time mean [s]');
% filename = sprintf('Delta_Booking time 4-13.png');
% saveas(gca,filename);
% hold off

%Plot the Delta_Booking time 3-6
scatter(Booking_Time_3_VOT_unique,Delta_Booking3_6);
hold on
plot(0);
title('Differential in Booking Time 3-6');
xticks(Booking_Time_3_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Booking Time mean [s]');
filename = sprintf('Delta_Booking time 3-6.png');
saveas(gca,filename);
hold off

%Plot the Delta_Booking time 6-9
scatter(Booking_Time_6_VOT_unique,Delta_Booking6_9);
hold on
plot(0);
title('Differential in Booking Time 6-9');
xticks(Booking_Time_6_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Booking Time mean [s]');
filename = sprintf('Delta_Booking time 6-9.png');
saveas(gca,filename);
hold off

%Plot the Delta_Booking time 6-12
scatter(Booking_Time_6_VOT_unique,Delta_Booking6_12);
hold on
plot(0);
title('Differential in Booking Time 6-12');
xticks(Booking_Time_6_VOT_unique);
xtickangle(120);
xlabel('VOT');
ylabel('Booking Time mean [s]');
filename = sprintf('Delta_Booking time 6-12.png');
saveas(gca,filename);
hold off

%Plot the Delta_Booking time 6-14
scatter(Booking_Time_6_VOT_unique,Delta_Booking6_14);
hold on
plot(0);
title('Differential in Booking Time 6-14');
xticks(Booking_Time_6_VOT_unique);
xtickangle(140);
xlabel('VOT');
ylabel('Booking Time mean [s]');
filename = sprintf('Delta_Booking time 6-14.png');
saveas(gca,filename);
hold off

%Plot the Delta_Booking time 1-7
Delta_Booking1_7 = Booking_Time_1_VOT_sum(:,1)-Booking_Time_7_VOT_sum(:,1); 
scatter(Booking_Time_1_VOT_unique,Delta_Booking1_7);
hold on
plot(0);
title('Differential in Booking Time 1-7');
xticks(Booking_Time_6_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Booking Time mean [s]');
filename = sprintf('Delta_Booking time 1-7.png');
saveas(gca,filename);
hold off

%Plot the Delta_Booking time 3-9
Delta_Booking3_9 = Booking_Time_3_VOT_sum(:,1)-Booking_Time_9_VOT_sum(:,1); 
scatter(Booking_Time_3_VOT_unique,Delta_Booking3_9);
hold on
plot(0);
title('Differential in Booking Time 3-9');
xticks(Booking_Time_6_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Booking Time mean [s]');
filename = sprintf('Delta_Booking time 3-9.png');
saveas(gca,filename);
hold off

