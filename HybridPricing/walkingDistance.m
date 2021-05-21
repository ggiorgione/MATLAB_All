%% Access Time - Global

load Agents.mat
walkingTime = [];

for i = 1:length(sim)

    input.CS1 = sprintf('/Users/giulio.giorgione/Documents/MATLAB/HybridPricing/');
    input.CS2 = whichLoop;
    input.CS3 = sprintf('/run1.500.CS_');
    input.CS4 = sprintf('%s',sim{i});
    input.CS5 = sprintf('.txt');
    inputCS = strcat(input.CS1,input.CS2,input.CS3,input.CS4,input.CS5);
    delimiterIn = ",";
    CS = readtable(inputCS,'Delimiter',',');

    walkingTime_temp = CS.accessTime;
    walkingTime.(sim{i}) = sum(walkingTime_temp);
    
    filename = [];
    filename.a = sprintf('WalkingTimeGlobal_');
    filename.b = sprintf(whichLoop);
    filename.c = sprintf('_');
    filename.d = sprintf('%s',sim{i});
    filename.e = sprintf('.txt');
    filename = strcat(filename.a,filename.b,filename.c,filename.d,filename.e);
    writematrix(walkingTime.(sim{i}), filename);

end

filename = [];
filename.a = sprintf('AccessTime_');
filename.b = sprintf(whichLoop);
filename.c = sprintf('.mat');
filename = strcat(filename.a,filename.b,filename.c);
save(filename,'walkingTime');

clear walkingTime_temp = [];

%% Access Time - Individual Stations

for i = 1:length(sim)

    input.CS1 = sprintf('/Users/giulio.giorgione/Documents/MATLAB/HybridPricing/');
    input.CS2 = whichLoop;
    input.CS3 = sprintf('/run1.500.CS_');
    input.CS4 = sprintf('%s',sim{i});
    input.CS5 = sprintf('.txt');
    inputCS = strcat(input.CS1,input.CS2,input.CS3,input.CS4,input.CS5);
    delimiterIn = ",";
    CS = readtable(inputCS,'Delimiter',',');

%   For individuals
    walkingTime_temp = CS.accessTime;
    walkingTimeCustomerID_temp = CS.personID;
    walkingTimeIndividual = [walkingTimeCustomerID_temp walkingTime_temp];
    
    for ii = 1:length(walkingTimeIndividual)
        for j = 1:length(Agents)
           if walkingTimeIndividual(ii,1) == Agents(j,1)
               walkingTimeIndividual(ii,3) = Agents(j,4);
           end
        end
    end
    
    filename = [];
    filename.a = sprintf('WalkingTimeIndividual_');
    filename.b = sprintf(whichLoop);
    filename.c = sprintf('_');
    filename.d = sprintf('%s',sim{i});
    filename.e = sprintf('.txt');
    filename = strcat(filename.a,filename.b,filename.c,filename.d,filename.e);
    writematrix(walkingTimeIndividual, filename);
    
    if length(unique(walkingTimeIndividual(:,1))) ~= length(walkingTimeIndividual(:,1))
        disp('ERROR! Agent took a vehicle twice');
    else
        disp('No agent took a vehicle twice');
    end
    
%   Sum for the walking time per station
    walkingTimeVehicleID.(sim{i}) = [CS.vehicleID CS.accessTime];
    walkingTimeStation.(sim{i}) = round(walkingTimeVehicleID.(sim{i})(:,1),-1)/10;
    walkingTimeStation.(sim{i})(:,2) = walkingTimeVehicleID.(sim{i})(:,2);

    walkingTimeStation.(sim{i}) = sortrows((walkingTimeStation.(sim{i})),1,'ascend');
    
    walkingTimeStation_temp = [];
    walkingTimeStation_temp(:,1) = unique(walkingTimeStation.(sim{i})(:,1));
    walkingTimeStation_temp(:,2) = 0;
    
    for k = 1:length(walkingTimeStation_temp)
        for j = 1:length(walkingTimeStation.(sim{i})(:,1))
            if walkingTimeStation_temp(k,1) == walkingTimeStation.(sim{i})(j,1)
                walkingTimeStation_temp(k,2) = walkingTimeStation_temp(k,2) + walkingTimeStation.(sim{i})(j,2);
            end
        end
    end
    
    walkingTimeStation.(sim{i}) = walkingTimeStation_temp;
    
    filename = [];
    filename.a = sprintf('WalkingTimeStations_');
    filename.b = sprintf(whichLoop);
    filename.c = sprintf('_');
    filename.d = sprintf('%s',sim{i});
    filename.e = sprintf('.txt');
    filename = strcat(filename.a,filename.b,filename.c,filename.d,filename.e);
    writematrix(walkingTimeStation.(sim{i}), filename);

end

filename = [];
filename.a = sprintf('AccessTime_');
filename.b = sprintf(whichLoop);
filename.c = sprintf('.mat');
filename = strcat(filename.a,filename.b,filename.c);
save(filename,'walkingTime','walkingTimeStation');

clear walkingTime_temp;
clear walkingTimeStation_temp;
clear endwalkingTimeCustomerID_temp;