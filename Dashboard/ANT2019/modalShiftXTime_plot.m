%MODAL SPLIT DURING THE DAY - plot

load ModalShiftXTime1.mat
Demand(:,6) = Demand(:,2) + Demand(:,3) + Demand(:,4) + Demand(:,5);

Time = Demand(:,1);
Timehour = Time./3600;
Modes = [Demand(:,2) Demand(:,3) Demand(:,4) Demand(:,5)];
Sum = Demand(:,6);

DemandPerc = Modes./Sum;
DemandPerc(isnan(DemandPerc)) = 0;
DemandPlot = [Timehour DemandPerc];

plot(Timehour,DemandPerc(:,4))
xlim([0 30]);
xlabel('Time [h]');
ylabel('Twoway Demand [%]');
title('Twoway Demand Profile Share');

filename = sprintf('Twoway Demand Profile Share1.png');
saveas(gca,filename);


load ModalShiftXTime3.mat
Demand(:,6) = Demand(:,2) + Demand(:,3) + Demand(:,4) + Demand(:,5);

Time = Demand(:,1);
Timehour = Time./3600;
Modes = [Demand(:,2) Demand(:,3) Demand(:,4) Demand(:,5)];
Sum = Demand(:,6);

DemandPerc = Modes./Sum;
DemandPerc(isnan(DemandPerc)) = 0;
DemandPlot = [Timehour DemandPerc];

plot(Timehour,DemandPerc(:,4))
xlim([0 30]);
xlabel('Time [h]');
ylabel('Twoway Demand [%]');
title('Twoway Demand Profile Share');

filename = sprintf('Twoway Demand Profile Share3.png');
saveas(gca,filename);


load ModalShiftXTime4.mat
Demand(:,6) = Demand(:,2) + Demand(:,3) + Demand(:,4) + Demand(:,5);

Time = Demand(:,1);
Timehour = Time./3600;
Modes = [Demand(:,2) Demand(:,3) Demand(:,4) Demand(:,5)];
Sum = Demand(:,6);

DemandPerc = Modes./Sum;
DemandPerc(isnan(DemandPerc)) = 0;
DemandPlot = [Timehour DemandPerc];

plot(Timehour,DemandPerc(:,4))
xlim([0 30]);
xlabel('Time [h]');
ylabel('Twoway Demand [%]');
title('Twoway Demand Profile Share');

filename = sprintf('Twoway Demand Profile Share4.png');
saveas(gca,filename);


load ModalShiftXTime6.mat
Demand(:,6) = Demand(:,2) + Demand(:,3) + Demand(:,4) + Demand(:,5);

Time = Demand(:,1);
Timehour = Time./3600;
Modes = [Demand(:,2) Demand(:,3) Demand(:,4) Demand(:,5)];
Sum = Demand(:,6);

DemandPerc = Modes./Sum;
DemandPerc(isnan(DemandPerc)) = 0;
DemandPlot = [Timehour DemandPerc];

plot(Timehour,DemandPerc(:,4))
xlim([0 30]);
xlabel('Time [h]');
ylabel('Twoway Demand [%]');
title('Twoway Demand Profile Share');

filename = sprintf('Twoway Demand Profile Share6.png');
saveas(gca,filename);


load ModalShiftXTime7.mat
Demand(:,6) = Demand(:,2) + Demand(:,3) + Demand(:,4) + Demand(:,5);

Time = Demand(:,1);
Timehour = Time./3600;
Modes = [Demand(:,2) Demand(:,3) Demand(:,4) Demand(:,5)];
Sum = Demand(:,6);

DemandPerc = Modes./Sum;
DemandPerc(isnan(DemandPerc)) = 0;
DemandPlot = [Timehour DemandPerc];

plot(Timehour,DemandPerc(:,4))
xlim([0 30]);
xlabel('Time [h]');
ylabel('Twoway Demand [%]');
title('Twoway Demand Profile Share');

filename = sprintf('Twoway Demand Profile Share7.png');
saveas(gca,filename);


load ModalShiftXTime9.mat
Demand(:,6) = Demand(:,2) + Demand(:,3) + Demand(:,4) + Demand(:,5);

Time = Demand(:,1);
Timehour = Time./3600;
Modes = [Demand(:,2) Demand(:,3) Demand(:,4) Demand(:,5)];
Sum = Demand(:,6);

DemandPerc = Modes./Sum;
DemandPerc(isnan(DemandPerc)) = 0;
DemandPlot = [Timehour DemandPerc];

plot(Timehour,DemandPerc(:,4))
xlim([0 30]);
xlabel('Time [h]');
ylabel('Twoway Demand [%]');
title('Twoway Demand Profile Share');

filename = sprintf('Twoway Demand Profile Share9.png');
saveas(gca,filename);


load ModalShiftXTime11.mat
Demand(:,6) = Demand(:,2) + Demand(:,3) + Demand(:,4) + Demand(:,5);

Time = Demand(:,1);
Timehour = Time./3600;
Modes = [Demand(:,2) Demand(:,3) Demand(:,4) Demand(:,5)];
Sum = Demand(:,6);

DemandPerc = Modes./Sum;
DemandPerc(isnan(DemandPerc)) = 0;
DemandPlot = [Timehour DemandPerc];

plot(Timehour,DemandPerc(:,4))
xlim([0 30]);
xlabel('Time [h]');
ylabel('Twoway Demand [%]');
title('Twoway Demand Profile Share');

filename = sprintf('Twoway Demand Profile Share11.png');
saveas(gca,filename);


load ModalShiftXTime12.mat
Demand(:,6) = Demand(:,2) + Demand(:,3) + Demand(:,4) + Demand(:,5);

Time = Demand(:,1);
Timehour = Time./3600;
Modes = [Demand(:,2) Demand(:,3) Demand(:,4) Demand(:,5)];
Sum = Demand(:,6);

DemandPerc = Modes./Sum;
DemandPerc(isnan(DemandPerc)) = 0;
DemandPlot = [Timehour DemandPerc];

plot(Timehour,DemandPerc(:,4))
xlim([0 30]);
xlabel('Time [h]');
ylabel('Twoway Demand [%]');
title('Twoway Demand Profile Share');

filename = sprintf('Twoway Demand Profile Share12.png');
saveas(gca,filename);


load ModalShiftXTime13.mat
Demand(:,6) = Demand(:,2) + Demand(:,3) + Demand(:,4) + Demand(:,5);

Time = Demand(:,1);
Timehour = Time./3600;
Modes = [Demand(:,2) Demand(:,3) Demand(:,4) Demand(:,5)];
Sum = Demand(:,6);

DemandPerc = Modes./Sum;
DemandPerc(isnan(DemandPerc)) = 0;
DemandPlot = [Timehour DemandPerc];

plot(Timehour,DemandPerc(:,4))
xlim([0 30]);
xlabel('Time [h]');
ylabel('Twoway Demand [%]');
title('Twoway Demand Profile Share');

filename = sprintf('Twoway Demand Profile Share13.png');
saveas(gca,filename);


load ModalShiftXTime14.mat
Demand(:,6) = Demand(:,2) + Demand(:,3) + Demand(:,4) + Demand(:,5);

Time = Demand(:,1);
Timehour = Time./3600;
Modes = [Demand(:,2) Demand(:,3) Demand(:,4) Demand(:,5)];
Sum = Demand(:,6);

DemandPerc = Modes./Sum;
DemandPerc(isnan(DemandPerc)) = 0;
DemandPlot = [Timehour DemandPerc];

plot(Timehour,DemandPerc(:,4))
xlim([0 30]);
xlabel('Time [h]');
ylabel('Twoway Demand [%]');
title('Twoway Demand Profile Share');

filename = sprintf('Twoway Demand Profile Share14.png');
saveas(gca,filename);