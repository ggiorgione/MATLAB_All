%% Starting up
clear all
ITERS = 500;
SimulatedTime = 30;

% %Asks to the user the iterations number as reported in the Config.xml file from MATSim
% promptIter = 'Enter the numer of Iterations as reported in the Config.xml file from MATSim: ';
% x = input(promptIter);
% ITERS=x;
% 
% promptSimulatedTime = 'Enter the numer of simulated hours as reported in the Config.xml file from MATSim: ';
% y = input(promptSimulatedTime);
% SimulatedTime = y;  %Set simulation Time

%Base folder input from the simulation
inputBase = '/Users/giulio.giorgione/Documents/STREAMS/exa-matsim-carsharing/test/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/';
inputBaseITER = strcat(inputBase,'ITERS/it.');

%% Coloumns in CS.txt
%1      	2           	3       	4       5           6           7           8       
%personID	carsharingType	startTime	endTIme	startLink	pickupLink	dropoffLink	endLink	
%9          10              11          12          13          14          15          16          
%distance	inVehicleTime	accessTime	egressTime	vehicleID	bookingTime	companyID	vehicleType

%% Daily Rentals (number)
CS = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.CS.txt');  %Retrieves data from the .txt file and puts it in a rectangular matrix
input = strcat(inputBaseITER,CS);                               %merge 2 or more strings
delimiterIn = ",";
DailyRentalsNum = readtable(input,'Delimiter',',');
DailyRentalsNum = height(DailyRentalsNum);

%% Daily Rentals (time)
DailyRentalsCompleteList = readtable(input,'Delimiter',',');
DailyRentalsTimeXPerson = [table2array(DailyRentalsCompleteList(:,13)) table2array(DailyRentalsCompleteList(:,15))/3600];  %Take the booking time [15] and the vehicle ID [13] from CS.txt and convert them in array
DailyRentalsTimeFleet = sum(DailyRentalsTimeXPerson(:,2),1);                               %Sum all the rental times
DailyRentalsTimeFleetRatio = round((DailyRentalsTimeFleet/(length(DailyRentalsTimeXPerson)*SimulatedTime))*100,1); %Time booked compared to the total time it could be booked
DailyRentalsTimeXPerson = sortrows(DailyRentalsTimeXPerson,1);
[values, ~, ids] = unique(DailyRentalsTimeXPerson(:,1), 'rows');                           %get unique id for rows with identical column 1
DailyRentalsTimeXVehicle = splitapply(@(rows) sum(rows, 1), DailyRentalsTimeXPerson, ids); %sum rows with identical id
DailyRentalsTimeXVehicle(:,1) = values;                                             %replace summed column 1 by original value
DailyRentalsTimeXVehicleRatio = [DailyRentalsTimeXVehicle(:,1) round((DailyRentalsTimeXVehicle(:,2)/SimulatedTime)*100,1)];

%% Daily Rentals (Area) NB: Every Vehicle is itself a station so VehicleID ≡ StationID
DailyRentalAreas=[];                                            %creates an empty matrix
CarsharingStations = strcat(inputBaseITER,num2str(ITERS),'/CarsharingStations.txt');
fid = fopen(CarsharingStations);
tline = fgets(fid);                                             %Read line from file specified in "fid", removing newline characters
while ischar(tline)                                             %while the line is a character do...
    if (startsWith(tline,'<vehicle type='))                     %take every line starting with '...' 
        splittedLine=strsplit(tline,'"');                       %split line with that character
        DailyRentalAreas=[DailyRentalAreas; splittedLine(4)];   %which cell of the splittedLine to take
    end
    tline = fgets(fid);
end
fclose(fid);                                                    %I obtained a list with all the VehicleID ≡ StationID

DailyRentalsVehID = [table2array(DailyRentalsCompleteList(:,13))];  %List of all the daily rentals per VehicleID ≡ StationID

% Now let's count the number associating them with an area
cell2mat(DailyRentalAreas);
DailyRentalAreas = str2double(DailyRentalAreas);
DailyRentalAreas(:,2) = zeros;
for i = 1:1:numel(DailyRentalsVehID(:,1))                           %Take the complete list of stations and, when a car is rented it adds 1 to that list
    for j = 1:1:numel(DailyRentalsVehID(:,1))
        if DailyRentalAreas(i,1) == DailyRentalsVehID(j,1)
            DailyRentalAreas(i,2) = DailyRentalAreas(i,2) + 1;
        end
    end
end


%% Daily revenue
RentalCost = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.RentalCost.txt');  %Retrieves data from the .txt file and puts it in a rectangular matrix
input = strcat(inputBaseITER,RentalCost);                               %merge 2 or more strings
delimiterIn = ",";
Revenue = readtable(input,'Delimiter',',');
RevenueXPerson = [table2array(Revenue(:,2)) table2array(Revenue(:,3))];  %Take the booking time [15] and the vehicle ID [13] from CS.txt and convert them in array
RevenueXPerson = sortrows(RevenueXPerson,1);
[values, ~, ids] = unique(RevenueXPerson(:,1), 'rows');                           %get unique id for rows with identical column 1
RevenueXVehicle = splitapply(@(rows) sum(rows, 1), RevenueXPerson, ids); %sum rows with identical id
RevenueANDTimeXVehicle = [RevenueXVehicle DailyRentalsTimeXVehicle(:,2)];
%Here we should define a way to round the revenue to the hour as offered from OPLy

%% Save the workspace
save('DailyRentals.mat')