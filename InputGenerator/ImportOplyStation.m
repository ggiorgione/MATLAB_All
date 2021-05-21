%OPLY station import from plan trips in Berlin

[null,Text,Raw]=xlsread('Plan_Trips_Berlin_2019-04-25.xlsx');    %Import table from excel
StartCarID = Raw(:,[8 11]);
Str(strfind(StartCarID, '{"lat":"')) = [];
B = regexp(StartCarID,'[0-9]','Match');