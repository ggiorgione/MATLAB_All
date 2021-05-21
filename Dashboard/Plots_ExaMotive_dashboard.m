%Plots for ExaMotive_dashboard
clear all
load('DailyRentals.mat');

%% Daily rentals number Plot
bar(DailyRentalsNum);
hold on
title('Total Number of Rentals')
set(gca,'xtick',[])
set(gca,'xticklabel',[])
ylabel('Number of Rentals');
text(1,DailyRentalsNum+1,num2str(DailyRentalsNum)); 
grid on
saveas(gcf,'Daily Rentals Number.png')
hold off

%% Daily rentals time [h]
bar(DailyRentalsTimeXVehicle(:,2));
hold on
title('Rental Time');
xlabel('VehicleID');
xticks(1:1:numel(DailyRentalsTimeXVehicle(:,1)));
xticklabels(DailyRentalsTimeXVehicle(:,1))
xtickangle(90)
ylabel('Booking Length [h]')
yticks(0:1:24);
text(1:length(DailyRentalsTimeXVehicle(:,1)),DailyRentalsTimeXVehicle(:,1),num2str(DailyRentalsTimeXVehicle(:,2)),'horiz','center');
grid on
saveas(gcf,'Daily Rentals Time [h].png')
hold off

%% Daily rentals time [%]
bar(DailyRentalsTimeXVehicleRatio(:,2));
hold on
title('Rental Time');
xlabel('VehicleID');
xticks(1:1:numel(DailyRentalsTimeXVehicleRatio(:,1)));
xticklabels(DailyRentalsTimeXVehicleRatio(:,1))
xtickangle(90)
ylabel('Booking Length [%]')
yticks(0:10:100);
ylim([0 100])
text(1:length(DailyRentalsTimeXVehicleRatio(:,1)),DailyRentalsTimeXVehicleRatio(:,1),num2str(DailyRentalsTimeXVehicleRatio(:,2)),'horiz','center');
% DailyRentalsTimeXVehicleRatio100(numel(DailyRentalsTimeXVehicleRatio(:,1)),1) = 0;
% DailyRentalsTimeXVehicleRatio100 = DailyRentalsTimeXVehicleRatio100 + 100;
% bar((DailyRentalsTimeXVehicleRatio100),'stacked','r')
grid on
saveas(gcf,'Daily Rentals Time [%].png')
hold off

%% Daily rentals time 4fleet [h]
bar(DailyRentalsTimeFleet);
hold on
title('Fleet Rental Time [h]');
xticklabels('Fleet')
ylabel('Fleet Rental Time [h]')
text(1,DailyRentalsTimeFleet+10,num2str(DailyRentalsTimeFleet),'horiz','center');
grid on
saveas(gcf,'Fleet Daily Rentals Time [h].png')
hold off

%% Daily rentals time 4fleet [%]
bar(DailyRentalsTimeFleetRatio);
hold on
title('Fleet Rental Time [%]');
xticklabels('Fleet')
ylabel('Fleet Rental Time [%]')
text(1,DailyRentalsTimeFleetRatio+1,num2str(DailyRentalsTimeFleetRatio),'horiz','center');
grid on
saveas(gcf,'Fleet Daily Rentals Time [%].png')
hold off

%% Daily revenue
bar(RevenueANDTimeXVehicle(:,2))
hold on
title('Daily Revenue per Vehicle')
xlabel('VehicleID')
xticks(1:1:numel(RevenueANDTimeXVehicle(:,1)));
xticklabels(RevenueANDTimeXVehicle(:,1))
xtickangle(90)
ylabel('Daily Revenue [€]')
grid on
saveas(gcf,'Daily Revenue per Vehicle [€].png')
hold off
% yticks(0:10:100);
% ylim([0 100])
