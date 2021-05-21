classdef UIGrapher
    
    properties (Dependent)
        
        Visible
        
    end
    
    properties (SetAccess = 'public', GetAccess = 'private', Hidden = true)
        Page;
        Graph;
        Visibility;
        
    end
    
    properties
       UserData; 
    end
    
    
    methods
        
         
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
            for i = 1:length(O.Graph), O.Graph{i}.Visible = K; end
            
        end
        
        
    end
    
    
    methods (Access = 'public', Static = false, Hidden = true)
        
        
        function obj = UIGrapher(s)
            
            obj.Page = s.Page;
            K = 45; xl = zeros(1,length(s.y));
            xx = [s.x,fliplr(s.x)]; PP = cell(1,K);
            
            PP{1} = fill(xx,[s.y,xl],s.Color);
            set(PP{1},'EdgeColor',s.Color,'FaceAlpha',.25);
            set(PP{1},'EdgeAlpha',0)
            
            for i = 2:K
                PP{i} = fill(xx,[s.y,fliplr(s.y.*((i-1)/K))],s.Color);
                set(PP{i},'EdgeColor',s.Color,'FaceAlpha',.02);
                set(PP{i},'EdgeAlpha',0)
            end,obj.Graph = PP;
            
            axis tight

        end
        
        
        function delete(obj)
            
            for i = 1:length(obj.Graph) 
                delete(obj.Graph{i});
            end
            
            obj.Graph = [];
            delete(obj.Graph)
        end
        
    end
    
    
end

