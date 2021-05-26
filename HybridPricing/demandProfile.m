%% Demand Profile

colorProfile = ([0, 0.42, 0.24; 0.15, 0.26, 0.55; 0.55, 0, 0]);
midnight = 24;
maxBookings.FP = 8;
maxBookings.MPP = 15;

for i = 1:length(sim)

    % Take the address of the table and reads it in Demand
    input.leg1 = sprintf('/Users/giulio.giorgione/Documents/MATLAB/HybridPricing/');
    input.leg2 = whichLoop;
    input.leg3 = sprintf('/run1.500.legHistogram_');
    input.leg4 = sprintf('%s',sim{i});
    input.leg5 = sprintf('.txt');
    inputleg = strcat(input.leg1,input.leg2,input.leg3,input.leg4,input.leg5);
    delimiterIn = ",";
    Demand = readtable(inputleg,'Delimiter','\t');
    timeBin = 5;

    %Demand en route
    Carsharing = [Demand.time_1/3600 Demand.en_route_twoway_vehicle];
    Carsharing(:,2) = movmean(Carsharing(:,2),1);
    CarsharingMean5 = movmean(Carsharing(:,2),timeBin);
    CarsharingMean20 = movmean(Carsharing(:,2),timeBin*4);
    
    if DemandProfilePlot == 1
        close all
        plot(Carsharing(:,1),Carsharing(:,2),':','Color',colorProfile(1,:),...
            'LineWidth',0.2);    %Plot the 3rd simulation Fleet utilization
        hold on
        plot(Carsharing(:,1),CarsharingMean5,'Color',colorProfile(2,:));
        plot(Carsharing(:,1),CarsharingMean20,'Color',colorProfile(3,:));
%         title('Carsharing Demand Profile (En Route)');
        xlim([0 midnight]);
        if isequal(whichLoop,'FP')
            ylim([0 maxBookings.FP]);
        end
        if isequal(whichLoop,'MPP')
            ylim([0 maxBookings.MPP]);
        end
        xticks(1:midnight);
        yticks(1:1:maxBookings.(whichLoop));
        ytickformat('%,.0f')
        ylabel('# Vehicles');
        xlabel('Time [h]');
        if isequal(i,length(sim))
            legend('En Route','MovMean on 5 min','MovMean on 20 min','location','best');
        end
        filename = [];
        filename.a = sprintf('Demand_Profile_en_route_');
        filename.b = whichLoop;
        filename.c = sprintf('_%s',sim{i});
        filename.d = sprintf('.png');
        filename = strcat(filename.a,filename.b,filename.c,filename.d);
        saveas(gca,filename);
        hold off
    end

end
clear Demand

%% Demand Profile and Shift
for i = 1:length(sim)

    % Take the address of the table and reads it in Demand
    input.leg1 = sprintf('/Users/giulio.giorgione/Documents/MATLAB/HybridPricing/');
    input.leg2 = whichLoop;
    input.leg3 = sprintf('/run1.500.legHistogram_');
    input.leg4 = sprintf('%s',sim{i});
    input.leg5 = sprintf('.txt');
    inputleg = strcat(input.leg1,input.leg2,input.leg3,input.leg4,input.leg5);
    delimiterIn = ",";
    timeBin = 5;
    
    Demand = readtable(inputleg,'Delimiter','\t');
    %From en_route Save only: "time_1", "all", "car", "pt", "twoway vehicle"
    %Trash: "time", "departures", "arrivals", "stuck"
    %Trash all as well for: "egress_walk_tw", "access_walk_tw", "bike", "walk",
    Demand.time = [];

    Demand.departures_all = [];
    Demand.arrivals_all = [];
    Demand.stuck_all = [];
%     Demand.en_route_all = [];

    Demand.departures_car = [];
    Demand.arrivals_car = [];
    Demand.stuck_car = [];
%     Demand.en_route_car = [];

    Demand.departures_egress_walk_tw = [];
    Demand.arrivals_egress_walk_tw = [];
    Demand.stuck_egress_walk_tw = [];
    Demand.en_route_egress_walk_tw = [];

    Demand.departures_pt = [];
    Demand.arrivals_pt = [];
    Demand.stuck_pt = [];
%     Demand.en_route_pt = [];

    Demand.departures_twoway_vehicle = [];
    Demand.arrivals_twoway_vehicle = [];
    Demand.stuck_twoway_vehicle = [];
%     Demand.en_route_twoway_vehicle = [];

    Demand.departures_access_walk_tw = [];
    Demand.arrivals_access_walk_tw = [];
    Demand.stuck_access_walk_tw = [];
    Demand.en_route_access_walk_tw = [];

    Demand.departures_bike = [];
    Demand.arrivals_bike = [];
    Demand.stuck_bike = [];
%     Demand.en_route_bike = [];

    Demand.departures_walk = [];
    Demand.arrivals_walk = [];
    Demand.stuck_walk = [];
%     Demand.en_route_walk = [];

    Demand = table2array(Demand); % Obtains Time-All-Car-Pt-Twoway
    DemandShareTW = Demand(:,5) ./ Demand(:,2);
    
    Time = Demand(:,1);
    Timehour = Time./3600;
    Modes = [Demand(:,4) Demand(:,5) Demand(:,6)]; %Car PT Carsharing
    Sum = Demand(:,2);
    
    DemandPerc = Modes./Sum;
    DemandPerc(isnan(DemandPerc)) = 0;
    DemandPercTransition = [DemandPerc(:,3) DemandPerc(:,1) DemandPerc(:,2)]; %Carsharing Car PT
    DemandPerc = DemandPercTransition*100;

    filename = sprintf('ModalShiftXTime%i.mat',i);
    save(filename,'Demand');
    
    if DemandProfilePlot == 2
        bar(Timehour,DemandPerc,'stacked')
        set(gca, 'YScale', 'log')
        xlim([0 24]);
        ylim([0 inf]);
        xlabel('Time [h]');
        ylabel('Modal Split [%]');
        title('Modal Split');
        legend('Carsharing','car','pt','Others');
        filename =[];
        filename.a = sprintf('Modal Split_');
        filename.b = sprintf('%s',sim{i});
        filename.c = sprintf('.png');
        filename = strcat(filename.a,filename.b,filename.c);
        saveas(gca,filename);
        % set(gca, 'YScale', 'linear')
    end
    
end

