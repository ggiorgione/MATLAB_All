load all.mat
load onlyCS.mat

allVotScore = [table2array(all(:,2)) table2array(all(:,3)) table2array(all(:,4))];
allVotScore = str2double(allVotScore);
temp = allVotScore(:,3) - allVotScore(:,2);
allVotScore = [allVotScore(:,1) temp];
allVotScore = floor(allVotScore);

allVotScoreNoZeros = allVotScore(any(allVotScore(:,2),2),:);
allVotScoreNoZeros(allVotScoreNoZeros(:,1) > 31, :) = [];
allVotScoreNoZeros(allVotScoreNoZeros(:,2) > 40, :) = [];
allVotScoreNoZeros(allVotScoreNoZeros(:,2) < -40, :) = [];

boxplot(allVotScoreNoZeros(:,2),allVotScoreNoZeros(:,1),'Whisker',1);
ylim([-50 50]);
grid on

onlyCSVotScore = [table2array(onlyCS(:,2)) table2array(onlyCS(:,3)) table2array(onlyCS(:,4))];
onlyCSVotScore = str2double(onlyCSVotScore);
temp = onlyCSVotScore(:,3) - onlyCSVotScore(:,2);
onlyCSVotScore = [onlyCSVotScore(:,1) temp];


onlyCSVotScore = floor(onlyCSVotScore);

onlyCSVotScoreNoZeros = onlyCSVotScore(any(onlyCSVotScore(:,2),2),:);
onlyCSVotScoreNoZeros(onlyCSVotScoreNoZeros(:,1) > 31, :) = [];
onlyCSVotScoreNoZeros(onlyCSVotScoreNoZeros(:,2) > 40, :) = [];
onlyCSVotScoreNoZeros(onlyCSVotScoreNoZeros(:,2) > 40, :) = [];
onlyCSVotScoreNoZeros(onlyCSVotScoreNoZeros(:,2) < -40, :) = [];

boxplot(onlyCSVotScoreNoZeros(:,2),onlyCSVotScoreNoZeros(:,1));
ylim([-50 50]);
grid on