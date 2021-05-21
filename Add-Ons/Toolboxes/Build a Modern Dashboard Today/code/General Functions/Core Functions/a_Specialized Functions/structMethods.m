function [value,Logicl,name] = structMethods(type,varargin)
% The following code enables user to easily create, handle and manage
% scripts from the method calls outlined below.
% -------------------------------------------------------------------------
% 'get' - gets the value of a given structure
% inputs  - stucture, feild name
% outputs - data, logical value, names
% -------------------------------------------------------------------------
% 'set' - sets the value of a given structure
% inputs: Structure | empty, feild, value, check (if valid name)
% outputs:  structure, logical value, names
% -------------------------------------------------------------------------
% 'join' - joins two structures into one with total properties
% inputs:   old structure, new structure, type
% outputs:  structure, logical value, names 
% handles: type - all, new, default, all
% -------------------------------------------------------------------------
% 'date' - joins two strucutures by a unique date index
% Inputs: transform date index, main date index, data structures
% Output: transformed data structures
% -------------------------------------------------------------------------

switch type
    case 'get', [value,Logicl,name] = getStructData(varargin{:});
    case 'set', [value,Logicl,name] = setSHandle(varargin{:});
    case 'join',[value,Logicl] = joinStructureHandle(varargin{:});
    case 'date', value = dateMergerFunction(varargin{:});
    case 'struct', value = getNStructs(varargin{:});
    case 'lgc', [value,Logicl] = getStructLogical(varargin{:});
    case 'class', value = importStruct2Class(varargin{:});
end


end


function obj = importStruct2Class(s,obj)

N = properties(obj);
F = fieldnames(s);
N = N(ismember(N,F));

for i = length(N)
    obj.(N{i}) = s.(N{i});
end

end

function [Logicl,name] = getStructLogical(varargin)

s = inputMethods('asafe','type',{'col'},{'main','name'},varargin);
if isempty(s.main), Logicl = false; name = []; return, end
s.name = cellstr(s.name); 
name = fieldnames(s.main); Logicl = (ismember(s.name,name));
s.name = s.name(ismember(s.name,name));
name = s.name;
end

% get method
function [value,Logicl,name] = getStructData(varargin)
s = inputMethods('asafe','type',{'col'},{'main','name'},varargin);
s.name = cellstr(s.name); value = []; Logicl = true;
name = fieldnames(s.main); s.name = s.name(ismember(s.name,name));

switch s.type,                  case 'col'
    for i = 1:length(s.name)
        value = joinColumns(value,s.main.(char(s.name(i))));
    end, name = s.name; return, case 'row'
    for i = 1:length(s.name)
        value = joinRows(value,s.main.(char(s.name(i))));
    end, name = s.name; return, case 'ccol'
    for i = 1:length(s.name)
        value = joinColumns(value,{s.main.(char(s.name(i)))});
    end, name = s.name; return, case 'crow'
    for i = 1:length(s.name)
        value = joinRows(value,{s.main.(char(s.name(i)))});
    end, name = s.name; return, case 'struct'
    for i = 1:length(s.name), N = char(s.name(i)); dhold = s.main.(N);
        if i == 1, value = struct(N,dhold); else, value.(N) = dhold; end
    end, name = s.name; return
end
end

% set method
function [data,Logcl,name] = setSHandle(varargin)
% switch to a dynamic feild handling strategy please check over
% Inputs: s, field, value, Check

s = inputMethods('safe',{'main','field','value','check'},varargin);
s.field = cellstr(s.field); Logcl = true;
if isempty(s.check), s.check = 0; end
if s.check == 1, Logcl = isvarname(s.field);
    if Logcl == 0, return, end
end

if length(s.field) == 1
    if isempty(s.main), s.main = struct(charFormat(s.field),[]);
        s.main.(charFormat(s.field)) = s.value;
    else, s.main.(charFormat(s.field)) = s.value;
    end, data = s.main; name = s.field; return
end

for i = 1:length(s.field)
    if isempty(s.main), s.main = struct(charFormat(s.field(i)),1);
        s.main.(charFormat(s.field(i))) = s.value{i};
    else, s.main.(charFormat(s.field(i))) = s.value{i};
    end
end, data = s.main; name = s.field;

end

% join method
function [Old,Lgcl] = joinStructureHandle(varargin), Lgcl = true;

s = inputMethods('asafe','type',{'all'},{'old','new'},varargin); 

switch s.type
    case 'all', DN_Nms = fieldnames(s.new); % get data feild names
        for i = 1:length(DN_Nms)
            s.old.(DN_Nms{i}) = s.new.(DN_Nms{i});
        end
    case 'new', DN_Nms = fieldnames(s.new); DO_Names = fieldnames(s.old);
        DN_Nms = DN_Nms((ismember(DN_Nms,DO_Names)) == 0);
        for i = 1:length(DN_Nms)
            s.old.(DN_Nms{i}) = s.new.(DN_Nms{i});
        end
end, Old = s.old;

end

% merge structure via dates:
function DataOut = dateMergerFunction(varargin)
% Transform structures based on a date structure


s = inputMethods('safe',{'dateIdx','date','data','name'},varargin);
if isstruct(s.dateIdx), s.dateIdx = dataMethods('get',s.dateIdx,'data');
end

if isstruct(s.date), s.name = dataMethods('get',s.date,'name');
    s.date = dataMethods('get',s.date,'data');
end

[I,II] = ismember(s.dateIdx,s.date); names = fieldnames(s.data);
for i = 1:length(names), if strcmpi(s.name,names(i)), continue, end
    try DNew = NaN(size(s.dateIdx));
        data = dataMethods('get',s.data,'data',names(i));
        DNew(1 == I,1) = data(II(1 == I));
        s.data.(charFormat(names(i))).data = DNew;
    catch, fprintf('%s was not uploaded\n',charFormat(names(i)))
    end
end, DataOut = s.data;

end



