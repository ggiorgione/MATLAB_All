classdef UICButtono
    % Generate clickable Button

    properties (Dependent)
        
        Highlight;
        Color;
        CColor;
        
        FontSize;
        FontAngle;
        FontWeight;
        
        Visible;
        String;
        
        FontHColor;
        FontCColor;
        FontColor;
        Curvature;
   
        
    end
    
    properties (SetAccess='public',GetAccess='public',Hidden=false)
        Page;
        Tag;      % Name of object in handles
        Callback;
        Box;
        Text;
        
    end
    
    
    
    properties (SetAccess='public',GetAccess='private',Hidden=true)
        
        BSettings;
        Axes;
        Pos;
        NormPos;  % position of figure (normalized)
        viewTbl;
        Clicked;
        Buttons;
        Visibility;
        
    end
    
    methods
        
        
        
        
        
        function T = get.Color(O) 
            T = O.BSettings.Color; 
        end
        
        
        function T = get.FontColor(O) 
            T = O.BSettings.FontColor; 
        end
        
        
        function T = get.FontHColor(O)
            T = O.BSettings.FontHColor;
        end
        
        
        function T = get.FontCColor(O) 
            T = O.BSettings.FontCColor;
        end
        
        
        function T = get.CColor(O) 
            T = O.BSettings.CColor; 
        end
        
        
        function T = get.Highlight(O) 
            T = O.BSettings.Highlight; 
        end
        
        
        function O = set.String(O,T)
            O.BSettings.String = T;
        end
        
        
        function O = set.Visible(O,T)
            
            O.Visibility = T;
            
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
            
            
            if isempty(O.Buttons), return, end
            if isempty(O.Buttons.id), return, end
            if O.Visibility, TT = 'on';  else, TT = 'off'; end
             
             O.Axes.Visible  = TT;
             O.Buttons.Box.Visible   = TT;
             O.Buttons.Text.Visible  = TT;
             
             
        end
        
        function O = set.FontHColor(O,T)
            O.BSettings.FontHColor = T;
        end
        
        function O = set.FontCColor(O,T) 
            O.BSettings.FontCColor = T;
        end
        
        function O = set.CColor(O,T) 
            O.BSettings.CColor = T; 
        end

        function O = set.FontColor(O,T), O.BSettings.FontColor = T;
            
            if ~isempty(O.Buttons)
               for i = 1:length(O.Buttons)
                   O.Buttons(i).FontColor = T;
               end
            end
            
        end
        
        function O = set.FontSize(O,T), O.BSettings.FontSize = T;
            
            if ~isempty(O.Buttons)
               for i = 1:length(O.Buttons)
                   O.Buttons(i).FontSize = T;
               end
            end
            
        end
        
        function O = set.FontWeight(O,T), O.BSettings.FontWeight = T;
            
            if ~isempty(O.Buttons)
               for i = 1:length(O.Buttons)
                   O.Buttons(i).FontWeight = T;
               end
            end
            
        end
        
        
        
        function O = set.Color(O,T), O.BSettings.Color = T;
            
            if ~isempty(O.Buttons)
               for i = 1:length(O.Buttons)
                   O.Buttons(i).Color = T;
               end
            end
        end
        
        function O = set.Highlight(O,T),  O.BSettings.Highlight = T;
        end
        
        function O = set.FontAngle(O,T), O.BSettings.FontAngle = T;
            
            if ~isempty(O.Buttons)
               for i = 1:length(O.Buttons)
                   O.Buttons(i).FontAngle = T;
               end
            end
            
        end
        
        function O = set.Curvature(O,T), O.BSettings.Curvature = T;
            
            if ~isempty(O.Buttons)
               for i = 1:length(O.Buttons)
                   O.Buttons(i).Curvature = T;
               end
            end
            
            
        end
        
        
    end
    
    methods (Access = 'public', Static = false, Hidden = true)
        
        

        % Constructor:
        function obj = UICButtono(varargin)
            
            
            if isstruct(varargin{1}), s = varargin{1};  else
                error('Needs to be struct import')
            end, obj.Buttons = uiButtono();
            
            obj.Page = s.Page;
            N = properties(obj);
            F = fieldnames(s); N = N(ismember(N,F));
            for i = 1:length(N), obj.(N{i}) = s.(N{i}); end
            
            
            pos = s.Position; obj.Tag = s.Tag;
            
            % Create Axeses if nargin < 4, Units = 'normalized'; end
            obj.Axes = axes('Position',pos,'Units','normalized');
            obj.Axes.YColor = 'none'; obj.Axes.XColor = 'none';
            obj.Axes.XTick	= []; obj.Axes.YTick = [];
            obj.Axes.Tag = obj.Tag; obj = setAxesLimits(obj);
            obj.Axes.Color = 'none'; obj.Clicked = false; 
            obj.Buttons.id = 1;
            
            
            % Setup View Table:
            Names = {'id','tag','pos'};
            obj.viewTbl = cell2table(cell(0,3));
            obj.viewTbl.Properties.VariableNames = Names; 
            obj.Axes.Color = 'none';
            
        end
        
        
        % Build Button
        function handles = buildUIButton(obj,s,handles)
            
            s.pos = [0,0,obj.Pos(3:4)];
            T = s.Tag; s.id = 1;
            s.CallFun = @(hObject,eventdata)buttonClicked...
                (T,hObject,guidata(hObject));
            obj.Buttons = buildButton(obj.Buttons,1,s);
            
            P1  = [obj.NormPos(2), sum(obj.NormPos([2,4]))];   
            P2  = [obj.NormPos(1), sum(obj.NormPos([1,3]))];   
            CIn = {s.id,obj.Tag,[P2 P1]};
            obj.viewTbl = [obj.viewTbl;CIn];
            
            % update View table
            handles.(obj.Tag) = obj;
            
            % upload to controller
            if ~isfield(handles,'UIControl')
                error('Controler Needs to Be Defined')
            end
            
            handles.UIControl = updateTable...
                (handles.UIControl,'view',obj.viewTbl,obj.Tag);
            
        end
        
                
        % Setup Axes Limits:
        function obj = setAxesLimits(obj)
            
            obj.Axes.Units = 'centimeters'; obj.Pos = obj.Axes.Position;
            obj.Axes.Units = 'normalized'; obj.NormPos = obj.Axes.Position;
            obj.Axes.XLim = [0,obj.Pos(3)]; obj.Axes.YLim = [0,obj.Pos(4)];
            
        end
        
        
        % Setup Settings:
        function obj = setupSettings(obj,Color)
          
          
            % box
            obj.id = 1;
            obj.Color       = Color;        % Box Color
            obj.CColor      = Color.*1.45;  % Box Color
            obj.Highlight   = Color.*1.25;  % Box Highlight
            
            obj.CColor(obj.CColor > 1) = 1;
            obj.Highlight(obj.Highlight > 1) = 1;
            
            obj.Settings.Width       = obj.Pos(3);   % Box Width
            obj.Settings.Height      = obj.Pos(4);   % box height
            obj.Settings.Curvature   = 0; % set to .1 to curve edges
            
            
            % text
            obj.FontColor   = [.98 .98 .98];  % Color of text box
            obj.FontHColor  = [.98 .98  1];   % Color of text box
            obj.FontCColor  = [.98 .98  1];   % Color of text box
            obj.FontSize    = 10;             % font size
            obj.FontAngle   = 'normal';     % font angle
            obj.FontWeight  = 'normal';     % font weight
            
            % other
            obj.Pos = obj.Pos;
            obj.Settings.Visible = true;
            
        end
     
        
        % set Callback:
        function obj = setUICallback(obj,call)
            
            obj.Callback = call;
            
        end
        
        
        % Edit Visibility
        function handles = editVisibility(O,handles,T)
            
            if nargin == 2
                if O.Settings.Visible, O.Settings.Visible = false; else
                    O.Settings.Visible = true;
                end, T = O.Settings.Visible; else, O.Settings.Visible = T;
            end
            
            
            if T
                O.Axes.Visible  = 'on';
                O.Box.Visible   = 'on';
                O.Text.Visible  = 'on';
                handles.UIControl = updateViewTbl...
                (handles.UIControl,O.viewTbl,O.Tag);

            else
                O.Axes.Visible  = 'off';
                O.Box.Visible   = 'off';
                O.Text.Visible  = 'off';
                handles.UIControl = clearTagInViewTbl...
                    (handles.UIControl,O.Tag);

            end
            
            handles.(O.Tag) = O;
            
            
        end
        
        
        % Default Hover Callback:
        function O = hoverDefault(O,Id)
            
            if O.Clicked
                O.Buttons = editColor(O.Buttons,Id,O.CColor,O.FontHColor);
            else
                O.Buttons=editColor(O.Buttons,Id,O.Highlight,O.FontHColor);
            end
            

        end
        
        
        % Turn Off Hover Click:
        function O = turnOffHoverDefault(O,Id)
            
            O.Clicked = false;
            O.Buttons = editColor(O.Buttons,Id,O.Color,O.FontColor);
            
        end
        
        
        % Click Button:
        function [handles,hObject] = buttonClick(O,Id,handles,hObject)
            
             O.Buttons = editColor(O.Buttons,Id,O.CColor,O.FontCColor);
             handles.(O.Tag) = O;
             if ~isempty(O.Callback)
                 [handles,hObject] = feval(O.Callback{:},...
                     O.Tag,handles,hObject);
             end
             
        end
        
    end
    
end



function buttonClicked(T,hObject,H)

[H,hObject] = buttonClick(H.(T),hObject.UserData,H,hObject);
guidata(hObject, H);

end

