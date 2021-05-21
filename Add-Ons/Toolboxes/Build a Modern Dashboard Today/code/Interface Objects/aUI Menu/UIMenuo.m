classdef UIMenuo
    
    properties (Dependent)
        Visible
        getLast;
    end
    
    
    % General Properties:
    properties 
        
        Page
        Tag;  % Name of object in handles
        NormPos;    % position of figure        (normalized)
        Pos;  % position of figure window (cm)
        Axes; % auto generated axes
        
    end
    
    
    % General Properties:
    properties (SetAccess = 'public', GetAccess = 'private', Hidden = true)
        
        Settings;
        TreeObj;
        viewTbl;
        Indent;     % How much you wish to indent
        Last;       % Last table call
        CallBack;
        Fields;
        Visibility;
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
            O.Axes.Visible = K;
            O.TreeObj  = editVisibility(O.TreeObj,K);
            
        end
        
        
        function T = get.Visible(obj)
            
            T = obj.Visibility;
        end
        
        function S = get.getLast(obj)
            
            if isempty(obj.Last)
                S.field = 'undefined';
                S.id = NaN;
                S.error = 'No Menu Tab Selected, Select a Menu Tab';
                S.Path = [];
            else
               S.id = obj.Last;
               S.field = obj.Fields{obj.Last};
               S.Path = [];
            end
            
        end
        
    end
    
    % General Methods:
    methods (Access = 'public', Static = false, Hidden = true)
        
        
        % Set Calback:
        function obj = setCallBack(obj,Call)
            obj.CallBack = Call;
        end
        
   
        
        
        % Constructor:
        function obj = UIMenuo(s)
            obj.Visibility = true;
            obj.Page       = s.Page;
            obj.Tag        = s.Tag;
            pos            = s.Position;
            left           = s.Indent;
            obj.Fields     = s.fields;
            
            s = rmfield(s,{'Tag','Position','Indent','fields'});
            
            if nargin ~= 3, left = 3; end 
            Default = s.Color;
            
            % Create Axeses
            if nargin < 3, Units = 'normalized'; end
            obj.Axes = axes('Position',pos,'Units',Units);
            Flds ={'YColor','XColor','XTick','YTick','Tag','Color'};
            Sets = {'none','none',[],[],obj.Tag,Default}; % Set Defaults
            set(obj.Axes,Flds,Sets); obj = setAxesLimits(obj);
            
            % Setup View Table:
            Names = {'id','tag','pos'};
            obj.viewTbl = cell2table(cell(0,3));
            obj.viewTbl.Properties.VariableNames = Names;
            
           
            obj = setupSettings(obj);
            obj.Indent = left;
            
            obj.Settings = structMethods('join',obj.Settings,s);
            obj = addUIMenu(obj);
            
        end
        
        
        % Setup Settings:
        function obj = setupSettings(obj)
            
            Bar_Height = .075; % Default Height
            Color      = ([44,62,80])./255;
            FontColor  = [253, 227, 167]./255;
            % bar
            obj.Settings.barHeight   = Bar_Height;
            obj.Settings.barColor    = ([92,151,191])./255;
            
            % box
            obj.Settings.Color       = Color;        % Box Color
            obj.Settings.CColor      = Color.*1.25;  % Box Color
            obj.Settings.Highlight   = Color.*1.10;  % Box Highlight
            obj.Settings.Width       = 4;            % Box Width
            obj.Settings.Height      = obj.Pos(4);   % box height
            obj.Settings.Curvature   = 0; % set to .1 to curve edges
            
            
            % text
            obj.Settings.FontColor   = FontColor;  % Color of text box
            obj.Settings.FontHColor  = FontColor;   % Color of text box
            obj.Settings.FontCColor  = FontColor;   % Color of text box
            
            
            obj.Settings.FontSize    = 12;             % font size
            obj.Settings.FontAngle   = 'normal';     % font angle
            obj.Settings.FontWeight  = 'normal';     % font weight
            
            % other
            obj.Settings.Pos        = obj.Pos;
            obj.Settings.AxesType   = 'OuterPosition';
            obj.Settings.Visible    = true;
        end
        
        
        % Setup Axes Limits:
        function obj = setAxesLimits(obj)
            
            obj.Axes.Units = 'centimeters'; obj.Pos = obj.Axes.Position;
            obj.Axes.Units = 'normalized'; obj.NormPos = obj.Axes.Position;
            obj.Axes.XLim = [0,obj.Pos(3)]; obj.Axes.YLim = [0,obj.Pos(4)];
            
        end
        
        
        % Create Menu Object:
        function obj = addUIMenu(obj)
            
            for i = 1:length(obj.Fields)
                Child.id    = i;
                Child.Field = obj.Fields{i};
                obj.TreeObj = menuBox(obj.Settings,Child,obj.TreeObj);
            end
            
        end
        
        
        % Create Menu Object:
        function handles = genMenu(obj,handles)
            
            B  = obj.NormPos(2);                 % Normalized Width
            T  = sum(obj.NormPos([2,4]));        % Normalized Height
            NL = obj.NormPos(1);                 % Width (Normalize)
            XR    = obj.NormPos(3)/obj.Pos(3);   % Transformation ratio
            Right = obj.Indent;                  % setup Indent
            Tg    = obj.Tag;
            B1 = @(hObject,eventdata)MClick(Tg,hObject,guidata(hObject));
            
            
            Info.CallBack = B1;
            for i = 1:length(obj.Fields), Left = Right;
                
                Info.Id   = i; % get Id
                Info.left = Left;
                [obj.TreeObj,Right] = buildMenu(obj.TreeObj,Info);
                
                % Normalize data to backround:
                CIn = {Info.Id,obj.Tag,[([Left Right]).*XR+NL,B,T]};
                obj.viewTbl = [obj.viewTbl;CIn];
                
            end
            
            % update View table
            handles.(obj.Tag) = obj;

            
            handles.UIControl = updateTable...
                (handles.UIControl,'view',obj.viewTbl,obj.Tag);
            
        end
        
         
    end
    
    
    
    % General Methods:
    methods (Access = 'public', Static = false, Hidden = true)
        
        % Edit Visibility
        function handles = editVisibility(O,handles,T)
            
            if nargin == 2
                if O.Settings.Visible, O.Settings.Visible = false; else
                    O.Settings.Visible = true;
                end, T = O.Settings.Visible; else, O.Settings.Visible = T;
            end
            
            if T
                O.Axes.Visible = 'on';
                O.TreeObj  = editVisibility(O.TreeObj,'on');
                handles.UIControl = updateTable...
                (handles.UIControl,'view',O.viewTbl,O.Tag);
                
            else
                O.Axes.Visible = 'off';
                O.TreeObj  = editVisibility(O.TreeObj,'off');
                handles.UIControl = clearTagInViewTbl...
                    (handles.UIControl,O.Tag);

            end
            
            handles.(O.Tag) = O;
        
        
        end
        
    end

    
    % Cursor & Callback Methods:
    methods (Access = 'public', Static = false, Hidden = true) 
                       
        % Default Hover Callback:
        function obj = hoverDefault(obj,id)
            obj.TreeObj = MenuBoxSettings(obj.TreeObj,id,2);
        end
            
        
        % Turn off Hover Default:
        function obj = turnOffHoverDefault(obj,id)
            obj.TreeObj = MenuBoxSettings(obj.TreeObj,id,1);
        end
       
        
        % Click on menu:
        function [hdl,hObject] = menuClick(O,id,hdl,hObject)
            
            if ~isempty(O.Last)
                O.TreeObj = MenuBoxSettings(O.TreeObj,O.Last,1,false);
            end,O.TreeObj = MenuBoxSettings(O.TreeObj,id,3,true);
            
            if ~isempty(O.CallBack)
                [hdl,hObject] = feval(O.CallBack{:},O.Tag,hdl,hObject);
            end
            
            O.Last = id; hdl.(O.Tag) = O;
            hdl = selectPage(hdl.UIControl,O.Fields(id),hdl);
    
    
            
        end
        

        
    end
    
end


function MClick(T,hObject,H)

[H,hObject] = menuClick(H.(T),hObject.UserData,H,hObject);
guidata(hObject, H);

end

