%EVALUATE REVENUE FOR THE COMPANY
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
    DTP = strcat(num2str(ITERS),'/run1.',num2str(ITERS),'.RentalCost.txt'); %file name = 'myfile01.txt' 
    input = strcat(inputBaseITER,DTP);                      %merge 2 or more strings
    delimiterIn = ",";

    if y==1  
        Revenue1 = readtable(input,'Delimiter',',');
        Revenue1 = table2array(Revenue1);
        filename = sprintf('Revenue%i.mat',y);
        save(filename,'Revenue1');
        %Total Revenue
        RevenueSUM1 = sum(Revenue1(:,3));
        RevenueSUM1 = sprintf('%.2f',RevenueSUM1);
        filename = sprintf('RevenueSum%i.mat',y);
        save(filename,'RevenueSUM1');
        %Revenue X VehicleID
        [VehicleUnique,~,idx] = unique(Revenue1(:,2));
        nu = numel(VehicleUnique);
        RevenueXVeh1 = zeros(nu,size(Revenue1,2));
        for ii = 1:nu
            RevenueXVeh1(ii,:) = sum(Revenue1(idx==ii,3));
        end
        RevenueXVeh1(:,2) = VehicleUnique;
        RevenueXVeh1 = [RevenueXVeh1(:,2) RevenueXVeh1(:,3)];
        filename = sprintf('RevenueXVeh%i.mat',y);
        save(filename,'RevenueXVeh1');
    else
        if y==2  
            Revenue2 = readtable(input,'Delimiter',',');
            Revenue2 = table2array(Revenue2);
            filename = sprintf('Revenue%i.mat',y);
            save(filename,'Revenue2');
            %Total Revenue
            RevenueSUM2 = sum(Revenue2(:,3));
            RevenueSUM2 = sprintf('%.2f',RevenueSUM2);
            filename = sprintf('RevenueSum%i.mat',y);
            save(filename,'RevenueSUM2');
            %Revenue X VehicleID
            [VehicleUnique,~,idx] = unique(Revenue2(:,2));
            nu = numel(VehicleUnique);
            RevenueXVeh2 = zeros(nu,size(Revenue2,2));
            for ii = 1:nu
                RevenueXVeh2(ii,:) = sum(Revenue2(idx==ii,3));
            end
            RevenueXVeh2(:,2) = VehicleUnique;
            RevenueXVeh2 = [RevenueXVeh2(:,2) RevenueXVeh2(:,3)];
            filename = sprintf('RevenueXVeh%i.mat',y);
            save(filename,'RevenueXVeh2');
        else
            if y==3  
                Revenue3 = readtable(input,'Delimiter',',');
                Revenue3 = table2array(Revenue3);
                filename = sprintf('Revenue%i.mat',y);
                save(filename,'Revenue3');
                %Total Revenue
                RevenueSUM3 = sum(Revenue3(:,3));
                RevenueSUM3 = sprintf('%.2f',RevenueSUM3);
                filename = sprintf('RevenueSum%i.mat',y);
                save(filename,'RevenueSUM3');
                %Revenue X VehicleID
                [VehicleUnique,~,idx] = unique(Revenue3(:,2));
                nu = numel(VehicleUnique);
                RevenueXVeh3 = zeros(nu,size(Revenue3,2));
                for ii = 1:nu
                    RevenueXVeh3(ii,:) = sum(Revenue3(idx==ii,3));
                end
                RevenueXVeh3(:,2) = VehicleUnique;
                RevenueXVeh3 = [RevenueXVeh3(:,2) RevenueXVeh3(:,3)];
                filename = sprintf('RevenueXVeh%i.mat',y);
                save(filename,'RevenueXVeh3');
            else
                if y==4  
                    Revenue4 = readtable(input,'Delimiter',',');
                    Revenue4 = table2array(Revenue4);
                    filename = sprintf('Revenue%i.mat',y);
                    save(filename,'Revenue4');
                    %Total Revenue
                    RevenueSUM4 = sum(Revenue4(:,3));
                    RevenueSUM4 = sprintf('%.2f',RevenueSUM4);
                    filename = sprintf('RevenueSum%i.mat',y);
                    save(filename,'RevenueSUM4');
                    %Revenue X VehicleID
                    [VehicleUnique,~,idx] = unique(Revenue4(:,2));
                    nu = numel(VehicleUnique);
                    RevenueXVeh4 = zeros(nu,size(Revenue4,2));
                    for ii = 1:nu
                        RevenueXVeh4(ii,:) = sum(Revenue4(idx==ii,3));
                    end
                    RevenueXVeh4(:,2) = VehicleUnique;
                    RevenueXVeh4 = [RevenueXVeh4(:,2) RevenueXVeh4(:,3)];
                    filename = sprintf('RevenueXVeh%i.mat',y);
                    save(filename,'RevenueXVeh4');
                else
                    if y==5  
                        Revenue5 = readtable(input,'Delimiter',',');
                        Revenue5 = table2array(Revenue5);
                        %Total Revenue
                        RevenueSUM5 = sum(Revenue5(:,3));
                        RevenueSUM5 = sprintf('%.2f',RevenueSUM5);
                        filename = sprintf('RevenueSum%i.mat',y);
                        save(filename,'RevenueSUM5');
                        %Revenue X VehicleID
                        [VehicleUnique,~,idx] = unique(Revenue5(:,2));
                        nu = numel(VehicleUnique);
                        RevenueXVeh5 = zeros(nu,size(Revenue5,2));
                        for ii = 1:nu
                            RevenueXVeh5(ii,:) = sum(Revenue5(idx==ii,3));
                        end
                        RevenueXVeh5(:,2) = VehicleUnique;
                        RevenueXVeh5 = [RevenueXVeh5(:,2) RevenueXVeh5(:,3)];
                        filename = sprintf('RevenueXVeh%i.mat',y);
                        save(filename,'RevenueXVeh5');
                    else
                        if y==6  
                            Revenue6 = readtable(input,'Delimiter',',');
                            Revenue6 = table2array(Revenue6);
                            filename = sprintf('Revenue%i.mat',y);
                            save(filename,'Revenue6');
                            %Total Revenue
                            RevenueSUM6 = sum(Revenue6(:,3));
                            RevenueSUM6 = sprintf('%.2f',RevenueSUM6);
                            filename = sprintf('RevenueSum%i.mat',y);
                            save(filename,'RevenueSUM6');
                            %Revenue X VehicleID
                            [VehicleUnique,~,idx] = unique(Revenue6(:,2));
                            nu = numel(VehicleUnique);
                            RevenueXVeh6 = zeros(nu,size(Revenue6,2));
                            for ii = 1:nu
                                RevenueXVeh6(ii,:) = sum(Revenue6(idx==ii,3));
                            end
                            RevenueXVeh6(:,2) = VehicleUnique;
                            RevenueXVeh6 = [RevenueXVeh6(:,2) RevenueXVeh6(:,3)];
                            filename = sprintf('RevenueXVeh%i.mat',y);
                            save(filename,'RevenueXVeh6');
                        else
                            if y==7  
                                Revenue7 = readtable(input,'Delimiter',',');
                                Revenue7 = table2array(Revenue7);
                                filename = sprintf('Revenue%i.mat',y);
                                save(filename,'Revenue7');
                                %Total Revenue
                                RevenueSUM7 = sum(Revenue7(:,3));
                                RevenueSUM7 = sprintf('%.2f',RevenueSUM7);
                                filename = sprintf('RevenueSum%i.mat',y);
                                save(filename,'RevenueSUM7');
                                %Revenue X VehicleID
                                [VehicleUnique,~,idx] = unique(Revenue7(:,2));
                                nu = numel(VehicleUnique);
                                RevenueXVeh7 = zeros(nu,size(Revenue7,2));
                                for ii = 1:nu
                                    RevenueXVeh7(ii,:) = sum(Revenue7(idx==ii,3));
                                end
                                RevenueXVeh7(:,2) = VehicleUnique;
                                RevenueXVeh7 = [RevenueXVeh7(:,2) RevenueXVeh7(:,3)];
                                filename = sprintf('RevenueXVeh%i.mat',y);
                                save(filename,'RevenueXVeh7');
                            else
                               if y==8  
                                    Revenue8 = readtable(input,'Delimiter',',');
                                    Revenue8 = table2array(Revenue8);
                                    %Total Revenue
                                    RevenueSUM8 = sum(Revenue8(:,3));
                                    RevenueSUM8 = sprintf('%.2f',RevenueSUM8);
                                    filename = sprintf('RevenueSum%i.mat',y);
                                    save(filename,'RevenueSUM8');
                                    %Revenue X VehicleID
                                    [VehicleUnique,~,idx] = unique(Revenue8(:,2));
                                    nu = numel(VehicleUnique);
                                    RevenueXVeh8 = zeros(nu,size(Revenue8,2));
                                    for ii = 1:nu
                                        RevenueXVeh8(ii,:) = sum(Revenue8(idx==ii,3));
                                    end
                                    RevenueXVeh8(:,2) = VehicleUnique;
                                    RevenueXVeh8 = [RevenueXVeh8(:,2) RevenueXVeh8(:,3)];
                                    filename = sprintf('RevenueXVeh%i.mat',y);
                                    save(filename,'RevenueXVeh8');
                               else
                                    if y==9  
                                        Revenue9 = readtable(input,'Delimiter',',');
                                        Revenue9 = table2array(Revenue9);
                                        filename = sprintf('Revenue%i.mat',y);
                                        save(filename,'Revenue9');
                                        %Total Revenue
                                        RevenueSUM9 = sum(Revenue9(:,3));
                                        RevenueSUM9 = sprintf('%.2f',RevenueSUM9);
                                        filename = sprintf('RevenueSum%i.mat',y);
                                        save(filename,'RevenueSUM9');
                                        %Revenue X VehicleID
                                        [VehicleUnique,~,idx] = unique(Revenue9(:,2));
                                        nu = numel(VehicleUnique);
                                        RevenueXVeh9 = zeros(nu,size(Revenue9,2));
                                        for ii = 1:nu
                                            RevenueXVeh9(ii,:) = sum(Revenue9(idx==ii,3));
                                        end
                                        RevenueXVeh9(:,2) = VehicleUnique;
                                        RevenueXVeh9 = [RevenueXVeh9(:,2) RevenueXVeh9(:,3)];
                                        filename = sprintf('RevenueXVeh%i.mat',y);
                                        save(filename,'RevenueXVeh9');
                                    else
                                        if y==11  
                                            Revenue11 = readtable(input,'Delimiter',',');
                                            Revenue11 = table2array(Revenue11);
                                            filename = sprintf('Revenue%i.mat',y);
                                            save(filename,'Revenue11');
                                            %Total Revenue
                                            RevenueSUM11 = sum(Revenue11(:,3));
                                            RevenueSUM11 = sprintf('%.2f',RevenueSUM11);
                                            filename = sprintf('RevenueSum%i.mat',y);
                                            save(filename,'RevenueSUM11');
                                            %Revenue X VehicleID
                                            [VehicleUnique,~,idx] = unique(Revenue11(:,2));
                                            nu = numel(VehicleUnique);
                                            RevenueXVeh11 = zeros(nu,size(Revenue11,2));
                                            for ii = 1:nu
                                                RevenueXVeh11(ii,:) = sum(Revenue11(idx==ii,3));
                                            end
                                            RevenueXVeh11(:,2) = VehicleUnique;
                                            RevenueXVeh11 = [RevenueXVeh11(:,2) RevenueXVeh11(:,3)];
                                            filename = sprintf('RevenueXVeh%i.mat',y);
                                            save(filename,'RevenueXVeh11');
                                        else
                                           if y==12  
                                                Revenue12 = readtable(input,'Delimiter',',');
                                                Revenue12 = table2array(Revenue12);
                                                filename = sprintf('Revenue%i.mat',y);
                                                save(filename,'Revenue12');
                                                %Total Revenue
                                                RevenueSUM12 = sum(Revenue12(:,3));
                                                RevenueSUM12 = sprintf('%.2f',RevenueSUM12);
                                                filename = sprintf('RevenueSum%i.mat',y);
                                                save(filename,'RevenueSUM12');
                                                %Revenue X VehicleID
                                                [VehicleUnique,~,idx] = unique(Revenue12(:,2));
                                                nu = numel(VehicleUnique);
                                                RevenueXVeh12 = zeros(nu,size(Revenue12,2));
                                                for ii = 1:nu
                                                    RevenueXVeh12(ii,:) = sum(Revenue12(idx==ii,3));
                                                end
                                                RevenueXVeh12(:,2) = VehicleUnique;
                                                RevenueXVeh12 = [RevenueXVeh12(:,2) RevenueXVeh12(:,3)];
                                                filename = sprintf('RevenueXVeh%i.mat',y);
                                                save(filename,'RevenueXVeh12');
                                           else
                                                if y==13  
                                                    Revenue13 = readtable(input,'Delimiter',',');
                                                    Revenue13 = table2array(Revenue13);
                                                    filename = sprintf('Revenue%i.mat',y);
                                                    save(filename,'Revenue13');
                                                    %Total Revenue
                                                    RevenueSUM13 = sum(Revenue13(:,3));
                                                    RevenueSUM13 = sprintf('%.2f',RevenueSUM13);
                                                    filename = sprintf('RevenueSum%i.mat',y);
                                                    save(filename,'RevenueSUM13');
                                                    %Revenue X VehicleID
                                                    [VehicleUnique,~,idx] = unique(Revenue13(:,2));
                                                    nu = numel(VehicleUnique);
                                                    RevenueXVeh13 = zeros(nu,size(Revenue13,2));
                                                    for ii = 1:nu
                                                        RevenueXVeh13(ii,:) = sum(Revenue13(idx==ii,3));
                                                    end
                                                    RevenueXVeh13(:,2) = VehicleUnique;
                                                    RevenueXVeh13 = [RevenueXVeh13(:,2) RevenueXVeh13(:,3)];
                                                    filename = sprintf('RevenueXVeh%i.mat',y);
                                                    save(filename,'RevenueXVeh13');
                                                else
                                                    if y==14  
                                                        Revenue14 = readtable(input,'Delimiter',',');
                                                        Revenue14 = table2array(Revenue14);
                                                        filename = sprintf('Revenue%i.mat',y);
                                                        save(filename,'Revenue14');
                                                        %Total Revenue
                                                        RevenueSUM14 = sum(Revenue14(:,3));
                                                        RevenueSUM14 = sprintf('%.2f',RevenueSUM14);
                                                        filename = sprintf('RevenueSum%i.mat',y);
                                                        save(filename,'RevenueSUM14');
                                                        %Revenue X VehicleID
                                                        [VehicleUnique,~,idx] = unique(Revenue14(:,2));
                                                        nu = numel(VehicleUnique);
                                                        RevenueXVeh14 = zeros(nu,size(Revenue14,2));
                                                        for ii = 1:nu
                                                            RevenueXVeh14(ii,:) = sum(Revenue14(idx==ii,3));
                                                        end
                                                        RevenueXVeh14(:,2) = VehicleUnique;
                                                        RevenueXVeh14 = [RevenueXVeh14(:,2) RevenueXVeh14(:,3)];
                                                        filename = sprintf('RevenueXVeh%i.mat',y);
                                                        save(filename,'RevenueXVeh14');
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
        end
    end


end
