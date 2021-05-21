%DEMAND PROFILE SHIFT EVALUATION

clear

load ModePercentage1.mat
twowayPERC1 = twowayPERC;
ptPERC1 = ptPERC;
carPERC1 = carPERC;
softPERC1 = 100-twowayPERC-ptPERC-carPERC;
load ModePercentage3.mat
twowayPERC3 = twowayPERC;
ptPERC3 = ptPERC;
carPERC3 = carPERC;
softPERC3 = 100-twowayPERC-ptPERC-carPERC;
load ModePercentage4.mat
twowayPERC4 = twowayPERC;
ptPERC4 = ptPERC;
carPERC4 = carPERC;
softPERC4 = 100-twowayPERC-ptPERC-carPERC;
load ModePercentage6.mat
twowayPERC6 = twowayPERC;
ptPERC6 = ptPERC;
carPERC6 = carPERC;
softPERC6 = 100-twowayPERC-ptPERC-carPERC;
load ModePercentage7.mat
twowayPERC7 = twowayPERC;
ptPERC7 = ptPERC;
carPERC7 = carPERC;
softPERC7 = 100-twowayPERC-ptPERC-carPERC;
load ModePercentage9.mat
twowayPERC9 = twowayPERC;
ptPERC9 = ptPERC;
carPERC9 = carPERC;
softPERC9 = 100-twowayPERC-ptPERC-carPERC;
load ModePercentage11.mat
twowayPERC11 = twowayPERC;
ptPERC11 = ptPERC;
carPERC11 = carPERC;
softPERC11 = 100-twowayPERC-ptPERC-carPERC;
load ModePercentage12.mat
twowayPERC12 = twowayPERC;
ptPERC12 = ptPERC;
carPERC12 = carPERC;
softPERC12 = 100-twowayPERC-ptPERC-carPERC;
load ModePercentage13.mat
twowayPERC13 = twowayPERC;
ptPERC13 = ptPERC;
carPERC13 = carPERC;
softPERC13 = 100-twowayPERC-ptPERC-carPERC;
load ModePercentage14.mat
twowayPERC14 = twowayPERC;
ptPERC14 = ptPERC;
carPERC14 = carPERC;
softPERC14 = 100-twowayPERC-ptPERC-carPERC;

totaltwoway = [twowayPERC1 twowayPERC3 twowayPERC4 twowayPERC6 twowayPERC7 twowayPERC9 twowayPERC11 twowayPERC12 twowayPERC13 twowayPERC14];
totalpt = [ptPERC1 ptPERC3 ptPERC4 ptPERC6 ptPERC7 ptPERC9 ptPERC11 ptPERC12 ptPERC13 ptPERC14];
totalcar = [carPERC1 carPERC3 carPERC4 carPERC6 carPERC7 carPERC9 carPERC11 carPERC12 carPERC13 carPERC14];
totalsoft = [softPERC1 softPERC3 softPERC4 softPERC6 softPERC7 softPERC9 softPERC11 softPERC12 softPERC13 softPERC14];
totaltotal(4,:) = totaltwoway;
totaltotal(2,:) = totalpt;
totaltotal(3,:) = totalcar;
totaltotal(1,:) = totalsoft;
totaltotal = totaltotal';
% log(totaltotal);

c = categorical({'Sim01','Sim03','Sim04','Sim06','Sim07','Sim09','Sim11','Sim12','Sim13','Sim14'});
bar(c,totaltotal,'stacked')
legend('Soft Modes','Public Transport','Car','Carsharing');
ylim([0 120]);
hold off

filename = sprintf('Mode_Shift_Histogram.mat');
save(filename,'carPERC', 'carPERC1', 'carPERC11', 'carPERC12', 'carPERC13', 'carPERC14', 'carPERC3', 'carPERC4', 'carPERC6', 'carPERC7', 'carPERC9', 'otherModesPERC', 'ptPERC', 'ptPERC1', 'ptPERC11', 'ptPERC12', 'ptPERC13', 'ptPERC14', 'ptPERC3', 'ptPERC4', 'ptPERC6', 'ptPERC7', 'ptPERC9', 'softPERC1', 'softPERC11', 'softPERC12', 'softPERC13', 'softPERC14', 'softPERC3', 'softPERC4', 'softPERC6', 'softPERC7', 'softPERC9', 'twowayPERC', 'twowayPERC1', 'twowayPERC11', 'twowayPERC12', 'twowayPERC13', 'twowayPERC14', 'twowayPERC3', 'twowayPERC4', 'twowayPERC6', 'twowayPERC7', 'twowayPERC9');

%Evaluate the modal shift





