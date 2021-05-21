classdef UItableo
    % setupSettingsIcon look at the following function to build images.
    
    
    
    % Graphical Objects & Axes properties:
    properties (Dependent)
        setMute
        Visible
        Table;
        Last;
        
        Color;
        Highlight;
        CColor;
        FontColor;
        FontHColor;
        FontCColor;
        FontSize;
        
        HeaderColor;
        HeaderHighlight;
        HeaderCColor;
        HeaderFontColor;
        HeaderFontHColor;
        HeaderFontCColor;
        HeaderFontSize;
        
        ButtonHeight;
        ButtonWidth;
        ButtonIndent;
        ButtonSpace;
        
        
        ButtonFont;
        ButtonFontColor;
        ButtonFontSize;
        ButtonWeight;
        ButtonCColor;
        ButtonColor;
        ButtonHighlight;
        ButtonFontAngle;
        ButtonCurvature;
        ButtonFontHColor;
        ButtonFontCColor;
        
        MenuColor;
        MenuHeight;
        BarColor;
    end
    
    
    % Visible Properties:
    properties
        
        Page;
        Tag;        % Name of object in handles
        Callback;
        Columns;
        RowHeight;
        
        
        ESettings;
        HSettings;
        BSettings;
        MSettings;
        SSettings;
        BPSettings;
        BarSettings;
        BarHeight;
        Elements;
        
        TblInfo;      % TblInfo Structure
        Axes;
        Menu_Axes;
        Control_Axes;
        Rows    
        Space   
        Width
        LastHeader;
        elementTbl; % Holds info on stack nodes and how to find them
        
    end
    
    
    % Hidden Properties:
    properties (SetAccess = 'public', GetAccess = 'public', Hidden = true)
        
        
        % Axes and Info:
        Pos;              NormPos;
        Menu_Pos,         Menu_NormPos  
        Control_NormPos,  Control_Pos  
        
        % Plot Objects:
        SearchBar;    % object
        SettingsIcon; % need to create object for this graph type
        Buttons;
        
        % Main Variables:
        Id;         % Current Id number for generation
        TableSize;  % the dimensions of the table
    
        
        % Tables:
        
        hoverTbl;   % hover table
        viewTbl;    % view table
        idTbl;      % id table
        Visibility;
        
        
    end

    
    % set and get Methods:
    methods 
        
        function O = set.setMute(O,T)
            O.SearchBar.setMute = T; 
        end
        
        function T = get.BarColor(O)
            T = O.BarSettings.BarColor;            
        end
        
        function O = set.BarColor(O,T)
            O.BarSettings.BarColor = T;
            if ~isempty(O.Control_Axes)
                O.Control_Axes.Color = T;
            end
        end
        
        function O = set.MenuColor(O,T)
            O.MSettings.MenuColor = T;
            if ~isempty(O.Menu_Axes)
                O.Menu_Axes.Color = T;
                O = setupSettingsIcon(O);
            end
        end
        
        function O = set.MenuHeight(O,T)
            O.MSettings.MenuHeight = T;
        end
        
        function T = get.MenuColor(O)
            T = O.MSettings.MenuColor;
        end
        
        function T = get.MenuHeight(O)
            T = O.MSettings.MenuHeight;
        end
        
        
        function O = set.ButtonHeight(O,T)
            O.BPSettings.ButtonHeight = T;
        end
        
        function O = set.ButtonWidth(O,T)
            O.BPSettings.ButtonWidth = T;
        end
        
        function O = set.ButtonIndent(O,T)
            O.BPSettings.ButtonIndent = T;
        end
        
        function O = set.ButtonSpace(O,T)
            O.BPSettings.ButtonSpace = T;
        end
        
        function O = set.ButtonFont(O,T)
            O.BSettings.Font = T;
        end
        
        
        
        function O = set.ButtonFontHColor(O,T), O.BSettings.FontHColor = T;
        end
        
        function O = set.ButtonFontCColor(O,T), O.BSettings.FontCColor = T;
        end

        function O = set.ButtonFontColor(O,T), O.BSettings.FontColor = T;
            
            if ~isempty(O.Buttons)
               for i = 1:length(O.Buttons)
                   O.Buttons(i).FontColor = T;
               end
            end
            
        end
        
        function O = set.ButtonFontSize(O,T), O.BSettings.FontSize = T;
            
            if ~isempty(O.Buttons)
               for i = 1:length(O.Buttons)
                   O.Buttons(i).FontSize = T;
               end
            end
            
        end
        
        function O = set.ButtonWeight(O,T), O.BSettings.FontWeight = T;
            
            if ~isempty(O.Buttons)
               for i = 1:length(O.Buttons)
                   O.Buttons(i).FontWeight = T;
               end
            end
            
        end
        
        function O = set.ButtonCColor(O,T),  O.BSettings.CColor = T; 
        end
        
        function O = set.ButtonColor(O,T), O.BSettings.Color = T;
            
            if ~isempty(O.Buttons)
               for i = 1:length(O.Buttons)
                   O.Buttons(i).Color = T;
               end
            end
        end
        
        function O = set.ButtonHighlight(O,T),  O.BSettings.Highlight = T;
        end
        
        function O = set.ButtonFontAngle(O,T), O.BSettings.FontAngle = T;
            
            if ~isempty(O.Buttons)
               for i = 1:length(O.Buttons)
                   O.Buttons(i).FontAngle = T;
               end
            end
            
        end
        
        function O = set.ButtonCurvature(O,T), O.BSettings.Curvature = T;
            
            if ~isempty(O.Buttons)
               for i = 1:length(O.Buttons)
                   O.Buttons(i).Curvature = T;
               end
            end
            
            
        end
        
        
        
        function O = set.HeaderColor(O,T), O.HSettings.Color = T;
            
            if ~isempty(O.Elements), N = 'elementTbl';
                ID = O.(N).id(O.(N).type == 1 & O.(N).row == 0);
                [~,I] = ismember(ID,[O.Elements.Id]);
                for i = 1:length(I)
                    O.Elements(I(i)).Color = T;
                end
            end
            
        end
        
        function O = set.HeaderHighlight(O,T), O.HSettings.Highlight = T;
            
            if ~isempty(O.Elements), N = 'elementTbl';
                ID = O.(N).id(O.(N).type == 2 & O.(N).row == 0);
                [~,I] = ismember(ID,[O.Elements.Id]);
                for i = 1:length(I)
                    O.Elements(I(i)).Color = T;
                end
            end
            
        end
        
        function O = set.HeaderCColor(O,T), O.HSettings.CColor = T;
            
            if ~isempty(O.Elements), N = 'elementTbl';
                ID = O.(N).id(O.(N).type == 3 & O.(N).row == 0);
                [~,I] = ismember(ID,[O.Elements.Id]);
                for i = 1:length(I)
                    O.Elements(I(i)).Color = T;
                end
            end
            
        end
        
        function O = set.HeaderFontColor(O,T), O.HSettings.FontColor = T;
            
            if ~isempty(O.Elements), N = 'elementTbl';
                ID = O.(N).id(O.(N).type == 1 & O.(N).row == 0);
                [~,I] = ismember(ID,[O.Elements.Id]);
                for i = 1:length(I)
                    O.Elements(I(i)).FontColor = T;
                end
            end
            
        end
        
        function O = set.HeaderFontHColor(O,T), O.HSettings.FontHColor = T;
            
            if ~isempty(O.Elements), N = 'elementTbl';
                ID = O.(N).id(O.(N).type == 2 & O.(N).row == 0);
                [~,I] = ismember(ID,[O.Elements.Id]);
                for i = 1:length(I)
                    O.Elements(I(i)).FontColor = T;
                end
            end
            
        end
        
        function O = set.HeaderFontCColor(O,T), O.HSettings.FontCColor = T;
            
            if ~isempty(O.Elements), N = 'elementTbl';
                ID = O.(N).id(O.(N).type == 3 & O.(N).row == 0);
                [~,I] = ismember(ID,[O.Elements.Id]);
                for i = 1:length(I)
                    O.Elements(I(i)).FontColor = T;
                end
            end
            
        end
        
        function O = set.HeaderFontSize(O,T), O.HSettings.FontSize = T;
            
            if ~isempty(O.Elements), N = 'elementTbl';
                ID = O.(N).id(O.(N).row == 0);
                [~,I] = ismember(ID,[O.Elements.Id]);
                for i = 1:length(I)
                    O.Elements(I(i)).FontSize = T;
                end
            end
        end
        
        

        function O = set.Color(O,T), O.ESettings.Color = T;
            
            if ~isempty(O.Elements), N = 'elementTbl';
                ID = O.(N).id(O.(N).type == 1 & O.(N).row ~= 0);
                [~,I] = ismember(ID,[O.Elements.Id]);
                for i = 1:length(I)
                    O.Elements(I(i)).Color = T;
                end
            end
            
        end
        
        function O = set.Highlight(O,T), O.ESettings.Highlight = T;
            
            if ~isempty(O.Elements), N = 'elementTbl';
                ID = O.(N).id(O.(N).type == 2 & O.(N).row ~= 0);
                [~,I] = ismember(ID,[O.Elements.Id]);
                for i = 1:length(I)
                    O.Elements(I(i)).Color = T;
                end
            end
            
        end
        
        function O = set.CColor(O,T), O.ESettings.CColor = T;
            
            if ~isempty(O.Elements), N = 'elementTbl';
                ID = O.(N).id(O.(N).type == 3 & O.(N).row ~= 0);
                [~,I] = ismember(ID,[O.Elements.Id]);
                for i = 1:length(I)
                    O.Elements(I(i)).Color = T;
                end
            end
            
        end
        
        function O = set.FontColor(O,T), O.ESettings.FontColor = T;
            
            if ~isempty(O.Elements), N = 'elementTbl';
                ID = O.(N).id(O.(N).type == 1 & O.(N).row ~= 0);
                [~,I] = ismember(ID,[O.Elements.Id]);
                for i = 1:length(I)
                    O.Elements(I(i)).FontColor = T;
                end
            end
            
        end
        
        function O = set.FontHColor(O,T), O.ESettings.FontHColor = T;
            
            if ~isempty(O.Elements), N = 'elementTbl';
                ID = O.(N).id(O.(N).type == 2 & O.(N).row ~= 0);
                [~,I] = ismember(ID,[O.Elements.Id]);
                for i = 1:length(I)
                    O.Elements(I(i)).FontColor = T;
                end
            end
            
        end
        
        function O = set.FontCColor(O,T), O.ESettings.FontCColor = T;
            
            if ~isempty(O.Elements), N = 'elementTbl';
                ID = O.(N).id(O.(N).type == 3 & O.(N).row ~= 0);
                [~,I] = ismember(ID,[O.Elements.Id]);
                for i = 1:length(I)
                    O.Elements(I(i)).FontColor = T;
                end
            end
            
        end
        
        function O = set.FontSize(O,T), O.ESettings.FontSize = T;
            
            if ~isempty(O.Elements), N = 'elementTbl';
                ID = O.(N).id(O.(N).row ~= 0);
                [~,I] = ismember(ID,[O.Elements.Id]);
                for i = 1:length(I)
                    O.Elements(I(i)).FontSize = T;
                end
            end
        end
        
        
        
        function T = get.ButtonHeight(O)
            T = O.BPSettings.ButtonHeight;
        end
        
        function T = get.ButtonWidth(O)
            T = O.BPSettings.ButtonWidth;
        end
        
        function T = get.ButtonIndent(O)
            T = O.BPSettings.ButtonIndent;
        end
        
        function T = get.ButtonSpace(O)
            T = O.BPSettings.ButtonSpace;
        end
        
        
        function T = get.ButtonFont(O)
            T = O.BSettings.Font;
        end
        
        function T = get.ButtonFontColor(O)
            T = O.BSettings.FontColor;
        end
        
        function T = get.ButtonFontSize(O)
            T = O.BSettings.FontSize;
        end
        
        function T = get.ButtonWeight(O)
            T = O.BSettings.FontWeight;
        end
        
        function T = get.ButtonCColor(O)
            T = O.BSettings.CColor;
        end
        
        function T = get.ButtonColor(O)
            T = O.BSettings.Color;
        end
        
        function T = get.ButtonHighlight(O)
            T = O.BSettings.Highlight;
        end
        
        function T = get.ButtonFontAngle(O)
            T = O.BSettings.FontAngle;
        end
        
        function T = get.ButtonCurvature(O)
            T = O.BSettings.Curvature;
        end
        
        
        
        
        % Get Information on Last Selection
        function d = get.Last(O)
            
            d.row = O.TblInfo.map(O.TblInfo.row + O.TblInfo.idx-1);
            d.column = O.TblInfo.Flds(O.TblInfo.col);
            
            if isempty(O.TblInfo.header)
                d.header = 'no header selected'; else
                d.header = O.TblInfo.Flds(O.TblInfo.header(1));
            end
            
            d.data =  O.TblInfo.tbl(O.TblInfo.row + O.TblInfo.idx-1,:);
            
        end
        
        
        % get Visibility
        function v = get.Visible(O)
            
            v = O.Visibility;
            
        end
        
        
        % Edit Visibility
        function O = set.Visible(O,T)
            
            
            if isempty(O.Elements)||isempty(O.Buttons)||...
                    isempty(O.SearchBar), return
            end
            
            
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
           
            
            if O.Visibility
                O.Axes.Visible = 'on';      O.SettingsIcon.Visible = 'on';
                O.Menu_Axes.Visible = 'on'; O.Control_Axes.Visible = 'on';
                O.Elements  = editVisibility(O.Elements,'on');
                O.Buttons   = editVisibility(O.Buttons,'on');
                O.SearchBar = editVisibility(O.SearchBar,'on');
            else
                O.Elements  = editVisibility(O.Elements,'off');
                O.Buttons   = editVisibility(O.Buttons,'off');
                O.SearchBar = editVisibility(O.SearchBar,'off');
                O.SettingsIcon.Visible = 'off';
                O.Control_Axes.Visible = 'off';
                O.Axes.Visible         = 'off';
                O.Menu_Axes.Visible    = 'off';
            end

        end
        
        
        % Load TblInfo:
        function tbl = get.Table(obj)
            
            tbl = obj.TblInfo.tbl;
            
        end
        
        
        % Set Values of Slider:
        function obj = set.Callback(obj,v)
            
            if iscell(v) || isempty(v)
                obj.Callback = v;
            else
               error(['invalid callback visit https://www.goldenoak',...
                   'research.com/moderngui For more details']) 
            end
            
        end
        
        
        % Load TblInfo:
        function obj = set.Table(obj,tbl)
            
            if ~istable(tbl)
                error(['invalid table input visit https://www.goldenoak',...
                   'research.com/moderngui For more details']) 
            end
            
            obj.TblInfo.tbl     = tbl;
            obj.TblInfo.row     = 1;
            obj.TblInfo.col     = 1;
            obj.TblInfo.size    = size(tbl,1);
            obj.TblInfo.map     = 1:obj.TblInfo.size(1);
            obj.TblInfo.idx     = 1;
            obj.TblInfo.id      = [];
            obj.TblInfo.header  = [];
            
            obj.TableSize = [obj.Rows,obj.Columns];
            Flds = tbl.Properties.VariableNames(1:obj.Columns);
            obj.TblInfo.Flds = Flds;
            obj = UploadTable(obj);
            
        end
        
        
    end
    
    
    % Create TblInfo Methods:
    methods (Access = 'public', Static = false, Hidden = true)
                
        % Constructor:
        function obj = UItableo(s)
            
            
            pos = s.Position;  N = properties(obj); 
            F = fieldnames(s); N = N(ismember(N,F)); obj.Page = s.Page;
            for i = 1:length(N), obj.(N{i}) = s.(N{i}); end
            Default = [.94 .94 .95]; obj.Id = 0; % Setup Id TblInfo
            FLOOR = pos(2); H = obj.BarHeight;
            
            % Setup Tables Data:
            Names = {'id','property'}; obj.idTbl = cell2table(cell(0,2));
            obj.idTbl.Properties.VariableNames = Names;
            Names = {'id','row','column','type','clicked'}; % Element TblInfo
            obj.elementTbl = cell2table(cell(0,5));
            obj.elementTbl.Properties.VariableNames = Names;
            Names = {'id','tag','pos'}; % Setup View TblInfo
            obj.viewTbl = cell2table(cell(0,3));
            obj.viewTbl.Properties.VariableNames = Names;

            
            [obj,pos] = setupMenuBar(obj,pos); % Step 1 - setup menu
            if nargin < 4, Units = 'normalized'; end % Step 2 - setup tbl
            obj.Axes = axes('Position',pos,'Units',Units);
            Saved = obj.Axes.Units; obj.Axes.Units = 'centimeters';
            POS = obj.Axes.Position;
            obj.Axes.Position([2 4]) = [POS(2) + H, POS(4) - H];
            obj.Axes.Units = Saved; pos = obj.Axes.Position;
            Flds ={'YColor','XColor','XTick','YTick','Tag','Color'};
            Sets = {'none','none',[],[],obj.Tag,Default}; % Set Defaults
            set(obj.Axes,Flds,Sets);  obj = setAxesLimits(obj);
            
            
            pos([2 4]) = [FLOOR,pos(2) - FLOOR]; % Step 3 - Load Controls
            obj = setupControlBar(obj,pos);
            obj = setupSettings(obj);
            
        end
        
        
        % Update in UI Control: 
        function handles = updateControl(O,handles)
           
            if obj.Visibility
                handles.UIControl = updateViewTbl...
                    (handles.UIControl,O.viewTbl,O.Tag);
            else
                handles.UIControl = clearTagInViewTbl...
                    (handles.UIControl,O.Tag);
            end
            
        end
        
        
        % Setup Settings:
        function O = setupSettings(O)

            % box
            O.Rows   = floor(O.Pos(4)/O.RowHeight);
            O.Space  = (O.Pos(4) - O.RowHeight*O.Rows)/(O.Rows+1);
            O.Width  = O.Pos(3)/O.Columns.*ones(1,O.Columns);

        end
        
        
        % Setup Axes Limits:
        function obj = setAxesLimits(obj)
            
            obj.Axes.Units = 'centimeters'; obj.Pos = obj.Axes.Position;
            obj.Axes.Units = 'normalized'; obj.NormPos = obj.Axes.Position;
            obj.Axes.XLim = [0,obj.Pos(3)]; obj.Axes.YLim = [0,obj.Pos(4)];
            
        end
        
        
        % Build Axes for Menu Bar
        function [O,Pos_Ret] = setupMenuBar(O,pos)
            
            
            Default = O.MenuColor; H = O.MenuHeight;            
            % Create Menu_Axes:
            if nargin < 3, Units = 'normalized'; end
            O.Menu_Axes = axes('Position',pos,'Units',Units);
            Saved = O.Menu_Axes.Units; O.Menu_Axes.Units = 'centimeters';
            POS = O.Menu_Axes.Position;  % Menu_Axes Position
            O.Menu_Axes.Position([2 4]) = [sum(POS([2 4])) - H,H];
            O.Menu_Axes.Units = Saved; POS = O.Menu_Axes.Position;
            Pos_Ret = [pos([1 2 3]),pos(4) - POS(4)];
            Flds ={'YColor','XColor','XTick','YTick','Color'};
            set(O.Menu_Axes,Flds,{'none','none',[],[],Default});
            O.Menu_Axes.Units = 'centimeters';
            O.Menu_Pos = O.Menu_Axes.Position;
            O.Menu_Axes.Units = 'normalized';
            O.Menu_NormPos = O.Menu_Axes.Position;
            O.Menu_Axes.XLim = [0,O.Menu_Pos(3)];
            O.Menu_Axes.YLim = [0,O.Menu_Pos(4)];
            O = createUIControl(O);

        end
        
                
        % Setup Control Bar
        function O = setupControlBar(O,pos)

            
            % Create Menu_Axes:
            if nargin < 3, Units = 'normalized'; end
            O.Control_Axes = axes('Position',pos,'Units',Units);                
            Flds ={'YColor','XColor','XTick','YTick','Color'};
            set(O.Control_Axes,Flds,{'none','none',[],[],O.BarColor});
            O.Control_Axes.Units = 'centimeters';
            O.Control_Pos = O.Control_Axes.Position;
            O.Control_Axes.Units = 'normalized';
            O.Control_NormPos = O.Control_Axes.Position;
            O.Control_Axes.XLim = [0,O.Control_Pos(3)];
            O.Control_Axes.YLim = [0,O.Control_Pos(4)];
            O = setupControls(O);
            
        end
        
        
    end
    

    % Most Used Functions:
    methods (Access = 'public', Static = false, Hidden = true)
        
        % Build TblInfo:
        function [handles] = buildTable(O,handles)
            % here the table core is built
            
            T = O.Tag;
            B1 = @(hObject,eventdata)sortTbl(T,hObject,guidata(hObject));
            B2 = @(hObject,eventdata)TblClick(T,hObject,guidata(hObject));
            Info = O.HSettings; Info.Callback = B1;
                
            if O.Axes ~= gca, axes(O.Menu_Axes); end % chck cur axes
            ST = O.Menu_NormPos([3 3 4 4])./O.Menu_Pos([3 3 4 4]);
            L = 0; Top = O.Menu_Pos(4);
            for k = 1:O.Columns
                
                % Calculate X & Y Positions
                O.Id = O.Id + 1; W = O.Width(k); R = L + W;
                Y = [0,O.RowHeight]; X = [L,L + R];
                
                % Set up info Struct to send to the element
                Info.boxPosition = [L,0,W,Y(2)];
                Info.txtPosition = [X(1)+W*.1,Y(1)+Y(2)/2];
                P = ([L R 0 Top])*diag(ST) + O.Menu_NormPos([1,1,2,2]);
                Info.Id  = O.Id; Info.Column = k;
                Info.Row = 0;    Info.String = ' ';
                O = addElement(O,Info,P); L = R;
                
            end
            
            
            Info = O.ESettings; Info.Callback = B2;
            if O.Axes ~= gca, axes(O.Axes); end % check current axes
            ST = O.NormPos([4 4])./O.Pos([4 4]); Bot = O.Pos(4);
            
            for i = 1:O.Rows, Top = Bot; R = 0; % row
                Bot = Top - O.RowHeight - O.Space;
                P = [O.NormPos(1),sum(O.NormPos([1 3])),...
                    ([Bot Top])*diag(ST) + O.NormPos([2,2])];
                
                
                for j = 1:O.Columns, L = R; % col
                    
                    % Calculate X & Y Positions
                    O.Id = O.Id + 1; W = O.Width(j);  R = L + W;
                    Y = [Bot,O.RowHeight]; X = [L,L + R];
                    
                    % Set up info Struct to send to the element
                    Info.boxPosition = [L,Bot,W,Y(2)];
                    Info.txtPosition = [X(1)+W*.1,Y(1)+Y(2)/2];
                    Info.Id = O.Id;  Info.Column = j;
                    Info.Row    = i; Info.String = ' ';
                    
                    if j == 1, O.viewTbl = [O.viewTbl;{O.Id,{O.Tag},P}]; 
                    end, O = addElement(O,Info,P); % Upload element  
                end   
            end, handles.(O.Tag) = O; % update View table
            handles.UIControl = updateTable...
                (handles.UIControl,'view',O.viewTbl,O.Tag);
            
        end
        
        
        % Add Elements to table:
        function O = addElement(O,S,P)
            % R = Row,  C = Column, P = Position
            
            if S.Row == 0, O.viewTbl = [O.viewTbl;{O.Id,{O.Tag},P}]; end
            
            % Upload data to table and Elements:
            tmpVar       = {O.Id,S.Row,S.Column,1,false};
            O.idTbl      = [O.idTbl;{O.Id,'Elements'}];
            O.elementTbl = [O.elementTbl;tmpVar];
            O.Elements   = UIelemento(S,O.Elements);
            
        end
        
                
        % Add Graphical Objects
        function obj = createUIControl(obj)
            hold on
            
            
            % Internal Settings:
            cm_height   = .5;
            cm_width    = 3.5;
            cm_indent   = .35;
            cm_H        = 1;
            
            Bottom = obj.Menu_Pos(4) - cm_H/2 - cm_height/2;
            Left   = obj.Menu_Pos(3) - cm_width - cm_indent;
            pos    = [Left,Bottom,cm_width,cm_height];
            obj.SearchBar = uiEditText(-1,obj.Menu_Pos,obj.Menu_NormPos);
            obj.SearchBar = buildEditText(obj.SearchBar,pos);
            
            
            % create magnify glass*
            obj.SSettings.c1 = [pos(1),pos(2)+pos(4)/2];
            obj.SSettings.r = pos(4)/2;           
            obj = setupSettingsIcon(obj);


        end
        
        
        % Setup Icons
        function obj = setupSettingsIcon(obj)
            
            if obj.Menu_Axes ~= gca, axes(obj.Menu_Axes); end
            if ~isempty(obj.SettingsIcon)
               delete(obj.SettingsIcon) 
            end
            
            D = obj.Menu_Axes.Color.*255;
            
            % Internal Settings:
            cm_height   = .5;
            cm_width    = 3.5;
            cm_indent   = .35;
            cm_H        = 1;
            
            Bottom = obj.Menu_Pos(4) - cm_H/2 - cm_height/2;
            Top = obj.Menu_Pos(4) - cm_H/2 + cm_height/2;
            Right   = obj.Menu_Pos(3) - cm_width - cm_indent;
            Left   = obj.Menu_Pos(3) - cm_width - cm_indent - cm_height;
            
            Span = [5 5]; RC = 217; GC = 217; BC = 217;
            myImg = imread('settingsicon1.jpg');
            myImg = changeColor(myImg,RC,GC,BC,D(1),D(2),D(3),50,18);
            myImg = imageFilter(myImg,Span,RC,GC,BC);
            icn = imagesc([Left,Right],[Bottom,Top], myImg);
            obj.SettingsIcon = icn;
            
        end
        
             
        % Setup Controls in control bar
        function O = setupControls(O)
            % sets.FontColor  = [.98 .98 .98];
            % sets.FontHColor = ([253,227,167])./255;
            % Internal Settings:
            hold on
            
            % Box
            
            

            % Extract Fixed ValuesL
            s = O.BSettings; T = O.Tag;
            ST = O.Control_NormPos([3 3 4 4])./O.Control_Pos([3 3 4 4]);
            B = {@(hObject,eventdata)nxtTbl(T,hObject,guidata(hObject))};
            B{2} = @(hObject,eventdata)backTbl(T,hObject,guidata(hObject));
            L   = O.Control_Pos(3); Nmes = {'Next','Back'};
            
            for i = 1:2
                O.Id = O.Id + 1;
                Bot = O.Control_Pos(4)/2 - O.ButtonHeight/2;
                L   = L - O.ButtonWidth - O.ButtonIndent;
                A   = [L,L + O.ButtonWidth,Bot,Bot+O.ButtonHeight];
                s.pos = [L,Bot,O.ButtonWidth,O.ButtonHeight];
                P = A*diag(ST) + O.Control_NormPos([1,1,2,2]);
                
                
                % Info
                s.CallFun = B{i}; s.String  = Nmes{i}; s.id = O.Id;
                O.Buttons = uiButtono(s,O.Buttons);
                O.idTbl      = [O.idTbl;{O.Id,'Buttons'}];
                O.viewTbl    = [O.viewTbl;{O.Id,{O.Tag},P}];
            end
        end
        
    end

    
    % Callback Methods:
    methods (Access = 'public', Static = false, Hidden = true)
             
        % Default Hover Callback:
        function [O,L] = hoverDefault(O,id)
            
            if ~O.Visibility, L = false; return, end, L = true;
            Row = O.elementTbl.row(O.elementTbl.id == id); 

         
            if isempty(Row) % if row is empty assume its a button
                O.Buttons = editColor(O.Buttons,...
                    id,O.BSettings.Highlight,O.BSettings.FontHColor);
                
            elseif Row ~= 0 % if Row == 0 then assume menu bar
                I = (O.elementTbl.row == Row);
                O.elementTbl.type(I)  = 2;
                O.Elements = RowColor(O.Elements,Row,...
                    O.ESettings.Highlight,O.ESettings.FontHColor);
            elseif Row == 0
                I = (O.elementTbl.id == id);
                O.elementTbl.type(I)  = 2;
                O.Elements = ElementColor(O.Elements,id,...
                    O.HSettings.Highlight,O.HSettings.FontHColor);
            else
                
            end
                    
     
        end
        
        
        % Tbl Info Click:
        function [hndl,hOb] = tableClick(O,id,hndl,hOb)
            
            % Isolate data into rows & columns:
            Row = O.elementTbl.row(O.elementTbl.id == id);
            Col = O.elementTbl.column(O.elementTbl.id == id);
            I   = O.elementTbl.row == Row;
            
            if Row ~= 0 % if Row == 0 then assume menu bar
                O.TblInfo.row = Row; O.TblInfo.col = Col;
                O.TblInfo.id  = id;
                
                II = O.elementTbl.clicked & O.elementTbl.row ~= 0 & ~I;
                
                if any(II)
                    O.elementTbl.clicked(II) = false;
                    O.elementTbl.type(II)    = 1;
                    Rws = unique(O.elementTbl.row(II));
                    O.Elements = RowColor(O.Elements,Rws,...
                        O.ESettings.Color,O.ESettings.FontColor);
                end
                
                O.elementTbl.type(I) = 3; O.elementTbl.clicked(I) = true;
                if ~isempty(O.Callback)
                    [hndl,hOb] = feval(O.Callback{:},O.Tag,hndl,hOb);
                end
                
                O.Elements = RowColor(O.Elements,Row,...
                    O.ESettings.CColor,O.ESettings.FontCColor);
                hndl.(O.Tag) = O;
                
            else
                
                O.TblInfo.header = [Col,id]; II = I & O.elementTbl.clicked;
                I  = O.elementTbl.id == id;
                
                if any(II),ID = O.elementTbl.id(II);
                    O.elementTbl.clicked(II) = false;
                    O.elementTbl.type(II) = 1;
                    O.Elements = ElementColor(O.Elements,ID,...
                        O.HSettings.Color,O.HSettings.FontColor);
                end
                
                O.elementTbl.type(I) = 3; O.elementTbl.clicked(I) = true;
                O.Elements = ElementColor(O.Elements,id,...
                    O.HSettings.CColor,O.HSettings.FontCColor);
                hndl.(O.Tag) = O;
            end
        end
        
        
        % Turn off Hover Default:
        function O = turnOffHoverDefault(O,id)
            
            row = O.elementTbl.row(O.elementTbl.id == id);
            if isempty(row) % if row is empty assume its a button
                
                O.Buttons = editColor(O.Buttons,...
                    id,O.BSettings.Color,O.BSettings.FontColor);
                
            elseif row ~= 0 % if Row == 0 then assume menu bar
                
                II = ismember(O.elementTbl.row,row);
                if all(O.elementTbl.clicked(II))
                    O.elementTbl.type(II) = 3;
                    O.Elements = RowColor(O.Elements,row,...
                        O.ESettings.CColor,O.ESettings.FontCColor); else
                    O.elementTbl.type(II) = 1;
                    O.Elements = RowColor(O.Elements,row,...
                        O.ESettings.Color,O.ESettings.FontColor);
                end
                
            elseif row == 0 % if Row is equal to zero
                
                II = (O.elementTbl.id == id);
                if O.elementTbl.clicked(II), O.elementTbl.type(II)  = 3;
                    O.Elements = ElementColor(O.Elements,id,...
                        O.HSettings.CColor,O.HSettings.FontCColor); else
                    O.elementTbl.type(II)  = 1;
                    O.Elements = ElementColor(O.Elements,id,...
                        O.HSettings.Color,O.HSettings.FontColor);
                end
            else
                
            end
        end
        
    end
    
    
    % table Methods:
    methods (Access = 'public', Static = false, Hidden = false)
        
        
        % Next Page Button:
        function [O] = TableNext(O,id)
            
            O.Buttons = editColor(O.Buttons,...
                    id,O.BSettings.CColor,O.BSettings.FontCColor);
            
            II = O.elementTbl.clicked & O.elementTbl.row ~= 0;
            O.elementTbl.clicked(II)  = false;
            Rws = unique(O.elementTbl.row(II));
            O.TblInfo.id  = []; O.TblInfo.row = []; O.TblInfo.col = [];
            O.Elements = RowColor(O.Elements,Rws,...
                        O.ESettings.Color,O.ESettings.FontColor);
                
            
            
            % Checks length of Array Pointer
            if O.TblInfo.size(1) > O.TblInfo.idx + O.TableSize(1)
                O.TblInfo.idx=O.TblInfo.idx(1)+O.TableSize(1); else
                O.TblInfo.idx = O.TblInfo.size(1)-O.TableSize(1)+1;
            end
            
            % If Index is < 1 set to = 1
            if O.TblInfo.idx(1) < 1, O.TblInfo.idx(1) = 1; end
            O = UploadTable(O);
            
        end
        
        
        % Back Page Button:
        function [O] = TableBack(O,id)
            
            O.Buttons = editColor(O.Buttons,...
                    id,O.BSettings.CColor,O.BSettings.FontCColor);
            
            II = O.elementTbl.clicked & O.elementTbl.row ~= 0;
            O.elementTbl.clicked(II)  = false;
            Rws = unique(O.elementTbl.row(II));
            O.TblInfo.id  = []; O.TblInfo.row = []; O.TblInfo.col = [];
            O.Elements = RowColor(O.Elements,Rws,...
                        O.ESettings.Color,O.ESettings.FontColor);
            
          
            
            % checks to see the idc is not greater than table size
            if 1 <= O.TblInfo.idx - O.TableSize(1)
                
                O.TblInfo.idx = O.TblInfo.idx - O.TableSize(1); else
                O.TblInfo.idx = 1;
            end
            
            O = UploadTable(O);
            
            
        end
        
        
        % Search TblInfo Button:
        function [obj] = TableSearch(obj)
            % need to auto generate the text box
            
            if 1 == 1, error('needs to be recoded'), end
            if isempty(obj), return, end
            
            
            % Get String Find Index
            Str = getString(obj.SearchBar);
            index = getIndex(obj.TblInfo.tbl.(obj.TblInfo.Flds{1}),Str);
            
            
            % If index does not equal zero:
            if index ~= 0
                index = obj.TblInfo.map(index);
                obj.TblInfo.row = 1; obj.TblInfo.idx = index;
                obj = UploadTable(obj); else
                set(handles.(STag),'String','Error');
            end
            
        end
        
        
        % Display TblInfo:
        function obj = UploadTable(obj)
            % Need to write method to load data into objects
            
            
            if isempty(obj), return, end
            SL = obj.TblInfo.idx - 1;
            
            for i = 1:obj.TableSize(2)
                Str = obj.TblInfo.Flds{i};
                obj.Elements = updateString(obj.Elements,Str,0,i);  
            end
            
            
            % Create TblInfo:
            for I = 1:obj.TableSize(1)    
                for J = 1:obj.TableSize(2)
                    
                    L1 = size(obj.TblInfo.tbl,1) >= (I + SL);
                    L2 = length(obj.TblInfo.Flds) >= J;
                    
                    if L1 && L2
                        i = obj.TblInfo.map(I + SL);
                        Str = obj.TblInfo.tbl.(obj.TblInfo.Flds{J})(i); else
                        Str = {' '};
                    end
                    
                    obj.Elements = updateString(obj.Elements,Str,I,J);
                end
            end
            
        end
        
        
    end
    
    
    % Backround TblInfo Methods:
    methods (Access = 'public', Static = false, Hidden = true)
        
        % Sort table based on field:
        function obj = sortTable(obj,Field)
           
            if isNumber(Field), Field = obj.TblInfo.Flds{Field}; end
            if isempty(obj.TblInfo.tbl), return, end
            [~,obj.TblInfo.map] = sort(obj.TblInfo.tbl.(Field));
            obj.TblInfo.idx = 1; obj.TblInfo.row = 1; obj.TblInfo.col = 1;
            obj = UploadTable(obj);
            
        end
        
    end
    
    
end


function nxtTbl(T,hObject,handles)

[handles.(T)] = TableNext(handles.(T),hObject.UserData);
guidata(hObject, handles);

end


function backTbl(T,hObject,handles)

[handles.(T)] = TableBack(handles.(T),hObject.UserData);
guidata(hObject, handles);

end


function sortTbl(T,hObject,H)

C = H.(T).elementTbl{H.(T).elementTbl.id == hObject.UserData,'column'};
H.(T) = sortTable(H.(T),C);
[H,hObject] = tableClick(H.(T),hObject.UserData,H,hObject);
guidata(hObject, H);

end


function TblClick(T,hObject,H)

[H,hObject] = tableClick(H.(T),hObject.UserData,H,hObject);
guidata(hObject, H);

end


function Logic = isNumber(Data,plusNaN)

if isempty(Data) == 0
    Logic = isa(Data(1),'double') || isa(Data(1),'integer');
    if nargin == 2
        if Logic == 1
            Logic = isnan(Data) == plusNaN;
        end
    end
else
    Logic = false;
end


end










