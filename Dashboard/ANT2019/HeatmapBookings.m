%Heatmap Bookings

clear all
clear y;
clear x;
clear prompt;

% sims = [1,3,4,6,7,9,11,12,13,14];
%sims = [1,3,4,6,7,9,11,12];
sims = [4,7];

    load VOT_ID.mat;
    VOT_ID= str2double(VOT_ID);

for y=sims
    %Output for every simulation:
    %Driving time matrix
    %Total driving time
    %Booking time matrix
    %Total booking time
    %Total distance travelled
    %Vehicle X Km
    %Differential in Starting Time "SRS"
    %Fleet utilization in Veh X #usage
    %Access times
    %Total access time

    % %Asks to the user the name of the simulation
    % prompt = 'Enter the simulation Number: ';
    % y = input(prompt);
    % 
    % %Asks to the user the iterations number as reported in the Config.xml file from MATSim
    % prompt = 'Enter the numer of Iterations as reported in the Config.xml file from MATSim: ';
    % x = input(prompt);
    x = 500;
    ITERS=x;



    %Read file with driving and booking time

    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/test%i/',y);
    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/vot1/test%i/',y);
    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/vot20/test%i/',y);
    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/cost5/test%i/',y);
    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/cost20/test%i/',y);
%     inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/testWrong/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
%     inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/testWrong-10/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
%     inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/testRight/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
%     inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/testRight-10/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
        inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/testfin/test%i/',y);

%     inputBaseITER = strcat(inputBase,'ITERS/it.');
    inputBaseITER = strcat(inputBase,'it.');

    %Retrieves data from the .txt file and puts it in a rectangular matrix
    DTP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.RentalCost.txt'); %file name = 'myfile01.txt' 
    input = strcat(inputBaseITER,DTP);                      %merge 2 or more strings
    delimiterIn = ",";
    
    Bookings = readtable(input,'Delimiter',',');
    Bookings.carID = [];
    Bookings.cost = [];
    Bookings = table2array(Bookings);
    Bookings = sortrows(Bookings);
    
    HMBookings = ismember(lineIDs10pctXYIDdouble,Bookings);
    for jj = 1:numel(HMBookings(:,1))
        if HMBookings(jj,1) == 1
            HMBookings(jj,2) = 1;
            HMBookings(jj,3) = 1;
        end
    end
    HMBookings = HMBookings .* lineIDs10pctXYIDdouble;
%     HMBookings(HMBookings==0) = [];
%     HMBookings = reshape(HMBookings,[numel(HMBookings(1,:)),numel(Bookings(:,1))]');
    
    filename = sprintf('IDXYBookings%i.xlsx',y);
    xlswrite(filename,HMBookings);
%     fileID = fopen(filename,'w');
%     fprintf(fileID,'%f,%f,%f\n',HMBookings);
%     fclose('all')
    
end
    
    
    