%dataPath = 'Users/giulio.giorgione/Eclipse-MATSim/STREAMS/CarsharingStationLocationOply.xlsx';
CarsXStationNo = 1; %Number of Cars per Station

indent1 = '<?xml version="1.0" encoding="utf-8"?>';
indent2 = '<!DOCTYPE companies SYSTEM "src/main/resources/dtd/CarsharingStations.dtd">';
indent3 = '<companies>';
indent4 = '<company name="Oply">';

out1 = '';
out2 = '</company>';
out3 = '</companies>';

fileID = fopen('CarsharingStationsOply.txt', 'w');
String = num2str(indent1);
fprintf(fileID,'%s\n',indent1,indent2);
fprintf(fileID,'%s\n\t',indent3);
fprintf(fileID,'%s\n\t\t',indent4);

[null,Text,Raw]=xlsread('Stations4MATLAB.xlsx');  %Import table from excel                                                   %added for OPLY
StationsLocation = Stations4MATLAB;
%StationsLocation = Raw((2:1588),(1:2));                         %Highlight the locations
%StationsLocation = strrep(StationsLocation,',','.');            %Replace , with .

k = (1:1:CarsXStationNo*numel(StationsLocation(:,1)));  %numel(StationsLocation(:,1) = Number of Stations
k = vec2mat(k,CarsXStationNo);                          %Matrix k generation to assign vehicleID in the next step

if isfile('VehicleIDOply.txt')                          %Check if a stationID file exists otherwise creates VehiclesID
    vehicleID = fopen('VehicleIDOply.txt');                       %Overwrite the ID creation in case an ID file already exist
    vehicleID = fscanf(vehicleID,'%d');
%    vehicleID = num2str(vehicleID);
else
    for i = 1:1:numel(StationsLocation(:,1))    
        for j = 1:1:(CarsXStationNo)
            vehicleID(j,i) = "5457"+k(i,j);     %Generates all the VehiclesID
        end
    end
end


 for i = 1:1:numel(StationsLocation(:,1))
     stationID=num2str(i);
     
     id0 = '';
     id1a = '<twoway id="';
     id1b = stationID;
     id1c = '" x="';
     id1d = cell2mat(StationsLocation(i,1));
     id1f = '" y="';
     id1g = cell2mat(StationsLocation(i,2));
     id1h = '" >';
     
     fprintf(fileID,'%s',id1a,id1b,id1c,id1d,id1f,id1g);
     fprintf(fileID,'%s\n\t\t',id1h); 
     
     id2a = '     <vehicle type="car" vehicleID="'; 
     id2b = num2str(vehicleID(i));
     id2c = '" />';

     fprintf(fileID,'%s',id2a,id2b);
     fprintf(fileID,'%s\n\t\t',id2c);
     
     id3 = '</twoway>';
     fprintf(fileID,'%s\n\t\t',id3);
 end

fprintf(fileID,'%s\n\t',out1);
fprintf(fileID,'%s\n',out2);
fprintf(fileID,'%s\n',out3);

fclose('all');

