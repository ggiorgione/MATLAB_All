%% Vehicles Utilization

load VehiclesID.mat
load StationsAndVehiclesNumber.mat

for i = 1:length(sim)

    input.CS1 = sprintf('/Users/giulio.giorgione/Documents/MATLAB/HybridPricing/');
    input.CS2 = whichLoop;
    input.CS3 = sprintf('/run1.500.CS_');
    input.CS4 = sprintf('%s',sim{i});
    input.CS5 = sprintf('.txt');
    inputCS = strcat(input.CS1,input.CS2,input.CS3,input.CS4,input.CS5);
    delimiterIn = ",";
    CS = readtable(inputCS,'Delimiter',',');
    
    vehiclesUsed.(sim{i})(:,1) = CS.vehicleID;
    vehiclesUsed.(sim{i})(:,2) = CS.bookingTime;
    vehiclesUsed.(sim{i}) = sortrows((vehiclesUsed.(sim{i})),1,'ascend');

    
    vehiclesUsed_temp = [];
    vehiclesUsed_temp(:,1) = unique(vehiclesUsed.(sim{i})(:,1));
    vehiclesUsed_temp(:,2) = 0;
    
    for k = 1:length(vehiclesUsed_temp)
        for j = 1:length(vehiclesUsed.(sim{i})(:,1))
            if vehiclesUsed_temp(k,1) == vehiclesUsed.(sim{i})(j,1)
                vehiclesUsed_temp(k,2) = vehiclesUsed_temp(k,2) + vehiclesUsed.(sim{i})(j,2);
            end
        end
    end
    
    vehiclesUsedSum.(sim{i})(:,1) = vehiclesUsed_temp(:,1);
    vehiclesUsedSum.(sim{i})(:,2) = vehiclesUsed_temp(:,2);
    vehiclesUsedSum.(sim{i})(:,3) = 24*60*60;
    vehiclesUsedSum.(sim{i})(:,4) = round((vehiclesUsedSum.(sim{i})(:,2)./vehiclesUsedSum.(sim{i})(:,3))*100,2);        % Utilizzo sulla giornata (divided by 24 hours)
    vehiclesUsedSum.(sim{i})(:,5) = round((vehiclesUsedSum.(sim{i})(:,2)./sum(vehiclesUsedSum.(sim{i})(:,2)))*100,2);   % Utilizzo sul totale compresi gli altri veicoli (divided by all the cumulative time)
    vehiclesUsedSum.(sim{i}) = sortrows(vehiclesUsedSum.(sim{i}),4,'descend');
end

filename = [];
filename.a = sprintf('VehiclesUtilization_');
filename.b = sprintf(whichLoop);
filename.c = sprintf('.mat');
filename = strcat(filename.a,filename.b,filename.c);
save(filename,'vehiclesUsedSum');

%% Station Utilization

for i = 1:length(sim)
    StationsUsed.(sim{i}) = round(vehiclesUsedSum.(sim{i})(:,1),-1)/10;
    StationsUsed.(sim{i})(:,2) = vehiclesUsedSum.(sim{i})(:,2);

    StationsUsed.(sim{i}) = sortrows((StationsUsed.(sim{i})),1,'ascend');
    
    StationsUsed_temp = [];
    StationsUsed_temp(:,1) = unique(StationsUsed.(sim{i})(:,1));
    StationsUsed_temp(:,2) = 0;
    
    for k = 1:length(StationsUsed_temp)
        for j = 1:length(StationsUsed.(sim{i})(:,1))
            if StationsUsed_temp(k,1) == StationsUsed.(sim{i})(j,1)
                StationsUsed_temp(k,2) = StationsUsed_temp(k,2) + StationsUsed.(sim{i})(j,2);
            end
        end
    end
    
    actualStationsAndVehiclesNumber = [];
    
    for ii = 1:length(StationsAndVehiclesNumber)
        for j = 1:length(StationsUsed_temp)
           if StationsAndVehiclesNumber(ii,1) == StationsUsed_temp(j,1)
               actualStationsAndVehiclesNumber(ii,:) = StationsAndVehiclesNumber(ii,:);
           end
        end
    end

    actualStationsAndVehiclesNumber(actualStationsAndVehiclesNumber(:,1)==0,:) = [] ;
    
    if isequal(i,6)
        if isequal(StationsUsed.(sim{i})(20,1),1210365)
            StationsUsed.(sim{i})(20,:) = [];
        end
    end
    
    StationsUsed.(sim{i}) = [];
    StationsUsed.(sim{i})(:,1) = StationsUsed_temp(:,1);    %StationID
    StationsUsed.(sim{i})(:,2) = StationsUsed_temp(:,2);    %Booking Time Total
    if isequal(i,6) || isequal(i,7)
        if isequal(StationsUsed.(sim{i})(20,1),1210365)
            StationsUsed.(sim{i})(20,:) = [];
        end
    end
    StationsUsed.(sim{i})(:,3) = 24*60*60*actualStationsAndVehiclesNumber(:,2); %Numer of vehicles * Day Time
	StationsUsed.(sim{i})(:,4) = round((StationsUsed.(sim{i})(:,2)./StationsUsed.(sim{i})(:,3))*100,2);        % Utilizzo sulla giornata (divided by 24hours*nVehicles)
    StationsUsed.(sim{i})(:,5) = round((StationsUsed.(sim{i})(:,2)./sum(StationsUsed.(sim{i})(:,2)))*100,2);    % Utilizzo rispetto agli altri veicoli

    filename = [];
    filename.a = sprintf('StationsUtilization_');
    filename.b = sprintf(whichLoop);
    filename.c = sprintf('_');
    filename.d = sprintf('%s',sim{i});
    filename.e = sprintf('.txt');
    filename = strcat(filename.a,filename.b,filename.c,filename.d,filename.e);
    writematrix(StationsUsed.(sim{i}), filename);

end

filename = [];
filename.a = sprintf('StationsUtilization_');
filename.b = sprintf(whichLoop);
filename.c = sprintf('.mat');
filename = strcat(filename.a,filename.b,filename.c);
save(filename,'StationsUsed');

clear StationsUsed_temp
clear vehiclesUsed_temp