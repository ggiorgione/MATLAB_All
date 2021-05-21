classdef DBT < DBTree
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Dependent)
        Visible
    end
    
    properties
        
       Visibility 
    end
    
    methods
        
        % Edit Visibility
        function O = set.Visible(O,T)
            
            
            if islogical(T), O.Visibility = T;
            elseif strcmpi(T,'off'), O.Visibility = false;
            elseif strcmpi(T,'on'), O.Visibility = true;
            elseif strcmpi(T,'switch')
                if O.Visibility, O.Visibility = false; else
                    O.Visibility = true;
                end,else
                error(['Visibility input visit: https://www.goldenoak',...
                    'research.com/moderngui For more details'])
            end
            
            
            if O.Visibility,  K = 'on'; else, K = 'off'; end
            O = UITreeVisibility(O,K);
            
        end
        
        
        function T = get.Visible(obj)
            
            T = obj.Visibility;
        end
        
        
        function obj = DBT(s)
           
            if 1 == 2
            obj.Axes = axes('Position',s.Position,'Units','normalized');
            obj.Axes.YColor = 'none'; obj.Axes.XColor = 'none';
            obj.Axes.XTick	= []; obj.Axes.YTick = [];
            
            Flds ={'YColor','XColor','XTick','YTick','Tag','Color'};
            set(obj.Axes,Flds,{'none','none',[],[],s.Tag,[.98,.98,.98]})
            obj.Axes.Tag = s.Tag; obj = setAxesLimits(obj);
            end
            
            obj = buildTreeAxes(obj,s.Position,s.Tag);
            
            % Set up Tables:
            obj = tblSetupID(obj);
            
            % Setup Variables:
            obj.Id = 0; obj.Tag = s.Tag;
            obj.Settings.Visible = true;

            obj = setupConfigNNodes(obj);

            
            if ~isempty(s.table)
               obj.setTable = s.table; 
            end
            
        end
        
    end
    
end

