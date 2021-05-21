function [Nodes,L] = deriveNodes(T,I,Type)

if nargin == 0
    T = load('demo_variables.mat','TblImport');
    T = T.TblImport;
end

L = false;
F = T.Properties.VariableNames; % field names of variables
name = lower(F);                % set lowercase nodes
tblSize = size(T);              % size of table
def = 'undefined';


if nargin < 2
    
    Nodes = cell(length(F),2); % create node cell
    for i = 1:tblSize(2)
        I = i;
        LVec = zeros(5,1);
        Logic(1) = isa(T.(F{i}),'numeric');
        
        
        if Logic(1)
            LVec(1) = all(T.(F{i}) <= 90 & T.(F{i}) >= -90); % latitude
            LVec(2) = all(T.(F{i}) <= 180 & T.(F{i}) >= -180); % logitude
        end
        
        % Initial Logical Checks:
        LVec(3) = isdatetime(T.(F{i}));
        LVec(4) = any(contains(name{i},'lat'));
        LVec(5) = any(contains(name{i},'lon'));
        LVec(6) = any(contains(name{i},'id'));
        LVec(7) = any(contains(name{i},'date'));
        LVec(8) = isa(T.(F{i}),'cell');
        
        % Process logic Vector to final Product Key
        Logic(1) = LVec(1) & LVec(4);   % latitude
        Logic(2) = LVec(5) & LVec(2);   % longitude
        Logic(3) = LVec(6);             % id
        Logic(4) = LVec(7) | LVec(3);   % date
        Logic(5) = LVec(8) & ~Logic(4); % catigorical
        
        Key = bin2Decimal(Logic); % convert key to number
        runAlg()
    end
    
else
    
    Nodes = cell(1,2);      % create node cell
    if iscellstr(I), [~,I] = ismember(I,F); end
    i = 1;
    switch Type
        case 'latitude'
            if ~all(T.(F{I}) <= 90 & T.(F{I}) >= -90), return, end
            Key = 16;
            
        case 'longitude'
            if ~all(T.(F{I}) <= 180 & T.(F{I}) >= -180), return, end
            Key = 8;
            
        case 'id'
            Key = 4;
            
        case 'date'
            if ~isdatetime(T.(F{I})), return, end
            Key = 2;
            
        case 'catigorical'
            if ~isa(T.(F{I}),'cell'), return, end
            Key = 1;
            
        case 'double'
            if ~isa(T.(F{I}),'numeric'), return, end
            Key = 0;
   
    end
    
    runAlg()
    
end

L = true;

    function runAlg()
        
        
        switch Key
            
            case 16    % latitude
                
                Nodes{i} = createNode('Latitude',{'D',F{I}},{'id'});
                s.definition  = def;
                s.map         = false;
                s.field       = F{I};
                s.id          = NaN;
                s.data_type          = 'latitude';
                s.nan_percent   = sum(isnan(T.(F{I})))/tblSize(1); % nan pct
                s.inf_percent   = sum(isinf(T.(F{I})))/tblSize(1); % inf pct
                s.empty_percent = sum(isinf(T.(F{I})))/tblSize(1); % empty pct
                
            case 8     % longitude
                
                Nodes{i} = createNode('Longitude',{'D',F{I}},{'id'});
                s.definition  = def;
                s.map         = false;
                s.field       = F{I};
                s.id          = NaN;
                s.data_type          = 'longitude';
                s.nan_percent   = sum(isnan(T.(F{I})))/tblSize(1); % nan pct
                s.inf_percent   = sum(isinf(T.(F{I})))/tblSize(1); % inf pct
                s.empty_percent = sum(isinf(T.(F{I})))/tblSize(1); % empty pct
                
            case 4     % id
                
                Nodes{i} = createNode('ID',{'D',F{I}},{'id'});
                s.definition  = def;
                s.map         = false;
                s.field       = F{I};
                s.id          = NaN;
                s.data_type          = 'id';
                s.nan_percent   = sum(isnan(T.(F{I})))/tblSize(1); % nan pct
                s.inf_percent   = sum(isinf(T.(F{I})))/tblSize(1); % inf pct
                s.empty_percent = sum(isinf(T.(F{I})))/tblSize(1); % empty pct
                
            case 2     % date
                
                Nodes{i} = createNode('Date',{'D',F{I}},{'id'});
                s.definition  = def;
                s.map         = false;
                s.field       = F{I};
                s.id          = NaN;
                s.data_type          = 'date';
                s.nan_percent   = sum(isnan(T.(F{I})))/tblSize(1); % nan pct
                s.inf_percent   = sum(isinf(T.(F{I})))/tblSize(1); % inf pct
                s.empty_percent = sum(isinf(T.(F{I})))/tblSize(1); % empty pct
                
            case 1     % catigorical
                
                [Key,T.(F{I}),PNaN,PEmy,type,inf]=catMethods('gen',T.(F{I}));
                Nodes{i} = createNode(F{I},{'M',F{I}},{'double'});
                s.definition  = def;
                s.map         = Key;
                s.field       = F{I};
                s.id          = NaN;
                s.data_type     = type;
                s.nan_percent   = PNaN; % nan pct
                s.inf_percent   = PEmy; % inf pct
                s.empty_percent = inf; % empty pct
                
            otherwise  % double
                
                Nodes{i} = createNode(F{I},{'M',F{I}},{'double'});
                s.definition  = def;
                s.map         = false;
                s.field       = F{I};
                s.id          = NaN;
                s.data_type     = 'double';
                s.nan_percent   = sum(isnan(T.(F{I})))/tblSize(1); % nan pct
                s.inf_percent   = sum(isinf(T.(F{I})))/tblSize(1); % inf pct
                s.empty_percent = sum(isinf(T.(F{I})))/tblSize(1); % empty pct
                
        end
        
        Nodes{i,2} = s;
        
    end


end

