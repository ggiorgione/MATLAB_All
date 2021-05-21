classdef LegendNode
    
    % Settings for Node:
    % PillColor
    % Height
    % Color
    % FontSize
    % FontColor
    % FontHColor
    % Icon       (not important)
    % THeight    (not important)
    
    properties (Dependent)
       Visible 
        
    end
            
    % General Properties:
    properties
        
        % Node Properties:
        Id;
        Field;
        UserData;
        
        % Info Properties
        Sett
        CallFun
        Bot
        view
        
        % Plot Objects:
        Text
        Box
        Icon
        Triange
        Visibility
        
        
    end
    
    
    % Most Used Functions:
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
            
            if ~isempty(O.Text), O.Text.Visible = K;      end
            if ~isempty(O.Box), O.Box.Visible = K;        end
            if ~isempty(O.Icon),O.Icon.Visible = K;       end
            if ~isempty(O.Triange),O.Triange.Visible = K; end
            
        end
        
        
           function T = get.Visible(O)   
               T = O.Visibility;
           end
        
        % Constructor:
        function obj = LegendNode(s,O)
            % If any adjustment entry has been made make sure to edit the
            % function --> treemr
            
            obj.Id        = s.id;
            obj.Field     = s.field;
            obj.Sett.view = s.view;
            obj = nodeSettings(obj,s.Space);
            
            if nargin == 2, if ~isempty(O), obj = [obj;O];  end, end
            
        end
        
        
        % add Node to Tree Node:
        function obj = addNode(obj,Pos,Fld,ID)
            obj = [obj,treeNode(Pos,Fld,ID)];
        end
        
        
        % Turn off Object Visibility:
        function O = deleteNode(O,id)
            % Delete the individual plots then deletes the object itself.
            
            if nargin == 1, id = 1:length(O); else
                id = findIndex(O,id);
            end
            
            for I = 1:length(id)
                i = id(I);
                if ~isempty(O(i).Text), delete(O(i).Text); end
                if ~isempty(O(i).Box),delete(O(i).Box); end
                if ~isempty(O(i).Icon),delete(O(i).Icon); end
                if ~isempty(O(i).Triange),delete(O(i).Triange); end
            end,O(id) = [];
            
        end
        
        
        % Switch Visibility:
        function obj = switchVisibility(obj,id)
            
            if length(obj(id(1)).Text.Visible) == 2
                obj = turnOffVisibility(obj,id);
                
            else
                obj = turnOnVisibility(obj,id);
            
            end
        end
        
        
        % Build Node:
        function [obj,Top] = buildNode(obj,Top)
            
            % Calculate Data to Plot
            obj.Bot = Top - obj.Sett.Height;
            
            % Plot Objects:
            obj = PlotRectangularBox(obj);
            obj = PlotTextField(obj);
            obj = PlotTriangeField(obj);
            
            % Current bottom and next* object's Top
            Top = obj.Bot;
            
        end
        
        
    end
    
    
    % Getneral Methods:
    methods

        
        % Find Index of Tree Node Given Id:
        function I = findIndex(obj,num)
            [~,I] = ismember(num,[obj.Id]);
        end

        
        % Mirror Constructor:
        function obj = treemr(obj,Pos,Fld,ID)
            
            obj.Id = ID;
            obj.Field = Fld;
            obj = nodeSettings(obj,Pos);
            
        end
        
               
        
        
        % Axes Settings:
        function obj = nodeSettings(obj,space)
            
            
         
            
            
            % Backround Box Settings:
            obj.Sett.Height  = .575;
            obj.Sett.Color  = [.98 .98 .98];
            
            % Text Box Settings:
            obj.Sett.THeight  = .5;
            obj.Sett.FontSize = 10; % Font Size, Text box Legend
            obj.Sett.FontColor = [.5 .5 .5]; % Color of text box Legend
            obj.Sett.FontHColor = [.98 .98 .98]; % Color of text box Legend
             
            % Icon Size
            obj.Sett.Icon  = .25;
                      
            % Figure Info
            obj.Sett.Space = space;
        
        end
        

        
    end
    
    
    % Plot Object Methods:
    methods
        
        
        % Plot Text Field:
        function O = PlotTextField(O)
            
            % Text Box Dimensions:
            TBot = O.Bot + O.Sett.Height/2;
            TLft = O.Sett.Space + .32;
            
            if isempty(O.Text)
                % Set Text Box:
                Txt = text(TLft,TBot,O.Field,'Clipping','on');
                Txt.Color         = O.Sett.FontColor;
                Txt.FontSize      = O.Sett.FontSize;
                Txt.ButtonDownFcn = O.CallFun;
                Txt.UserData      = O.Field;
                Txt.Units         = 'centimeter';  
                O.Text = Txt; 
            else
                O.Text.Units = 'centimeter';  
                O.Text.Position = [TLft, TBot, 0];
            end
            
        end
        
        
        % Plot Text Field:
        function O = PlotTriangeField(O)
            
            
            % Set Text Box:
            if obj.Sett.view
                x = O.Sett.Space + - .28 + [-0, .25, 0];
                y = O.Bot + O.Sett.Height/2 - .04 + [-.125,0,.125];
            else
                x = O.Sett.Space + - .28 + [-0, .13, .26];
                y = O.Bot + O.Sett.Height/2 - .04 + [.125,-.125,.125];
            end
            
            if isempty(O.Triange), hold on
                Tri = fill(x,y,[.5 .5 .5]);
                Tri.EdgeColor = [.8 .8 .8];
                Tri.EdgeColor = [.8 .8 .8];
                
                Tri.FaceAlpha = .7;
                Tri.EdgeAlpha = .7;
                
                Tri.Clipping      = 'on';
                Tri.ButtonDownFcn = s.TriCall;
                Tri.UserData      = O.Field;
                O.Triange = Tri;
            else
                O.Triange.XData = x;
                O.Triange.YData = y;
            end
            
            
        end
        
       
        % Plot Rectangular Box:
        function O = PlotRectangularBox(O)
            
            % Calculate Position:
           Pos = [0,O.Bot,O.Sett.Pos(4),O.Sett.Height];
           
           % Set Rectangluar Box:
           if isempty(O.Box)
               Rec = rectangle('Position',Pos);
               Rec.ButtonDownFcn = O.CallFun;
               Rec.UserData  = O.Field;
               Rec.FaceColor = O.Sett.Color;
               Rec.EdgeColor = O.Sett.Color;
               O.Box = Rec;
               
           else
               O.Box.Position = Pos;
           end
        end
        
        
    
        
        
    end
    
    
    % Interactive Pill Functions:
    methods
        
        
        % Turn on Object Visibility:
        function O = turnOnVisibility(O,id)
           
            if nargin == 1,  id = 1:length(O);  else
                id = findIndex(O,id);
            end
            
            for I = 1:length(id)
                i = id(I);
                O(i).Visibility = true;
                if ~isempty(O(i).Text), O(i).Text.Visible = 'on';      end
                if ~isempty(O(i).Box), O(i).Box.Visible = 'on';        end
                if ~isempty(O(i).Icon),O(i).Icon.Visible = 'on';       end
                if ~isempty(O(i).Triange),O(i).Triange.Visible = 'on'; end
            end
            
        end
        
        
        % Turn off Object Visibility:
        function O = turnOffVisibility(O,id)
            
            if nargin == 1,  id = 1:length(O);  else
                id = findIndex(O,id);
            end
  
            for I = 1:length(id)
                i = id(I);
                O(i).Visibility = false;
                if ~isempty(O(i).Text), O(i).Text.Visible = 'off';      end
                if ~isempty(O(i).Box), O(i).Box.Visible = 'off';        end
                if ~isempty(O(i).Icon),O(i).Icon.Visible = 'off';       end
                if ~isempty(O(i).Triange),O(i).Triange.Visible = 'off'; end
            end
            
        end
        
        
        % Highlight Box on:
        function O = highlightBox(O,id,Color)
            
            I = findIndex(O,id);
            O(I).Box.FaceColor = Color;
            O(I).Box.EdgeColor = Color;
            
        end
        
        
        % Highlight Box off:
        function O = highlightBoxOff(O,id)
            
            I = findIndex(O,id);
            O(I).Box.FaceColor = O(I).Sett.Color;
            O(I).Box.EdgeColor = O(I).Sett.Color;
            
        end
        
    end
    
    
end

% plot text in middle of location:
function H = plotTxtMiddle(W,H,varargin) %#ok

H = text(W,H,varargin{:});
tPos = H.Extent;
H.Position(1) = W - tPos(3)/2;

end

