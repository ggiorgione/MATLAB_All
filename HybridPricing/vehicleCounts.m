load VehiclesID.mat

a = 0;
for i = 1:length(vehiclesID)
    if ~isnan(vehiclesID(i,:))
        a(i) = a(i)+1;
        a(i+1) = 0;
    else
        a(i+1) = 0;
        continue
    end
end

StationsID = unique(round(vehiclesID(~isnan(vehiclesID)),-1)/10);

y = cumsum(a==0 | [true,a(1:end-1)==0]);
z = accumarray(y(:),a(:));

indices = find(z(:,1)==0);
z(indices,:) = [];

zSUM = sum(z);
zAVG = mean(z);

StationsAndVehiclesNumber = [StationsID z];
writematrix(StationsAndVehiclesNumber,'StationsAndVehiclesNumber.txt');