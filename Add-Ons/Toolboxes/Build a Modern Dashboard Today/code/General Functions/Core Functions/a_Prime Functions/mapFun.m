function [d1,d2] = mapFun(type,varargin)

% -------------------------------------------------------------------------
% 'dist' - calculate distances between points
% Inputs: p1 (main point) , p2 (other points)
% Outputs: [distance, index (of p2)]
% Handles - 'type' {have,pyth}, 'find' {'min',max'}, top (double)
% -------------------------------------------------------------------------
% 'stats' get statistics of data
% inputs geo point, data of geo points, range
% outputs 'zscore' | 'mean' | 'std'
% handles 'get' {zscore,mean,std}
% -------------------------------------------------------------------------
% 'school' get statistics of data
% inputs
% outputs
% handles
% -------------------------------------------------------------------------
% 'coast' get statistics of data
% inputs
% outputs
% handles
% -------------------------------------------------------------------------
% 'square' get statistics of data
% inputs
% outputs
% handles
% -------------------------------------------------------------------------

switch type
    case 'dist', [d1,d2] = calcDist(varargin{:});
    case 'stats',d1 = getGeoStats(varargin{:});
    case 'proj',d1 = projectDist(varargin{:});
        
    case 'school', d1 = getDataBySchool(varargin{:});
    case 'income', d1 = getIncomeDatabase(varargin{:});
    case 'coast', [d1,d2] = distance2Coast(varargin{:});
    case 'rent', d1 = getRentDatabase(varargin{:});
        
    case 'square', d1 = calcSquare(varargin{:});
end


end


% Calculation Methods -----------------------------------------------------


% calculate Distance
function [d1,d2] = calcDist(varargin)
% input [latitude longitude]
% Pythagoran distance
% Haversine distance


NW = {'type','find','top'}; MW = {'have',[],[]};
s = inputMethods('adv',NW,MW,{'P1','P2'},varargin);

a1 = s.P1(:,1).*pi./180; a2 = s.P2(:,1).*pi./180;
o1 = s.P1(:,2).*pi./180; o2 = s.P2(:,2).*pi./180;

switch s.type
    case 'have',a=sin((a2-a1)./2).^2+cos(a1).*cos(a2).*sin((o2-o1)./2).^2;
                d1=12742.*atan2(sqrt(a),sqrt(1-a));
    case 'pyth',d1=6371.*sqrt(((o2-o1).*cos((a1+a2)./2)).^2+(a2-a1).^2);
end,if isempty(s.find), d2 = []; return, end
if isempty(s.top)
switch s.find
    case 'dist', return
    case 'min', [d1,d2] = min(d1);      if isempty(s.top),return, end
    case 'max', [d1,d2] = max(d1);      if isempty(s.top),return, end
    case 'all', [d1,d2] = sortrows(d1); if isempty(s.top),return, end
end
end

if strcmpi(s.find,'max'), [d1,I] = sortrows(d1,'descend'); end
if strcmpi(s.find,'min'), [d1,I] = sortrows(d1); end
if s.top > length(d1), s.top = length(d1); end
d1 = d1(1:s.top); d2 = I(1:s.top);
end


% get geographic statistics given input data
function d1 = getGeoStats(varargin)

WM = {'all',1,'on','on',3,'off'};
WN = {'get','range','parallel','filter','thresh','warning'}; 
s  = inputMethods('adv',WN,WM,{'geo','data','range'},varargin);

if strcmpi(s.warning,'off'), warning('off','all'), end
if strcmpi(s.filter,'on'), SWC = true;  else, SWC = 0; end
if strcmpi(s.parallel,'on'), Par = true; else, Par = 0; end

s = rmfield(s,'parallel'); s = rmfield(s,'filter');
[LGeo,~,ic] = unique(s.geo,'rows'); Lng = size(s.data,2);
s.size = size(LGeo,1); Std = zeros(s.size,Lng);
Mean = zeros(s.size,Lng); Zscore = zeros(s.size,Lng);


a2 = s.geo(:,1).*pi./180; % Convert & Extract Key Data
o2 = s.geo(:,2).*pi./180; s = rmfield(s,'geo');
Rng  = s.range;           s = rmfield(s,'range');
Data = s.data;            s = rmfield(s,'data');
Filt = s.thresh;

A = LGeo(:,1).*pi./180; % Convert Data
O = LGeo(:,2).*pi./180; clear LGeo
     

if Par
    parfor (i = 1:s.size,21)
        a = sin((a2-A(i))./2).^2+cos(A(i)).*cos(a2).*sin((o2-O(i))./2).^2;
        d = 12742.*atan2(sqrt(a),sqrt(1-a));
        if sum(d < Rng) == 0, continue, end
        if SWC == false
            Std(i,:)    = nanstd(Data(d < Rng,:)); %#ok
            Mean(i,:)   = nanmean(Data(d < Rng,:));
            Zscore(i,:) = Mean(i,:)/Std(i,:); else
            SI = nanstd(Data(d < Rng,:)); MI = nanmean(Data(d < Rng,:));
            IH = 1./(d<Rng)&(Data>(MI-Filt*SI))&(Data<(MI+Filt*SI));
            if nansum(nansum(IH,2)) ~= 0
                Std(i,:)    = nanstd(Data.*IH);
                Mean(i,:)   = nanmean(Data.*IH);
                Zscore(i,:) = Mean(i,:)/Std(i,:);
            end
        end
    end,else
    
    for i = 1:s.size
        a = sin((a2-A(i))./2).^2+cos(A(i)).*cos(a2).*sin((o2-O(i))./2).^2;
        d = 12742.*atan2(sqrt(a),sqrt(1-a));
        
        if SWC == false
            Std(i,:)    = nanstd(Data(d < Rng,:));
            Mean(i,:)   = nanmean(Data(d < Rng,:));
            Zscore(i,:) = Mean(i,:)/Std(i,:);  else
            SI = nanstd(Data(d < Rng,:)); MI = nanmean(Data(d < Rng,:));
            IH = 1./(d<Rng)&(Data>(MI-Filt*SI))&(Data<(MI+Filt*SI));
            Std(i,:)    = nanstd(Data.*IH);
            Mean(i,:)   = nanmean(Data.*IH);
            Zscore(i,:) = Mean(i,:)/Std(i,:);
        end
    end
end

d1.std    = Std(ic); clear Std
d1.mean   = Mean(ic); clear Mean
d1.zscore = Zscore(ic); clear Zscore


switch s.get
    case 'zscore',d1 = d1.zscore;
    case 'mean',  d1 = d1.mean;
    case 'std',   d1 = d1.std;
    case 'all'
end

end


% a vector scaled to a given distance.
function d1 = projectDist(varargin)

NW = {'type','find','top'}; MW = {'have',[],[]};
s = inputMethods('adv',NW,MW,{'P1','P2','dist'},varargin);

adj_side = s.P2(2) - s.P1(2);
opp_side = s.P2(1) - s.P1(1);
Ratio    = calcDist(s.P1,s.P2)/s.dist;

s.dist = sqrt(adj_side^2 + opp_side^2).*Ratio;

d1 = [s.P1(1) + s.dist*opp_side,s.P1(2) + s.dist*adj_side];


end



% Data retrevial  ---------------------------------------------------------


% Find the location to closest school:
function [d1,d2] = distance2Coast(varargin)

NW = {'type','find','top','plot'}; MW = {'have','min',1,'off'};
s = inputMethods('adv',NW,MW,{'P1'},varargin);

load Global_Coast_t4 % load file ---------------------------
p2 = [Geo.lat Geo.lon];


[dist,idx] = calcDist(s.P1,p2,'find',s.find,'top',s.top);
d1 = dist;
d2 = p2(idx,:);


if strcmpi(s.plot,'on'), C = ones(size(d1,1),3).*([0.0 0.45 0.74]);
    loc = [d2;s.P1];
    C = [C;0.85 0.33 0.1];
    scatter(loc(:,2),loc(:,1),45,C,'filled')
    plot_google_map('MapType','roadmap')
end


end


% Find the location to closest school:
function d1 = getDataBySchool(varargin)

NW = {'get','type','find','top','plot'}; MW = {'dist','have','min',1,'off'};
s = inputMethods('adv',NW,MW,{'P1'},varargin); s.get = cellstr(s.get);

load schooldatabaseload % load file ---------------------------
p2 = [schooldatabase.Lat schooldatabase.Lon];


[dist,idx] = calcDist(s.P1,p2,'find',s.find,'top',s.top);
loc = [p2(idx,:);s.P1];


for i = 1:length(s.get)
    switch char(s.get(i))
        
        case 'dist', d1 = dist;
        case 'name', d1 = schooldatabase.school_name(idx,:);
        case 'state',d1 = schooldatabase.State(idx,:);
        case 'city', d1 = schooldatabase.City(idx,:);
        case 'math', d1 = schooldatabase.Math_Score(idx,:);
        case 'read',    d1 = schooldatabase.Read_Score(idx,:);
        case 'county',  d1 = schooldatabase.County(idx,:);
        case 'area',    d1 = schooldatabase.Area_Code(idx,:);
        case 'zip',     d1 = schooldatabase.Zip_Code(idx,:);
            
    end
end


if strcmpi(s.plot,'on'), C = ones(size(d1,1),3).*([0.0 0.45 0.74]);
    C = [C;0.85 0.33 0.1];
    scatter(loc(:,2),loc(:,1),45,C,'filled')
    plot_google_map('MapType','roadmap')
end


end


% Find the location to closest school:
function d1 = getRentDatabase(varargin)

NW = {'get','type','find','top','plot','set','parallel','isolate','clean'};
MW = {'mean','have','min',1,'off','family','off',[],'on'};
s = inputMethods('adv',NW,MW,{'P1'},varargin); s.get = cellstr(s.get);

if strcmpi(s.set,'family')
    load grossrentdatabaseload % load file
    p2 = [GrossRent.Lat GrossRent.Lon];
    Rent = GrossRent; clear GrossRent
end

if isempty(s.isolate) == 0
    if strcmpi(s.isolate,'tracks')
        Rent(ismember(Rent.Primary,'Track') == 0,:) = [];
    else
        Rent(ismember(Rent.Primary,'Track'),:) = [];
    end
end

if strcmpi(s.clean,'on')
   Rent(Rent.Mean == 0,:) = [];
end


num_Pnts = size(s.P1,1);
num_gets = length(s.get); d1 = zeros(num_Pnts,num_gets);
if num_Pnts ~= 1, if s.top ~= 1, s.top = 1; disp('top set to one'),end,end


if strcmpi(s.parallel,'on'), P1 = s.P1; Find = s.find;
    Top = s.top; Get = s.get;
    parfor k = 1:num_Pnts
        [dist,idx] = calcDist(P1(k,:),p2,'find',Find,'top',Top);
        d1(k,:)    = DataExtraction(Rent,Get,dist,idx,num_gets);
    end
else
    for k = 1:num_Pnts
        [dist,idx] = calcDist(s.P1(k,:),p2,'find',s.find,'top',s.top);
        loc = [p2(idx,:);s.P1];
        d1(k,:)  = DataExtraction(Rent,s.get,dist,idx,num_gets);
    end
end


if strcmpi(s.plot,'on'), C = ones(size(d1,1),3).*([0.0 0.45 0.74]);
    C = [C;0.85 0.33 0.1];
    scatter(loc(:,2),loc(:,1),45,C,'filled')
    plot_google_map('MapType','roadmap')
end

end


% Find the location to closest school:
function d1 = getIncomeDatabase(varargin)

NW = {'get','type','find','top','plot','set','parallel','clean','isolate'};
MW = {'mean','have','min',1,'off','family','off','on',[]};
s = inputMethods('adv',NW,MW,{'P1'},varargin); s.get = cellstr(s.get);

if strcmpi(s.set,'family')
    load familyincomedatabaseload % load file
    p2 = [FamilyIncome.Lat FamilyIncome.Lon];
    Income = FamilyIncome; clear FamilyIncome
end

if isempty(s.isolate) == 0
    if strcmpi(s.isolate,'tracks')
        Income(ismember(Income.Primary,'Track') == 0,:) = [];
    else
        Income(ismember(Income.Primary,'Track'),:) = [];
    end
end

if strcmpi(s.clean,'on')
   Income(Income.Mean == 0,:) = [];
end

num_Pnts = size(s.P1,1);
num_gets = length(s.get); d1 = zeros(num_Pnts,num_gets);
if num_Pnts ~= 1, if s.top ~= 1, s.top = 1; disp('top set to one'),end,end


if strcmpi(s.parallel,'on'), P1 = s.P1; Find = s.find;
    Top = s.top; Get = s.get;
    parfor k = 1:num_Pnts
        [dist,idx] = calcDist(P1(k,:),p2,'find',Find,'top',Top);
        d1(k,:)    = DataExtraction(Income,Get,dist,idx,num_gets);
    end
else
    for k = 1:num_Pnts
        [dist,idx] = calcDist(s.P1(k,:),p2,'find',s.find,'top',s.top);
        loc = [p2(idx,:);s.P1];
        d1(k,:)  = DataExtraction(Income,s.get,dist,idx,num_gets);
    end
end



if strcmpi(s.plot,'on'), C = ones(size(d1,1),3).*([0.0 0.45 0.74]);
    C = [C;0.85 0.33 0.1];
    scatter(loc(:,2),loc(:,1),45,C,'filled')
    plot_google_map('MapType','roadmap')
end

end


% Extract the Data:
function data = DataExtraction(Inc,Get,Dist,I,num)
data = zeros(1,num);
for i = 1:num
    switch Get{i}
        case 'dist',    data(i) = Dist;
        case 'id',      data(i) = Inc.ID;
        case 'mean',    data(i) = Inc.Mean(I);
        case 'median',  data(i) = Inc.Median(I);
        case 'std',     data(i) = Inc.Stdev(I);
        case 'samples', data(i) = Inc.Families(I);
        case 'state',   data(i) = Inc.school_Name(I);
        case 'county',  data(i) = Inc.County(I);
        case 'place',   data(i) = Inc.Place(I);
        case 'city',    data(i) = Inc.City(I);
        case 'primary', data(i) = Inc.Primary(I);
        case 'type',    data(i) = Inc.Type(I);
        case 'area',    data(i) = Inc.Area_Code(I);
        case 'zip',     data(i) = Inc.Zip_Code(I);
            
    end
end
end


% Coastal mapping ---------------------------------------------------------


% used for coastal mapping:
function d1 = calcSquare(varargin)
% inputs [lat lon]


WN = {'imag'}; WM = {[]};
s = inputMethods('adv',WN,WM,{'p1','r','lat','lon','imag'},varargin);
s.lat_size = length(s.lat); s.lon_size = length(s.lon);


Sea = (s.imag(:,:,1) == 163) & (s.imag(:,:,2) == 204) & (s.imag(:,:,3) == 255);


% W = [163,204,255;243,241,238;243,242,238];
% % L = [250 252 253];
% for T = 1:3
%     New = s.imag(:,:,1) == W(T,1) & s.imag(:,:,2) == W(T,2) & s.imag(:,:,3) == W(T,3);
%     if T ~= 1, Sea = Sea | New; else, Sea = New; end
% end
% % 
% % for T = 1:1
% %     New = s.imag(:,:,1) == L(T,1) & s.imag(:,:,2) == L(T,2) & s.imag(:,:,3) == L(T,3);
% %     if T ~= 1, Land = Land | New; else, Land = New; end
% % end
% % 
% % Sea(Land == 1) = 0;


Ignore = (s.imag(:,:,1) == 143) & (s.imag(:,:,2) == 107) & (s.imag(:,:,3) == 131) |...
(s.imag(:,:,1) == 164) & (s.imag(:,:,2) == 138) & (s.imag(:,:,3) == 156) |...
(s.imag(:,:,1) == 239) & (s.imag(:,:,2) == 239) & (s.imag(:,:,3) == 236) |...
(s.imag(:,:,1) == 232) & (s.imag(:,:,2) == 233) & (s.imag(:,:,3) == 233) |...
(s.imag(:,:,1) == 217) & (s.imag(:,:,2) == 204) & (s.imag(:,:,3) == 204);


% [xd,x] = calcDist(s.p1,[s.p1(1).*ones(s.lon_size,1),s.lon],'find','min');
% [yd,y] = calcDist(s.p1,[s.lat,s.p1(2).*ones(s.lat_size,1)],'find','min');

[grid_x] = calcDist(s.p1,[s.p1(1).*ones(s.lon_size,1),s.lon]);
[grid_y] = calcDist(s.p1,[s.lat,s.p1(2).*ones(s.lat_size,1)]);
grid(:,1:s.lon_size) = sqrt(grid_x(1:s.lon_size).^2 + (grid_y.^2)');


Max = max(max(grid)); grid = grid'; grid(Sea == 0 | Ignore == 1) = Max;
[yn,xn] = find(grid == min(min(grid)),1); sea_pnt = [s.lat(yn), s.lon(xn)];
grid = numMethods('sgrid',grid,[5 5],'max',Max);

[grid_x] = calcDist(sea_pnt,[sea_pnt(1).*ones(s.lon_size,1),s.lon]);
[grid_y] = calcDist(sea_pnt,[s.lat,sea_pnt(2).*ones(s.lat_size,1)]);
grid(:,1:s.lon_size) = sqrt(grid_x(1:s.lon_size).^2 + (grid_y.^2)');


Max = max(max(grid)); grid = grid'; grid(Sea == 1 | Ignore == 1) = Max;
grid = numMethods('sgrid',grid,[5 5],'max',Max);
[yn,xn] = find(grid == min(min(grid)),1); land_pnt = [s.lat(yn), s.lon(xn)];


[grid_x] = calcDist(land_pnt,[land_pnt(1).*ones(s.lon_size,1),s.lon]);
[grid_y] = calcDist(land_pnt,[s.lat,land_pnt(2).*ones(s.lat_size,1)]);
grid(:,1:s.lon_size) = sqrt(grid_x(1:s.lon_size).^2 + (grid_y.^2)');

Max = max(max(grid)); grid = grid'; grid(Sea == 0 | Ignore == 1) = Max;
%grid = numMethods('sgrid',grid,[5 5],'max',Max);
[yn,xn] = find(grid == min(min(grid)),1); sea_pnt = [s.lat(yn), s.lon(xn)];


d1 = calcDist(s.p1,sea_pnt);
if d1 < 180, d1 = sea_pnt; else, d1 = s.p1; end

end

