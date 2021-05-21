classdef treeNode
    
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
        
        Position
        Setup
        Visible
        TriSwitch
        SetupIcon
    end
            
    % General Properties:
    properties
        
        % Node Properties:
        Id;
        Field;
        UserData;
        Parent;
        Space;
        Height;
        Pos;
        Export;
        Import;
        view;
        
        % Info Properties
        Sett
        CallFun;
        PillCall;
        TriCall;
        Bot
        
        % Plot Objects:
        Text
        Box
        Pill
        Icon
        Triange
        Visibility
        
    end
    
    
    % General Methods:
    methods 
        
        function O = set.SetupIcon(O,s)
      
            O.Icon = designIcon(O.Icon,s);
            
        end
        
        % switch triangle arrow:
        function O = set.TriSwitch(O,N)
            
            if N
                x = O.Space + -0.405 + [0, .25, 0];
                y = O.Bot + O.Height/2 - .04 + [-.125,0,.125];
            else
                x = O.Space + - .28 + [-.125, 0, .125];
                y = O.Bot + O.Height/2 + .25/2 + [0, -.25, 0];
            end
            
            O.Triange.XData = x;
            O.Triange.YData = y;
            
        end
        
        
        % Set Position
        function O = set.Position(O,N)
            
            % set position for the tree node:
            O.Bot = N(1);
            TBot  = O.Bot + O.Height/2;    % Text Bottom
            Right = O.Pos(3)*11/12 - N(2); % Pill Right
            bottom  = O.Bot + (O.Height - O.Height*4/5)/2;   
            P = [bottom,N(2),Right]; % pill position
            O.Space = N(2);
            
            if ~isempty(O.Triange)
                Change = N(1) - O.Box.Position(2);
                O.Triange.YData = O.Triange.YData + Change(1);
                x = O.Space - .5; w = .12;
            else
                x = O.Space - .5;  w = .12;
            end
            
            
            
            % icon sizing:
            icon_sz = [x,O.Space] + w*[x,O.Space]*[-1;1]*[1,-2];
            icon_pos = [icon_sz(2),TBot,0,0] + icon_sz*[-1;1]*[0,-.5,1,1];
            icon_pos(1) = icon_pos(1) - O.Box.Position(4)/2;
            
            if ~isempty(O.Text), O.Text.Position(1) = N(2) + .32;    end
            if ~isempty(O.Box), O.Box.Position(2)   = N(1);          end
            if ~isempty(O.Text), O.Text.Position(2) = TBot;          end
            if ~isempty(O.Pill), O.Pill.Position([2,1,3]) = P;       end
            if ~isempty(O.Icon), O.Icon.Position = icon_pos;         end
            
        end
        
        
        % setup Graphical Object
        function O = set.Setup(O,s)
            
            if ~isempty(O.Text)
                set(O.Text,s.Text.Fields,s.Text.Values); 
            end
            
            if ~isempty(O.Pill)
                set(O.Pill,s.Pill.Fields,s.Pill.Values); 
            end
            
            if ~isempty(O.Box) 
                set(O.Box,s.Box.Fields,s.Box.Values);
            end
            
            if ~isempty(O.Triange)
                set(O.Triange,s.Triangle.Fields,s.Triangle.Values);
            end
            
        end
        
        
        % get Visibility:
        function out = get.Visible(O)
           out = O.Visibility; 
        end
        
        % set visibility:
        function O = set.Visible(O,T)
            
            if islogical(T), O.Visibility = T;
            elseif strcmpi(T,'off'),O.Visibility = false;
            elseif strcmpi(T,'on'), O.Visibility = true;
            elseif strcmpi(T,'switch')
                if O.Visibility, O.Visibility = false; else
                    O.Visibility = true;
                end,else
                error(['Visibility input visit: https://www.goldenoak',...
                    'research.com/moderngui For more details'])
            end
            
            if O.Visibility, K = 'on'; else, K = 'off';   end
            if ~isempty(O.Text), O.Text.Visible      = K; end
            if ~isempty(O.Pill), O.Pill.Visible      = K; end
            if ~isempty(O.Box), O.Box.Visible        = K; end
            if ~isempty(O.Icon),O.Icon.Visible       = K; end
            if ~isempty(O.Triange),O.Triange.Visible = K; end

            
        end
        
        
    end
    
    
    % Most Used Functions:
    methods 
        
                        
        % Constructor:
        function obj = treeNode(pos,s,ss,O)
            % If any adjustment entry has been made make sure to edit the
            % function --> treemr
            
            obj.Id     = s.id;
            obj.Field  = s.field;
            obj.Pos    = pos;
            obj.Space  = .5;
            obj.Bot    = 0;
            obj.Parent = ss.Settings.Parent;
            obj.Height = ss.Settings.Height;
            obj.Export = ss.Settings.Export;
            obj.Import = ss.Settings.Import;
            obj.Visibility = true;
            obj.view       = false;
            
            
            if islogical(ss.Settings.Export)
                error('Export needs to be a logical data type')
            elseif islogical(ss.Settings.Parent)
                error('Parent needs to be a logical data type')
            end
            
            if ss.Settings.Export,obj.PillCall = ss.Call.PillCall;  end
            if ss.Settings.Parent, obj.TriCall = ss.Call.TriCall;   end
            
            obj = initialBuild(obj);
            obj.Setup  = ss.N;
            obj.SetupIcon  = ss.Icon;
            if nargin == 4, if ~isempty(O), obj = [obj;O];  end, end
            
        end
        
        
        
        % add Node to Tree Node:
        function obj = addNode(obj,pos,Fld,ID)
            obj = [obj,treeNode(pos,Fld,ID)];
        end
        
        
        % Icons delete Here needs to be added*
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
                if ~isempty(O(i).Pill),delete(O(i).Pill); end
                if ~isempty(O(i).Triange),delete(O(i).Triange); end
            end
            
            O(id) = [];
            
        end
        
        
    end
    
    
    % Getneral Methods:
    methods

        
        % Find Index of Tree Node Given Id:
        function I = findIndex(obj,num)
            [~,I] = ismember(num,[obj.Id]);
        end

        
        % Mirror Constructor:
        function obj = treemr(obj,pos,Fld,ID)
            
            obj.Id = ID; obj.Field = Fld;
            obj = nodeSettings(obj,pos);
            
        end

        
    end
    
    
    % Plot Object Methods:
    methods
        
        
        % Edit Build
        function O = editBuild(O,s)
            
            if ~isempty(O.Text),set(O.Text,s.TextFields,s.TextValues); end
            if ~isempty(O.Box), set(O.Box,s.BoxFields,s.BoxValues); end
            if ~isempty(O.Pill),set(O.Pill,s.PillFields,s.PillValues); end
            if ~isempty(O.Triange)
                set(O.Triange,s.TriangeFields,s.TriangeValues);
            end
            
        end
        
        
        % Build Initial Plots:
        function O = initialBuild(O)
            % 1. Height  ( independent )
            % 2. Pos     ( dependent )
            % 3. Bot     ( changes )
            % 4. Space   ( changes )
            % 5. CallFun ( dependent )
            % 6. Field   ( independent )
              
            % initial bottom setting*
            O.Bot = -5; % set temp bottom value for setup.
            
            
            
           % Box Calculations:
            PBox  = [0,O.Bot,O.Pos(3),O.Height]; % Box Position
            Hight = O.Height*4/5;                % Pill Height
            Bott  = (O.Height - O.Height*4/5)/2; % bottom position
            Right = O.Pos(3)*11/12 - O.Space;    % Pill Right         
            PPill = [O.Space,Bott,Right,Hight];  % Pill Position
            TBot  = O.Bot + O.Height/2;          % Text Bottom
            TLft  = O.Space + .32;               % Text Left
            x = O.Space - 0.405 + [0,.25,0];    % triangle x
            y = O.Bot + O.Height/2 - .04 + [-.125,0,.125]; % triangle y
            
            
            % -------------------------------------------------------------
            % icon sizing / icon calculations:
            w     = .1; % icon weightimg
            icon_sz = [x(1),O.Space] + w*[x(1),O.Space]*[-1;1]*[1,-2];
            icon_pos = [icon_sz(1),TBot,0,0] + icon_sz*[-1;1]*[0,-.5,1,1];
            % -------------------------------------------------------------
            
            % Icon Generation goes here (In-Progress)
            hold on, % Generate Graphical Objects:
            O.Box = rectangle('Position',PBox,'UserData',O.Field); % Box
            O.Icon = dataTypeIcon(icon_pos);               % icon
            O.Pill = rectangle('Position',PPill,'Curvature',1); % Pill
            O.Text = text(TLft,TBot,O.Field,'Clipping','on');   % Text
            if O.Parent,  O.Triange = fill(x,y,'k');  end       % Triangle
            
            
            % setup callbacks:
            O.Pill.ButtonDownFcn = O.CallFun;
            O.Text.ButtonDownFcn = O.CallFun;
            
            % setup User Data:
            O.Pill.UserData      = O.Field;
            O.Text.UserData      = O.Field;
            
            
            % Pill Call Specific:
            if ~isempty(O.PillCall)
                O.Pill.ButtonDownFcn = O.PillCall;
                O.Text.ButtonDownFcn = O.PillCall;
            end
            
            % setup Triangle:
            if ~isempty(O.TriCall)
                if O.Parent,  O.Triange.ButtonDownFcn = O.TriCall;  end
            end

            
        end

        
    end
    
    
    % Interactive Pill Functions:
    methods
          
        
        % Switch Visibility:
        function obj = switchVisibility(obj,id)
            
            if length(obj(id(1)).Text.Visible) == 2
                obj = turnOffVisibility(obj,id);  else
                obj = turnOnVisibility(obj,id);
            end
        end

      
        % Turn on Object Visibility:
        function O = turnOnVisibility(O,id)
           
            if nargin == 1,  id = 1:length(O);  else
                id = findIndex(O,id);
            end
            
            for I = 1:length(id)
                i = id(I); O(i).Visibility = true;
                if ~isempty(O(i).Text), O(i).Text.Visible      = 'on'; end
                if ~isempty(O(i).Pill), O(i).Pill.Visible      = 'on'; end
                if ~isempty(O(i).Box), O(i).Box.Visible        = 'on'; end
                if ~isempty(O(i).Icon),O(i).Icon.Visible       = 'on'; end
                if ~isempty(O(i).Triange),O(i).Triange.Visible = 'on'; end
            end
            
        end
        
        
        % Turn off Object Visibility:
        function O = turnOffVisibility(O,id)
            
            if nargin == 1,  id = 1:length(O);  else
                id = findIndex(O,id);
            end
  
            for I = 1:length(id)
                i = id(I); O(i).Visibility = false;
                if ~isempty(O(i).Text), O(i).Text.Visible = 'off';      end
                if ~isempty(O(i).Box), O(i).Box.Visible = 'off';        end
                if ~isempty(O(i).Icon),O(i).Icon.Visible = 'off';       end
                if ~isempty(O(i).Triange),O(i).Triange.Visible = 'off'; end
                if ~isempty(O(i).Pill),O(i).Pill.Visible = 'off';       end
            end
            
        end
        
        
    end
    
    
    % Floater
    methods
                       
        % Build Floater:
        function New = buildFloater(O,Child,B,New) %#ok

            error('the floater will be embedded directly into the uitree')
            
        end
        
    end
    
    
end

% plot text in middle of location:
function H = plotTxtMiddle(W,H,varargin) %#ok

H = text(W,H,varargin{:});
tPos = H.Extent;
H.Position(1) = W - tPos(3)/2;

end