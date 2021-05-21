%MODAL SPLIT DURING THE DAY

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

    Demand = readtable(input,'Delimiter','\t');
    %From en_route Save only: "time_1", "all", "car", "pt", "twoway vehicle"
    %Trash: "time", "departures", "arrivals", "stuck"
    %Trash all as well for: "egress_walk_tw", "access_walk_tw", "bike", "walk",
    Demand.time = [];

    %Demand.departures_all = [];
    Demand.arrivals_all = [];
    Demand.stuck_all = [];
    Demand.en_route_all = [];

    %Demand.departures_car = [];
    Demand.arrivals_car = [];
    Demand.stuck_car = [];
    Demand.en_route_car = [];

    Demand.departures_egress_walk_tw = [];
    Demand.arrivals_egress_walk_tw = [];
    Demand.stuck_egress_walk_tw = [];
    Demand.en_route_egress_walk_tw = [];

    %Demand.departures_pt = [];
    Demand.arrivals_pt = [];
    Demand.stuck_pt = [];
    Demand.en_route_pt = [];

    %Demand.departures_twoway_vehicle = [];
    %Demand.arrivals_twoway_vehicle = [];
    Demand.stuck_twoway_vehicle = [];
    Demand.en_route_twoway_vehicle = [];

    Demand.departures_access_walk_tw = [];
    Demand.arrivals_access_walk_tw = [];
    Demand.stuck_access_walk_tw = [];
    Demand.en_route_access_walk_tw = [];

    Demand.departures_bike = [];
    Demand.arrivals_bike = [];
    Demand.stuck_bike = [];
    Demand.en_route_bike = [];

    Demand.departures_walk = [];
    Demand.arrivals_walk = [];
    Demand.stuck_walk = [];
    Demand.en_route_walk = [];

    Demand = table2array(Demand); % Obtains Time-All-Car-Pt-Twoway
    Demand(:,6) = Demand(:,5) ./ Demand(:,2);

    filename = sprintf('ModalShiftXTime%i.mat',y);
    save(filename,'Demand');

    Demand(:,1) = movmean(Demand(:,1),20);
    Demand(1,1) = 0;
    Demand(:,6) = movmean(Demand(:,6),20);
    Demand(1,6) = 0;
    plot(Demand(:,1)/3600,Demand(:,6));
    filename1 = sprintf('Demand Share for Twoway%i',y);
    title(filename1)
    xlabel('Time [h]')
    ylabel('Demand Share [%]')
    filename = sprintf('DemandShareTwoway%i.png',y);
    saveas(gca,filename);
    
end