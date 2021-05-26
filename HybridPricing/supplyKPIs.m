 %% Revenue - BookingTime - nBookings - In Vehicles Time - Profit
for i = 1:length(sim)

    input.CS1 = sprintf('/Users/giulio.giorgione/Documents/MATLAB/HybridPricing/');
    input.CS2 = whichLoop;
    input.CS3 = sprintf('/run1.500.CS_');
    input.CS4 = sprintf('%s',sim{i});
    input.CS5 = sprintf('.txt');
    inputCS = strcat(input.CS1,input.CS2,input.CS3,input.CS4,input.CS5);
    delimiterIn = ",";
    CS = readtable(inputCS,'Delimiter',',');

    revenue_temp = CS.cost;
    revenue.(sim{i}) = sum(revenue_temp);
    
    nbookings.(sim{i}) = length(revenue_temp);
    
    bookingTime_temp = CS.bookingTime;
    bookingTime.(sim{i}) = sum(bookingTime_temp);
    
    inVehicleTime_temp = CS.inVehicleTime;
    inVehicleTime.(sim{i}) = sum(inVehicleTime_temp);
    
    fixCost = 3; %3/3600;   %[€/veh]
    varCost = 1.5;     %[€/veh*s]
    totCost.(sim{i}) = fixCost * nVehs + (varCost * (inVehicleTime.(sim{i}))/3600);
    profit.(sim{i}) = revenue.(sim{i}) - totCost.(sim{i});
    
    test.(sim{i}) = revenue.(sim{i}) / bookingTime.(sim{i})*3600;
end

filename =[];
filename.a = sprintf('SupplyKPIs_');
filename.b = sprintf(whichLoop);
filename.c = sprintf('.mat');
filename = strcat(filename.a,filename.b,filename.c);
save(filename,'bookingTime','inVehicleTime','nbookings','revenue','profit','totCost');

clear revenue_temp
clear bookingTime_temp
clear inVehicleTime_temp

%% Spider Plot

if DemandProfilePlot == 0
    if isequal(whichLoop,'FP')
        FP = [profit.FP bookingTime.FP nbookings.FP inVehicleTime.FP walkingTime.FP/nbookings.FP];
        TBDP010 = [profit.TBDP010 bookingTime.TBDP010 nbookings.TBDP010 inVehicleTime.TBDP010 walkingTime.TBDP010/nbookings.TBDP010];
        TBDP030 = [profit.TBDP030 bookingTime.TBDP030 nbookings.TBDP030 inVehicleTime.TBDP030 walkingTime.TBDP030/nbookings.TBDP030];
        ABDP105 = [profit.ABDP105 bookingTime.ABDP105 nbookings.ABDP105 inVehicleTime.ABDP105 walkingTime.ABDP105/nbookings.ABDP105];
        ABDP120 = [profit.ABDP120 bookingTime.ABDP120 nbookings.ABDP120 inVehicleTime.ABDP120 walkingTime.ABDP120/nbookings.ABDP120];
        FPRelocation = [profit.FPRelocation bookingTime.FPRelocation nbookings.FPRelocation inVehicleTime.FPRelocation walkingTime.FPRelocation/nbookings.FPRelocation];
        TBDP010Relocation = [profit.TBDP010Relocation bookingTime.TBDP010Relocation nbookings.TBDP010Relocation inVehicleTime.TBDP010Relocation walkingTime.TBDP010Relocation/nbookings.TBDP010Relocation];
        VarPlot = [FP; TBDP010; TBDP030; ABDP105; ABDP120; FPRelocation; TBDP010Relocation];
        spider_plot(VarPlot,...
            'AxesLabels', {'Profit [€]', 'Booking Time [s]', '# Bookings',...
            'in Vehicle Time [s]', 'Walking Time to Station [s]'},...
            'AxesInterval', 2,...
            'FillOption', {'on', 'on', 'on', 'on', 'on', 'on', 'on'},...
            'FillTransparency', [0.05,0.05,0.05,0.05,0.05,0.05,0.05],...
            'LineStyle', {'-', '--', '--', ':', ':', '-', '-'},...
            'Color', colorSims);
            legend('FP','TBDP010','TBDP030','ABDP105','ABDP120','FPRelocation','TBDP010Relocation','Location','eastoutside');
    else
        MPP = [profit.MPP bookingTime.MPP nbookings.MPP inVehicleTime.MPP walkingTime.MPP/nbookings.MPP];
        TBDP010 = [profit.TBDP010 bookingTime.TBDP010 nbookings.TBDP010 inVehicleTime.TBDP010 walkingTime.TBDP010/nbookings.TBDP010];
        TBDP030 = [profit.TBDP030 bookingTime.TBDP030 nbookings.TBDP030 inVehicleTime.TBDP030 walkingTime.TBDP030/nbookings.TBDP030];
        ABDP105 = [profit.ABDP105 bookingTime.ABDP105 nbookings.ABDP105 inVehicleTime.ABDP105 walkingTime.ABDP105/nbookings.ABDP105];
        ABDP120 = [profit.ABDP120 bookingTime.ABDP120 nbookings.ABDP120 inVehicleTime.ABDP120 walkingTime.ABDP120/nbookings.ABDP120];
        MPPRelocation = [profit.MPPRelocation bookingTime.MPPRelocation nbookings.MPPRelocation inVehicleTime.MPPRelocation walkingTime.MPPRelocation/nbookings.MPPRelocation];
        ABDP105Relocation = [profit.ABDP105Relocation bookingTime.ABDP105Relocation nbookings.ABDP105Relocation inVehicleTime.ABDP105Relocation walkingTime.ABDP105Relocation/nbookings.ABDP105Relocation];        
        VarPlot = [MPP; TBDP010; TBDP030; ABDP105; ABDP120; MPPRelocation; ABDP105Relocation];
        spider_plot(VarPlot,...
            'AxesLabels', {'Profit [€]', 'Booking Time [s]', '# Bookings',...
            'in Vehicle Time [s]', 'Walking Time to Station [s]'},...
            'AxesInterval', 2,...
            'FillOption', {'on', 'on', 'on', 'on', 'on', 'on', 'on'},...
            'FillTransparency', [0.05,0.05,0.05,0.05,0.05,0.05,0.05],...
            'LineStyle', {'-', '--', '--', ':', ':', '-', '-'},...
            'Color', colorSims);
            legend('MPP','TBDP010','TBDP030','ABDP105','ABDP120','MPPRelocation','ABDP105Relocation','Location','eastoutside');
    end
    filename = [];
    filename.a = sprintf('SpiderPlot_KPIsSupply');
    filename.b = sprintf('%s',whichLoop);
    filename.c = sprintf('.png');
    filename = strcat(filename.a,filename.b,filename.c);
    saveas(gca,filename);
end

clear VarPlot
clear FP
clear TBDP010
clear TBDP030
clear ABDP105
clear ABDP120
clear TBDP010Relocation
clear ABDP105Relocation
clear FPRelocation
clear MPPRelocation
