%load AccessTimeValues.mat;

%Scatter access time mean
%Boxplot access time

%Plot the Delta time 1-4
scatter(AccessTime1_VOT_unique,Delta1_4);
hold on
plot(0);
title('Differential Access Time 1-4');
xticks(AccessTime1_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Access Time mean [s]');
hold off
filename = sprintf('Delta Access Time 1-4.png');
saveas(gca,filename);

%Plot the Delta time 4-7
scatter(AccessTime4_VOT_unique,Delta4_7);
hold on
plot(0);
title('Differential Access Time 4-7');
xticks(AccessTime4_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access Time 4-7.png');
saveas(gca,filename);
hold off

%Plot the Delta time 4-11
scatter(AccessTime4_VOT_unique,Delta4_11);
hold on
plot(0);
title('Differential Access Time 4-11');
xticks(AccessTime4_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access Time 4-11.png');
saveas(gca,filename);
hold off

% %Plot the Delta time 4-13
% scatter(AccessTime4_VOT_unique,Delta4_13);
% hold on
% plot(0);
% title('Differential Access Time 4-13');
% xticks(AccessTime4_VOT_unique);
% xtickangle(90);
% xlabel('VOT');
% ylabel('Access Time mean [s]');
% filename = sprintf('Delta Access Time 4-13.png');
% saveas(gca,filename);
% hold off

%Plot the Delta time 3-6
scatter(AccessTime3_VOT_unique,Delta3_6);
hold on
plot(0);
title('Differential Access Time 3-6');
xticks(AccessTime3_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access time 3-6.png');
saveas(gca,filename);
hold off

%Plot the Delta time 6-9
scatter(AccessTime6_VOT_unique,Delta6_9);
hold on
plot(0);
title('Differential Access Time 6-9');
xticks(AccessTime6_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access Time 6-9.png');
saveas(gca,filename);
hold off

%Plot the Delta time 6-12
scatter(AccessTime6_VOT_unique,Delta6_12);
hold on
plot(0);
title('Differential Access Time 6-12');
xticks(AccessTime6_VOT_unique);
xtickangle(120);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access Time 6-12.png');
saveas(gca,filename);
hold off

%Plot the Delta time 6-14
scatter(AccessTime6_VOT_unique,Delta6_14);
hold on
plot(0);
title('Differential Access Time 6-14');
xticks(AccessTime6_VOT_unique);
xtickangle(140);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access Time 6-14.png');
saveas(gca,filename);
hold off

%Plot the Delta time 1-7
Delta1_7 = AccessTime1_sum(:,1)-AccessTime7_VOT_sum(:,1); 
scatter(AccessTime1_VOT_unique,Delta1_7);
hold on
plot(0);
title('Differential Access Starting Time 1-7');
xticks(AccessTime6_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access Time 1-7.png');
saveas(gca,filename);
hold off

%Plot the Delta time 3-9
Delta3_9 = AccessTime3_VOT_sum(:,1)-AccessTime9_VOT_sum(:,1); 
scatter(AccessTime3_VOT_unique,Delta3_9);
hold on
plot(0);
title('Differential Access Starting Time 3-9');
xticks(AccessTime6_VOT_unique);
xtickangle(90);
xlabel('VOT');
ylabel('Access Time mean [s]');
filename = sprintf('Delta Access Time 3-9.png');
saveas(gca,filename);
hold off

%%%%%%%%%%
%BOXPLOTS%
%%%%%%%%%%


%BOXPLOT AccessTime1-4

subplot(2,1,1);
boxplot(AccessTime1_VOT(:,1),AccessTime1_VOT(:,2));
xlabel('VOT');
ylabel('Access Time [s]');
ylim([0 3000]);
title('Access Time 1')
grid on

subplot(2,1,2);
boxplot(AccessTime4_VOT(:,1),AccessTime4_VOT(:,2));
xlabel('VOT');
ylabel('Access Time [s]');
ylim([0 3000]);
title('Access Time 4');
grid on

filename = sprintf('Boxplot_Access_Time1-4.png');
saveas(gca,filename);

%BOXPLOT AccessTime3-6

subplot(2,1,1);
boxplot(AccessTime3_VOT(:,1),AccessTime3_VOT(:,2));
xlabel('VOT');
ylabel('Access Time [s]');
ylim([0 3000]);
title('Access Time 3')
grid on

subplot(2,1,2);
boxplot(AccessTime6_VOT(:,1),AccessTime6_VOT(:,2));
xlabel('VOT');
ylabel('Access Time [s]');
ylim([0 3000]);
title('Access Time 6');
grid on

filename = sprintf('Boxplot_Access_Time3-6.png');
saveas(gca,filename);

%BOXPLOT AccessTime4-7

subplot(2,1,1);
boxplot(AccessTime4_VOT(:,1),AccessTime4_VOT(:,2));
xlabel('VOT');
ylabel('Access Time [s]');
ylim([0 3000]);
title('Access Time 4')
grid on

subplot(2,1,2);
boxplot(AccessTime7_VOT(:,1),AccessTime7_VOT(:,2));
xlabel('VOT');
ylabel('Access Time [s]');
ylim([0 3000]);
title('Access Time 7');
grid on

filename = sprintf('Boxplot_Access_Time4-7.png');
saveas(gca,filename);

%BOXPLOT AccessTime6-9

subplot(2,1,1);
boxplot(AccessTime6_VOT(:,1),AccessTime6_VOT(:,2));
xlabel('VOT');
ylabel('Access Time [s]');
ylim([0 3000]);
title('Access Time 6')
grid on

subplot(2,1,2);
boxplot(AccessTime9_VOT(:,1),AccessTime9_VOT(:,2));
xlabel('VOT');
ylabel('Access Time [s]');
ylim([0 3000]);
title('Access Time 9');
grid on

filename = sprintf('Boxplot_Access_Time6-9.png');
saveas(gca,filename);

%BOXPLOT AccessTime4-11

subplot(2,1,1);
boxplot(AccessTime4_VOT(:,1),AccessTime4_VOT(:,2));
xlabel('Access Time [s]');
ylabel('VOT');
ylim([0 3000]);
title('Access Time 4')
grid on

subplot(2,1,2);
boxplot(AccessTime11_VOT(:,1),AccessTime11_VOT(:,2));
xlabel('Access Time [s]');
ylabel('VOT');
ylim([0 3000]);
title('Access Time 11');
grid on

filename = sprintf('Boxplot_Access_Time4-11.png');
saveas(gca,filename);

%BOXPLOT AccessTime4-13

subplot(2,1,1);
boxplot(AccessTime4_VOT(:,1),AccessTime4_VOT(:,2));
xlabel('VOT');
ylabel('Access Time [s]');
ylim([0 3000]);
title('Access Time 4')
grid on

subplot(2,1,2);
boxplot(AccessTime13_VOT(:,1),AccessTime13_VOT(:,2));
xlabel('VOT');
ylabel('Access Time [s]');
ylim([0 3000]);
title('Access Time 13');
grid on

filename = sprintf('Boxplot_Access_Time4-13.png');
saveas(gca,filename);

%BOXPLOT AccessTime6-12

subplot(2,1,1);
boxplot(AccessTime6_VOT(:,1),AccessTime6_VOT(:,2));
xlabel('VOT');
ylabel('Access Time [s]');
ylim([0 3000]);
title('Access Time 6')
grid on

subplot(2,1,2);
boxplot(AccessTime12_VOT(:,1),AccessTime12_VOT(:,2));
xlabel('VOT');
ylabel('Access Time [s]');
ylim([0 3000]);
title('Access Time 12');
grid on

filename = sprintf('Boxplot_Access_Time6-12.png');
saveas(gca,filename);

%BOXPLOT AccessTime6-14

subplot(2,1,1);
boxplot(AccessTime6_VOT(:,1),AccessTime6_VOT(:,2));
xlabel('VOT');
ylabel('Access Time [s]');
ylim([0 3000]);
title('Access Time 6')
grid on

subplot(2,1,2);
boxplot(AccessTime14_VOT(:,1),AccessTime14_VOT(:,2));
xlabel('VOT');
ylabel('Access Time [s]');
ylim([0 3000]);
title('Access Time 14');
grid on

filename = sprintf('Boxplot_Access_Time6-14.png');
saveas(gca,filename);