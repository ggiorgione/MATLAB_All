%STATION EQUILIBRIUM

clear all
clear y;
clear x;
clear prompt;

% sims = [1,3,4,6,7,9,11,12,13,14];
sims = [1,3,4,6,7,9,11,12];

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
    DTP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.RentedCarsXStation.txt'); %file name = 'myfile01.txt' 
    input = strcat(inputBaseITER,DTP);                      %merge 2 or more strings
    delimiterIn = ",";
    RentedCars = readtable(input,'Delimiter',',');
    StationCode = readtable('CSStationComas.txt','Delimiter',',');
    RentedCars = table2array (RentedCars);
    StationCode.X = [];
    StationCode.Y = [];
    StationCode = table2array(StationCode);
    
    for i=1:numel(StationCode(:,1))
        for j=1:numel(RentedCars(:,1))
            if RentedCars(j,2) == StationCode(i,1)
                RentedCars(j,3) = StationCode(i,2);
            end
        end
    end
    
    RentedCars = sortrows(RentedCars,3);
    
    for k=1:numel(RentedCars(:,1))
        if RentedCars(k,3) == Berlin
%             if numel(RentedCarsEva(1,:)) == 4 && y>1
%                 RentedCarsEva(:,4) = [];
%             end
            RentedCarsEva(k,:) = RentedCars(k,:);
        end
    end
    Temp = RentedCarsEva;
    RentedCarsEvaTemp = nonzeros(RentedCarsEva);
    RentedCarsEva = reshape(RentedCarsEvaTemp,[],3);
    
    Steps = [];
    for l=1:numel(RentedCarsEva(:,1))
        Steps(l,1) = l;
    end
    
    RentedCarsEva(:,4) = Steps;
    
    %-------------------------------------------------------------------------
    %Ariane
    %-------------------------------------------------------------------------
    
    A=unique(RentedCarsEva(:,2));
    B=zeros(size(RentedCarsEva,1)+1,size(A,1));
    
    i=1;
    ii=1;
    
    for ii=1:size(RentedCarsEva,1)
        for i=1:size(A,1)
            if RentedCarsEva(ii,2)==A(i)
                B(ii+1,i)=B(ii,i)+1;
            else
                B(ii+1,i)=B(ii,i);
            end
            
        end
        i=1;
    end
    
    RentedCarsEva = [];
    
    
    A = num2str(A);
    StationID = "StationID";
    A = StationID + A;
    figure
    plot(B)
    filename1 = sprintf("Car Rent Distribution%i",y);
    title(filename1);
    hold on
    xlabel('Time Step');
    ylabel('Vehicles Cumulative');
    legend(A,'Location','northwest');
    filename = sprintf('Car Rent Distribution%i.png',y);
    saveas(gca,filename);
    hold off
    
end
