function [d1,d2] = inputMethods(type,varargin)
% Input methods consists of the processing of data inputs, and allocated
% into a structure via several methods. All data is able to import handles.
% the function methods include:
%
% Let Standard = {feild names 1-n}, varargin
% Where varargin = {data 1, data 2, data n}
%
% -------------------------------------------------------------------------
% 'basic' The following function inputs have the following results
% 1. No default values can be set for structure feild
% 2. No structure feilds. If structure the feilds are re-allocated to data
% Inputs - type, Standard
% Output - orginized input data structure
% -------------------------------------------------------------------------
% 'adv' The following function inputs have the following results
% 1. Default values can be set for structure feild
% 2. No structure feilds. If structure the feilds are re-allocated to data
% Inputs - type, {dflt-names}, {defult-data}, Standard
% Output - orginized input data structure
% -------------------------------------------------------------------------
% 'safe' The following function inputs have the following results
% 1. No default values can be set for structure feild
% 2. Structure feilds can be a feild in the output.
% Inputs - type, Standard
% Output - orginized input data structure
% -------------------------------------------------------------------------
% 'asafe' The following function inputs have the following results
% 1. Default values can be set for structure feild
% 2. Structure feilds can be a feild in the output.
% Inputs - type, {dflt-names}, {defult-data}, Standard
% Output - orginized input data structure
% -------------------------------------------------------------------------

switch type
    case 'basic', d1 = getBasicInputDataone(varargin{:});
    case 'adv', d1 = getAdvInputDataone(varargin{:});
    case 'safe', d1 = getSafeInputDataone(varargin{:});
    case 'asafe', d1 = getaSafeInputDataone(varargin{:});
    case 'fill', [d1,d2] = getFillInputDataone(varargin{:});
end


end


% produce structure
function DO = getAdvInputDataone(varargin)

defaultNames = cellstr(varargin{1}); defaultSettings = varargin{2};
names = cellstr(varargin{3}); dIpt = varargin{4};
DO = []; Idx = [1 2 1];

if isempty(defaultNames) == 0 % loop in default values
    for i = 1:length(defaultNames)
        if i == 1, DO = struct(defaultNames{i},1); end
        if length(defaultSettings) >= i
            DO.(defaultNames{i}) = defaultSettings{i};
        else, error('all defaults need to have values');
        end
    end
end


for i = 1:length(names), Idx(1) = Idx(1) + 1;
    if i == 1
        if isstruct(dIpt(i)), DO = joinSHandle(DO,dIpt); return
        elseif isstruct(dIpt{i}), DO = dIpt{i};
            if length(dIpt) == 1, return, else, continue, end
        end,if isempty(DO), DO = struct(names{i},1); end
    end
    
    if length(dIpt) < i && sctmember(data,names(i)) == 0
        data.(char(names(i))) = []; continue,
    elseif length(dIpt) < i, continue, else
        data.(char(names(i))) = dIpt{i};
    end
    
    if isstruct(dIpt{i}),DO = joinSHandle(DO,dIpt{i}); continue
    end, DO.(char(names(i))) = dIpt{i};

    
end, Idx(3) = Idx(3) + rem(4,2); % if odd shift end back 1
if length(dIpt) > Idx(1), DO = generateInputStruct(Idx,dIpt,DO); end

end


function [DO,D1] = getFillInputDataone(varargin)
DO = []; Idx = [1 2 1]; names = cellstr(varargin{1}); D1 = 0;
dIpt = varargin{2}; Lng = length(names);


for i = 1:Lng, Idx(1) = Idx(1) + 1;
    if i == 1
        if isstruct(dIpt(i)), DO = dIpt(1); return
        elseif isstruct(dIpt{i}), DO = dIpt{i};
            if length(dIpt) == 1, return, else, continue, end
        end, DO = struct(names{i},1);
    end, if length(dIpt) < i, DO.(char(names(i))) = []; continue, end
    if isstruct(dIpt{i}),DO = joinSHandle(DO,dIpt{i}); continue
    end, DO.(char(names(i))) = dIpt{i};

    
end, Idx(3) = Idx(3) + rem(4,2); % if odd shift end back 1
if length(dIpt) > Idx(1), DO.hdls = dIpt(Lng:end); D1 = 1; end


end


% produce structure
function DO = getBasicInputDataone(varargin)
DO = []; Idx = [1 2 1];
names = cellstr(varargin{1}); dIpt = varargin{2};


for i = 1:length(names), Idx(1) = Idx(1) + 1;
    if i == 1
        if isstruct(dIpt(i)), DO = dIpt(1); return
        elseif isstruct(dIpt{i}), DO = dIpt{i};
            if length(dIpt) == 1, return, else, continue, end
        end, DO = struct(names{i},1);
    end, if length(dIpt) < i, DO.(char(names(i))) = []; continue, end
    if isstruct(dIpt{i}),DO = joinSHandle(DO,dIpt{i}); continue
    end, DO.(char(names(i))) = dIpt{i};

    
end, Idx(3) = Idx(3) + rem(4,2); % if odd shift end back 1
if length(dIpt) > Idx(1), DO = generateInputStruct(Idx,dIpt,DO); end

end


% produce structure
function data = getSafeInputDataone(varargin), data = []; Idx = [1 2 1];
names = cellstr(varargin{1}); dIpt = varargin{2};
for i = 1:length(names), Idx(1) = Idx(1) + 1;
    
    if i == 1, data = struct(names{i},dIpt{i}); continue, end
    if length(dIpt) >= i, data.(char(names(i))) = dIpt{i};
    else, data.(char(names(i))) = [];
    end
    
end, Idx(3) = Idx(3) + rem(4,2); % if odd shift end back 1
if length(dIpt) > Idx(1), data = generateInputStruct(Idx,dIpt,data); end

end


% produce structure
function data = getaSafeInputDataone(varargin), data = []; Idx = [1 2 1];
defaultNames = cellstr(varargin{1}); defaultSettings = varargin{2};
names = cellstr(varargin{3}); dIpt = varargin{4};


if isempty(defaultNames) == 0 % loop in default values
    for i = 1:length(defaultNames)
        if i == 1, data = struct(defaultNames{i},1); end
        if length(defaultSettings) >= i
            data.(defaultNames{i}) = defaultSettings{i};
        else, error('all defaults need to have values');
        end
    end
end



for i = 1:length(names), Idx(1) = Idx(1) + 1;
    if i == 1 && isempty(data),data = struct(names{i},dIpt{i}); 
    continue, elseif i == 1, data.(char(names(i))) = dIpt{i};
    end
    if length(dIpt) < i && sctmember(data,names(i)) == 0
        data.(char(names(i))) = []; continue,
    elseif length(dIpt) < i, continue, else
        data.(char(names(i))) = dIpt{i};
    end
end, Idx(3) = Idx(3) + rem(4,2); % if odd shift end back 1
if length(dIpt) > Idx(1), data = generateInputStruct(Idx,dIpt,data); end

end

function Lcle = sctmember(stct,name)

if isempty(stct), Lcle = true; return, end
Lcle = ismember(name,fieldnames(stct));

end


% generates handles in structure
function data = generateInputStruct(varargin) % Idx,dIpt,data

Idx = varargin{1}; dIpt = varargin{2};
if length(varargin) == 3, data = varargin{3}; else, data = []; end
if length(dIpt) > Idx(1) % if handles present
    for i = Idx(1):Idx(2):(length(dIpt) - Idx(3))
        if strcmpi('struct',dIpt{i})
            data = joinSHandle(data,dIpt{i+1});
        else, data.(dIpt{i}) = dIpt{i+1};
        end
    end
end

end


% join method
function [Old,Lgcl] = joinSHandle(varargin)
Lgcl = true;
s = struct('old',varargin{1}); s.('new') = varargin{2};
if length(varargin) == 2, s.('type') = 'all'; else
    s.('type') = varargin{3};
end

switch s.type
    case 'all', DN_Nms = fieldnames(s.new); % get all
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









