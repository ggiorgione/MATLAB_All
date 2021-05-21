%Distance

clear all
clear y;
clear x;
clear prompt;

% sims = [1,3,4,6,7,9,11,12,13,14];
sims = [1,3,4,6,7,9,11,12];

    load VOT_ID.mat;
    VOT_ID= str2double(VOT_ID);

for y=sims
    %Output for every simulation:
    %Driving time matrix
    %Total driving time
    %Booking time matrix
    %Total booking time
    %Total distance travelled
    %Vehicle X Km
    %Differential in Starting Time "SRS"
    %Fleet utilization in Veh X #usage
    %Access times
    %Total access time

    % %Asks to the user the name of the simulation
    % prompt = 'Enter the simulation Number: ';
    % y = input(prompt);
    % 
    % %Asks to the user the iterations number as reported in the Config.xml file from MATSim
    % prompt = 'Enter the numer of Iterations as reported in the Config.xml file from MATSim: ';
    % x = input(prompt);
    x = 500;
    ITERS=x;



    %Read file with driving and booking time

    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/test%i/',y);
    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/vot1/test%i/',y);
    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/vot20/test%i/',y);
    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/cost5/test%i/',y);
    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/cost20/test%i/',y);
%     inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/testWrong/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
%     inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/testWrong-10/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
%     inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/testRight/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
%     inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/testRight-10/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
        inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/testfin/test%i/',y);

%     inputBaseITER = strcat(inputBase,'ITERS/it.');
    inputBaseITER = strcat(inputBase,'it.');

    % Coloumns in CS.txt
    %1      	2           	3       	4       5           6           7           8       
    %personID	carsharingType	startTime	endTIme	startLink	pickupLink	dropoffLink	endLink	
    %9          10              11          12          13          14          15          16          
    %distance	inVehicleTime	accessTime	egressTime	vehicleID	bookingTime	companyID	vehicleType

    DayHours = 30;  %Simulation Time

    DaySeconds = DayHours*3600;

    %Retrieves data from the .txt file and puts it in a rectangular matrix
    DTP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.CS.txt'); %file name = 'myfile01.txt' 
    input = strcat(inputBaseITER,DTP);                      %merge 2 or more strings
    delimiterIn = ",";
    Distance = readtable(input,'Delimiter',',');
    Distance.Var2=[];
    Distance.Var5=[];
    Distance.Var6=[];
    Distance.Var7=[];
    Distance.Var8=[];
    Distance.Var15=[];
    Distance.Var16=[];
    Distance.Var17=[];
    Distance = table2array(Distance);
    Distance = Distance(:,[1 6]); %Caring only about the inVehicleTime (5) and the vehicleId (8)
    

    filename = sprintf('Distance%i.mat',y);
    save(filename,'Distance');
    
end