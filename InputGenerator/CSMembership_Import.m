%%Import Membership from Berlin Membership FF RT

ID_Column = 1;
Choice_Column = 17;

%% Indentation + xml statements
line1 = '<?xml version="1.0" encoding="utf-8"?>';
line2 = '<!DOCTYPE companies SYSTEM "src/main/resources/dtd/CarsharingStations.dtd">';
line3 = '<memberships>';

out1 = '';
out2 = '</memberships>';

fileID = fopen('CSMembership.txt', 'w');
String = num2str(line1);
fprintf(fileID,'%s\n',line1);
fprintf(fileID,'%s\n\n',line2);
fprintf(fileID,'%s',line3);

%% Import carsharing tables from excel and returns a matrix ID|Choice

% [null,Text,Raw]=xlsread('/Users/giulio.giorgione/Documents/MATLAB/Berlin_Membership_FF_RT.xlsx',1);   %Import free-floating table from excel
% IDChoiceFF_all = null(:,[ID_Column,Choice_Column]);    %Slicing on ID and free-floating choice (1 no 2 yes)
% 
% [null,Text,Raw]=xlsread('/Users/giulio.giorgione/Documents/MATLAB/Berlin_Membership_FF_RT.xlsx',2);   %Import round-trip table from excel
% IDChoiceRT_all = null(:,[ID_Column,Choice_Column]);    %Slicing on ID and round-trip choice (1 no 2 yes)

IDChoiceFF_temp = IDChoiceFF_all(:,2) == 2; %Returns 1 when the membership is chosen (2 on the table IDChoiceFF_all)
IDChoiceFF=IDChoiceFF_all(IDChoiceFF_temp,:); %Returns all the members for the free-floating

IDChoiceRT_temp = IDChoiceRT_all(:,2) == 2; %Returns 1 when the membership is chosen (2 on the table IDChoiceRT_all)
IDChoiceRT=IDChoiceRT_all(IDChoiceRT_temp,:); %Returns all the members for the round-trip

%% Produce xml lines from data (ID) in IDChoiceRT
 for i = 1:1:numel(IDChoiceRT(:,1))
     
     line4 = '';
     line5 = '<person id="';
     line5b = num2str(IDChoiceRT(i,1));
     line5c = '">'
     line6 = '<company id="Oply">';
     line7 = '<carsharing name="twoway"/>';
     line8 = '</company>';
     line9 = '</person>';
     
     fprintf(fileID,'%s\n\t',line4);
     fprintf(fileID,'%s',line5);
     fprintf(fileID,'%s',line5b);
     fprintf(fileID,'%s\n\t\t',line5c);
     fprintf(fileID,'%s\n\t\t\t',line6);
     fprintf(fileID,'%s\n\t\t',line7);   
     fprintf(fileID,'%s\n\t',line8);
     fprintf(fileID,'%s\n',line9);
 end
 
 fprintf(fileID,'%s',out2);  %Prints the last line

 fclose('all');