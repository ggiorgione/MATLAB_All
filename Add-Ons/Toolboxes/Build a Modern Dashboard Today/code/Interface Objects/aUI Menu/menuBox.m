classdef menuBox
    % Menu box Sub Object
    
    properties
        
        % Id Data:
        Clicked;
        Type;     % 1, highlight 2, click 3, normal
        Id;
        Field;
        Sett;
        Left;     % Middle Position
        CallFun;  % Callback Function
        
        % Plotable Objects:
        Text;
        Box;
        Bar;
    end
    
    methods
        
        % Constructor:
        function obj = menuBox(S,strct,O)
            
            obj.Id    = strct.id;
            obj.Field = strct.Field;
            obj.Sett  = S;
            if nargin == 3, if ~isempty(O), obj = [O;obj];  end,  end
            
        end
        
        
        % Axes Settings:
        function obj = nodeSettings(obj,Pos)
            
            Bar_Height = .075;
            
            % Backround Box Settings:
            obj.Sett.barColor    = ([92,151,191])./255;
            FontColor = [253, 227, 167]./255;
            % Backround Box Settings:
            obj.Sett.barH      = Bar_Height;
            obj.Sett.Height    = Pos(4);
            obj.Sett.Width     = 4;
            obj.Sett.Color     = 'none';
            obj.Sett.CColor    = [.75 .75 .8];
            obj.Sett.Highlight = [.75 .75 .8];
            
            
            % Text Box Settings:
            obj.Sett.FontSize = 12;            % Font Size, Text box Legend
            obj.Sett.FontColor  = FontColor;    % Color of text box Legend
            obj.Sett.FontHColor = FontColor; % Color of text box Legend
            obj.Sett.FontCColor = FontColor; % Color of text box Legend
            
            % Figure Info
            obj.Sett.Pos = Pos;
            obj.Sett.AxesType = 'OuterPosition';
            
        end
        
 
        % Menu Box Settings:
        function obj = MenuBoxSettings(obj,id,type,click)
            
            [~,I] = ismember(id,[obj.Id]);
            
            if nargin == 4, obj(I).Clicked = click; 
            else
                if obj(I).Clicked && type == 1,      type = 3;
                elseif ~obj(I).Clicked && type == 3, type = 1;
                end
            end,   obj(I).Type = type;
            
            
            switch obj(I).Type
                case 1
                    RA = {obj(I).Sett.Color,obj(I).Sett.Color};
                    set(obj(I).Box,{'FaceColor','EdgeColor'},RA)
                    obj(I).Text.Color = obj(I).Sett.FontColor;
                    obj(I).Bar.Visible = 'off';
                    
                case 2
                    RA = {obj(I).Sett.Highlight,obj(I).Sett.Highlight};
                    set(obj(I).Box,{'FaceColor','EdgeColor'},RA)
                    obj(I).Text.Color = obj(I).Sett.FontHColor;
                    obj(I).Bar.Visible = 'on';
                    
                case 3
                    RA = {obj(I).Sett.CColor,obj(I).Sett.CColor};
                    set(obj(I).Box,{'FaceColor','EdgeColor'},RA)
                    obj(I).Text.Color = obj(I).Sett.FontCColor;
                    obj(I).Bar.Visible = 'on';
            end
            
        end
        
        
        % edit the visibility of the Objects
        function obj = editVisibility(obj,varargin)
            % Case one is passed just T {'on'|'off'}
            % Case two is passed id of obj's for T to turn {'on'|'off'}
            
            switch length(varargin)
                case 1, T = varargin{1}; I = 1:length(obj);
                case 2, I = ismember([obj.Id],varargin{1});T = varargin{2};  
            end
            
            
            for i = 1:length(I)
                if obj(I(i)).Type ~= 1, obj(I(i)).Bar.Visible  = T; end
                obj(I(i)).Box.Visible  = T;
                obj(I(i)).Text.Visible = T;
            end
            
        end
        
        
    end
    
    
    methods

             
        % Create Menu:
        function [obj,left] = buildMenu(obj,Info)
            
            [~,I] = ismember(Info.Id,[obj.Id]);
            obj(I).CallFun = Info.CallBack;
            obj(I).Left = Info.left;
            obj(I) = PlotRectangularBox(obj(I));
            obj(I) = PlotTextField(obj(I));
            obj(I) = underlineBar(obj(I));
            left = obj(I).Left + obj(I).Sett.Width;
            obj(I) = MenuBoxSettings(obj(I),obj(I).Id,1,false);
            
        end
        
                
        % Plot Text Field:
        function O = PlotTextField(O)
            
            % Text Box Dimensions:
            TLft = O.Left + O.Sett.Width/2;
            TBot = O.Sett.Height/2;
            
            if isempty(O.Text)
                % Set Text Box:
                Txt = plotTxtMiddle(TLft,TBot,O.Field,'Clipping','on');
                Txt.Color = O.Sett.FontColor;
                Txt.FontSize = O.Sett.FontSize;
                Txt.ButtonDownFcn = O.CallFun;
                Txt.UserData = O.Id;
                Txt.Units = 'centimeter';
                O.Text = Txt;
            else
                O.Text.Units = 'centimeter';
                O.Text.Position = [TLft, TBot, 0];
            end
            
            
        end
        
        
        % Plot Rectangular Box:
        function O = PlotRectangularBox(O)
            
            % Calculate Position:
            H = O.Sett.barHeight;
            Pos = [O.Left,H,O.Sett.Width,O.Sett.Height-2*H];
            
            % Set Rectangluar Box:
            if isempty(O.Box)
                Rec = rectangle('Position',Pos,...
                    'Curvature',O.Sett.Curvature,'Clipping','off');
                Rec.ButtonDownFcn = O.CallFun;
                Rec.UserData      = O.Id;
                Rec.FaceColor     = O.Sett.Color;
                Rec.EdgeColor     = O.Sett.Color;
                O.Box = Rec; 
            else
                O.Box.Position = Pos;
            end
        end
 
        
        % Generate Underline Bar:
        function obj = underlineBar(obj)
            
            Shift = 0; %obj.Sett.Width*.1;
            W = obj.Sett.Width - Shift;
            H = obj.Sett.barHeight;
            
            % Calculate Position:
            Pos    = [obj.Left+Shift/2,0,W,H];
            
            % Set Rectangluar Box:
            if isempty(obj.Bar)
                Rec = rectangle('Position',Pos,'Curvature',...
                    1,'Clipping','off');
                Rec.ButtonDownFcn = obj.CallFun;
                Rec.UserData  = obj.Id;
                Rec.FaceColor = obj.Sett.barColor;
                Rec.EdgeColor = 'none';
                Rec.LineWidth = .5;
                Rec.Visible = 'off';
                obj.Bar = Rec;
            else
                obj.Bar.Position = Pos;
            end
        end
        
              
    end
    
end


% plot text in middle of location:
function H = plotTxtMiddle(W,H,varargin)

H = text(W,H,varargin{:});
H.Position(1) = W - H.Extent(3)/2;

end

