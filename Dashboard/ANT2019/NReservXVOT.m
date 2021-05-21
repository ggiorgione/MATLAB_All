%Num reservation X VOT

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


NRXVOT1 = sortrows(SRS1);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,NRXVOT1);              %Check same ID in VOT_ID and SRS1
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
NRXVOT1_VOT = VOT_ID_Rented;               %Put them together


%Put together all the time with the same VOT

[NRXVOT1_VOTunique,~,idx] = unique(NRXVOT1_VOT(:,2));
nu = numel(NRXVOT1_VOTunique);
NRXVOT1_VOT_sum = zeros(nu,size(NRXVOT1_VOT,2));
d = {};
for i=1:nu
    c = numel(find(idx==i));
    d{i} = c;
end
d = d';
f = cell2mat(d);
NRXVOT1_VOT_sum = [f NRXVOT1_VOTunique];






NRXVOT3 = sortrows(SRS3);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,NRXVOT3);              %Check same ID in VOT_ID and SRS3
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [309x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
NRXVOT3_VOT = VOT_ID_Rented;               %Put them together


%Put together all the time with the same VOT

[NRXVOT3_VOTunique,~,idx] = unique(NRXVOT3_VOT(:,2));
nu = numel(NRXVOT3_VOTunique);
NRXVOT3_VOT_sum = zeros(nu,size(NRXVOT3_VOT,2));
d = {};
for i=1:nu
    c = numel(find(idx==i));
    d{i} = c;
end
d = d';
f = cell2mat(d);
NRXVOT3_VOT_sum = [f NRXVOT3_VOTunique];



NRXVOT4 = sortrows(SRS4);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,NRXVOT4);              %Check same ID in VOT_ID and SRS4
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [409x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
NRXVOT4_VOT = VOT_ID_Rented;               %Put them together


%Put together all the time with the same VOT

[NRXVOT4_VOTunique,~,idx] = unique(NRXVOT4_VOT(:,2));
nu = numel(NRXVOT4_VOTunique);
NRXVOT4_VOT_sum = zeros(nu,size(NRXVOT4_VOT,2));
d = {};
for i=1:nu
    c = numel(find(idx==i));
    d{i} = c;
end
d = d';
f = cell2mat(d);
NRXVOT4_VOT_sum = [f NRXVOT4_VOTunique];



NRXVOT6 = sortrows(SRS6);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,NRXVOT6);              %Check same ID in VOT_ID and SRS6
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [609x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
NRXVOT6_VOT = VOT_ID_Rented;               %Put them together


%Put together all the time with the same VOT

[NRXVOT6_VOTunique,~,idx] = unique(NRXVOT6_VOT(:,2));
nu = numel(NRXVOT6_VOTunique);
NRXVOT6_VOT_sum = zeros(nu,size(NRXVOT6_VOT,2));
d = {};
for i=1:nu
    c = numel(find(idx==i));
    d{i} = c;
end
d = d';
f = cell2mat(d);
NRXVOT6_VOT_sum = [f NRXVOT6_VOTunique];



NRXVOT7 = sortrows(SRS7);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,NRXVOT7);              %Check same ID in VOT_ID and SRS7
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [707x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
NRXVOT7_VOT = VOT_ID_Rented;               %Put them together


%Put together all the time with the same VOT

[NRXVOT7_VOTunique,~,idx] = unique(NRXVOT7_VOT(:,2));
nu = numel(NRXVOT7_VOTunique);
NRXVOT7_VOT_sum = zeros(nu,size(NRXVOT7_VOT,2));
d = {};
for i=1:nu
    c = numel(find(idx==i));
    d{i} = c;
end
d = d';
f = cell2mat(d);
NRXVOT7_VOT_sum = [f NRXVOT7_VOTunique];



NRXVOT9 = sortrows(SRS9);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,NRXVOT9);              %Check same ID in VOT_ID and SRS9
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [909x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
NRXVOT9_VOT = VOT_ID_Rented;               %Put them together


%Put together all the time with the same VOT

[NRXVOT9_VOTunique,~,idx] = unique(NRXVOT9_VOT(:,2));
nu = numel(NRXVOT9_VOTunique);
NRXVOT9_VOT_sum = zeros(nu,size(NRXVOT9_VOT,2));
d = {};
for i=1:nu
    c = numel(find(idx==i));
    d{i} = c;
end
d = d';
f = cell2mat(d);
NRXVOT9_VOT_sum = [f NRXVOT9_VOTunique];



NRXVOT11 = sortrows(SRS11);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,NRXVOT11);              %Check same ID in VOT_ID and SRS11
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [11011x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
NRXVOT11_VOT = VOT_ID_Rented;               %Put them together


%Put together all the time with the same VOT

[NRXVOT11_VOTunique,~,idx] = unique(NRXVOT11_VOT(:,2));
nu = numel(NRXVOT11_VOTunique);
NRXVOT11_VOT_sum = zeros(nu,size(NRXVOT11_VOT,2));
d = {};
for i=1:nu
    c = numel(find(idx==i));
    d{i} = c;
end
d = d';
f = cell2mat(d);
NRXVOT11_VOT_sum = [f NRXVOT11_VOTunique];




NRXVOT12 = sortrows(SRS12);                              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,NRXVOT12);              %Check same ID in VOT_ID and SRS12
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];               %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);        %Reshape it as before [12012x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
NRXVOT12_VOT = VOT_ID_Rented;               %Put them together


%Put together all the time with the same VOT

[NRXVOT12_VOTunique,~,idx] = unique(NRXVOT12_VOT(:,2));
nu = numel(NRXVOT12_VOTunique);
NRXVOT12_VOT_sum = zeros(nu,size(NRXVOT12_VOT,2));
d = {};
for i=1:nu
    c = numel(find(idx==i));
    d{i} = c;
end
d = d';
f = cell2mat(d);
NRXVOT12_VOT_sum = [f NRXVOT12_VOTunique];

plot(NRXVOT12_VOT_sum(:,2),NRXVOT12_VOT_sum(:,1))
