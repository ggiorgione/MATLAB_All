clear all;
clear y;
clear x;
clear prompt;

%Output for every simulation:
%Driving time matrix
%Total driving time
%Booking time matrix
%Total booking time
%Total distance travelled
%Vehicle X Km
%Differential in Starting Time "SRS"
%Fleet utilization in Veh X #usage
%Access time
%Total access time

%Asks to the user the name of the simulation
prompt = 'Enter the simulation Number: ';
y = input(prompt);

%Asks to the user the iterations number as reported in the Config.xml file from MATSim
prompt = 'Enter the numer of Iterations as reported in the Config.xml file from MATSim: ';
x = input(prompt);
% x = 100;
ITERS=x;

load VOT_ID.mat
VOT_ID= str2double(VOT_ID);
%Read file with driving and booking time

inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
%inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/test%i/',y);
inputBaseITER = strcat(inputBase,'ITERS/it.');

% Coloumns in CS.txt
%1      	2           	3       	4       5           6           7           8       
%personID	carsharingType	startTime	endTIme	startLink	pickupLink	dropoffLink	endLink	
%9          10              11          12          13          14          15          16          
%distance	inVehicleTime	accessTime	egressTime	vehicleID	bookingTime	companyID	vehicleType

DayHours = 30;  %Simulation Time

%%%%%%%%%%%%%%
%Driving Time%
%%%%%%%%%%%%%%

DaySeconds = DayHours*3600;

%Retrieves data from the .txt file and puts it in a rectangular matrix
DTP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.CS.txt'); %file name = 'myfile01.txt' 
input = strcat(inputBaseITER,DTP);                      %merge 2 or more strings
delimiterIn = ",";
DrivingTimePercentage = readtable(input,'Delimiter',',');
DrivingTimePercentage.Var2=[];
DrivingTimePercentage.Var5=[];
DrivingTimePercentage.Var6=[];
DrivingTimePercentage.Var7=[];
DrivingTimePercentage.Var8=[];
DrivingTimePercentage.Var15=[];
DrivingTimePercentage.Var16=[];
DrivingTimePercentage.Var17=[];
DrivingTimePercentage = table2array(DrivingTimePercentage);
DrivingTimePercentage = DrivingTimePercentage(:,[8 5 1]); %Caring only about the inVehicleTime (5) and the vehicleId (8)


%Sums all the utilization time for the same vehicle - https://stackoverflow.com/questions/50025485/matlab-how-can-i-sum-all-the-rows-of-the-first-column-when-on-the-second-column
[VehId,~,id] = unique(DrivingTimePercentage(:,1),'stable');
filename = sprintf('Driving_Time_%i.mat',y);
save(filename,'DrivingTimePercentage');
DrivingTimePercentage = [accumarray(id,DrivingTimePercentage(:,2)), VehId];
SortedDrivingTimePercentage = sortrows(DrivingTimePercentage,1,'descend');

%Sums all the driving time giving back a global driving time
CTot=sum(SortedDrivingTimePercentage);
TotalDrivingTimeSecs = CTot(:,1);
TotalDrivingTimeMin = TotalDrivingTimeSecs/60;


%Do the same for the booking time


%%%%%%%%%%%%%%
%Booking Time%
%%%%%%%%%%%%%%

%Retrieves data from the .txt file and puts it in a rectangular matrix
DTP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.CS.txt'); %file name = 'myfile01.txt' 
input = strcat(inputBaseITER,DTP);                      %merge 2 or more strings
delimiterIn = ",";
BookingTimePercentage = readtable(input,'Delimiter',',');
BookingTime=BookingTimePercentage.Var4-BookingTimePercentage.Var3;
PersonID4booking = BookingTimePercentage.Var1;
BookingTimePercentage.Var1=[];
BookingTimePercentage.Var2=[];
BookingTimePercentage.Var3=[];
BookingTimePercentage.Var4=[];
BookingTimePercentage.Var5=[];
BookingTimePercentage.Var6=[];
BookingTimePercentage.Var7=[];
BookingTimePercentage.Var8=[];
BookingTimePercentage.Var9=[];
BookingTimePercentage.Var10=[];
BookingTimePercentage.Var11=[];
BookingTimePercentage.Var12=[];
BookingTimePercentage.Var14=[];
BookingTimePercentage.Var15=[];
BookingTimePercentage.Var16=[];
BookingTimePercentage.Var17=[];
BookingTimePercentage = table2array(BookingTimePercentage);
BookingTimePercentage = ([BookingTimePercentage BookingTime PersonID4booking]);

%Sums all the utilization time for the same vehicle - https://stackoverflow.com/questions/50025485/matlab-how-can-i-sum-all-the-rows-of-the-first-column-when-on-the-second-column
[VehId,~,id] = unique(BookingTimePercentage(:,1),'stable');
filename = sprintf('Booking_Time_%i.mat',y);
save(filename,'BookingTimePercentage');
BookingTimePercentage = [accumarray(id,BookingTimePercentage(:,2)), VehId];
SortedBookingTimePercentage = sortrows(BookingTimePercentage,1,'descend'); 

%Sums all the booking time giving back a global driving time
CTot=sum(SortedBookingTimePercentage);
TotalBookingTimeSecs = CTot(:,1);
TotalBookingTimeMin = TotalBookingTimeSecs/60;
TotalBookingTimehour = TotalBookingTimeMin/60;


%%%%%%%%%%%%%%%%
%Total Distance%
%%%%%%%%%%%%%%%%

%Retrieves data from the .txt file and puts it in a rectangular matrix
DTP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.CS.txt'); %file name = 'myfile01.txt' 
input = strcat(inputBaseITER,DTP);                      %merge 2 or more strings
delimiterIn = ",";
Distance = readtable(input,'Delimiter',',');
Distance.Var1=[];
Distance.Var2=[];
Distance.Var3=[];
Distance.Var4=[];
Distance.Var5=[];
Distance.Var6=[];
Distance.Var7=[];
Distance.Var8=[];
Distance.Var10=[];
Distance.Var11=[];
Distance.Var12=[];
Distance.Var14=[];
Distance.Var15=[];
Distance.Var16=[];
Distance.Var17=[];
Distance = table2array(Distance);
VehXDist = Distance(:,[1 2]);                           %Caring only about the Distance (4) and the vehicleId (8)
Distance = Distance(:,1); 

DistanceTot = sum(Distance)/1000;
VehXDist(:,1) = VehXDist(:,1)/1000;
VehXDist = sortrows(VehXDist,2);

%Vehicle X Kilometer
[VehXDistunique,~,idx] = unique(VehXDist(:,2));
nu = numel(VehXDistunique);
VehXDist_sum = zeros(nu,size(VehXDist,2));
for ii = 1:nu
    VehXDist_sum(ii,:) = sum(VehXDist(idx==ii,1));
end
VehXDist_sum(:,2) = VehXDistunique;

VehXDist_sum = sortrows(VehXDist_sum,1);
plot(1:numel(VehXDist_sum(:,2)),VehXDist_sum(:,1),'r');    %Plot the 1st simulation Shifting Rental Starts
hold on
title('Fleet Utilization 1');
ylabel('Vehicle * Km');
xlabel('VehId');
hold off

VehXDist_sum_TOT=sum(VehXDist_sum(:,1));

filename = sprintf('VehXDist_sum%i.png',y);
saveas(gca,filename);
filename1 = sprintf('VehXDist_sum_TOT%i.mat');
save(filename1,'VehXDist_sum_TOT');
filename1 = sprintf('VehXDist_sum%i.mat');
save(filename1,'VehXDist_sum');


%%%%%%%%%%%%%%%%%%%%%%%
%Shifting Rental Start%
%%%%%%%%%%%%%%%%%%%%%%%

%Retrieves data from the .txt file and puts it in a rectangular matrix
DTP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.CS.txt'); %file name = 'myfile01.txt' 
input = strcat(inputBaseITER,DTP);                      %merge 2 or more strings
delimiterIn = ",";
SRS = readtable(input,'Delimiter',',');                 %Shifting Rental Start (SRS)
SRS.Var2=[];
SRS.Var4=[];
SRS.Var5=[];
SRS.Var6=[];
SRS.Var7=[];
SRS.Var8=[];
SRS.Var9=[];
SRS.Var10=[];
SRS.Var11=[];
SRS.Var12=[];
SRS.Var13=[];
SRS.Var14=[];
SRS.Var15=[];
SRS.Var16=[];
SRS.Var17=[];
SRS = table2array(SRS);
SRS = SRS(:,[1 2]); %Caring only about the Starting time and the personID
SRSh = SRS(:,2)/3600;
SRS(:,2) = SRSh;

if y==1 %Creo una IF per ogni scenario in modo tale da importarlo in Shifting_Rental_Start_Plots.m
    SRS1=sortrows(SRS,2);
    filename = sprintf('SRS%i.mat',y);
    save(filename,'SRS1');

    %Create the graph
    SRSPlot = plot(SRS1(:,2));
    ylim([0 24]);
    set(gca,'YTick',0:1:24)
    view([90 -90]);

    filename = sprintf('Shifting_Rental_Start%i.png',y);
    saveas(gca,filename);
else
    if y==2
        SRS2=sortrows(SRS,2);
        filename = sprintf('SRS%i.mat',y);
        save(filename,'SRS2');

        %Create the graph
        SRSPlot = plot(SRS2(:,2));
        ylim([0 24]);
        set(gca,'YTick',0:1:24)
        view([90 -90]);

        filename = sprintf('Shifting_Rental_Start%i.png',y);
        saveas(gca,filename);
    else
        if y==3
            SRS3=sortrows(SRS,2);
            filename = sprintf('SRS%i.mat',y);
            save(filename,'SRS3');

            %Create the graph
            SRSPlot = plot(SRS3(:,2));
            ylim([0 24]);
            set(gca,'YTick',0:1:24)
            view([90 -90]);

            filename = sprintf('Shifting_Rental_Start%i.png',y);
            saveas(gca,filename);
        else
            if y==4
                SRS4=sortrows(SRS,2);
                filename = sprintf('SRS%i.mat',y);
                save(filename,'SRS4');

                %Create the graph
                SRSPlot = plot(SRS4(:,2));
                ylim([0 24]);
                set(gca,'YTick',0:1:24)
                view([90 -90]);

                filename = sprintf('Shifting_Rental_Start%i.png',y);
                saveas(gca,filename);
            else
                if y==5
                    SRS5=sortrows(SRS,2);
                    filename = sprintf('SRS%i.mat',y);
                    save(filename,'SRS5');

                    %Create the graph
                    SRSPlot = plot(SRS5(:,2));
                    ylim([0 24]);
                    set(gca,'YTick',0:1:24)
                    view([90 -90]);

                    filename = sprintf('Shifting_Rental_Start%i.png',y);
                    saveas(gca,filename);
                else
                    if y==6
                        SRS6=sortrows(SRS,2);
                        filename = sprintf('SRS%i.mat',y);
                        save(filename,'SRS6');

                        %Create the graph
                        SRSPlot = plot(SRS6(:,2));
                        ylim([0 24]);
                        set(gca,'YTick',0:1:24)
                        view([90 -90]);

                        filename = sprintf('Shifting_Rental_Start%i.png',y);
                        saveas(gca,filename);
                    else
                        if y==7
                            SRS7=sortrows(SRS,2);
                            filename = sprintf('SRS%i.mat',y);
                            save(filename,'SRS7');

                            %Create the graph
                            SRSPlot = plot(SRS7(:,2));
                            ylim([0 24]);
                            set(gca,'YTick',0:1:24)
                            view([90 -90]);

                            filename = sprintf('Shifting_Rental_Start%i.png',y);
                            saveas(gca,filename);
                        else
                            if y==7
                                SRS7=sortrows(SRS,2);
                                filename = sprintf('SRS%i.mat',y);
                                save(filename,'SRS7');

                                %Create the graph
                                SRSPlot = plot(SRS7(:,2));
                                ylim([0 24]);
                                set(gca,'YTick',0:1:24)
                                view([90 -90]);

                                filename = sprintf('Shifting_Rental_Start%i.png',y);
                                saveas(gca,filename);
                            else
                                if y==8
                                    SRS8=sortrows(SRS,2);
                                    filename = sprintf('SRS%i.mat',y);
                                    save(filename,'SRS8');

                                    %Create the graph
                                    SRSPlot = plot(SRS8(:,2));
                                    ylim([0 24]);
                                    set(gca,'YTick',0:1:24)
                                    view([90 -90]);

                                    filename = sprintf('Shifting_Rental_Start%i.png',y);
                                    saveas(gca,filename);
                                else
                                    if y==9
                                        SRS9=sortrows(SRS,2);
                                        filename = sprintf('SRS%i.mat',y);
                                        save(filename,'SRS9');

                                        %Create the graph
                                        SRSPlot = plot(SRS9(:,2));
                                        ylim([0 24]);
                                        set(gca,'YTick',0:1:24)
                                        view([90 -90]);

                                        filename = sprintf('Shifting_Rental_Start%i.png',y);
                                        saveas(gca,filename);
                                    else
                                        if y==10
                                            SRS10=sortrows(SRS,2);
                                            filename = sprintf('SRS%i.mat',y);
                                            save(filename,'SRS10');

                                            %Create the graph
                                            SRSPlot = plot(SRS10(:,2));
                                            ylim([0 24]);
                                            set(gca,'YTick',0:1:24)
                                            view([90 -90]);

                                            filename = sprintf('Shifting_Rental_Start%i.png',y);
                                            saveas(gca,filename);
                                        else
                                            if y==11
                                                SRS11=sortrows(SRS,2);
                                                filename = sprintf('SRS%i.mat',y);
                                                save(filename,'SRS11');

                                                %Create the graph
                                                SRSPlot = plot(SRS11(:,2));
                                                ylim([0 24]);
                                                set(gca,'YTick',0:1:24)
                                                view([90 -90]);

                                                filename = sprintf('Shifting_Rental_Start%i.png',y);
                                                saveas(gca,filename);
                                            else
                                                if y==12
                                                    SRS12=sortrows(SRS,2);
                                                    filename = sprintf('SRS%i.mat',y);
                                                    save(filename,'SRS12');

                                                    %Create the graph
                                                    SRSPlot = plot(SRS12(:,2));
                                                    ylim([0 24]);
                                                    set(gca,'YTick',0:1:24)
                                                    view([90 -90]);

                                                    filename = sprintf('Shifting_Rental_Start%i.png',y);
                                                    saveas(gca,filename);
                                                else
                                                    if y==13
                                                        SRS13=sortrows(SRS,2);
                                                        filename = sprintf('SRS%i.mat',y);
                                                        save(filename,'SRS13');

                                                        %Create the graph
                                                        SRSPlot = plot(SRS13(:,2));
                                                        ylim([0 24]);
                                                        set(gca,'YTick',0:1:24)
                                                        view([90 -90]);

                                                        filename = sprintf('Shifting_Rental_Start%i.png',y);
                                                        saveas(gca,filename);
                                                    else
                                                        if y==14
                                                            SRS14=sortrows(SRS,2);
                                                            filename = sprintf('SRS%i.mat',y);
                                                            save(filename,'SRS14');

                                                            %Create the graph
                                                            SRSPlot = plot(SRS14(:,2));
                                                            ylim([0 24]);
                                                            set(gca,'YTick',0:1:24)
                                                            view([90 -90]);

                                                            filename = sprintf('Shifting_Rental_Start%i.png',y);
                                                            saveas(gca,filename);
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%
%Fleet Utilization%
%%%%%%%%%%%%%%%%%%%

%Number of Vehicles used and how many times
%Retrieves data from the .txt file and puts it in a rectangular matrix
DTP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.CS.txt'); %file name = 'myfile01.txt' 
input = strcat(inputBaseITER,DTP);                              %merge 2 or more strings
delimiterIn = ",";
Rentals = readtable(input,'Delimiter',',');                     %Shifting Rental Start (SRS)
RentalsNumber = numel(Rentals(:,1));

Rentals.Var2=[];
Rentals.Var3=[];
Rentals.Var4=[];
Rentals.Var5=[];
Rentals.Var6=[];
Rentals.Var7=[];
Rentals.Var8=[];
Rentals.Var9=[];
Rentals.Var10=[];
Rentals.Var11=[];
Rentals.Var12=[];
Rentals.Var14=[];
Rentals.Var15=[];
Rentals.Var16=[];
Rentals.Var17=[];
Rentals = table2array(Rentals);
Rentals = Rentals(:,[2 1]);

[VehId,~,id] = unique(Rentals(:,1),'stable');
VehTot = [accumarray(id,Rentals(:,2)), VehId];
VehTot = numel(VehTot(:,2));

%Vehicle X Km (or PAX X Km)

RentalsXKm = DistanceTot * RentalsNumber;
VehXKm = DistanceTot * VehTot;


%%%%%%%%%%%%%
%Access Time%
%%%%%%%%%%%%%

DTP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.CS.txt'); %file name = 'myfile01.txt' 
input = strcat(inputBaseITER,DTP);                              %merge 2 or more strings
delimiterIn = ",";
AccessTime = readtable(input,'Delimiter',',');
AccessTime.Var2=[];
AccessTime.Var3=[];
AccessTime.Var4=[];
AccessTime.Var5=[];
AccessTime.Var6=[];
AccessTime.Var7=[];
AccessTime.Var8=[];
AccessTime.Var9=[];
AccessTime.Var10=[];
AccessTime.Var12=[];
AccessTime.Var13=[];
AccessTime.Var14=[];
AccessTime.Var15=[];
AccessTime.Var16=[];
AccessTime.Var17=[];
AccessTime = table2array(AccessTime);
AccessTime = AccessTime(:,[2 1]);
AccessTime = sortrows(AccessTime,1);

if y==1
    AccessTime1=AccessTime;
    AccessTime1Tot=sum(AccessTime1(:,1));
    filename = sprintf('AccessTime%i.mat',y);
    save(filename,'AccessTime1','AccessTime1Tot');
else
    if y==2
        AccessTime2=AccessTime;
        AccessTime2Tot=sum(AccessTime2(:,1));
        filename = sprintf('AccessTime%i.mat',y);
        save(filename,'AccessTime2','AccessTime2Tot');
    else
        if y==3
            AccessTime3=AccessTime;
            AccessTime3Tot=sum(AccessTime3(:,1));
            filename = sprintf('AccessTime%i.mat',y);
            save(filename,'AccessTime3','AccessTime3Tot');    
        else
            if y==4
                AccessTime4=AccessTime;
                AccessTime4Tot=sum(AccessTime4(:,1));
                filename = sprintf('AccessTime%i.mat',y);
                save(filename,'AccessTime4','AccessTime4Tot');
            else
                if y==5
                    AccessTime5=AccessTime;
                    AccessTime5Tot=sum(AccessTime5(:,1));
                    filename = sprintf('AccessTime%i.mat',y);
                    save(filename,'AccessTime5','AccessTime5Tot');
                else
                    if y==6
                        AccessTime6=AccessTime;
                        AccessTime6Tot=sum(AccessTime6(:,1));
                        filename = sprintf('AccessTime%i.mat',y);
                        save(filename,'AccessTime6','AccessTime6Tot');
                    else
                        if y==7
                            AccessTime7=AccessTime;
                            AccessTime7Tot=sum(AccessTime7(:,1));
                            filename = sprintf('AccessTime%i.mat',y);
                            save(filename,'AccessTime7','AccessTime7Tot');
                        else
                            if y==8
                                AccessTime8=AccessTime;
                                AccessTime8Tot=sum(AccessTime8(:,1));
                                filename = sprintf('AccessTime%i.mat',y);
                                save(filename,'AccessTime8','AccessTime8Tot');
                            else
                                if y==9
                                    AccessTime9=AccessTime;
                                    AccessTime9Tot=sum(AccessTime9(:,1));
                                    filename = sprintf('AccessTime%i.mat',y);
                                    save(filename,'AccessTime9','AccessTime9Tot');
                                else
                                    if y==11
                                        AccessTime11=AccessTime;
                                        AccessTime11Tot=sum(AccessTime11(:,1));
                                        filename = sprintf('AccessTime%i.mat',y);
                                        save(filename,'AccessTime11','AccessTime11Tot');
                                    else
                                        if y==12
                                            AccessTime12=AccessTime;
                                            AccessTime12Tot=sum(AccessTime12(:,1));
                                            filename = sprintf('AccessTime%i.mat',y);
                                            save(filename,'AccessTime12','AccessTime12Tot');
                                        else
                                            if y==13
                                                AccessTime13=AccessTime;
                                                AccessTime13Tot=sum(AccessTime13(:,1));
                                                filename = sprintf('AccessTime%i.mat',y);
                                                save(filename,'AccessTime13','AccessTime13Tot');
                                            else
                                                if y==14
                                                    AccessTime14=AccessTime;
                                                    AccessTime14Tot=sum(AccessTime14(:,1));
                                                    filename = sprintf('AccessTime%i.mat',y);
                                                    save(filename,'AccessTime14','AccessTime14Tot');
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

if y==1

    %AccessTime with the VOT
    AccessTime1 = sortrows(AccessTime1);                        %Sort by the ID
    VOT_ID_AccessTime = ismember(VOT_ID,AccessTime1);                  %Check same ID in VOT_ID and SRS1
    VOT_ID_AccessTime(:,2) = VOT_ID_AccessTime(:,1);            
    VOT_ID_AccessTime = VOT_ID_AccessTime.*VOT_ID;
    VOT_ID_AccessTime = VOT_ID_AccessTime';
    VOT_ID_AccessTime(VOT_ID_AccessTime==0) = [];               %Remove the 0s
    VOT_ID_AccessTime = reshape(VOT_ID_AccessTime,2,[]);        %Reshape it as before [101x2]
    VOT_ID_AccessTime = VOT_ID_AccessTime';
    VOT_ID_AccessTime = sortrows(VOT_ID_AccessTime,'ascend');
    AccessTime1_VOT = [AccessTime1 VOT_ID_AccessTime(:,2)];                   %Put them together
    AccessTime1_VOT = sortrows(AccessTime1_VOT,3,'ascend');                   %sort by the VOT

    AccessTime1_VOT = [AccessTime1_VOT(:,1) AccessTime1_VOT(:,3)];



    %Put together all the time with the same VOT

    %Vehicle X Kilometer
    [AccessTime1_VOTunique,~,idx] = unique(AccessTime1_VOT(:,2));
    nu = numel(AccessTime1_VOTunique);
    AccessTime1_VOT_sum = zeros(nu,size(AccessTime1_VOT,2));
    for ii = 1:nu
        AccessTime1_VOT_sum(ii,:) = mean(AccessTime1_VOT(idx==ii,1));
    end
    AccessTime1_VOT_sum(:,2) = AccessTime1_VOTunique;

    filename = sprintf('AccessTime%i_VOT_sum.mat',y);
    save(filename,'AccessTime1_VOT_sum','AccessTime1_VOTunique');
else
    if y==2

        %AccessTime2 with the VOT
        AccessTime2 = sortrows(AccessTime2);                        %Sort by the ID
        VOT_ID_AccessTime = ismember(VOT_ID,AccessTime2);                  %Check same ID in VOT_ID and SRS1
        VOT_ID_AccessTime(:,2) = VOT_ID_AccessTime(:,1);            
        VOT_ID_AccessTime = VOT_ID_AccessTime.*VOT_ID;
        VOT_ID_AccessTime = VOT_ID_AccessTime';
        VOT_ID_AccessTime(VOT_ID_AccessTime==0) = [];               %Remove the 0s
        VOT_ID_AccessTime = reshape(VOT_ID_AccessTime,2,[]);        %Reshape it as before [109x2]
        VOT_ID_AccessTime = VOT_ID_AccessTime';
        VOT_ID_AccessTime = sortrows(VOT_ID_AccessTime,'ascend');
        AccessTime2_VOT = [AccessTime2 VOT_ID_AccessTime(:,2)];                   %Put them together
        AccessTime2_VOT = sortrows(AccessTime2_VOT,3,'ascend');                   %sort by the VOT

        AccessTime2_VOT = [AccessTime2_VOT(:,1) AccessTime2_VOT(:,3)];

        %Put together all the time with the same VOT

        %Vehicle X Kilometer
        [AccessTime2_VOTunique,~,idx] = unique(AccessTime2_VOT(:,2));
        nu = numel(AccessTime2_VOTunique);
        AccessTime2_VOT_sum = zeros(nu,size(AccessTime2_VOT,2));
        for ii = 1:nu
            AccessTime2_VOT_sum(ii,:) = mean(AccessTime2_VOT(idx==ii,1));
        end
        AccessTime2_VOT_sum(:,2) = AccessTime2_VOTunique;

        filename = sprintf('AccessTime%i_VOT_sum.mat',y);
        save(filename,'AccessTime2_VOT_sum','AccessTime2_VOTunique');
    else
        if y==3

            %AccessTime with the VOT
            AccessTime3 = sortrows(AccessTime3);                        %Sort by the ID
            VOT_ID_AccessTime = ismember(VOT_ID,AccessTime3);                  %Check same ID in VOT_ID and SRS1
            VOT_ID_AccessTime(:,2) = VOT_ID_AccessTime(:,1);            
            VOT_ID_AccessTime = VOT_ID_AccessTime.*VOT_ID;
            VOT_ID_AccessTime = VOT_ID_AccessTime';
            VOT_ID_AccessTime(VOT_ID_AccessTime==0) = [];               %Remove the 0s
            VOT_ID_AccessTime = reshape(VOT_ID_AccessTime,2,[]);        %Reshape it as before [109x2]
            VOT_ID_AccessTime = VOT_ID_AccessTime';
            VOT_ID_AccessTime = sortrows(VOT_ID_AccessTime,'ascend');
            AccessTime3_VOT = [AccessTime3 VOT_ID_AccessTime(:,2)];                   %Put them together
            AccessTime3_VOT = sortrows(AccessTime3_VOT,3,'ascend');                   %sort by the VOT

            AccessTime3_VOT = [AccessTime3_VOT(:,1) AccessTime3_VOT(:,3)];



            %Put together all the time with the same VOT

            %Vehicle X Kilometer
            [AccessTime3_VOTunique,~,idx] = unique(AccessTime3_VOT(:,2));
            nu = numel(AccessTime3_VOTunique);
            AccessTime3_VOT_sum = zeros(nu,size(AccessTime3_VOT,2));
            for ii = 1:nu
                AccessTime3_VOT_sum(ii,:) = mean(AccessTime3_VOT(idx==ii,1));
            end
            AccessTime3_VOT_sum(:,2) = AccessTime3_VOTunique;

            filename = sprintf('AccessTime%i_VOT_sum.mat',y);
            save(filename,'AccessTime3_VOT_sum','AccessTime3_VOTunique');
        else
            if y==4

                %AccessTime with the VOT
                AccessTime4 = sortrows(AccessTime4);                        %Sort by the ID
                VOT_ID_AccessTime = ismember(VOT_ID,AccessTime4);                  %Check same ID in VOT_ID and SRS1
                VOT_ID_AccessTime(:,2) = VOT_ID_AccessTime(:,1);            
                VOT_ID_AccessTime = VOT_ID_AccessTime.*VOT_ID;
                VOT_ID_AccessTime = VOT_ID_AccessTime';
                VOT_ID_AccessTime(VOT_ID_AccessTime==0) = [];               %Remove the 0s
                VOT_ID_AccessTime = reshape(VOT_ID_AccessTime,2,[]);        %Reshape it as before [109x2]
                VOT_ID_AccessTime = VOT_ID_AccessTime';
                VOT_ID_AccessTime = sortrows(VOT_ID_AccessTime,'ascend');
                AccessTime4_VOT = [AccessTime4 VOT_ID_AccessTime(:,2)];                   %Put them together
                AccessTime4_VOT = sortrows(AccessTime4_VOT,3,'ascend');                   %sort by the VOT

                AccessTime4_VOT = [AccessTime4_VOT(:,1) AccessTime4_VOT(:,3)];



                %Put together all the time with the same VOT

                %Vehicle X Kilometer
                [AccessTime4_VOTunique,~,idx] = unique(AccessTime4_VOT(:,2));
                nu = numel(AccessTime4_VOTunique);
                AccessTime4_VOT_sum = zeros(nu,size(AccessTime4_VOT,2));
                for ii = 1:nu
                    AccessTime4_VOT_sum(ii,:) = mean(AccessTime4_VOT(idx==ii,1));
                end
                AccessTime4_VOT_sum(:,2) = AccessTime4_VOTunique;

                filename = sprintf('AccessTime%i_VOT_sum.mat',y);
                save(filename,'AccessTime4_VOT_sum','AccessTime4_VOTunique');
            else
                if y==5

                    %AccessTime with the VOT
                    AccessTime5 = sortrows(AccessTime5);                        %Sort by the ID
                    VOT_ID_AccessTime = ismember(VOT_ID,AccessTime5);                  %Check same ID in VOT_ID and SRS1
                    VOT_ID_AccessTime(:,2) = VOT_ID_AccessTime(:,1);            
                    VOT_ID_AccessTime = VOT_ID_AccessTime.*VOT_ID;
                    VOT_ID_AccessTime = VOT_ID_AccessTime';
                    VOT_ID_AccessTime(VOT_ID_AccessTime==0) = [];               %Remove the 0s
                    VOT_ID_AccessTime = reshape(VOT_ID_AccessTime,2,[]);        %Reshape it as before [109x2]
                    VOT_ID_AccessTime = VOT_ID_AccessTime';
                    VOT_ID_AccessTime = sortrows(VOT_ID_AccessTime,'ascend');
                    AccessTime5_VOT = [AccessTime5 VOT_ID_AccessTime(:,2)];                   %Put them together
                    AccessTime5_VOT = sortrows(AccessTime5_VOT,3,'ascend');                   %sort by the VOT

                    AccessTime5_VOT = [AccessTime5_VOT(:,1) AccessTime5_VOT(:,3)];



                    %Put together all the time with the same VOT

                    %Vehicle X Kilometer
                    [AccessTime5_VOTunique,~,idx] = unique(AccessTime5_VOT(:,2));
                    nu = numel(AccessTime5_VOTunique);
                    AccessTime5_VOT_sum = zeros(nu,size(AccessTime5_VOT,2));
                    for ii = 1:nu
                        AccessTime5_VOT_sum(ii,:) = mean(AccessTime5_VOT(idx==ii,1));
                    end
                    AccessTime5_VOT_sum(:,2) = AccessTime5_VOTunique;

                    filename = sprintf('AccessTime%i_VOT_sum.mat',y);
                    save(filename,'AccessTime5_VOT_sum','AccessTime5_VOTunique');
                else
                    if y==6

                        %AccessTime with the VOT
                        AccessTime6 = sortrows(AccessTime6);                        %Sort by the ID
                        VOT_ID_AccessTime = ismember(VOT_ID,AccessTime6);                  %Check same ID in VOT_ID and SRS1
                        VOT_ID_AccessTime(:,2) = VOT_ID_AccessTime(:,1);            
                        VOT_ID_AccessTime = VOT_ID_AccessTime.*VOT_ID;
                        VOT_ID_AccessTime = VOT_ID_AccessTime';
                        VOT_ID_AccessTime(VOT_ID_AccessTime==0) = [];               %Remove the 0s
                        VOT_ID_AccessTime = reshape(VOT_ID_AccessTime,2,[]);        %Reshape it as before [109x2]
                        VOT_ID_AccessTime = VOT_ID_AccessTime';
                        VOT_ID_AccessTime = sortrows(VOT_ID_AccessTime,'ascend');
                        AccessTime6_VOT = [AccessTime6 VOT_ID_AccessTime(:,2)];                   %Put them together
                        AccessTime6_VOT = sortrows(AccessTime6_VOT,3,'ascend');                   %sort by the VOT

                        AccessTime6_VOT = [AccessTime6_VOT(:,1) AccessTime6_VOT(:,3)];



                        %Put together all the time with the same VOT

                        %Vehicle X Kilometer
                        [AccessTime6_VOTunique,~,idx] = unique(AccessTime6_VOT(:,2));
                        nu = numel(AccessTime6_VOTunique);
                        AccessTime6_VOT_sum = zeros(nu,size(AccessTime6_VOT,2));
                        for ii = 1:nu
                            AccessTime6_VOT_sum(ii,:) = mean(AccessTime6_VOT(idx==ii,1));
                        end
                        AccessTime6_VOT_sum(:,2) = AccessTime6_VOTunique;

                        filename = sprintf('AccessTime%i_VOT_sum.mat',y);
                        save(filename,'AccessTime6_VOT_sum','AccessTime6_VOTunique');
                    else
                        if y==7

                            %AccessTime with the VOT
                            AccessTime7 = sortrows(AccessTime7);                        %Sort by the ID
                            VOT_ID_AccessTime = ismember(VOT_ID,AccessTime7);                  %Check same ID in VOT_ID and SRS1
                            VOT_ID_AccessTime(:,2) = VOT_ID_AccessTime(:,1);            
                            VOT_ID_AccessTime = VOT_ID_AccessTime.*VOT_ID;
                            VOT_ID_AccessTime = VOT_ID_AccessTime';
                            VOT_ID_AccessTime(VOT_ID_AccessTime==0) = [];               %Remove the 0s
                            VOT_ID_AccessTime = reshape(VOT_ID_AccessTime,2,[]);        %Reshape it as before [109x2]
                            VOT_ID_AccessTime = VOT_ID_AccessTime';
                            VOT_ID_AccessTime = sortrows(VOT_ID_AccessTime,'ascend');
                            AccessTime7_VOT = [AccessTime7 VOT_ID_AccessTime(:,2)];                   %Put them together
                            AccessTime7_VOT = sortrows(AccessTime7_VOT,3,'ascend');                   %sort by the VOT

                            AccessTime7_VOT = [AccessTime7_VOT(:,1) AccessTime7_VOT(:,3)];



                            %Put together all the time with the same VOT

                            %Vehicle X Kilometer
                            [AccessTime7_VOTunique,~,idx] = unique(AccessTime7_VOT(:,2));
                            nu = numel(AccessTime7_VOTunique);
                            AccessTime7_VOT_sum = zeros(nu,size(AccessTime7_VOT,2));
                            for ii = 1:nu
                                AccessTime7_VOT_sum(ii,:) = mean(AccessTime7_VOT(idx==ii,1));
                            end
                            AccessTime7_VOT_sum(:,2) = AccessTime7_VOTunique;

                            filename = sprintf('AccessTime%i_VOT_sum.mat',y);
                            save(filename,'AccessTime7_VOT_sum','AccessTime7_VOTunique');
                        else
                            if y==8

                                %AccessTime with the VOT
                                AccessTime8 = sortrows(AccessTime8);                        %Sort by the ID
                                VOT_ID_AccessTime = ismember(VOT_ID,AccessTime8);                  %Check same ID in VOT_ID and SRS1
                                VOT_ID_AccessTime(:,2) = VOT_ID_AccessTime(:,1);            
                                VOT_ID_AccessTime = VOT_ID_AccessTime.*VOT_ID;
                                VOT_ID_AccessTime = VOT_ID_AccessTime';
                                VOT_ID_AccessTime(VOT_ID_AccessTime==0) = [];               %Remove the 0s
                                VOT_ID_AccessTime = reshape(VOT_ID_AccessTime,2,[]);        %Reshape it as before [109x2]
                                VOT_ID_AccessTime = VOT_ID_AccessTime';
                                VOT_ID_AccessTime = sortrows(VOT_ID_AccessTime,'ascend');
                                AccessTime8_VOT = [AccessTime8 VOT_ID_AccessTime(:,2)];                   %Put them together
                                AccessTime8_VOT = sortrows(AccessTime8_VOT,3,'ascend');                   %sort by the VOT

                                AccessTime8_VOT = [AccessTime8_VOT(:,1) AccessTime8_VOT(:,3)];



                                %Put together all the time with the same VOT

                                %Vehicle X Kilometer
                                [AccessTime8_VOTunique,~,idx] = unique(AccessTime8_VOT(:,2));
                                nu = numel(AccessTime8_VOTunique);
                                AccessTime8_VOT_sum = zeros(nu,size(AccessTime8_VOT,2));
                                for ii = 1:nu
                                    AccessTime8_VOT_sum(ii,:) = mean(AccessTime8_VOT(idx==ii,1));
                                end
                                AccessTime8_VOT_sum(:,2) = AccessTime8_VOTunique;

                                filename = sprintf('AccessTime%i_VOT_sum.mat',y);
                                save(filename,'AccessTime8_VOT_sum','AccessTime8_VOTunique');
                            else
                                if y==9

                                    %AccessTime with the VOT
                                    AccessTime9 = sortrows(AccessTime9);                        %Sort by the ID
                                    VOT_ID_AccessTime = ismember(VOT_ID,AccessTime9);                  %Check same ID in VOT_ID and SRS1
                                    VOT_ID_AccessTime(:,2) = VOT_ID_AccessTime(:,1);            
                                    VOT_ID_AccessTime = VOT_ID_AccessTime.*VOT_ID;
                                    VOT_ID_AccessTime = VOT_ID_AccessTime';
                                    VOT_ID_AccessTime(VOT_ID_AccessTime==0) = [];               %Remove the 0s
                                    VOT_ID_AccessTime = reshape(VOT_ID_AccessTime,2,[]);        %Reshape it as before [109x2]
                                    VOT_ID_AccessTime = VOT_ID_AccessTime';
                                    VOT_ID_AccessTime = sortrows(VOT_ID_AccessTime,'ascend');
                                    AccessTime9_VOT = [AccessTime9 VOT_ID_AccessTime(:,2)];                   %Put them together
                                    AccessTime9_VOT = sortrows(AccessTime9_VOT,3,'ascend');                   %sort by the VOT

                                    AccessTime9_VOT = [AccessTime9_VOT(:,1) AccessTime9_VOT(:,3)];



                                    %Put together all the time with the same VOT

                                    %Vehicle X Kilometer
                                    [AccessTime9_VOTunique,~,idx] = unique(AccessTime9_VOT(:,2));
                                    nu = numel(AccessTime9_VOTunique);
                                    AccessTime9_VOT_sum = zeros(nu,size(AccessTime9_VOT,2));
                                    for ii = 1:nu
                                        AccessTime9_VOT_sum(ii,:) = mean(AccessTime9_VOT(idx==ii,1));
                                    end
                                    AccessTime9_VOT_sum(:,2) = AccessTime9_VOTunique;

                                    filename = sprintf('AccessTime%i_VOT_sum.mat',y);
                                    save(filename,'AccessTime9_VOT_sum','AccessTime9_VOTunique');
                                else
                                    if y==10

                                        %AccessTime with the VOT
                                        AccessTime10 = sortrows(AccessTime10);                        %Sort by the ID
                                        VOT_ID_AccessTime = ismember(VOT_ID,AccessTime10);            %Check same ID in VOT_ID and SRS1
                                        VOT_ID_AccessTime(:,2) = VOT_ID_AccessTime(:,1);            
                                        VOT_ID_AccessTime = VOT_ID_AccessTime.*VOT_ID;
                                        VOT_ID_AccessTime = VOT_ID_AccessTime';
                                        VOT_ID_AccessTime(VOT_ID_AccessTime==0) = [];               %Remove the 0s
                                        VOT_ID_AccessTime = reshape(VOT_ID_AccessTime,2,[]);        
                                        VOT_ID_AccessTime = VOT_ID_AccessTime';
                                        VOT_ID_AccessTime = sortrows(VOT_ID_AccessTime,'ascend');
                                        AccessTime10_VOT = [AccessTime10 VOT_ID_AccessTime(:,2)];                   %Put them together
                                        AccessTime10_VOT = sortrows(AccessTime10_VOT,3,'ascend');                   %sort by the VOT

                                        AccessTime10_VOT = [AccessTime10_VOT(:,1) AccessTime10_VOT(:,3)];



                                        %Put together all the time with the same VOT

                                        %Vehicle X Kilometer
                                        [AccessTime10_VOTunique,~,idx] = unique(AccessTime10_VOT(:,2));
                                        nu = numel(AccessTime10_VOTunique);
                                        AccessTime10_VOT_sum = zeros(nu,size(AccessTime10_VOT,2));
                                        for ii = 1:nu
                                            AccessTime10_VOT_sum(ii,:) = mean(AccessTime10_VOT(idx==ii,1));
                                        end
                                        AccessTime10_VOT_sum(:,2) = AccessTime10_VOTunique;

                                        filename = sprintf('AccessTime%i_VOT_sum.mat',y);
                                        save(filename,'AccessTime10_VOT_sum','AccessTime10_VOTunique');
                                    else
                                        if y==11

                                            %AccessTime with the VOT
                                            AccessTime11 = sortrows(AccessTime11);                        %Sort by the ID
                                            VOT_ID_AccessTime = ismember(VOT_ID,AccessTime11);            %Check same ID in VOT_ID and SRS1
                                            VOT_ID_AccessTime(:,2) = VOT_ID_AccessTime(:,1);            
                                            VOT_ID_AccessTime = VOT_ID_AccessTime.*VOT_ID;
                                            VOT_ID_AccessTime = VOT_ID_AccessTime';
                                            VOT_ID_AccessTime(VOT_ID_AccessTime==0) = [];               %Remove the 0s
                                            VOT_ID_AccessTime = reshape(VOT_ID_AccessTime,2,[]);        
                                            VOT_ID_AccessTime = VOT_ID_AccessTime';
                                            VOT_ID_AccessTime = sortrows(VOT_ID_AccessTime,'ascend');
                                            AccessTime11_VOT = [AccessTime11 VOT_ID_AccessTime(:,2)];                   %Put them together
                                            AccessTime11_VOT = sortrows(AccessTime11_VOT,3,'ascend');                   %sort by the VOT

                                            AccessTime11_VOT = [AccessTime11_VOT(:,1) AccessTime11_VOT(:,3)];



                                            %Put together all the time with the same VOT

                                            %Vehicle X Kilometer
                                            [AccessTime11_VOTunique,~,idx] = unique(AccessTime11_VOT(:,2));
                                            nu = numel(AccessTime11_VOTunique);
                                            AccessTime11_VOT_sum = zeros(nu,size(AccessTime11_VOT,2));
                                            for ii = 1:nu
                                                AccessTime11_VOT_sum(ii,:) = mean(AccessTime11_VOT(idx==ii,1));
                                            end
                                            AccessTime11_VOT_sum(:,2) = AccessTime11_VOTunique;

                                            filename = sprintf('AccessTime%i_VOT_sum.mat',y);
                                            save(filename,'AccessTime11_VOT_sum','AccessTime11_VOTunique');
                                        else
                                            if y==12

                                                %AccessTime with the VOT
                                                AccessTime12 = sortrows(AccessTime12);                        %Sort by the ID
                                                VOT_ID_AccessTime = ismember(VOT_ID,AccessTime12);            %Check same ID in VOT_ID and SRS1
                                                VOT_ID_AccessTime(:,2) = VOT_ID_AccessTime(:,1);            
                                                VOT_ID_AccessTime = VOT_ID_AccessTime.*VOT_ID;
                                                VOT_ID_AccessTime = VOT_ID_AccessTime';
                                                VOT_ID_AccessTime(VOT_ID_AccessTime==0) = [];               %Remove the 0s
                                                VOT_ID_AccessTime = reshape(VOT_ID_AccessTime,2,[]);        
                                                VOT_ID_AccessTime = VOT_ID_AccessTime';
                                                VOT_ID_AccessTime = sortrows(VOT_ID_AccessTime,'ascend');
                                                AccessTime12_VOT = [AccessTime12 VOT_ID_AccessTime(:,2)];                   %Put them together
                                                AccessTime12_VOT = sortrows(AccessTime12_VOT,3,'ascend');                   %sort by the VOT

                                                AccessTime12_VOT = [AccessTime12_VOT(:,1) AccessTime12_VOT(:,3)];



                                                %Put together all the time with the same VOT

                                                %Vehicle X Kilometer
                                                [AccessTime12_VOTunique,~,idx] = unique(AccessTime12_VOT(:,2));
                                                nu = numel(AccessTime12_VOTunique);
                                                AccessTime12_VOT_sum = zeros(nu,size(AccessTime12_VOT,2));
                                                for ii = 1:nu
                                                    AccessTime12_VOT_sum(ii,:) = mean(AccessTime12_VOT(idx==ii,1));
                                                end
                                                AccessTime12_VOT_sum(:,2) = AccessTime12_VOTunique;

                                                filename = sprintf('AccessTime%i_VOT_sum.mat',y);
                                                save(filename,'AccessTime12_VOT_sum','AccessTime12_VOTunique');
                                            else
                                                if y==13
                                                    %AccessTime with the VOT
                                                    AccessTime13 = sortrows(AccessTime13);                        %Sort by the ID
                                                    VOT_ID_AccessTime = ismember(VOT_ID,AccessTime13);            %Check same ID in VOT_ID and SRS1
                                                    VOT_ID_AccessTime(:,2) = VOT_ID_AccessTime(:,1);            
                                                    VOT_ID_AccessTime = VOT_ID_AccessTime.*VOT_ID;
                                                    VOT_ID_AccessTime = VOT_ID_AccessTime';
                                                    VOT_ID_AccessTime(VOT_ID_AccessTime==0) = [];               %Remove the 0s
                                                    VOT_ID_AccessTime = reshape(VOT_ID_AccessTime,2,[]);        
                                                    VOT_ID_AccessTime = VOT_ID_AccessTime';
                                                    VOT_ID_AccessTime = sortrows(VOT_ID_AccessTime,'ascend');
                                                    AccessTime13_VOT = [AccessTime13 VOT_ID_AccessTime(:,2)];                   %Put them together
                                                    AccessTime13_VOT = sortrows(AccessTime13_VOT,3,'ascend');                   %sort by the VOT

                                                    AccessTime13_VOT = [AccessTime13_VOT(:,1) AccessTime13_VOT(:,3)];



                                                    %Put together all the time with the same VOT

                                                    %Vehicle X Kilometer
                                                    [AccessTime13_VOTunique,~,idx] = unique(AccessTime13_VOT(:,2));
                                                    nu = numel(AccessTime13_VOTunique);
                                                    AccessTime13_VOT_sum = zeros(nu,size(AccessTime13_VOT,2));
                                                    for ii = 1:nu
                                                        AccessTime13_VOT_sum(ii,:) = mean(AccessTime13_VOT(idx==ii,1));
                                                    end
                                                    AccessTime13_VOT_sum(:,2) = AccessTime13_VOTunique;

                                                    filename = sprintf('AccessTime%i_VOT_sum.mat',y);
                                                    save(filename,'AccessTime13_VOT_sum','AccessTime13_VOTunique');
                                                else
                                                    if y==14
                                                        %AccessTime with the VOT
                                                        AccessTime14 = sortrows(AccessTime14);                        %Sort by the ID
                                                        VOT_ID_AccessTime = ismember(VOT_ID,AccessTime14);            %Check same ID in VOT_ID and SRS1
                                                        VOT_ID_AccessTime(:,2) = VOT_ID_AccessTime(:,1);            
                                                        VOT_ID_AccessTime = VOT_ID_AccessTime.*VOT_ID;
                                                        VOT_ID_AccessTime = VOT_ID_AccessTime';
                                                        VOT_ID_AccessTime(VOT_ID_AccessTime==0) = [];               %Remove the 0s
                                                        VOT_ID_AccessTime = reshape(VOT_ID_AccessTime,2,[]);        
                                                        VOT_ID_AccessTime = VOT_ID_AccessTime';
                                                        VOT_ID_AccessTime = sortrows(VOT_ID_AccessTime,'ascend');
                                                        AccessTime14_VOT = [AccessTime14 VOT_ID_AccessTime(:,2)];                   %Put them together
                                                        AccessTime14_VOT = sortrows(AccessTime14_VOT,3,'ascend');                   %sort by the VOT

                                                        AccessTime14_VOT = [AccessTime14_VOT(:,1) AccessTime14_VOT(:,3)];



                                                        %Put together all the time with the same VOT

                                                        %Vehicle X Kilometer
                                                        [AccessTime14_VOTunique,~,idx] = unique(AccessTime14_VOT(:,2));
                                                        nu = numel(AccessTime14_VOTunique);
                                                        AccessTime14_VOT_sum = zeros(nu,size(AccessTime14_VOT,2));
                                                        for ii = 1:nu
                                                            AccessTime14_VOT_sum(ii,:) = mean(AccessTime14_VOT(idx==ii,1));
                                                        end
                                                        AccessTime14_VOT_sum(:,2) = AccessTime14_VOTunique;

                                                        filename = sprintf('AccessTime%i_VOT_sum.mat',y);
                                                        save(filename,'AccessTime14_VOT_sum','AccessTime14_VOTunique');
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

%Scatter Plot of AccessTime1_VOT_sum and AccessTime4_VOT_sum
load AccessTime1_VOT_sum.mat
load AccessTime4_VOT_sum.mat

DeltaAccessTime = AccessTime4_VOT_sum(:,1)-AccessTime1_VOT_sum(:,1);

scatter(AccessTime1_VOTunique,DeltaAccessTime);
hold on
plot(0);
title('DeltaAccessTime1-4');
title('Access Time1 - Access Time4');
xticks(AccessTime1_VOTunique);
xtickangle(90);
xlabel('VOT');
ylabel('DeltaAccessTime [s]');
filename = sprintf('DeltaAccessTime1-4.png');
saveas(gca,filename);
hold off

%Scatter Plot of AccessTime4_VOT_sum and AccessTime7_VOT_sum
load AccessTime4_VOT_sum.mat
load AccessTime7_VOT_sum.mat

DeltaAccessTime = AccessTime7_VOT_sum(:,1)-AccessTime4_VOT_sum(:,1);

scatter(AccessTime4_VOTunique,DeltaAccessTime);
hold on
plot(0);
title('DeltaAccessTime4-7');
xticks(AccessTime4_VOTunique);
xtickangle(90);
xlabel('VOT');
ylabel('DeltaAccessTime [s]');
filename = sprintf('DeltaAccessTime4-7.png');
saveas(gca,filename);
hold off

%Scatter Plot of AccessTime4_VOT_sum and AccessTime11_VOT_sum
load AccessTime4_VOT_sum.mat
load AccessTime11_VOT_sum.mat

DeltaAccessTime = AccessTime11_VOT_sum(:,1)-AccessTime4_VOT_sum(:,1);

scatter(AccessTime4_VOTunique,DeltaAccessTime);
hold on
plot(0);
title('DeltaAccessTime4-11');
xticks(AccessTime4_VOTunique);
xtickangle(90);
xlabel('VOT');
ylabel('DeltaAccessTime [s]');
filename = sprintf('DeltaAccessTime4-11.png');
saveas(gca,filename);
hold off

%Scatter Plot of AccessTime4_VOT_sum and AccessTime13_VOT_sum
load AccessTime4_VOT_sum.mat
load AccessTime13_VOT_sum.mat

DeltaAccessTime = AccessTime13_VOT_sum(:,1)-AccessTime4_VOT_sum(:,1);

scatter(AccessTime4_VOTunique,DeltaAccessTime);
hold on
plot(0);
title('DeltaAccessTime4-13');
xticks(AccessTime4_VOTunique);
xtickangle(90);
xlabel('VOT');
ylabel('DeltaAccessTime [s]');
filename = sprintf('DeltaAccessTime4-13.png');
saveas(gca,filename);
hold off

%Scatter Plot of AccessTime6_VOT_sum and AccessTime3_VOT_sum
load AccessTime3_VOT_sum.mat
load AccessTime6_VOT_sum.mat

DeltaAccessTime = AccessTime6_VOT_sum(:,1)-AccessTime3_VOT_sum(:,1);

scatter(AccessTime3_VOTunique,DeltaAccessTime);
hold on
plot(0);
title('DeltaAccessTime3-6');
xticks(AccessTime3_VOTunique);
xtickangle(90);
xlabel('VOT');
ylabel('DeltaAccessTime [s]');
filename = sprintf('DeltaAccessTime3-6.png');
saveas(gca,filename);
hold off

%Scatter Plot of AccessTime9_VOT_sum and AccessTime6_VOT_sum
load AccessTime6_VOT_sum.mat
load AccessTime9_VOT_sum.mat

DeltaAccessTime = AccessTime9_VOT_sum(:,1)-AccessTime6_VOT_sum(:,1);

scatter(AccessTime6_VOTunique,DeltaAccessTime);
hold on
plot(0);
title('DeltaAccessTime6-9');
xticks(AccessTime6_VOTunique);
xtickangle(90);
xlabel('VOT');
ylabel('DeltaAccessTime [s]');
filename = sprintf('DeltaAccessTime6-9.png');
saveas(gca,filename);
hold off

%Scatter Plot of AccessTime12_VOT_sum and AccessTime6_VOT_sum
load AccessTime6_VOT_sum.mat
load AccessTime12_VOT_sum.mat

DeltaAccessTime = AccessTime12_VOT_sum(:,1)-AccessTime6_VOT_sum(:,1);

scatter(AccessTime6_VOTunique,DeltaAccessTime);
hold on
plot(0);
title('DeltaAccessTime6-12');
xticks(AccessTime6_VOTunique);
xtickangle(120);
xlabel('VOT');
ylabel('DeltaAccessTime [s]');
filename = sprintf('DeltaAccessTime6-12.png');
saveas(gca,filename);
hold off

%Scatter Plot of AccessTime14_VOT_sum and AccessTime6_VOT_sum
load AccessTime6_VOT_sum.mat
load AccessTime14_VOT_sum.mat

DeltaAccessTime = AccessTime14_VOT_sum(:,1)-AccessTime6_VOT_sum(:,1);

scatter(AccessTime6_VOTunique,DeltaAccessTime);
hold on
plot(0);
title('DeltaAccessTime6-14');
xticks(AccessTime6_VOTunique);
xtickangle(140);
xlabel('VOT');
ylabel('DeltaAccessTime [s]');
filename = sprintf('DeltaAccessTime6-14.png');
saveas(gca,filename);
hold off
