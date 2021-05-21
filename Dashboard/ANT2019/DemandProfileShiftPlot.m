%DEMAND PROFILE SHIFT PLOT


% Sims 4-7
% %all
% load ModePercentage4.mat
% plot((time/3600),all,'r');    %Plot the 4st simulation Fleet utilization
% hold on
% load ModePercentage7.mat
% plot((time/3600),all,'b');    %Plot the 7th simulation Fleet utilization
% title('Demand Profile all');
% xlim([0 24]);
% ylabel('Vehicle_all');
% xlabel('Time [h]');
% legend('Demand Profile Sim4','Demand Profile Sim7');
% filename = sprintf('Demand_Profile_All_4-7.png');
% saveas(gca,filename);
% hold off
% 
% %car
% load ModePercentage4.mat
% plot((time/3600),car,'r');    %Plot the 4st simulation Fleet utilization
% hold on
% load ModePercentage7.mat
% plot((time/3600),car,'b');    %Plot the 7th simulation Fleet utilization
% title('Demand Profile car');
% xlim([0 24]);
% ylabel('Vehicle_car');
% xlabel('Time [h]');
% legend('Demand Profile Sim4','Demand Profile Sim7');
% filename = sprintf('Demand_Profile_car_4-7.png');
% saveas(gca,filename);
% hold off
% 
% %pt
% load ModePercentage4.mat
% plot((time/3600),pt,'r');    %Plot the 4st simulation Fleet utilization
% hold on
% load ModePercentage7.mat
% plot((time/3600),pt,'b');    %Plot the 7th simulation Fleet utilization
% title('Demand Profile pt');
% xlim([0 24]);
% ylabel('Vehicle_pt');
% xlabel('Time [h]');
% legend('Demand Profile Sim4','Demand Profile Sim7');
% filename = sprintf('Demand_Profile_pt_4-7.png');
% saveas(gca,filename);
% hold off

%twoway
load ModePercentage4.mat
twoway=movmean(twoway,20);
twowayarrival=movmean(twowayarrival,20);
plot((time/3600),twoway,'r');    %Plot the 4st simulation Fleet utilization
hold on
plot((time/3600),twowayarrival,'y');    
load ModePercentage7.mat
twoway=movmean(twoway,20);
twowayarrival=movmean(twowayarrival,20);
plot((time/3600),twoway,'b');    %Plot the 7th simulation Fleet utilization
plot((time/3600),twowayarrival,'c');  
title('Demand Profile twoway4-7');
xlim([0 24]);
ylabel('Vehicle_twoway');
xlabel('Time [h]');
legend('Demand Profile Sim4','Arrival Profile Sim4','Demand Profile Sim7','Arrival Profile Sim7');
filename = sprintf('Demand_Profile_twoway_4-7.png');
saveas(gca,filename);
hold off

% Sims 4-11
% %all
% load ModePercentage4.mat
% plot((time/3600),all,'r');    %Plot the 4st simulation Fleet utilization
% hold on
% load ModePercentage11.mat
% plot((time/3600),all,'b');    %Plot the 11th simulation Fleet utilization
% title('Demand Profile all');
% xlim([0 24]);
% ylabel('Vehicle_all');
% xlabel('Time [h]');
% legend('Demand Profile Sim4','Demand Profile Sim11');
% filename = sprintf('Demand_Profile_All_4-11.png');
% saveas(gca,filename);
% hold off
% 
% %car
% load ModePercentage4.mat
% plot((time/3600),car,'r');    %Plot the 4st simulation Fleet utilization
% hold on
% load ModePercentage11.mat
% plot((time/3600),car,'b');    %Plot the 11th simulation Fleet utilization
% title('Demand Profile car');
% xlim([0 24]);
% ylabel('Vehicle_car');
% xlabel('Time [h]');
% legend('Demand Profile Sim4','Demand Profile Sim11');
% filename = sprintf('Demand_Profile_car_4-11.png');
% saveas(gca,filename);
% hold off
% 
% %pt
% load ModePercentage4.mat
% plot((time/3600),pt,'r');    %Plot the 4st simulation Fleet utilization
% hold on
% load ModePercentage11.mat
% plot((time/3600),pt,'b');    %Plot the 11th simulation Fleet utilization
% title('Demand Profile pt');
% xlim([0 24]);
% ylabel('Vehicle_pt');
% xlabel('Time [h]');
% legend('Demand Profile Sim4','Demand Profile Sim11');
% filename = sprintf('Demand_Profile_pt_4-11.png');
% saveas(gca,filename);
% hold off

%twoway
load ModePercentage4.mat
twoway=movmean(twoway,20);
twowayarrival=movmean(twowayarrival,20);
plot((time/3600),twoway,'r');    %Plot the 4st simulation Fleet utilization
hold on
plot((time/3600),twowayarrival,'y');  
load ModePercentage11.mat
twoway=movmean(twoway,20);
twowayarrival=movmean(twowayarrival,20);
plot((time/3600),twoway,'b');    %Plot the 11th simulation Fleet utilization
plot((time/3600),twowayarrival,'c');  
title('Demand Profile twoway4-11');
xlim([0 24]);
ylabel('Vehicle_twoway');
xlabel('Time [h]');
legend('Demand Profile Sim4','Arrival Profile Sim4','Demand Profile Sim11','Arrival Profile Sim11');
filename = sprintf('Demand_Profile_twoway_4-11.png');
saveas(gca,filename);
hold off

% % Sims 4-13
% %all
% load ModePercentage4.mat
% plot((time/3600),all,'r');    %Plot the 4st simulation Fleet utilization
% hold on
% load ModePercentage13.mat
% plot((time/3600),all,'b');    %Plot the 13th simulation Fleet utilization
% title('Demand Profile all');
% xlim([0 24]);
% ylabel('Vehicle_all');
% xlabel('Time [h]');
% legend('Demand Profile Sim4','Demand Profile Sim13');
% filename = sprintf('Demand_Profile_All_4-13.png');
% saveas(gca,filename);
% hold off
% 
% %car
% load ModePercentage4.mat
% plot((time/3600),car,'r');    %Plot the 4st simulation Fleet utilization
% hold on
% load ModePercentage13.mat
% plot((time/3600),car,'b');    %Plot the 13th simulation Fleet utilization
% title('Demand Profile car');
% xlim([0 24]);
% ylabel('Vehicle_car');
% xlabel('Time [h]');
% legend('Demand Profile Sim4','Demand Profile Sim13');
% filename = sprintf('Demand_Profile_car_4-13.png');
% saveas(gca,filename);
% hold off
% 
% %pt
% load ModePercentage4.mat
% plot((time/3600),pt,'r');    %Plot the 4st simulation Fleet utilization
% hold on
% load ModePercentage13.mat
% plot((time/3600),pt,'b');    %Plot the 13th simulation Fleet utilization
% title('Demand Profile pt');
% xlim([0 24]);
% ylabel('Vehicle_pt');
% xlabel('Time [h]');
% legend('Demand Profile Sim4','Demand Profile Sim13');
% filename = sprintf('Demand_Profile_pt_4-13.png');
% saveas(gca,filename);
% hold off
% 
% %twoway
% load ModePercentage4.mat
% twoway=movmean(twoway,20);
% plot((time/3600),twoway,'r');    %Plot the 4st simulation Fleet utilization
% hold on
% load ModePercentage13.mat
% twoway=movmean(twoway,20);
% plot((time/3600),twoway,'b');    %Plot the 13th simulation Fleet utilization
% title('Demand Profile twoway');
% xlim([0 24]);
% ylabel('Vehicle_twoway');
% xlabel('Time [h]');
% legend('Demand Profile Sim4','Demand Profile Sim13');
% filename = sprintf('Demand_Profile_twoway_4-13.png');
% saveas(gca,filename);
% hold off


% Sims 6-9
%all
% load ModePercentage6.mat
% plot((time/3600),all,'r');    %Plot the 6st simulation Fleet utilization
% hold on
% load ModePercentage9.mat
% plot((time/3600),all,'b');    %Plot the 9th simulation Fleet utilization
% title('Demand Profile all');
% xlim([0 24]);
% ylabel('Vehicle_all');
% xlabel('Time [h]');
% legend('Demand Profile Sim6','Demand Profile Sim9');
% filename = sprintf('Demand_Profile_All_6-9.png');
% saveas(gca,filename);
% hold off
% 
% %car
% load ModePercentage6.mat
% plot((time/3600),car,'r');    %Plot the 6st simulation Fleet utilization
% hold on
% load ModePercentage9.mat
% plot((time/3600),car,'b');    %Plot the 9th simulation Fleet utilization
% title('Demand Profile car');
% xlim([0 24]);
% ylabel('Vehicle_car');
% xlabel('Time [h]');
% legend('Demand Profile Sim6','Demand Profile Sim9');
% filename = sprintf('Demand_Profile_car_6-9.png');
% saveas(gca,filename);
% hold off
% 
% %pt
% load ModePercentage6.mat
% plot((time/3600),pt,'r');    %Plot the 6st simulation Fleet utilization
% hold on
% load ModePercentage9.mat
% plot((time/3600),pt,'b');    %Plot the 9th simulation Fleet utilization
% title('Demand Profile pt');
% xlim([0 24]);
% ylabel('Vehicle_pt');
% xlabel('Time [h]');
% legend('Demand Profile Sim6','Demand Profile Sim9');
% filename = sprintf('Demand_Profile_pt_6-9.png');
% saveas(gca,filename);
% hold off

%twoway
load ModePercentage6.mat
A=mean(twoway);
twoway=movmean(twoway,20);
twowayarrival=movmean(twowayarrival,20);
plot((time/3600),twoway,'r');    %Plot the 6st simulation Fleet utilization
hold on
plot((time/3600),twowayarrival,'y');  
load ModePercentage9.mat
B=mean(twoway);
twoway=movmean(twoway,20);
twowayarrival=movmean(twowayarrival,20);
plot((time/3600),twoway,'b');    %Plot the 9th simulation Fleet utilization
plot((time/3600),twowayarrival,'c');  
title('Demand Profile twoway6-9');
xlim([0 24]);
ylabel('Vehicle_twoway');
xlabel('Time [h]');
legend('Demand Profile Sim6','Arrival Profile Sim6','Demand Profile Sim9','Arrival Profile Sim9');
filename = sprintf('Demand_Profile_twoway_6-9.png');
saveas(gca,filename);
hold off


% Sims 6-12
% %all
% load ModePercentage6.mat
% twoway=movmean(twoway,20);
% plot((time/3600),all,'r');    %Plot the 6st simulation Fleet utilization
% hold on
% load ModePercentage12.mat
% twoway=movmean(twoway,20);
% plot((time/3600),all,'b');    %Plot the 12th simulation Fleet utilization
% title('Demand Profile all');
% xlim([0 24]);
% ylabel('Vehicle_all');
% xlabel('Time [h]');
% legend('Demand Profile Sim6','Demand Profile Sim12');
% filename = sprintf('Demand_Profile_All_6-12.png');
% saveas(gca,filename);
% hold off
% 
% %car
% load ModePercentage6.mat
% plot((time/3600),car,'r');    %Plot the 6st simulation Fleet utilization
% hold on
% load ModePercentage12.mat
% plot((time/3600),car,'b');    %Plot the 12th simulation Fleet utilization
% title('Demand Profile car');
% xlim([0 24]);
% ylabel('Vehicle_car');
% xlabel('Time [h]');
% legend('Demand Profile Sim6','Demand Profile Sim12');
% filename = sprintf('Demand_Profile_car_6-12.png');
% saveas(gca,filename);
% hold off
% 
% %pt
% load ModePercentage6.mat
% plot((time/3600),pt,'r');    %Plot the 6st simulation Fleet utilization
% hold on
% load ModePercentage12.mat
% plot((time/3600),pt,'b');    %Plot the 12th simulation Fleet utilization
% title('Demand Profile pt');
% xlim([0 24]);
% ylabel('Vehicle_pt');
% xlabel('Time [h]');
% legend('Demand Profile Sim6','Demand Profile Sim12');
% filename = sprintf('Demand_Profile_pt_6-12.png');
% saveas(gca,filename);
% hold off

%twoway
load ModePercentage6.mat
A=mean(twoway);
twoway=movmean(twoway,20);
twowayarrival=movmean(twowayarrival,20);
plot((time/3600),twoway,'r');    %Plot the 6st simulation Fleet utilization
hold on
plot((time/3600),twowayarrival,'y');  
load ModePercentage12.mat
B=mean(twoway);
twoway=movmean(twoway,20);
twowayarrival=movmean(twowayarrival,20);
plot((time/3600),twoway,'b');    %Plot the 12th simulation Fleet utilization
plot((time/3600),twowayarrival,'c');  
title('Demand Profile twoway6-12');
xlim([0 24]);
ylabel('Vehicle_twoway');
xlabel('Time [h]');
legend('Demand Profile Sim6','Arrival Profile Sim6','Demand Profile Sim12','Arrival Profile Sim12');
filename = sprintf('Demand_Profile_twoway_6-12.png');
saveas(gca,filename);
hold off

% % Sims 6-14
% %all
% load ModePercentage6.mat
% plot((time/3600),all,'r');    %Plot the 6st simulation Fleet utilization
% hold on
% load ModePercentage14.mat
% plot((time/3600),all,'b');    %Plot the 14th simulation Fleet utilization
% title('Demand Profile all');
% xlim([0 24]);
% ylabel('Vehicle_all');
% xlabel('Time [h]');
% legend('Demand Profile Sim6','Demand Profile Sim14');
% filename = sprintf('Demand_Profile_All_6-14.png');
% saveas(gca,filename);
% hold off
% 
% %car
% load ModePercentage6.mat
% plot((time/3600),car,'r');    %Plot the 6st simulation Fleet utilization
% hold on
% load ModePercentage14.mat
% plot((time/3600),car,'b');    %Plot the 14th simulation Fleet utilization
% title('Demand Profile car');
% xlim([0 24]);
% ylabel('Vehicle_car');
% xlabel('Time [h]');
% legend('Demand Profile Sim6','Demand Profile Sim14');
% filename = sprintf('Demand_Profile_car_6-14.png');
% saveas(gca,filename);
% hold off
% 
% %pt
% load ModePercentage6.mat
% plot((time/3600),pt,'r');    %Plot the 6st simulation Fleet utilization
% hold on
% load ModePercentage14.mat
% plot((time/3600),pt,'b');    %Plot the 14th simulation Fleet utilization
% title('Demand Profile pt');
% xlim([0 24]);
% ylabel('Vehicle_pt');
% xlabel('Time [h]');
% legend('Demand Profile Sim6','Demand Profile Sim14');
% filename = sprintf('Demand_Profile_pt_6-14.png');
% saveas(gca,filename);
% hold off
% 
% %twoway
% load ModePercentage6.mat
% A=mean(twoway);
% twoway=movmean(twoway,20);
% plot((time/3600),twoway,'r');    %Plot the 6st simulation Fleet utilization
% hold on
% load ModePercentage14.mat
% B=mean(twoway);
% twoway=movmean(twoway,20);
% plot((time/3600),twoway,'b');    %Plot the 14th simulation Fleet utilization
% title('Demand Profile twoway');
% xlim([0 24]);
% ylabel('Vehicle_twoway');
% xlabel('Time [h]');
% legend('Demand Profile Sim6','Demand Profile Sim14');
% filename = sprintf('Demand_Profile_twoway_6-14.png');
% saveas(gca,filename);
% hold off

