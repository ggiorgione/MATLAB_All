%RESERVATION NUMBER

load AccessTimeValues.mat

[AccessTime1_VOTunique,~,idx] = unique(AccessTime1_VOT(:,2));
nu = numel(AccessTime1_VOTunique);
ResNumb1 = zeros(nu,size(AccessTime1_VOT,2));
for ii = 1:nu
    ResNumb1(ii,:) = numel(AccessTime1_VOT(idx==ii,1));
end
ResNumb1(:,2) = AccessTime1_VOTunique;


[AccessTime3_VOTunique,~,idx] = unique(AccessTime3_VOT(:,2));
nu = numel(AccessTime3_VOTunique);
ResNumb3 = zeros(nu,size(AccessTime3_VOT,2));
for ii = 1:nu
    ResNumb3(ii,:) = numel(AccessTime3_VOT(idx==ii,1));
end
ResNumb3(:,2) = AccessTime3_VOTunique;


[AccessTime4_VOTunique,~,idx] = unique(AccessTime4_VOT(:,2));
nu = numel(AccessTime4_VOTunique);
ResNumb4 = zeros(nu,size(AccessTime4_VOT,2));
for ii = 1:nu
    ResNumb4(ii,:) = numel(AccessTime4_VOT(idx==ii,1));
end
ResNumb4(:,2) = AccessTime4_VOTunique;


[AccessTime6_VOTunique,~,idx] = unique(AccessTime6_VOT(:,2));
nu = numel(AccessTime6_VOTunique);
ResNumb6 = zeros(nu,size(AccessTime6_VOT,2));
for ii = 1:nu
    ResNumb6(ii,:) = numel(AccessTime6_VOT(idx==ii,1));
end
ResNumb6(:,2) = AccessTime6_VOTunique;


[AccessTime7_VOTunique,~,idx] = unique(AccessTime7_VOT(:,2));
nu = numel(AccessTime7_VOTunique);
ResNumb7 = zeros(nu,size(AccessTime7_VOT,2));
for ii = 1:nu
    ResNumb7(ii,:) = numel(AccessTime7_VOT(idx==ii,1));
end
ResNumb7(:,2) = AccessTime7_VOTunique;


[AccessTime9_VOTunique,~,idx] = unique(AccessTime9_VOT(:,2));
nu = numel(AccessTime9_VOTunique);
ResNumb9 = zeros(nu,size(AccessTime9_VOT,2));
for ii = 1:nu
    ResNumb9(ii,:) = numel(AccessTime9_VOT(idx==ii,1));
end
ResNumb9(:,2) = AccessTime9_VOTunique;


[AccessTime11_VOTunique,~,idx] = unique(AccessTime11_VOT(:,2));
nu = numel(AccessTime11_VOTunique);
ResNumb11 = zeros(nu,size(AccessTime11_VOT,2));
for ii = 1:nu
    ResNumb11(ii,:) = numel(AccessTime11_VOT(idx==ii,1));
end
ResNumb11(:,2) = AccessTime11_VOTunique;


[AccessTime12_VOTunique,~,idx] = unique(AccessTime12_VOT(:,2));
nu = numel(AccessTime12_VOTunique);
ResNumb12 = zeros(nu,size(AccessTime12_VOT,2));
for ii = 1:nu
    ResNumb12(ii,:) = numel(AccessTime12_VOT(idx==ii,1));
end
ResNumb12(:,2) = AccessTime12_VOTunique;


[AccessTime13_VOTunique,~,idx] = unique(AccessTime13_VOT(:,2));
nu = numel(AccessTime13_VOTunique);
ResNumb13 = zeros(nu,size(AccessTime13_VOT,2));
for ii = 1:nu
    ResNumb13(ii,:) = numel(AccessTime13_VOT(idx==ii,1));
end
ResNumb13(:,2) = AccessTime13_VOTunique;


[AccessTime14_VOTunique,~,idx] = unique(AccessTime14_VOT(:,2));
nu = numel(AccessTime14_VOTunique);
ResNumb14 = zeros(nu,size(AccessTime14_VOT,2));
for ii = 1:nu
    ResNumb14(ii,:) = numel(AccessTime14_VOT(idx==ii,1));
end
ResNumb14(:,2) = AccessTime14_VOTunique;

%Delta 1-4
plot(ResNumb1(:,2),ResNumb1(:,1))
hold on
plot(ResNumb4(:,2),ResNumb4(:,1));
% title('Shift in Reservations 1-4');
legend('Reservation Sim1','Reservation Sim4','Location','northwest');
xlabel('VOT [€/h]');
xticks(ResNumb1(:,2));
xtickangle(90)
ylabel('Reservations');
hold off

filename = sprintf('Shift in Reservations 1-4.png');
saveas(gca,filename);

%Delta 4-7
plot(ResNumb4(:,2),ResNumb4(:,1))
hold on
plot(ResNumb7(:,2),ResNumb7(:,1));
% title('Shift in Reservations 4-7');
legend('Reservation Sim4','Reservation Sim7','Location','northwest');
xlabel('VOT [€/h]');
xticks(ResNumb4(:,2));
xtickangle(90)
ylabel('Reservations');
hold off

filename = sprintf('Shift in Reservations 4-7.png');
saveas(gca,filename);

%Delta 4-11
plot(ResNumb4(:,2),ResNumb4(:,1))
hold on
plot(ResNumb11(:,2),ResNumb11(:,1));
% title('Shift in Reservations 4-11');
legend('Reservation Sim4','Reservation Sim11','Location','northwest');
xlabel('VOT [€/h]');
xticks(ResNumb4(:,2));
xtickangle(90)
ylabel('Reservations');
hold off

filename = sprintf('Shift in Reservations 4-11.png');
saveas(gca,filename);

%Delta 4-13
plot(ResNumb4(:,2),ResNumb4(:,1))
hold on
plot(ResNumb13(:,2),ResNumb13(:,1));
% title('Shift in Reservations 4-13');
legend('Reservation Sim4','Reservation Sim13','Location','northwest');
xlabel('VOT [€/h]');
xticks(ResNumb4(:,2));
xtickangle(90)
ylabel('Reservations');
hold off

filename = sprintf('Shift in Reservations 4-13.png');
saveas(gca,filename);

%Delta 3-6
plot(ResNumb3(:,2),ResNumb3(:,1))
hold on
plot(ResNumb6(:,2),ResNumb6(:,1));
% title('Shift in Reservations 3-6');
legend('Reservation Sim3','Reservation Sim6','Location','northwest');
xlabel('VOT [€/h]');
xticks(ResNumb3(:,2));
xtickangle(90)
ylabel('Reservations');
hold off

filename = sprintf('Shift in Reservations 3-6.png');
saveas(gca,filename);

%Delta 6-9
plot(ResNumb6(:,2),ResNumb6(:,1))
hold on
plot(ResNumb9(:,2),ResNumb9(:,1));
% title('Shift in Reservations 6-9');
legend('Reservation Sim6','Reservation Sim9','Location','northwest');
xlabel('VOT [€/h]');
xticks(ResNumb6(:,2));
xtickangle(90)
ylabel('Reservations');
hold off

filename = sprintf('Shift in Reservations 6-9.png');
saveas(gca,filename);

%Delta 6-12
plot(ResNumb6(:,2),ResNumb6(:,1))
hold on
plot(ResNumb12(:,2),ResNumb12(:,1));
% title('Shift in Reservations 6-12');
legend('Reservation Sim6','Reservation Sim12','Location','northwest');
xlabel('VOT [€/h]');
xticks(ResNumb6(:,2));
xtickangle(90)
ylabel('Reservations');
hold off

filename = sprintf('Shift in Reservations 6-12.png');
saveas(gca,filename);

%Delta 6-14
plot(ResNumb6(:,2),ResNumb6(:,1))
hold on
plot(ResNumb14(:,2),ResNumb14(:,1));
% title('Shift in Reservations 6-14');
legend('Reservation Sim6','Reservation Sim14','Location','northwest');
xlabel('VOT [€/h]');
xticks(ResNumb6(:,2));
xtickangle(90)
ylabel('Reservations');
hold off

filename = sprintf('Shift in Reservations 6-14.png');
saveas(gca,filename);