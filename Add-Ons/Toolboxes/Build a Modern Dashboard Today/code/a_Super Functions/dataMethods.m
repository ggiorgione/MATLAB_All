function [data,Other] = dataMethods(type,varargin)
% the following function provides methods to a standardization of all data
% types such that that are able to be grouped together the following
% methods include:
% -------------------------------------------------------------------------
% 'build' - builds a data type structure
% Inputs:  data, name, def
% outputs: data structure
% -------------------------------------------------------------------------
% 'view' - retrieves string-cell data for display purpouses
% input: data structure
% output: string-cell filled with data info
% -------------------------------------------------------------------------
% 'get' - get information of a data structure
% Inputs: main, type, feild
% Output: requested data info
% -------------------------------------------------------------------------
% 'set' - set information of a data structure
% Inputs: new data, set feild, data structure, data feild
% Output: updated structure
% -------------------------------------------------------------------------
% 'del' - delete inputs and returns deleted data
% Inputs: data structure, delete feild, structure feild
% Output: edited structure, deleted feild data
% -------------------------------------------------------------------------

switch type
    case 'build', data = buildDataMethods(varargin{:});
    case 'view', data = getDataView(varargin{:}); 
    case 'get', [data,Other] = getDataEntry(varargin{:});
    case 'set', [data,Other] = setDataEntry(varargin{:}); 
    case 'del', [data,Other] = delDataEntry(varargin{:}); 
    case 'ismember', [data,Other] = Structismember(varargin{:});
    case 'filter',  data = genAdvFilter(varargin{:});
    case 'feature', data = genAdvFeature(varargin{:});
end



end


% get a column listing of all data info
function d = getDataView(varargin)


s = inputMethods('asafe',{'pre'},{0},{'main','name'},varargin);
inpts = {'data','name','type','def','PNaN','PEmy','key'}; d = [];
flnms = fieldnames(s.main); Lgcle = sum(ismember(flnms,inpts));
Lgcle = Lgcle == 7 | Lgcle == 6;

if s.pre == 1, s.name = fieldnames(s.main);
elseif Lgcle == 0 && isempty(s.name), d = []; return
elseif isempty(s.name), d = getData(s.main); return
end, Ntmp = fieldnames(s.main);
    
if isNumber(s.name) && Lgcle == 0, s.name = Ntmp(s.name); else
     s.name = Ntmp(ismember(Ntmp,s.name));
end, s.name = cellstr(s.name);

for i = 1:length(s.name)
    d = joinRows(d,getData(s.main.(char(s.name(i)))));
end

end


% data display:
function data = getData(s)

data = cellstr(s.name); data{2} = s.type; data{3} = charFormat(s.def);
data{4} = val2str(s.PNaN,'percent','char');
data{5} = val2str(s.PEmy,'percent','char');
data{6} = s.key;

end


% get specific data on the data feild:
function [data,L] = getDataEntry(varargin), L = true;

s = inputMethods('safe',{'main','type','field'},varargin);
inpts = {'data','name','type','def','PNaN','PEmy','key','cat'};
flnms = fieldnames(s.main); Lgcle = sum(ismember(flnms,inpts));
Lgcle = Lgcle == 7 | Lgcle == 6;
if Lgcle == 0 && isempty(s.field)
    if isempty(s.field) == 0, s.main = s.main.(charFormat(s.field));
    elseif length(flnms) == 1, s.main = s.main.(char(flnms));
    end
end,if isempty(s.field) == 0, s.main = s.main.(charFormat(s.field)); end
switch s.type, case 'def', data = charFormat(s.main.def);
    case 'data', data = s.main.data; case 'name', data = s.main.name;  
    case 'type', data = s.main.type; case 'key', data = s.main.key;
    case 'pnan', data = s.main.PNaN; case 'pempy', data = s.main.PEmy;  
    case 'struct', data = s.main;    case 'cat',data = s.main.key;
    case 'categories',data = s.main.key; otherwise, L = false; data = [];
end

end


% get specific data on the data feild:
function [data,Rem] = delDataEntry(varargin)


s = inputMethods('safe',{'main','type','field'},varargin);
inpts = {'data','name','type','def','PNaN','PEmy','key'};
flnms = fieldnames(s.main); name = [];
Lgcle = sum(ismember(flnms,inpts)); Lgcle = Lgcle == 7 | Lgcle == 6;
if Lgcle == 0 && isempty(s.field), data = s.main;
    if isempty(s.field) == 0, name = charFormat(s.field);
        Data = s.main.(charFormat(s.field));
    elseif length(flnms) == 1, name = flnms;
        Data = s.main.(char(flnms));
    end, else, data = s.main;
    if isempty(s.field) == 0, name = charFormat(s.field);
        Data = s.main.(charFormat(s.field)); else, Data = s.main;
    end
end
switch s.type
    case 'data', Rem = Data.data; Data = rmfield(Data,'data');
    case 'name', Rem = Data.name; Data = rmfield(Data,'name');
    case 'type', Rem = Data.type; Data = rmfield(Data,'type');
    case 'def' ,Rem = charFormat(Data.def); Data = rmfield(Data,'def');
    case 'pnan', Rem = Data.PNaN; Data = rmfield(Data,'PNaN');
    case 'pempy', Rem = Data.PEmy; Data = rmfield(Data,'PEmy');
    case 'key', Rem = Data.key; Data = rmfield(Data,'key');
    case 'cat', Rem = Data.key; Data = rmfield(Data,'key');
end, if isempty(name) == 0, data.(name) = Data; else, data = Data; end

end


% get specific data on the data feild:
function [data,L] = setDataEntry(varargin)


s = inputMethods('basic',{'new','type','main','field'},varargin);
inpts = {'data','name','type','def','PNaN','PEmy','key'}; name = [];
flnms = fieldnames(s.main); Lgcle = sum(ismember(flnms,inpts)) ~= 0;
if Lgcle == 0
    if isempty(s.field) == 0, data = s.main; name = charFormat(s.field);
        Data = s.main.(name); elseif length(flnms) == 1
        data = s.main; name = char(flnms); Data = s.main.(name);
    end,else,  Data = s.main; L = true;
end
switch s.type
    case {'data'},  Data.data = s.new; case {'name'},  Data.name = s.new;
    case {'type'},  Data.type = s.new; case {'def'},  Data.def = s.new;
    case {'pnan'},  Data.PNaN = s.new; case {'pempy'}, Data.PEmy = s.new;
    case {'key','cat','categories'}, Data.key = s.new;
    otherwise, L = false; return
end, if isempty(name) == 0, data.name = Data; else, data = Data; end

end


% build data type object:
function DOut = buildDataMethods(varargin)

data_List = {'data','name','def','type','PNaN','PEmy','key'};
s = inputMethods('basic',data_List,varargin);

if isempty(s.def), s.def = {'undefined'}; end
if isempty(s.name), s.name = {'undefined'}; end, DL = length(s.data);


if length(varargin) == 5
    PN = s.PNaN; s.PEmy; key = s.key; T = s.type;

elseif isa(s.data,'double'), T = 'double'; key ={'Not-Applicable'};
    [PN,PE] = getDataInfoPct(s.data,DL);
  
elseif isa(s.data,'intiger'), T = 'integer'; key ={'Not-Applicable'};
    [PN,PE] = getDataInfoPct(s.data,DL);
    
elseif isa(s.data,'datetime'),T = 'date'; key ={'Not-Applicable'};
    s.data = datenum(s.data); [PN,PE] = getDataInfoPct(s.data,DL);
    
elseif isa(s.data,'cell')
    [key,s.data,PN,PE,T] = catMethods('gen',s.data);    

end

DOut.data = s.data; DOut.name = s.name; DOut.type = T; DOut.def = s.def;
DOut.PNaN = PN; DOut.PEmy = PE; DOut.key = key;


end


% get percent info:
function [PNaN,PEmy] = getDataInfoPct(Data,DL)
if nargin == 2, DL = length(Data); end
PNaN = sum(isnan(Data))/DL; PEmy = sum(isempty(Data))/DL;   
end


% get structure member logicsals:
function [I,names] = Structismember(varargin)

s = inputMethods('basic',{'main','name'},varargin);
s.('feild_names') = s.main.(charFormat(name));
I = ismember(s.feild_names,s.name); names = s.feild_names(I);

end


% generate filter:
function data = genAdvFilter(varargin)
% MW = {'name','action'}; NW = {[],'process'};
s = inputMethods('adv','name',{[]},{'main','type'},varargin);
if isempty(s.name), data = s.main; s.main = s.main.data; else
    data = s.main; s.main = s.main.(charFormat(s.name)).data; 
end, s.main = DataTrimming('thresh',s);
if isempty(s.name), data.data = s.main; else
    data.(charFormat(s.name)).data =  s.main; 
end

end


% get advanced features:
function d = genAdvFeature(varargin), d = [];

NW = {'def','name','action','features'}; MW = {[],[],'advanced','value'};
s = inputMethods('asafe',NW,MW,{'date','data'},varargin); W = s.data;
if isempty(s.name), Q = s.data.name; s.data = s.data.data;
else, s.name = cellstr(s.name); Q = s.data.(char(s.name)).name;
    s.data = s.data.(char(s.name)).data;
end,s.date = getDataEntry(s.date,'data'); 
s.features = cellstr(s.features);

switch s.action % process data based on action 
    case 'advanced', DataTrimming('feature',s); d = W; return
    case 'original', plot(s.date,s.data), d = W; return
    case 'process', [s.data,s.def] = DataTrimming('feature',s);
end, s.data = structMethods('get',s.data,s.features,'type','struct');
s.def = structMethods('get',s.def,s.features,'type','struct');
for i = 1:length(s.features), F = char(s.features(i)); % dwl data.
    D = strcat(s.def.(F),{' '},Q); N = strcat(Q,{'_'},F);
    d = joinRows(d,buildDataMethods(s.data.(F),N,D));
end,if isempty(s.name), return, end
for i = 1:length(d), W.(char(d(i).name)) = d(i); end, d = W;

end






