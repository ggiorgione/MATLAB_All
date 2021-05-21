%AVERAGE COST PER VOT

%EVALUATE REVENUE FOR THE COMPANY
clear all
clear y;
clear x;
clear prompt;

sims = [1,3,4,6,7,9,11,12,13,14];

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
    x = 100;
    ITERS=x;

    load VOT_ID.mat;
    VOT_ID= str2double(VOT_ID);

    %Read file with driving and booking time

    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/test%i/',y);
    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/vot1/test%i/',y);
    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/vot20/test%i/',y);
    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/cost5/test%i/',y);
    % inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/cost20/test%i/',y);
%     inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/testWrong/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
%     inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/testWrong-10/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
    inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/testRight/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
%     inputBase = sprintf('/Users/giulio.giorgione/Documents/STREAMS/ArticleTRB/testRight-10/test%i/output/org/matsim/contrib/carsharing/runExample/RunCarsharingTest/',y);
    
    inputBaseITER = strcat(inputBase,'ITERS/it.');
%     inputBaseITER = strcat(inputBase,'it.');


    %Retrieves data from the .txt file and puts it in a rectangular matrix
    DTP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.RentalCost.txt'); %file name = 'myfile01.txt' 
    input = strcat(inputBaseITER,DTP);                      %merge 2 or more strings
    delimiterIn = ",";

    if y==1  
        Revenue1 = readtable(input,'Delimiter',',');
        Revenue1 = table2array(Revenue1);

        %Add the VOT to the Revenue
        Revenue1 = sortrows(Revenue1,1);                      %Sort by the ID
        VOT_ID_Rented = ismember(VOT_ID,Revenue1);               %Check same ID in VOT_ID and AccessTime
        VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
        VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
        VOT_ID_Rented = VOT_ID_Rented';
        VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
        VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
        VOT_ID_Rented = VOT_ID_Rented';
        VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
        Revenue1 = Revenue1(1:numel(VOT_ID_Rented(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
        Revenue_VOT = [Revenue1 VOT_ID_Rented(:,2)];         %Put them together
        Revenue_VOT_1 = sortrows(Revenue_VOT,3,'ascend');     %sort by the VOT

        filename = sprintf('RevenueVOT%i.mat',y);
        save(filename,'Revenue_VOT_1');
    else
        if y==3  
        Revenue3 = readtable(input,'Delimiter',',');
        Revenue3 = table2array(Revenue3);

        %Add the VOT to the Revenue
        Revenue3 = sortrows(Revenue3,1);                      %Sort by the ID
        VOT_ID_Rented = ismember(VOT_ID,Revenue3);               %Check same ID in VOT_ID and AccessTime
        VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
        VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
        VOT_ID_Rented = VOT_ID_Rented';
        VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
        VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
        VOT_ID_Rented = VOT_ID_Rented';
        VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
        VOT_ID_Rented = VOT_ID_Rented(1:numel(Revenue3(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
        Revenue_VOT = [Revenue3 VOT_ID_Rented(:,2)];         %Put them together
        Revenue_VOT_3 = sortrows(Revenue_VOT,3,'ascend');     %sort by the VOT

        filename = sprintf('RevenueVOT%i.mat',y);
        save(filename,'Revenue_VOT_3');
        else
            if y==4  
            Revenue4 = readtable(input,'Delimiter',',');
            Revenue4 = table2array(Revenue4);

            %Add the VOT to the Revenue
            Revenue4 = sortrows(Revenue4,1);                      %Sort by the ID
            VOT_ID_Rented = ismember(VOT_ID,Revenue4);               %Check same ID in VOT_ID and AccessTime
            VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
            VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
            VOT_ID_Rented = VOT_ID_Rented';
            VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
            VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
            VOT_ID_Rented = VOT_ID_Rented';
            VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
            Revenue4 = Revenue4(1:numel(VOT_ID_Rented(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
            Revenue_VOT = [Revenue4 VOT_ID_Rented(:,2)];         %Put them together
            Revenue_VOT_4 = sortrows(Revenue_VOT,3,'ascend');     %sort by the VOT

            filename = sprintf('RevenueVOT%i.mat',y);
            save(filename,'Revenue_VOT_4');
            else
                if y==6  
                Revenue6 = readtable(input,'Delimiter',',');
                Revenue6 = table2array(Revenue6);

                %Add the VOT to the Revenue
                Revenue6 = sortrows(Revenue6,1);                      %Sort by the ID
                VOT_ID_Rented = ismember(VOT_ID,Revenue6);               %Check same ID in VOT_ID and AccessTime
                VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
                VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
                VOT_ID_Rented = VOT_ID_Rented';
                VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
                VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
                VOT_ID_Rented = VOT_ID_Rented';
                VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
                VOT_ID_Rented = VOT_ID_Rented(1:numel(Revenue6(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
                Revenue_VOT = [Revenue6 VOT_ID_Rented(:,2)];         %Put them together
                Revenue_VOT_6 = sortrows(Revenue_VOT,3,'ascend');     %sort by the VOT

                filename = sprintf('RevenueVOT%i.mat',y);
                save(filename,'Revenue_VOT_6');
                else
                    if y==7  
                    Revenue7 = readtable(input,'Delimiter',',');
                    Revenue7 = table2array(Revenue7);

                    %Add the VOT to the Revenue
                    Revenue7 = sortrows(Revenue7,1);                      %Sort by the ID
                    VOT_ID_Rented = ismember(VOT_ID,Revenue7);               %Check same ID in VOT_ID and AccessTime
                    VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
                    VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
                    VOT_ID_Rented = VOT_ID_Rented';
                    VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
                    VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
                    VOT_ID_Rented = VOT_ID_Rented';
                    VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
                    Revenue7 = Revenue7(1:numel(VOT_ID_Rented(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
                    Revenue_VOT = [Revenue7 VOT_ID_Rented(:,2)];         %Put them together
                    Revenue_VOT_7 = sortrows(Revenue_VOT,3,'ascend');     %sort by the VOT

                    filename = sprintf('RevenueVOT%i.mat',y);
                    save(filename,'Revenue_VOT_7');

                    else
                        if y==9  
                        Revenue9 = readtable(input,'Delimiter',',');
                        Revenue9 = table2array(Revenue9);

                        %Add the VOT to the Revenue
                        Revenue9 = sortrows(Revenue9,1);                      %Sort by the ID
                        VOT_ID_Rented = ismember(VOT_ID,Revenue9);               %Check same ID in VOT_ID and AccessTime
                        VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
                        VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
                        VOT_ID_Rented = VOT_ID_Rented';
                        VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
                        VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
                        VOT_ID_Rented = VOT_ID_Rented';
                        VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
                        VOT_ID_Rented = VOT_ID_Rented(1:numel(Revenue9(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
                        Revenue_VOT = [Revenue9 VOT_ID_Rented(:,2)];         %Put them together
                        Revenue_VOT_9 = sortrows(Revenue_VOT,3,'ascend');     %sort by the VOT

                        filename = sprintf('RevenueVOT%i.mat',y);
                        save(filename,'Revenue_VOT_9');
                        else
                            if y==11  
                            Revenue11 = readtable(input,'Delimiter',',');
                            Revenue11 = table2array(Revenue11);

                            %Add the VOT to the Revenue
                            Revenue11 = sortrows(Revenue11,1);                      %Sort by the ID
                            VOT_ID_Rented = ismember(VOT_ID,Revenue11);               %Check same ID in VOT_ID and AccessTime
                            VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
                            VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
                            VOT_ID_Rented = VOT_ID_Rented';
                            VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
                            VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
                            VOT_ID_Rented = VOT_ID_Rented';
                            VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
                            Revenue11 = Revenue11(1:numel(VOT_ID_Rented(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
                            Revenue_VOT = [Revenue11 VOT_ID_Rented(:,2)];         %Put them together
                            Revenue_VOT_11 = sortrows(Revenue_VOT,3,'ascend');     %sort by the VOT

                            filename = sprintf('RevenueVOT%i.mat',y);
                            save(filename,'Revenue_VOT_11');
                            else
                                if y==12  
                                Revenue12 = readtable(input,'Delimiter',',');
                                Revenue12 = table2array(Revenue12);

                                %Add the VOT to the Revenue
                                Revenue12 = sortrows(Revenue12,1);                      %Sort by the ID
                                VOT_ID_Rented = ismember(VOT_ID,Revenue12);               %Check same ID in VOT_ID and AccessTime
                                VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
                                VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
                                VOT_ID_Rented = VOT_ID_Rented';
                                VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
                                VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
                                VOT_ID_Rented = VOT_ID_Rented';
                                VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
                                VOT_ID_Rented = VOT_ID_Rented(1:numel(Revenue12(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
                                Revenue_VOT = [Revenue12 VOT_ID_Rented(:,2)];         %Put them together
                                Revenue_VOT_12 = sortrows(Revenue_VOT,3,'ascend');     %sort by the VOT

                                filename = sprintf('RevenueVOT%i.mat',y);
                                save(filename,'Revenue_VOT_12');
                                else                                  
                                    if y==13  
                                    Revenue13 = readtable(input,'Delimiter',',');
                                    Revenue13 = table2array(Revenue13);

                                    %Add the VOT to the Revenue
                                    Revenue13 = sortrows(Revenue13,1);                      %Sort by the ID
                                    VOT_ID_Rented = ismember(VOT_ID,Revenue13);               %Check same ID in VOT_ID and AccessTime
                                    VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
                                    VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
                                    VOT_ID_Rented = VOT_ID_Rented';
                                    VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
                                    VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
                                    VOT_ID_Rented = VOT_ID_Rented';
                                    VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
                                    Revenue13 = Revenue13(1:numel(VOT_ID_Rented(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
                                    Revenue_VOT = [Revenue13 VOT_ID_Rented(:,2)];         %Put them together
                                    Revenue_VOT_13 = sortrows(Revenue_VOT,3,'ascend');     %sort by the VOT

                                    filename = sprintf('RevenueVOT%i.mat',y);
                                    save(filename,'Revenue_VOT_13');  
                                    else
                                        if y==14  
                                        Revenue14 = readtable(input,'Delimiter',',');
                                        Revenue14 = table2array(Revenue14);

                                        %Add the VOT to the Revenue
                                        Revenue14 = sortrows(Revenue14,1);                      %Sort by the ID
                                        VOT_ID_Rented = ismember(VOT_ID,Revenue14);               %Check same ID in VOT_ID and AccessTime
                                        VOT_ID_Rented(:,2) = VOT_ID_Rented(:,1);            
                                        VOT_ID_Rented = VOT_ID_Rented.*VOT_ID;
                                        VOT_ID_Rented = VOT_ID_Rented';
                                        VOT_ID_Rented(VOT_ID_Rented==0) = [];                       %Remove the 0s
                                        VOT_ID_Rented = reshape(VOT_ID_Rented,2,[]);                %Reshape it as before
                                        VOT_ID_Rented = VOT_ID_Rented';
                                        VOT_ID_Rented = sortrows(VOT_ID_Rented,'ascend');
                                        VOT_ID_Rented = VOT_ID_Rented(1:numel(Revenue14(:,1)),:);                                                                                  %remove if "Dimensions of arrays being concatenated are not consistent."
                                        Revenue_VOT = [Revenue14 VOT_ID_Rented(:,2)];         %Put them together
                                        Revenue_VOT_14 = sortrows(Revenue_VOT,3,'ascend');     %sort by the VOT

                                        filename = sprintf('RevenueVOT%i.mat',y);
                                        save(filename,'Revenue_VOT_14');
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    
end