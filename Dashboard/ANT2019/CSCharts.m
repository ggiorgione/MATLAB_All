clear all

%Asks to the user the iterations number as reported in the Config.xml file from MATSim
prompt = 'Enter the numer of Iterations as reported in the Config.xml file from MATSim: ';
x = input(prompt);
ITERS=x;

%Base folder input from the simulation
inputBase = '/Users/giulio.giorgione/Documents/Carsharing/test/output/org/matsim/contrib/carsharing/runExample/RunCarsharingIT/test/';
inputBaseITER = strcat(inputBase,'ITERS/it.');

% Coloumns in CS.txt
%1      	2           	3       	4       5           6           7           8       
%personID	carsharingType	startTime	endTIme	startLink	pickupLink	dropoffLink	endLink	
%9          10              11          12          13          14          15          16          
%distance	inVehicleTime	accessTime	egressTime	vehicleID	bookingTime	companyID	vehicleType

DayHours = 30;  %Simulation Time

%%%%%%%%%%%%%%%%%%%%%%%
%RENTALS PER ITERATION%
%%%%%%%%%%%%%%%%%%%%%%%

%Retrieves data from the .txt file and puts it in a rectangular matrix
RXI = 'run1.Rentals X Iteration.txt';   %file name = 'myfile01.txt' 
input = strcat(inputBase,RXI);          %merge 2 or more strings
delimiterIn = ',';
RentalsXIteration = importdata(input,delimiterIn);

%Set "NaN=0" 
RentalsXIteration.data(isnan(RentalsXIteration.data))=0;

%creates the HISTOGRAM
XPlot = RentalsXIteration.data(:,1);
YPlot = RentalsXIteration.data(:,2);
bar(XPlot,YPlot,0.5,'b');

%Frocerie for the histogram
hold on
title('Rentals Per Iteration')
xlabel('Iteration');
ylabel('Rentals');
set(gca,'XTick',1:1:numel(RentalsXIteration.data)) % sets the x axis ticks
hold off

%Plot Printing
saveas(gcf,strcat(inputBase,'Rentals per Iteration.png'));


%%%%%%%%%%%%%%%%%%%%%
%AVERAGE ACCESS TIME%
%%%%%%%%%%%%%%%%%%%%%

%Retrieves data from the .txt file and puts it in a rectangular matrix
AAT = 'run1.avgAccessTime.txt';     %file name = 'myfile01.txt' 
input = strcat(inputBase,AAT);      %merge 2 or more strings
delimiterIn = ',';
TripLengthP = importdata(input,delimiterIn);

%Set "NaN=0" 
TripLengthP.data(isnan(TripLengthP.data))=0;

%creates the HISTOGRAM
XPlot = TripLengthP.data(:,1);
YPlot = TripLengthP.data(:,2);
bar(XPlot,YPlot,0.5,'b');

%Frocerie for the histogram
hold on
title('Average Access Time')
xlabel('Iteration');
ylabel('Access Time [s]');
set(gca,'XTick',1:1:numel(TripLengthP.data)) % sets the x axis ticks
hold off

%Plot Printing
saveas(gcf,strcat(inputBase,'Average Access Time.png'));


%%%%%%%%%%%%%%%%%%%%%%%%%%
%Trip Length by Person ID%
%%%%%%%%%%%%%%%%%%%%%%%%%%

%Converts String to Double


%Retrieves data from the .txt file and puts it in a rectangular matrix
TLP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.CS.txt');     %file name = 'myfile01.txt'�
input = strcat(inputBaseITER,TLP);                          %merge 2 or more strings
delimiterIn = ",";
TripLengthP = readtable(input,'Delimiter',',');
TripLengthP.carsharingType=[]; 
TripLengthP.startLink=[];
TripLengthP.endLink=[];
TripLengthP.pickupLink=[];
TripLengthP.dropoffLink=[];
TripLengthP.companyID=[];
TripLengthP.vehicleType=[];

TripLengthP = table2array(TripLengthP);
TripLengthP = TripLengthP(:,[1 4]);
TripLengthP = sortrows(TripLengthP,2,'descend');

%creates the HISTOGRAM
XPlot = TripLengthP(:,1);
YPlot = TripLengthP(:,2);   %4 is defined as the distance
bar(YPlot,0.5,'r');

%Frocerie for the histogram
hold on
set(gca,'xticklabel',XPlot);
title('Trip Length by PersonID')
%legend('Trip Length');
xlabel('PersonID');
ylabel('Trip Length [m]');
xtickangle(90);                                         % sets the x axis tick angle
set(gca,'XTick',0:1:numel(TripLengthP), 'FontSize', 6)  % sets the x axis ticks
xtickformat('%.0f');
hold off

%Plot Printing
saveas(gcf,strcat(input,num2str(ITERS),'_Trip Length by PersonID.png'));

%%%%%%%%%%%%%%%%%%%%
%Trip Length by Car%
%%%%%%%%%%%%%%%%%%%%

%Retrieves data from the .txt file and puts it in a rectangular matrix
TLC = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.CS.txt'); %file name = 'myfile01.txt' 
input = strcat(inputBaseITER,TLC);                      %merge 2 or more strings
delimiterIn = ",";
TripLengthC = readtable(input,'Delimiter',',');
TripLengthC.carsharingType=[];
TripLengthC.startLink=[];
TripLengthC.endLink=[];
TripLengthC.pickupLink=[];
TripLengthC.dropoffLink=[];
TripLengthC.companyID=[];
TripLengthC.vehicleType=[];
TripLengthC = table2array(TripLengthC);
TripLengthC = TripLengthC(:,[8 4]);                     %Obtains a matrix with Distance (4) and VehicleID (8)

%https://stackoverflow.com/questions/50025485/matlab-how-can-i-sum-all-the-rows-of-the-first-column-when-on-the-second-column
[VehId,~,id] = unique(TripLengthC(:,1),'stable');
TripLengthC = [accumarray(id,TripLengthC(:,2)), VehId];
TripLengthC = sortrows(TripLengthC,1,'descend');

%creates the HISTOGRAM
XPlot = TripLengthC(:,2);   %2 is defined as the vehicleID
YPlot = TripLengthC(:,1);   %1 is defined as the distance
bar(YPlot,0.5,'r');

%Frocerie for the histogram
hold on
set(gca,'xticklabel',XPlot);
title('Trip Length by Car')
%legend('Trip Length');
xlabel('VehicleID');
ylabel('Trip Length [m]');
xtickangle(90);                         % sets the x axis tick angle
set(gca,'XTick',0:1:numel(TripLengthC)) % sets the x axis ticks
hold off

%Plot Printing
saveas(gcf,strcat(input,num2str(ITERS),'_Trip Length by Car.png'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Time to Reach the Station%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Converts String to Double

%Retrieves data from the .txt file and puts it in a rectangular matrix
T2S = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.CS.txt'); %file name = 'myfile01.txt' 
input = strcat(inputBaseITER,T2S);                      %merge 2 or more strings
delimiterIn = ",";
Time2Station = readtable(input,'Delimiter',',');
Time2Station.carsharingType=[];
Time2Station.startLink=[];
Time2Station.pickupLink=[];
Time2Station.dropoffLink=[];
Time2Station.endLink=[];
Time2Station.companyID=[];
Time2Station.vehicleType=[];
Time2Station = table2array(Time2Station);
Time2Station = sortrows(Time2Station,6,'descend');

%creates the HISTOGRAM
XPlot = Time2Station(:,1);
YPlot = Time2Station(:,6);  %2 is defined as the accessTime
bar(YPlot,0.5,'r');

%Frocerie for the histogram
hold on
set(gca,'xticklabel',XPlot, 'FontSize', 6);
title('Time to Reach the Station')
xlabel('PersonID');
ylabel('Time to Reach the Station [s]');
xtickangle(90);                            % sets the x axis tick angle
set(gca,'XTick',0:1:numel(Time2Station))   % sets the x axis ticks
xtickformat('%.0f');
hold off

%Plot Printing
saveas(gcf,strcat(input,num2str(ITERS),'_Time to Reach the Station.png'));


%%%%%%%%%%%%%%%%%%%%%%%%%
%Driving Time Percentage%
%%%%%%%%%%%%%%%%%%%%%%%%%

DaySeconds = DayHours*3600;

%Retrieves data from the .txt file and puts it in a rectangular matrix
DTP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.CS.txt'); %file name = 'myfile01.txt' 
input = strcat(inputBaseITER,DTP);                      %merge 2 or more strings
DrivingTimePercentage = readtable(input,'Delimiter',',');
DrivingTimePercentage.carsharingType=[];
DrivingTimePercentage.startLink=[];
DrivingTimePercentage.pickupLink=[];
DrivingTimePercentage.dropoffLink=[];
DrivingTimePercentage.endLink=[];
DrivingTimePercentage.companyID=[];
DrivingTimePercentage.vehicleType=[];
DrivingTimePercentage = table2array(DrivingTimePercentage);
DrivingTimePercentage = DrivingTimePercentage(:,[8 5]); %Caring only about the inVehicleTime (5) and the vehicleId (8)

%Sums all the utilization time for the same vehicle - https://stackoverflow.com/questions/50025485/matlab-how-can-i-sum-all-the-rows-of-the-first-column-when-on-the-second-column
[VehId,~,id] = unique(DrivingTimePercentage(:,1),'stable');
DrivingTimePercentage = [accumarray(id,DrivingTimePercentage(:,2)), VehId];
SortedDrivingTimePercentage = sortrows(DrivingTimePercentage,1,'descend');
SortedDrivingTimePercentagePerc = (SortedDrivingTimePercentage(:,1)/DaySeconds)*100;    %Calculating the Percentage

%creates the HISTOGRAM
XPlot = SortedDrivingTimePercentage(:,2);
YPlot = SortedDrivingTimePercentagePerc(:,1);
bar(YPlot,0.5,'b');

%Frocerie for the histogram
hold on
set(gca,'xticklabel',XPlot);
title('Driving Time [%]')
%legend('Time to Reach the Station');
xlabel('Vehicle Id');
ylabel('Vehicle Utilization [%]');
ylim([0 100]);    
xtickangle(90);                                         % sets the x axis tick angle
set(gca,'XTick',0:1:numel(SortedDrivingTimePercentage)) % sets the x axis ticks
hold off

%Plot Printing
saveas(gcf,strcat(input,num2str(ITERS),'Driving Time [%].png'));


%%%%%%%%%%%%%%%%%%%%%%%%%
%Booking Time Percentage%
%%%%%%%%%%%%%%%%%%%%%%%%%

%Retrieves data from the .txt file and puts it in a rectangular matrix
DTP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.CS.txt'); %file name = 'myfile01.txt' 
input = strcat(inputBaseITER,DTP);                      %merge 2 or more strings
delimiterIn = ",";
BookingTimePercentage = readtable(input,'Delimiter',',');
BookingTimePercentage.carsharingType=[];
BookingTimePercentage.startLink=[];
BookingTimePercentage.pickupLink=[];
BookingTimePercentage.dropoffLink=[];
BookingTimePercentage.endLink=[];
BookingTimePercentage.companyID=[];
BookingTimePercentage.vehicleType=[];
BookingTimePercentage = table2array(BookingTimePercentage);
BookingTimePercentage = BookingTimePercentage(:,[8 9 5]); %Caring only about the BookingTime (9) and the vehicleId (8)

%Sums all the utilization time for the same vehicle - https://stackoverflow.com/questions/50025485/matlab-how-can-i-sum-all-the-rows-of-the-first-column-when-on-the-second-column
[VehId,~,id] = unique(BookingTimePercentage(:,1),'stable');
BookingTimePercentage = [accumarray(id,BookingTimePercentage(:,2)), VehId];
SortedBookingTimePercentage = sortrows(BookingTimePercentage,1,'descend'); 

SortedBookingTimePercentagePerc = (SortedBookingTimePercentage(:,1)/DaySeconds)*100;    %Calculating the Percentage

%creates the HISTOGRAM
XPlot = SortedBookingTimePercentage(:,2);
YPlot = SortedBookingTimePercentagePerc(:,1);
bar(YPlot,0.5,'b');

%Frocerie for the histogram
hold on
set(gca,'xticklabel',XPlot);
title('Booking Time [%]')
%legend('Time to Reach the Station');
xlabel('Vehicle Id');
ylabel('Vehicle Utilization [%]');
ylim([0 100]);
xtickangle(90);                                     % sets the x axis tick angle
set(gca,'XTick',0:1:numel(SortedBookingTimePercentagePerc))   % sets the x axis ticks
hold off

%Plot Printing
saveas(gcf,strcat(input,num2str(ITERS),'Booking Time [%].png'));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Booking and Driving Time Percentage Chart%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DrivingBookingCombination = [BookingTimePercentage DrivingTimePercentage];          %Combine Driving and Booking time for the same vehicle
DrivingBookingCombination = DrivingBookingCombination(:,[1 3 4]);
SortDrivingBookingCombination = sortrows(DrivingBookingCombination,1,'descend');    %Sort descending by booking time
SortDrivingBookingCombinationPerc = (SortDrivingBookingCombination(:,[1 2])/DaySeconds)*100;    %Calculating the Percentage

BDTPC = [SortDrivingBookingCombinationPerc(:,2) SortDrivingBookingCombinationPerc(:,1)-SortDrivingBookingCombinationPerc(:,2)];

%creates the HISTOGRAM
XPlot = SortDrivingBookingCombination(:,3);
bar(BDTPC,0.5,'stacked');

%Frocerie for the histogram
hold on
set(gca,'xticklabel',XPlot);
title('Total Driving+Booking [%]')
legend('Total Driving Time [%]','Total Booking Time [%]');
xlabel('Vehicle Id');
ylabel('Total Vehicle Utilization [%]');
xtickangle(90);                   % sets the x axis tick angle
set(gca,'XTick',0:1:numel(SortDrivingBookingCombinationPerc)) % sets the x axis ticks

%Plot the Average
AvgSortDrivingBookingCombinationPerc = mean(SortDrivingBookingCombinationPerc(:,1));    %AVG of the Array
plot (AvgSortDrivingBookingCombinationPerc,'g');
hold off

%Plot Printing
saveas(gcf,strcat(input,num2str(ITERS),'Total Driving+Booking [%].png'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Booking and Driving Time Chart%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DTP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.CS.txt'); %file name = 'myfile01.txt' 
input = strcat(inputBaseITER,DTP);                      %merge 2 or more strings
DrivingTime = readtable(input,'Delimiter',',');
DrivingTime.carsharingType=[];
DrivingTime.startLink=[];
DrivingTime.pickupLink=[];
DrivingTime.dropoffLink=[];
DrivingTime.endLink=[];
DrivingTime.companyID=[];
DrivingTime.vehicleType=[];
DrivingTime = table2array(DrivingTime);
DrivingTime = DrivingTime(:,[8 5]); %Caring only about the inVehicleTime (5) and the vehicleId (8)

BookingTime = readtable(input,'Delimiter',',');
BookingTime.carsharingType=[];
BookingTime.startLink=[];
BookingTime.pickupLink=[];
BookingTime.dropoffLink=[];
BookingTime.endLink=[];
BookingTime.companyID=[];
BookingTime.vehicleType=[];
BookingTime = table2array(BookingTime);
BookingTime = BookingTime(:,[8 9 5]); %Caring only about the BookingTime (9) and the vehicleId (8)

SumBookingTime = [BookingTime (BookingTime(:,2)+BookingTime(:,3))];
SortDrivingBookingCombination = sortrows(SumBookingTime,4,'descend');    %Sort descending by booking time

BDTPC = SortDrivingBookingCombination;

%creates the HISTOGRAM
XPlot = BDTPC(:,1);
bar(BDTPC(:,2:3),0.5,'stacked');

%Frocerie for the histogram
hold on
set(gca,'xticklabel',XPlot);
title('Total Driving+Booking [s]')
legend('Total Driving Time [s]','Total Booking Time [s]');
xlabel('Vehicle Id');
ylabel('Total Vehicle Utilization [s]');
xtickangle(90);                   % sets the x axis tick angle
set(gca,'XTick',0:1:numel(SortDrivingBookingCombination)) % sets the x axis ticks

%Plot the Average
AvgSortDrivingBookingCombination = mean(SortDrivingBookingCombination(:,4));    %AVG of the Array
plot (AvgSortDrivingBookingCombination,'g');
hold off

%Plot Printing
saveas(gcf,strcat(input,num2str(ITERS),'Total Driving+Booking [s].png'));  

%%%%%%%%%%%%%%%%%%%%
%Driving Time Chart%
%%%%%%%%%%%%%%%%%%%%

%creates the HISTOGRAM
XPlot = BDTPC(:,1);
bar(BDTPC(:,3),0.5,'stacked');

%Frocerie for the histogram
hold on
set(gca,'xticklabel',XPlot);
title('Total Driving Time [s]')
legend('Total Driving Time [s]');
xlabel('Vehicle Id');
ylabel('Driving Time [s]');
xtickangle(90);                                           % sets the x axis tick angle
set(gca,'XTick',0:1:numel(SortDrivingBookingCombination)) % sets the x axis ticks

hold off

%Plot Printing
saveas(gcf,strcat(input,num2str(ITERS),'Total Driving Time [s].png'));

%%%%%%%%%%%%%%%%%%%%
%Booking Time Chart%
%%%%%%%%%%%%%%%%%%%%

%creates the HISTOGRAM
XPlot = BDTPC(:,1);
bar(BDTPC(:,2),0.5,'stacked');

%Frocerie for the histogram
hold on
set(gca,'xticklabel',XPlot);
title('Total Booking Time [s]')
legend('Total Booking Time [s]');
xlabel('Vehicle Id');
ylabel('Booking Time [s]');
xtickangle(90);                                           % sets the x axis tick angle
set(gca,'XTick',0:1:numel(SortDrivingBookingCombination)) % sets the x axis ticks

hold off

%Plot Printing
saveas(gcf,strcat(input,num2str(ITERS),'Total Booking Time [s].png'));