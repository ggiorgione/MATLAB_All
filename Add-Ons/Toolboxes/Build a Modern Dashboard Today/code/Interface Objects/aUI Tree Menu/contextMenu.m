classdef contextMenu
    
    % dependent properties:
    properties (Dependent)
        
        FaceColor;
        EdgeColor;
        Visible;
        Position;
        Last;
        
    end

    
    % general properties:
    properties
        
        fields
        position
        graphs
        Vec
        Visibility
        info
        setGraphs;
        Tripos
        Triangle
       TriId
    end
    
    
    % set and get methods:
    methods
        
        
        % set info:
        function obj = set.Last(obj,id)
            
            
            if isempty(obj.info)
                obj = turnOnLast(obj,id);
                obj.info.id = id;
                obj.info.field = obj.fields{id};
                
            elseif obj.info.id ~= id
                obj = turnOffLast(obj,obj.info.id);
                obj = turnOnLast(obj,id);
                obj.info.id = id;
                obj.info.field = obj.fields{id};
            end

            
        end
        
        % get info:
        function Info = get.Last(obj)
        
            Info = obj.info;
            
        end
        
        % set position:
        function obj = set.Position(obj,start_position)
            
            if ~obj.Visibility, obj.Visible = 'on'; end
            obj.position = start_position;
            obj.Vec = obj.position(1) + obj.position(4).*(0:(n-1));
            
            
            for i = 1:n
                
                % setup box position:
                P = obj.position + [0,obj.Vec(i),0,0];
                obj.graphs{i,1}.Position = P;
                
                % setup text positions:
                P([1,2]) = P([1,2]) + [s.shift,+obj.position(4)/2];
                obj.graphs{i,2}.Position = [P([1,2]),0];
                 
            end
            
        end
        
        % get position:
        function P = get.Position(obj)
            
            P = obj.position;
           
        end
        
        % set visiblility:
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
            set([O.graphs{:,1:2}],'Visible',K)
            
            
        end
        
        % get visiblility:
        function T = get.Visible(obj)
            
            T = obj.Visibility;
        end
        
        
    end
    
    
    % general methods:
    methods
        
        function [O,L] = getHover(O,m)
     
            if ~(m(1) > O.position(1) && m(1) < sum(O.position([1,3])))
                if ~isempty(O.info),O = turnOffLast(O); end
                L = false; return
            end
            
            P = [0,O.position(4)] + O.Vec';
            I = P(:,1) < m(2) & P(:,2) > m(2);
            if ~any(I), L = false; return, end
            O.Last = O.graphs{I,3};
            
            
        end
        
 
        % turn off last
        function O = turnOffLast(O,id)
            
            if nargin == 1, id = O.info.id; O.info = []; end
            
           O.graphs{id,1}.FaceColor = O.setGraphs.FaceColor;
           O.graphs{id,1}.EdgeColor = O.setGraphs.EdgeColor;
           if id == O.TriId
               O.Triangle.FaceColor = O.setGraphs.FaceColor;
               O.Triangle.EdgeColor = O.setGraphs.EdgeColor;
           end
           
        end
        
        % turn on last
        function O = turnOnLast(O,id)
            
           Color = [54, 215, 183]./255;
           O.graphs{id,1}.FaceColor = Color;
           O.graphs{id,1}.EdgeColor = Color;
           
           if id == O.TriId
               O.Triangle.FaceColor = Color;
               O.Triangle.EdgeColor = Color;
           end
        end
        
        % generate context menu:
        function O = contextMenu(s)
            % required fields in structure s
            % 1. fields        2. Position
            % -------------------------------------------------------------
            % optional fields                                             |
            % 1. Callback      2.FaceColor     3.EdgeColor                |
            % -------------------------------------------------------------
            
            
            
            if ~isfield(s,'shift'), s.shift = .1;                    end
            if ~isfield(s,'FaceColor'), s.FaceColor = [.97,.97,.98]; end
            if ~isfield(s,'EdgeColor'), s.EdgeColor = 'none';        end
            
            O.setGraphs.FaceColor = s.FaceColor;
            O.setGraphs.EdgeColor = s.EdgeColor;
     
            
            % pull data:
            O.fields = s.fields;
            O.position = s.Position; % position of object
            n = length(s.fields); % number of fields
            
            if s.Position(2) - s.Position(4)*n - s.Shift < s.B
                L = abs(s.Position(2) - s.Position(4)*n);
                d = ceil((L-abs(s.B))/s.Position(4)); else, d = 0;
            end
            
            % upload:
            O.Vec = s.Position(2) - s.Position(4).*(1-d:n-d) + s.Shift;
            O.Tripos = s.Position(2)-s.Position(4).*(0:.5:1)+s.Shift;
            O.graphs = cell(n,3); % setup cell array
       
            O.Triangle = fill(O.position([1,5,1]),O.Tripos,s.FaceColor);
            O.Triangle.EdgeColor = s.FaceColor;
            O.TriId = 1+d;
            
            for i = 1:n
                
                % setup:
                P = [O.position(1),O.Vec(i),O.position(3:4)];
                
                % setup block graphs.
                O.graphs{i,1} = rectangle('Position',P);
                O.graphs{i,1}.Clipping      = 'off';
                O.graphs{i,1}.FaceColor     = s.FaceColor;
                O.graphs{i,1}.EdgeColor     = s.EdgeColor;
                O.graphs{i,1}.ButtonDownFcn = s.Callback;
                
                % setup text graphs.
                P([1,2]) = P([1,2]) + [s.shift,+O.position(4)/2];
                O.graphs{i,2} = text(P(1),P(2),s.fields{i});
                O.graphs{i,2}.ButtonDownFcn = s.Callback;
                O.graphs{i,3} = i;
                
            end

        end

        % delete:
        function delete(obj)
            
            for i = 1:size(obj.graphs)
                delete(obj.graphs{i,1})
                delete(obj.graphs{i,2})
            end
            
        end
        
        
    end
    
end

