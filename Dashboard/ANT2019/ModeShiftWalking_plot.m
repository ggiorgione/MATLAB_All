load ModalShiftXTime1.mat
DemandWalking1 = DemandWalking
load ModalShiftXTime3.mat
DemandWalking3 = DemandWalking
load ModalShiftXTime4.mat
DemandWalking4 = DemandWalking
load ModalShiftXTime6.mat
DemandWalking6 = DemandWalking
load ModalShiftXTime7.mat
DemandWalking7 = DemandWalking
load ModalShiftXTime9.mat
DemandWalking9 = DemandWalking
load ModalShiftXTime11.mat
DemandWalking11 = DemandWalking
load ModalShiftXTime12.mat
DemandWalking12 = DemandWalking

%4-7
plot(DemandWalking1(:,1)/3600,DemandWalking4(:,3));
hold on
plot(DemandWalking1(:,1)/3600,DemandWalking7(:,3));
title('Persons Walking to Carsharing4-7');
xlabel('Time [h]')
ylabel('Persons')
legend('Sim4','Sim7')
hold off
filename = sprintf('DemandShareWalking4-7.png');
saveas(gca,filename);

%4-11
plot(DemandWalking1(:,1)/3600,DemandWalking4(:,3));
hold on
plot(DemandWalking1(:,1)/3600,DemandWalking11(:,3));
title('Persons Walking to Carsharing4-11');
xlabel('Time [h]')
ylabel('Persons')
legend('Sim4','Sim11')
hold off
filename = sprintf('DemandShareWalking4-11.png');
saveas(gca,filename);

%6-9
plot(DemandWalking1(:,1)/3600,DemandWalking6(:,3));
hold on
plot(DemandWalking1(:,1)/3600,DemandWalking9(:,3));
title('Persons Walking to Carsharing6-9');
xlabel('Time [h]')
ylabel('Persons')
legend('Sim6','Sim9')
hold off
filename = sprintf('DemandShareWalking6-9.png');
saveas(gca,filename);

%6-12
plot(DemandWalking1(:,1)/3600,DemandWalking6(:,3));
hold on
plot(DemandWalking1(:,1)/3600,DemandWalking12(:,3));
title('Persons Walking to Carsharing6-12');
xlabel('Time [h]')
ylabel('Persons')
legend('Sim6','Sim12')
hold off
filename = sprintf('DemandShareWalking6-12.png');
saveas(gca,filename);