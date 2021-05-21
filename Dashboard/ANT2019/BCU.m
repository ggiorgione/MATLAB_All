%BOOKING COST X USER -SUM(bcu)/TotUsers = (AVGcost * Users with that cost)/TotUsers

load VOT_ID.mat
VOT_ID= str2double(VOT_ID);

sims = {1,3,4,6,7,9,11,12};

load Booking_Time_1.mat
load Revenue1.mat
load StartingTime_1.mat
VehIDBookTimeUserID1 = BookingTimePercentage;
IdCostBooktimeStarttimeVot = [BookingTimePercentage(:,3) Revenue1(:,3) BookingTimePercentage(:,2) StartingTime];
%Add the VOT to IdCostBooktimeStarttimeVot#
IdCostBooktimeStarttimeVot = sortrows(IdCostBooktimeStarttimeVot);              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,IdCostBooktimeStarttimeVot(:,1));               %Check same ID in VOT_ID and SRS1           
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                                           %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                                    %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
IdCostBooktimeStarttimeVot = [IdCostBooktimeStarttimeVot VOT_ID_Rented(:,2)];   %Put them together
filename = ('IdCostBooktimeStarttimeVot1.mat');
save(filename,'IdCostBooktimeStarttimeVot');
clear BookingTime
clear BookingTimePercentage
clear IdCostBooktimeStarttimeVot

load Booking_Time_3.mat
load Revenue3.mat
load StartingTime_3.mat
VehIDBookTimeUserID3 = BookingTimePercentage;
IdCostBooktimeStarttimeVot = [BookingTimePercentage(:,3) Revenue3(:,3) BookingTimePercentage(:,2) StartingTime];
%Add the VOT to IdCostBooktimeStarttimeVot#
IdCostBooktimeStarttimeVot = sortrows(IdCostBooktimeStarttimeVot);              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,IdCostBooktimeStarttimeVot(:,1));               %Check same ID in VOT_ID and SRS1           
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                                           %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                                    %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
IdCostBooktimeStarttimeVot = [IdCostBooktimeStarttimeVot VOT_ID_Rented(:,2)];   %Put them together
filename = ('IdCostBooktimeStarttimeVot3.mat');
save(filename,'IdCostBooktimeStarttimeVot');
clear BookingTime
clear BookingTimePercentage
clear IdCostBooktimeStarttimeVot

load Booking_Time_4.mat
load Revenue4.mat
load StartingTime_4.mat
VehIDBookTimeUserID4 = BookingTimePercentage;
IdCostBooktimeStarttimeVot = [BookingTimePercentage(:,3) Revenue4(:,3) BookingTimePercentage(:,2) StartingTime];
%Add the VOT to IdCostBooktimeStarttimeVot#
IdCostBooktimeStarttimeVot = sortrows(IdCostBooktimeStarttimeVot);              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,IdCostBooktimeStarttimeVot(:,1));               %Check same ID in VOT_ID and SRS1           
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                                           %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                                    %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
IdCostBooktimeStarttimeVot = [IdCostBooktimeStarttimeVot VOT_ID_Rented(:,2)];   %Put them together
filename = ('IdCostBooktimeStarttimeVot4.mat');
save(filename,'IdCostBooktimeStarttimeVot');
clear BookingTime
clear BookingTimePercentage
clear IdCostBooktimeStarttimeVot

load Booking_Time_6.mat
load Revenue6.mat
load StartingTime_6.mat
VehIDBookTimeUserID6 = BookingTimePercentage;
IdCostBooktimeStarttimeVot = [BookingTimePercentage(:,3) Revenue6(:,3) BookingTimePercentage(:,2) StartingTime];
%Add the VOT to IdCostBooktimeStarttimeVot#
IdCostBooktimeStarttimeVot = sortrows(IdCostBooktimeStarttimeVot);              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,IdCostBooktimeStarttimeVot(:,1));               %Check same ID in VOT_ID and SRS1           
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                                           %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                                    %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
IdCostBooktimeStarttimeVot = [IdCostBooktimeStarttimeVot VOT_ID_Rented(:,2)];   %Put them together
filename = ('IdCostBooktimeStarttimeVot6.mat');
save(filename,'IdCostBooktimeStarttimeVot');
clear BookingTime
clear BookingTimePercentage
clear IdCostBooktimeStarttimeVot

load Booking_Time_7.mat
load Revenue7.mat
load StartingTime_7.mat
VehIDBookTimeUserID7 = BookingTimePercentage;
IdCostBooktimeStarttimeVot = [BookingTimePercentage(:,3) Revenue7(:,3) BookingTimePercentage(:,2) StartingTime];
%Add the VOT to IdCostBooktimeStarttimeVot#
IdCostBooktimeStarttimeVot = sortrows(IdCostBooktimeStarttimeVot);              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,IdCostBooktimeStarttimeVot(:,1));               %Check same ID in VOT_ID and SRS1           
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                                           %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                                    %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
IdCostBooktimeStarttimeVot = [IdCostBooktimeStarttimeVot VOT_ID_Rented(:,2)];   %Put them together
filename = ('IdCostBooktimeStarttimeVot7.mat');
save(filename,'IdCostBooktimeStarttimeVot');
clear BookingTime
clear BookingTimePercentage
clear IdCostBooktimeStarttimeVot

load Booking_Time_9.mat
load Revenue9.mat
load StartingTime_9.mat
VehIDBookTimeUserID9 = BookingTimePercentage;
IdCostBooktimeStarttimeVot = [BookingTimePercentage(:,3) Revenue9(:,3) BookingTimePercentage(:,2) StartingTime];
%Add the VOT to IdCostBooktimeStarttimeVot#
IdCostBooktimeStarttimeVot = sortrows(IdCostBooktimeStarttimeVot);              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,IdCostBooktimeStarttimeVot(:,1));               %Check same ID in VOT_ID and SRS1           
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                                           %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                                    %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
IdCostBooktimeStarttimeVot = [IdCostBooktimeStarttimeVot VOT_ID_Rented(:,2)];   %Put them together
filename = ('IdCostBooktimeStarttimeVot9.mat');
save(filename,'IdCostBooktimeStarttimeVot');
clear BookingTime
clear BookingTimePercentage
clear IdCostBooktimeStarttimeVot

load Booking_Time_11.mat
load Revenue11.mat
load StartingTime_11.mat
VehIDBookTimeUserID11 = BookingTimePercentage;
IdCostBooktimeStarttimeVot = [BookingTimePercentage(:,3) Revenue11(:,3) BookingTimePercentage(:,2) StartingTime];
%Add the VOT to IdCostBooktimeStarttimeVot#
IdCostBooktimeStarttimeVot = sortrows(IdCostBooktimeStarttimeVot);              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,IdCostBooktimeStarttimeVot(:,1));               %Check same ID in VOT_ID and SRS1           
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                                           %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                                    %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
IdCostBooktimeStarttimeVot = [IdCostBooktimeStarttimeVot VOT_ID_Rented(:,2)];   %Put them together
filename = ('IdCostBooktimeStarttimeVot11.mat');
save(filename,'IdCostBooktimeStarttimeVot');
clear BookingTime
clear BookingTimePercentage
clear IdCostBooktimeStarttimeVot

load Booking_Time_12.mat
load Revenue12.mat
load StartingTime_12.mat
VehIDBookTimeUserID12 = BookingTimePercentage;
IdCostBooktimeStarttimeVot = [BookingTimePercentage(:,3) Revenue12(:,3) BookingTimePercentage(:,2) StartingTime];
%Add the VOT to IdCostBooktimeStarttimeVot#
IdCostBooktimeStarttimeVot = sortrows(IdCostBooktimeStarttimeVot);              %Sort by the ID
VOT_ID_Rented = ismember(VOT_ID,IdCostBooktimeStarttimeVot(:,1));               %Check same ID in VOT_ID and SRS1           
VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);
VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented(VOT_ID_Rented==0) = [];                                           %Remove the 0s
VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                                    %Reshape it as before [109x2]
VOT_ID_Rented = VOT_ID_Rented';
VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
IdCostBooktimeStarttimeVot = [IdCostBooktimeStarttimeVot VOT_ID_Rented(:,2)];   %Put them together
filename = ('IdCostBooktimeStarttimeVot12.mat');
save(filename,'IdCostBooktimeStarttimeVot');
clear BookingTime
clear BookingTimePercentage
clear IdCostBooktimeStarttimeVot

% load Booking_Time_13.mat
% load Revenue13.mat
% load StartingTime_13.mat
% VehIDBookTimeUserID13 = BookingTimePercentage;
% IdCostBooktimeStarttimeVot = [BookingTimePercentage(:,3) Revenue13(:,3) BookingTimePercentage(:,2) StartingTime];
% %Add the VOT to IdCostBooktimeStarttimeVot#
% IdCostBooktimeStarttimeVot = sortrows(IdCostBooktimeStarttimeVot);              %Sort by the ID
% VOT_ID_Rented = ismember(VOT_ID,IdCostBooktimeStarttimeVot(:,1));               %Check same ID in VOT_ID and SRS1           
% VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);
% VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented(VOT_ID_Rented==0) = [];                                           %Remove the 0s
% VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                                    %Reshape it as before [109x2]
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
% IdCostBooktimeStarttimeVot = [IdCostBooktimeStarttimeVot VOT_ID_Rented(:,2)];   %Put them together
% filename = ('IdCostBooktimeStarttimeVot13.mat');
% save(filename,'IdCostBooktimeStarttimeVot');
% clear BookingTime
% clear BookingTimePercentage
% clear IdCostBooktimeStarttimeVot
% 
% load Booking_Time_14.mat
% load Revenue14.mat
% load StartingTime_14.mat
% VehIDBookTimeUserID14 = BookingTimePercentage;
% IdCostBooktimeStarttimeVot = [BookingTimePercentage(:,3) Revenue14(:,3) BookingTimePercentage(:,2) StartingTime];
% %Add the VOT to IdCostBooktimeStarttimeVot#
% IdCostBooktimeStarttimeVot = sortrows(IdCostBooktimeStarttimeVot);              %Sort by the ID
% VOT_ID_Rented = ismember(VOT_ID,IdCostBooktimeStarttimeVot(:,1));               %Check same ID in VOT_ID and SRS1           
% VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);
% VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented(VOT_ID_Rented==0) = [];                                           %Remove the 0s
% VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                                    %Reshape it as before [109x2]
% VOT_ID_Rented = VOT_ID_Rented';
% VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
% IdCostBooktimeStarttimeVot = [IdCostBooktimeStarttimeVot VOT_ID_Rented(:,2)];   %Put them together
% filename = ('IdCostBooktimeStarttimeVot14.mat');
% save(filename,'IdCostBooktimeStarttimeVot');

clear all


%EVALUATION

daytimemin = 1800;
daytimesec = 1800*60;
step = 15;
timestep = (1:120);
timestep = timestep * step;
timestepmin = timestep';
timestep = timestep' * 60;
sims = [1,3,4,6,7,9,11,12];

for s=sims
    filename = sprintf('IdCostBooktimeStarttimeVot%i.mat',s)                            %Load the matrix
    load(filename)                              
    
    IdCostBooktimeStarttimeVottemp = IdCostBooktimeStarttimeVot;
    IdCostBooktimeStarttimeVottemp(:,3) = IdCostBooktimeStarttimeVottemp(:,3)/60;           %Evaluation average price per user per minute
    IdCostBooktimeStarttimeVottemp(:,4) = IdCostBooktimeStarttimeVottemp(:,4)/60;
    priceunit = IdCostBooktimeStarttimeVottemp(:,3)./IdCostBooktimeStarttimeVottemp(:,2);
    IdCostBooktimeStarttimeVot(:,6) = priceunit;

    IdCostBooktimeStarttimeVot = sortrows(IdCostBooktimeStarttimeVot,4); 
    Temp={};
    for k = 1:1:(numel(timestep))-1                                                     %Creates matrix (temp) with starting time between k and k+1
        tStart=timestep(k);
        tEnd=timestep(k+1);
        kTemp=IdCostBooktimeStarttimeVot(IdCostBooktimeStarttimeVot(:,4)>=tStart,:);
        kTemp=kTemp(kTemp(:,4)<tEnd,:);
        Temp{k,1}=kTemp;
    end
    for k = 1:1:(numel(timestep))-1
        
        BCUTemp = Temp{k};
        BCUTemp(:,6) = round(BCUTemp(:,6),1)
        %BCUTemp = cell2mat(BCUTemp);
        if BCUTemp ~= 0
            %How many users with the same price?
            [Priceunique,~,idx] = unique(BCUTemp(:,6));
            nu = numel(Priceunique);
            %UsersXPrice = zeros(nu,size(BCUTemp,2));
            UsersXPrice = [];
            for ii = 1:nu
                UsersXPrice(ii,:) = numel(BCUTemp(idx==ii,1));
            end
            UsersXPrice = (UsersXPrice(:,1));

            BookingCostXUser = (sum(UsersXPrice.*Priceunique))/(sum(UsersXPrice));
        else
            BookingCostXUser = 0;
            UsersXPrice = 0;
            Priceunique = 0;
        end
        BookingCostXUserMatrix{k,1} = BookingCostXUser;
        UsersXPriceMatrix{k,1} = UsersXPrice;
        PriceuniqueMatrix{k,1} = Priceunique;
        
    end
%    TotUsers = (cell2mat(UsersXPriceMatrix)*cell2mat(PriceuniqueMatrix))/numel(IdCostBooktimeStarttimeVot(:,1));

    filename = sprintf('BookingCostXUser%i.mat',s);
    save(filename,'BookingCostXUserMatrix','UsersXPriceMatrix','IdCostBooktimeStarttimeVot','PriceuniqueMatrix');
end







% 
% 
% load IdCostBooktimeStarttimeVot7.mat
% IdCostBooktimeStarttimeVot = sortrows(IdCostBooktimeStarttimeVot,4); 
% Temp={};
% for k = 1:1:(numel(timestep))-1
%     tStart=timestep(k);
%     tEnd=timestep(k+1);
%     kTemp=IdCostBooktimeStarttimeVot(IdCostBooktimeStarttimeVot(:,4)>=tStart,:);
%     kTemp=kTemp(kTemp(:,4)<tEnd,:);
%     Temp{k,1}=kTemp;
% end
% 
% 
% 

















% for i = 0:timestep:daytimemin
%     load IdCostBooktimeStarttimeVot7.mat
%     IdCostBooktimeStarttimeVot = sortrows(IdCostBooktimeStarttimeVot,4);
%     for k = 1:(numel(timestep))-1
%         for j = 1:numel(IdCostBooktimeStarttimeVot(:,4))
%             if IdCostBooktimeStarttimeVot(j,4) >= timestep(k,:) && IdCostBooktimeStarttimeVot(j,4) <= timestep(k+1,:)
%                 Temp(j,:) = IdCostBooktimeStarttimeVot(j,:);
%             end
%         end
%     end
%     if Temp~=[]
%         IdCostBooktimeStarttimeVot(:,3) = IdCostBooktimeStarttimeVot(:,3)/60;
%         IdCostBooktimeStarttimeVot(:,4) = IdCostBooktimeStarttimeVot(:,4)/60;
%         priceunit = IdCostBooktimeStarttimeVot(:,3)./IdCostBooktimeStarttimeVot(:,2);
%         IdCostBooktimeStarttimeVot(:,6) = priceunit;
%         IdCostBooktimeStarttimeVot = sortrows(IdCostBooktimeStarttimeVot,6);
%         IdCostBooktimeStarttimeVot(:,6) = round(IdCostBooktimeStarttimeVot(:,6),2);
% 
%         %How many users with the same price?
%         [Priceunique,~,idx] = unique(IdCostBooktimeStarttimeVot(:,6));
%         nu = numel(Priceunique);
%         UsersXPrice = zeros(nu,size(IdCostBooktimeStarttimeVot,2));
%         for ii = 1:nu
%             UsersXPrice(ii,:) = numel(IdCostBooktimeStarttimeVot(idx==ii,1));
%         end
%         UsersXPrice = (UsersXPrice(:,1));
% 
%         BookingCostXUser = (sum(UsersXPrice.*Priceunique))/(sum(UsersXPrice));
%         filename = sprintf('BookingCostXUser%i.mat',i);
%         save(filename,'BookingCostXUser');
%     end
% end
    

