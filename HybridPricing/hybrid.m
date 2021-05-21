clear
clc

whichLoop = ('FP');
whichLoop = ('MPP');

if isequal(whichLoop,'FP')
    sim = {'FP','TBDP010','TBDP030','ABDP105','ABDP120','FPRelocation','TBDP010Relocation'};
else
    sim = {'MPP','TBDP010','TBDP030','ABDP105','ABDP120','MPPRelocation','ABDP105Relocation'};

end

DemandProfilePlot = 1;
nVehs = 186;
colorSims = ([1, 0, 0; 0.78, 0.54, 1; 0.45, 0, 0.90; 0.12, 0.46, 1; 0, 0, 1;...
    0.02, 0.94, 0.69; 0.01, 0.67, 0.49]);

run walkingDistance.m
run supplyKPIs.m
run demandProfile.m
run vehiclesUtilization.m
run WalkingTimeIndividual.m
run modalSplitAll.m
run scoreDistribution.m