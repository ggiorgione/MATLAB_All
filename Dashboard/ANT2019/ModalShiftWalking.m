%MODAL SPLIT for walking to carsharing DURING THE DAY

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


    %Retrieves data from the .txt file and puts it in a rectangular matrix
    DTP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.legHistogram.txt');   %file name = 'myfile01.txt' 
    input = strcat(inputBaseITER,DTP);                                          %merge 2 or more strings
    delimiterIn = "\t";

    DemandWalking = readtable(input,'Delimiter','\t');
    %From en_route Save only: "time_1", "all", "car", "pt", "twoway vehicle"
    %Trash: "time", "departures", "arrivals", "stuck"
    %Trash all as well for: "egress_walk_tw", "access_walk_tw", "bike", "walk",
    DemandWalking.time = [];

    %Demand.departures_all = [];
    DemandWalking.arrivals_all = [];
    DemandWalking.stuck_all = [];
    DemandWalking.en_route_all = [];

    %Demand.departures_car = [];
    DemandWalking.arrivals_car = [];
    DemandWalking.stuck_car = [];
    DemandWalking.en_route_car = [];

    DemandWalking.departures_egress_walk_tw = [];
    DemandWalking.arrivals_egress_walk_tw = [];
    DemandWalking.stuck_egress_walk_tw = [];
    DemandWalking.en_route_egress_walk_tw = [];

    %Demand.departures_pt = [];
    DemandWalking.arrivals_pt = [];
    DemandWalking.stuck_pt = [];
    DemandWalking.en_route_pt = [];

    %Demand.departures_twoway_vehicle = [];
    DemandWalking.arrivals_twoway_vehicle = [];
    DemandWalking.stuck_twoway_vehicle = [];
    DemandWalking.en_route_twoway_vehicle = [];

    %DemandWalking.departures_access_walk_tw = [];
    DemandWalking.arrivals_access_walk_tw = [];
    DemandWalking.stuck_access_walk_tw = [];
    DemandWalking.en_route_access_walk_tw = [];

    DemandWalking.departures_bike = [];
    DemandWalking.arrivals_bike = [];
    DemandWalking.stuck_bike = [];
    DemandWalking.en_route_bike = [];

    DemandWalking.departures_walk = [];
    DemandWalking.arrivals_walk = [];
    DemandWalking.stuck_walk = [];
    DemandWalking.en_route_walk = [];

    DemandWalking = table2array(DemandWalking); % Obtains Time-All--WalkingTW-Car-Pt-Twoway

    filename = sprintf('ModalShiftXTime%i.mat',y);
    save(filename,'DemandWalking');
% 
%     plot(DemandWalking(:,1)/3600,DemandWalking(:,3));
%     filenname1 = sprintf('Persons Walking to Carsharing%i',y);
%     title(filenname1)
%     xlabel('Time [h]')
%     ylabel('Persons')
%     filename = sprintf('DemandShareWalking%i.png',y);
%     saveas(gca,filename);
    
end