classdef NodeConfiguration
    
    properties (Dependent)
        
        highlight
        normal
        import
        subset;
        superset;
        
    end
    
    properties
        
        Box;
        Pill;
        Text;
        Triangle;
        Icon
        Settings;
        sendOut;
        Tag;
        Set;
        
        
    end
    
    % get and set methods:
    methods
        
        % set subset:
        function O = set.subset(O,S)
            
            if ~isempty(S)
                O.Set.subset = cellstr(S); else
                O.Set.subset = [];
            end
            
        end
        
        % set superset:
        function O = set.superset(O,S)
            
            if ~isempty(S)
                O.Set.superset = cellstr(S);
            else
                O.Set.subset = [];
            end
            
        end
        
        % get subset:
        function S = get.subset(O)
            
            S = O.Set.subset;
            
        end
        
        % get superset:
        function S = get.superset(O)
            
            S = O.Set.superset;
            
        end
        
        % get normal config:
        function out = get.normal(obj)
            out = obj.sendOut.Normal;
        end
        
        % get import config:
        function out = get.import(obj)
            out = obj.sendOut.Import;
        end
        
        % get highlight settings
        function out = get.highlight(obj)
            out = obj.sendOut.Highlight;
        end
        
        
    end
    
    
    % general methods:
    methods
        
        % logic to checking subset:
        function L = checkSubset(O1,O2)
            
            % check if either has the same superset:
            if ~isempty(O1.superset) && ~isempty(O2.superset)
                if any(ismember(O1.superset,O2.superset))
                    L = 1; return
                end
            end
            
            % check if object two is a superset of object 2
            if ~isempty(O2.Tag) && ~isempty(O2.subset)
                O1Tag = cellstr(O1.Tag);
                if any(ismember(O2.subset,O1Tag))
                    L = 2; return
                end
            end

            L = 0;
            
           
        end
        
        % add config:
        function O = addConfig(O,T,S,varargin)
            for i = 1:2:length(varargin)-1
                O.(T).(S).(char(cellstr(varargin{i}))) = varargin{i+1};
            end 
            
            O = build(O);
            
        end
        
        % add config:
        function O = addIcon(O,varargin)
            for i = 1:2:length(varargin)-1
                O.Icon.(char(cellstr(varargin{i}))) = varargin{i+1};
            end 
            
            O = build(O);
            
        end
        
        % remove config:
        function O = removeConfig(O,T,S,varargin)
            
            for i = 1:length(varargin)
                if isfield(O.(T).(S),(char(cellstr(varargin{i}))))
                    O.(T).(S) = rmfield(O.(T).(S),cellstr(varargin{i}));
                end
            end
            
            O = build(O);
        end
        
        % node configure:
        function obj = NodeConfiguration(tag)
            if nargin == 1, obj.Tag = tag; else, obj.Tag = 'default'; end
            
            obj.Settings.Height = .575;
            obj.Settings.Export = 1;
            obj.Settings.Import = 0;
            obj.Settings.Parent = 0;
            
            BaseBox.FaceColor = [.98 .98 .98];
            BaseBox.EdgeColor = [.98 .98 .98];
            
            BasePill.FaceColor = ([92,151,191])./255;
            BasePill.EdgeColor = ([92,151,191])./255;
            
            obj.Icon.Color = 'none';
            obj.Icon.Symbol = '';
            
            BaseText.Color    = [.35 .35 .39];
            BaseText.FontSize = 10;
            
            BaseTriangle.FaceColor = [.35 .35 .39];
            BaseTriangle.EdgeColor = [.35 .35 .39];
            
            obj.Box.Highlight = BaseBox;
            obj.Box.Import    = BaseBox;
            obj.Box.Normal    = BaseBox;
            
            obj.Pill.Highlight = BasePill;
            obj.Pill.Import    = BasePill;
            obj.Pill.Normal    = BasePill;
            
            obj.Text.Highlight = BaseText;
            obj.Text.Import    = BaseText;
            obj.Text.Normal    = BaseText;
            
            obj.Triangle.Highlight = BaseTriangle;
            obj.Triangle.Import    = BaseTriangle;
            obj.Triangle.Normal    = BaseTriangle;
            
            obj = build(obj);
            
        end
        
        % Build Configuration:
        function obj = build(obj)
            
            clear obj.sendOut
            LOO = {'Triangle','Text','Box','Pill'};
            Vars = {'N','H','I'};
            MAPS = {'Normal','Highlight','Import'};
            
            %%%% Box.
            for j = 1:length(Vars)
                obj.sendOut.(Vars{j}) = []; % instantiate
                for i = 1:length(LOO)
                    
                    obj.sendOut.(Vars{j}).(LOO{i}) = []; %instantiate
                    
                    Fields = fieldnames(obj.(LOO{i}).Normal);
                    Values = cell(1,length(Fields));
                    
                    for k = 1:length(Fields)
                        Values{k} = obj.(LOO{i}).(MAPS{j}).(Fields{k});
                    end
                    
                    obj.sendOut.(Vars{j}).(LOO{i}).Fields = Fields;
                    obj.sendOut.(Vars{j}).(LOO{i}).Values = Values;
                    
                end
            end 
            
            obj.sendOut.Settings = obj.Settings;
            obj.sendOut.Icon = obj.Icon;
        end
        
        
    end
    
end

