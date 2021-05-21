load AccessTime6.mat
load AccessTime9.mat

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

% %Sim9
% AccessTime9_VOT = AccessTime9_VOT(:,[1 3]);                       %Take the 2 column that are important
% 
% [AccessTime9_VOT_unique,~,idx] = unique(AccessTime9_VOT(:,2));    %create unique matrix and id the same values
% nu = numel(AccessTime9_VOT_unique);
% AccessTime9_VOT_sum = zeros(nu,size(AccessTime9_VOT,2));          %initialize the matrix
% for ii = 1:nu
%   AccessTime9_VOT_sum(ii,:) = mean(AccessTime9_VOT(idx==ii,:));    %sum the same time with the same VOT
% end
% AccessTime9_VOT_sum(:,2) = AccessTime9_VOT_unique;                %finalize the matrix setting the VOT

%DELTA
Delta6_9 = AccessTime6_VOT(:,1)-AccessTime9_VOT(:,1);   %Check the delta between the 2 simulation