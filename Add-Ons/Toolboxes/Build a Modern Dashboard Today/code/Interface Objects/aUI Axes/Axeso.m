classdef Axeso < DBTree
    % Tables Derived in Axeso
    % graphTbl   - 'id','field','visible','type'
    % ScrollTbl  - 'tag','pos','property'
            
    
    % Dependent Properties:        
    properties (Dependent)
        

        Axis
        YLabel
        Visible
        DeletePlot
        
    end
    
    
    % General Properties:
    properties 
        
        GID;  % graph index
        HBox; % highlight Box
        PMot; % Pan motion

        GAxes;    % graphical axes
        GNormPos; % normalized GAxes position
        GPos;     % graphical axes position cm
        
        Color;
        HBoxs;
        
        graphObj;
        ScrollTbl;
        graphTbl;
        graph2data;
        AxesoSetting; % determines which state the axeso: legend,...,menu
        AxesObjects; % structure of menu and legend info / data
        LegendColor;
        LegendWidth;
        Visibility;
        PlotType;
        GMaps
        
    end
    
    
    % get and set methods:
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
            
            O.GAxes.Visible = K; % interactive graph visibility
            if isstruct(O.graphObj)
                FN = fieldnames(O.graphObj);
                for i = 1:length(FN),  O.graphObj.(FN{i}).Visible = K;  end
            end
            
            
            O = StateVisibility(O,O.AxesoSetting,K); % state visibility

            
            if isfield(O.GMaps,'Graph'), O.GMaps.Graph.Visible = K; end
            
            if ~isempty(O.HBox)
            if isfield(O.HBox,'Plot'),O.HBox.Plot.Visible = K; end
            end

            
        end
        
        
        % Get Current Visibility:
        function T = get.Visible(obj)
            
            T = obj.Visibility;
        end
        
        
        % Set YLabel for GAxes
        function obj = set.YLabel(obj,s)
            if gcf ~= obj.GAxes, axes(obj.GAxes); end, hold on
            ylabel(s)
        end
        
        
        % set Axis:
        function obj = set.Axis(obj,s)
            
            switch lower(s)
                case 'date', datetick('x','mmm'),axis auto, axis tight
                case 'geo', xtickformat('%.2f'), axis auto % update axis
            end
            
        end

        
        % Delete Plot
        function O = set.DeletePlot(O,gid)
            
            % delete graph
            delete(O.graphObj.(['n_',num2str(gid)]))
            
            % delete table data:
            O.graphTbl = O.graphTbl(O.graphTbl.GID ~= gid,:);
            O.graph2data = O.graph2data(O.graph2data.GID ~= gid,:);
            
            % remove graph obj from structure:
            O.graphObj = rmfield(O.graphObj,['n_',num2str(gid)]);
            
        end
        
    end
    
        
    % General Methods:
    methods
                
        % Setup GAxes:
        function obj = Axeso(s)
            
            % menu settings:
            MenuWidth   = 1.1;
            
            % legend settings:
            LegendWidth = 4.5;
            
            % chart settings:
            ChartWidth  = 1.25;
            cm_arrow   = 1;
            graph_button = 1;
            graph_space = .25;
            chart_bround = .65.*([0,48,91])./255 + .35.*([.98,.98,.98]);
            
            obj.PlotType     = 'geo';
            obj.AxesoSetting = 'legend';
            back_color = [108, 122, 137]./256;
            i_icon = .1;
            
            
            % set up initial conditions:
            obj.HBox = s.HBox;
            obj.LegendColor = [.95,.95,.95];
            obj.Tag = s.Tag; obj.GID = 0;
            
            % generate graphical Axes -------------------------------------
            % -------------------------------------------------------------
            
            % initial setup and data scale:
            obj.GAxes = axes('Position',s.Position);
            obj.GAxes.Units = 'centimeters';
            obj.GPos = obj.GAxes.Position;
            obj.GAxes.Units = 'normalized';
            obj.GNormPos = obj.GAxes.Position;
            Vx = obj.GNormPos([1,2])./obj.GPos([1,2]);
            
            
            % configure graphical axes:
            obj.GAxes.XLim = [0,obj.GPos(3)];
            obj.GAxes.YLim = [0,obj.GPos(4)];
            obj.GAxes.FontSize  = s.FontSize;
            
            flds = {'Units','Box','Color','XColor','YColor','GridColor'};
            sets = {s.Units,s.Box,s.Color,s.XColor,s.YColor,s.GridColor};
            set(obj.GAxes,flds,sets);
            
            % Check if YTicks are Preset:
            if ~isempty(s.YTick), obj.GAxes.YTick = s.YTick; end
            grid on, hold on, T = obj.Tag; % Left over setup features
            obj = setupTables(obj,s.Position,'GAxes');
            
            % set up callbacks:
            B = @(hObject,eventdata)graphClick(T,guidata(hObject),hObject);
            obj.GAxes.ButtonDownFcn = B; % capture push down button.
            
            
            % Legend set up -----------------------------------------------
            % -------------------------------------------------------------
            
            % set up meta data structure:
            Legend.Width  = LegendWidth*Vx(1);
            Legend.Left   = sum(obj.GNormPos([1,3])) - Legend.Width;
            Legend.Bottom = obj.GNormPos(2);
            Legend.Hight  = obj.GNormPos(4);
            Legend.Axes   = obj.GNormPos(3) - Legend.Width;
            
            % build legend:
            P = [Legend.Left Legend.Bottom Legend.Width Legend.Hight];
            obj = buildTreeAxes(obj,P,s.Tag);
            obj = tblSetupID(obj); % Set up Tables:
            obj.Settings.Visible = true;
            obj.GAxes.Position(3) = Legend.Axes;
            
            
             % Configure Legend
            obj.Settings.Visible = true;
            obj = setupGConfigNNodes(obj);
            
            if isfield(s,'table') % add table:
                if ~isempty(s.table), obj.setTable = s.table;  end
            end
            
            
            % menu bar setup ----------------------------------------------
            % -------------------------------------------------------------
            
            % setup meta data structure:
            MenuBar.Width  = MenuWidth*Vx(1);
            MenuBar.Left   = sum(obj.GNormPos([1,3])) - MenuBar.Width;
            MenuBar.Bottom = obj.GNormPos(2);
            MenuBar.Hight  = obj.GNormPos(4);
            MenuBar.Axes = obj.GNormPos(3) - MenuBar.Width;
            
            
            % Build Menu Bar:
            P = [MenuBar.Left MenuBar.Bottom MenuBar.Width MenuBar.Hight];
            MenuBar.Menu = axes('Position',P,'Color','none');
            MenuBar.Menu.Units = 'centimeters';
            flds = {'XColor','YColor','XLim','YLim'};
            sets = {'none','none',[0,MenuWidth],[0,MenuBar.Hight/Vx(2)]};
            set(MenuBar.Menu,flds,sets);
            
            
            % set Menu Backround Bar:
            Pbmenu = [0,0,MenuWidth,MenuBar.Hight/Vx(2)];
            MenuBar.menu_bround = rectangle('Position',Pbmenu);
            MenuBar.menu_bround.Clipping  = 'off';
            MenuBar.menu_bround.Curvature = .5;
            MenuBar.menu_bround.FaceColor = back_color;
            MenuBar.menu_bround.EdgeColor = 'none';
            
            
            % setup Legend Button:
            Lpos = [0,MenuBar.Hight/Vx(2)-MenuWidth,MenuWidth,MenuWidth];
            Lpos(1:4) = Lpos(1:4) + [i_icon,-.125,-i_icon.*2,-2*i_icon];
            MenuBar.Legend = iconGraphic('document',Lpos,back_color);

          
            % setup graph Button:
            Lpos = [0,MenuBar.Hight/Vx(2)-2*MenuWidth,MenuWidth,MenuWidth];
            Lpos(1:4) = Lpos(1:4) + [i_icon,-.155,-i_icon.*2,-2*i_icon];
            MenuBar.charts = iconGraphic('chart',Lpos,back_color);
            
            
            % set GAxes:
            obj.GAxes.Position(3) = MenuBar.Axes;
          
            
            % setup menu button Callback
            s2 = 'legend';
            B = @(hObject,eventdata)tostate(T,s2,guidata(hObject),hObject);
            MenuBar.Legend.ButtonDownFcn = B;
            
            % setup menu button Callback
            s2 = 'chart';
            B = @(hObject,eventdata)tostate(T,s2,guidata(hObject),hObject);
            MenuBar.charts.ButtonDownFcn = B;
            
            % chart bar setup ---------------------------------------------
            % -------------------------------------------------------------
            
            % setup metadata chart structure:
            Chart.Width  = ChartWidth*Vx(1);
            Chart.Left   = sum(obj.GNormPos([1 3])) - Chart.Width;
            Chart.Bottom = obj.GNormPos(2);
            Chart.Hight  = obj.GNormPos(4);
            Chart.Axes = obj.GNormPos(3) - Chart.Width;
            
            
            % Build chart menu:
            P = [Chart.Left Chart.Bottom Chart.Width Chart.Hight];
            Chart.chart = axes('Position',P,'Color','none');
            Chart.chart.Units = 'centimeters';
            flds = {'XColor','YColor','XLim','YLim'};
            sets = {'none','none',[0,ChartWidth],[0,Chart.Hight/Vx(2)]};
            set(Chart.chart,flds,sets);
            
            
            % set chart Backround Bar:
            Pbmenu = [0,0,ChartWidth,Chart.Hight/Vx(2)];
            Chart.chart_bround = rectangle('Position',Pbmenu);
            Chart.chart_bround.Clipping  = 'off';
            Chart.chart_bround.Curvature = .25;
            Chart.chart_bround.FaceColor = back_color;
            Chart.chart_bround.EdgeColor = 'none';
            
            
            % set up chart back button
            bottom = Chart.Hight/Vx(2) - cm_arrow - graph_space/2;
            pos    = [0,bottom,ChartWidth,cm_arrow+graph_space];
            Chart.chart_menu = rectangle('Position',pos);
            Chart.chart_menu.Clipping  = 'off';
            Chart.chart_menu.Curvature = .25;
            Chart.chart_menu.FaceColor = chart_bround;
            Chart.chart_menu.EdgeColor = 'none';
            
            
            % set up chart back button
            szShift = .05;
            bottom = Chart.Hight/Vx(2) - cm_arrow + szShift/2;
            left = ChartWidth/2 - (cm_arrow+szShift/4)/2;
            pos    = [left,bottom,cm_arrow-szShift/2,cm_arrow-szShift];
            Chart.Back = iconGraphic('arrow',pos,chart_bround);
            
            % set up chart back button
            bottom = bottom - graph_button - graph_space;
            left = ChartWidth/2 - graph_button/2;
            pos    = [left,bottom,graph_button,graph_button];
            Chart.fill = iconGraphic('fill',pos,back_color);
        
            % set up chart back button
            bottom = bottom - graph_button - graph_space;
            left = ChartWidth/2 - graph_button/2;
            pos    = [left,bottom,graph_button,graph_button];
            Chart.geo = iconGraphic('geo',pos,back_color);
            
            s2 = 'menu';
            B = @(hObject,eventdata)tostate(T,s2,guidata(hObject),hObject);
            Chart.Back.ButtonDownFcn = B;
               
            s2 = 'date';
            B = @(hObject,eventdata)toGraph(T,s2,guidata(hObject),hObject);
            Chart.fill.ButtonDownFcn = B;
            
            s2 = 'geo';
            B = @(hObject,eventdata)toGraph(T,s2,guidata(hObject),hObject);
            Chart.geo.ButtonDownFcn = B;
            
            % Finish setup ------------------------------------------------
            % -------------------------------------------------------------
            obj.AxesObjects.MenuBar = MenuBar;
            obj.AxesObjects.Legend = Legend;
            obj.AxesObjects.Chart = Chart;
            obj.AxesoSetting = 'menu';
            
            obj = StateVisibility(obj,'chart','off');
            obj = StateVisibility(obj,'legend','off');
        end
        
  
        % Define State Visibility:
        function O = StateVisibility(O,State,View)
            
            
           switch State % turn off the past.
                
               case 'chart'
                   O.AxesObjects.Chart.chart.Visible        = View;
                   O.AxesObjects.Chart.chart_bround.Visible = View;
                   O.AxesObjects.Chart.Back.Visible         = View;
                   O.AxesObjects.Chart.chart_menu.Visible   = View;
                   O.AxesObjects.Chart.fill.Visible   = View;
                   O.AxesObjects.Chart.geo.Visible    = View;
                   
                   
               case 'menu'
                   O.AxesObjects.MenuBar.Menu.Visible         = View;
                   O.AxesObjects.MenuBar.Legend.Visible       = View;
                    O.AxesObjects.MenuBar.charts.Visible      = View;
                    O.AxesObjects.MenuBar.menu_bround.Visible = View;
                    
                case 'legend'
                    O = UITreeVisibility(O,View);
            end 
            
            
            
        end
        
       
        % define Axeso State:
        function H = defineState(O,future,H)
            
            % set following variables as empty:
            Tbl_Scroll = [];
            Tbl_View   = [];
            Tbl        = [];
              
            
            
            O = StateVisibility(O,O.AxesoSetting,'off');
            O = StateVisibility(O,future,'on');
            
            switch future % turn on the future.
                
                case 'chart'
                    O.GAxes.Position(3) = O.AxesObjects.Chart.Axes;
                    O.ScrollTbl.pos(2) = O.AxesObjects.Chart.Left;
                    
                case 'menu'
                    O.GAxes.Position(3) = O.AxesObjects.MenuBar.Axes;
                    O.ScrollTbl.pos(2) = O.AxesObjects.MenuBar.Left;
                    
                case 'legend'
                    Tbl_Scroll = deriveLegendScroll(O);
                    O.GAxes.Position(3) = O.AxesObjects.Legend.Axes;
                    O.ScrollTbl.pos(2) = O.AxesObjects.Legend.Left;
                    Tbl_View = getLegendTable(O);
                    Tbl = Tbl_View;  
                    
            end
            
            
            O.AxesoSetting = future; % save future setting
            tbl = [Tbl_Scroll;O.ScrollTbl];
            
            
            H.(O.Tag) = O;
            H.UIControl = updateTable(H.UIControl,'scroll',tbl,O.Tag);
            H.UIControl = updateTable(H.UIControl,'view',Tbl_View,O.Tag);
            H.UIControl = updateTable(H.UIControl,'import',Tbl,O.Tag);
            
            
        end
        
        
        % Setup Tables:
        function obj = setupTables(obj,GPos,Prop)
            
            Prop = cellstr(Prop);
            Names = {'tag','pos','property'};
            obj.ScrollTbl = cell2table(cell(0,3));
            obj.ScrollTbl.Properties.VariableNames = Names;
            
            P = zeros(1,4); % position
            P([1 2]) = [GPos(1),sum(GPos([1 3]))];
            P([3 4]) = [GPos(2),sum(GPos([2 4]))];
            obj.ScrollTbl = [obj.ScrollTbl;{obj.Tag,P,Prop}];
            
            Names = {'GID','visible','type'};
            obj.graphTbl = cell2table(cell(0,3));
            obj.graphTbl.Properties.VariableNames = Names;
            
            
            Names = {'GID','id','type'};
            obj.graph2data = cell2table(cell(0,3));
            obj.graph2data.Properties.VariableNames = Names;
            
            
        end
        
        
        % Setup GAxes:
        function h = setUpAxes(O,h)
            T = 'scroll';
            h.UIControl = updateTable(h.UIControl,T,O.ScrollTbl,O.Tag);
            h.(O.Tag)   = O;
        end
        
        
    end
    
    
    % Plot Data:
    methods
        
        
        % edit graph state:      
        function O = GraphState(O,S,hdl)
            
            if strcmp(O.PlotType,S)
                disp('prior graph-type and new graph-type are the same')
                return
                
            elseif strcmp(O.PlotType,'geo') && isfield(O.GMaps,'Graph')
                delete(O.GMaps.Graph);
                O.GMaps = rmfield(O.GMaps,'Graph');
                O.PlotType = S;
                
            else
                O.PlotType = S;
                
            end
            
            
            if isempty(O.graphObj)
                disp('no graph present in axeso')
                return
            end
            
            if isfield(O.HBox,'Plot')
                delete(O.HBox.Plot);
                O.HBox = rmfield(O.HBox,'Plot');
            end
            
            flds = fieldnames(O.graphObj);
            for i = 1:length(flds)
                
                % to pull table data:
                % tbl = O.graph2data(O.graph2data.GID ~= gid,:);
                s = O.graphObj.(flds{i}).UserData;
                O.DeletePlot = str2double(flds{i}(3:end));
              
                switch O.PlotType
                    case 'date'
                        O = addTimeSeriesPlot(O,s.main,hdl);
                        
                    case 'geo'
                        O = addGeoPlot(O,s.main,hdl);
                        
                end
                
            end
  
        end
        
        
        
        % Delete Plot
        function O = DeleteLinkedGraphs(O,id)
           
            gid = unique(O.graph2data.GID(O.graph2data.id == id,:));
               
            % get graph id:
            for i = 1:length(gid)
                O.DeletePlot = str2double(gid(i));
            end
            
        end
        
        
                
        % Create Plot:        
        function [obj,L] = createPlot(obj,id,hdl)
            
            switch obj.PlotType
                case 'date'
                    [obj,L] = addTimeSeriesPlot(obj,id,hdl);
                    
                case 'geo'
                    [obj,L] = addGeoPlot(obj,id,hdl);
                    
            end
             
        end
       
        
        
        % Add Geo Plot:
        function [obj,L] = addGeoPlot(obj,id,hdl)
            
            if isempty(obj.GMaps)
            elseif  isfield(obj.GMaps,'Graph')
                delete(obj.GMaps.Graph);
                obj.GMaps = rmfield(obj.GMaps,'Graph');
            end
                
                
                
            
            obj.GID = obj.GID + 1;       % Increment graph id
            T = ['n_',num2str(obj.GID)]; % generate field name str
            Cr = GCNType(obj.GID-1);
            field = obj.idTbl.field{obj.idTbl.id == id};
            
            % graph table update:
            C = {obj.GID,1,'geo'};
            obj.graphTbl = [obj.graphTbl;C];
        
            C = {obj.GID,id,'main'};
            obj.graph2data = [obj.graph2data;C];
            

            RequestFlds = {'latitude','longitude'}; % request info
            [s,L] = getData(obj,id,hdl,RequestFlds); % pull data
           if ~L, return, end

            % make sure Axeso Axes is the current Axes
            if gcf ~= obj.GAxes, axes(obj.GAxes); end, hold on
            
            
            % Data is equal to the only non-requested field name*
            Data = interpData(s.(field).data);
            Send = {s.latitude.data,Data,Cr,'filled'}; % inputs cell store
            obj.graphObj.(T) = scatter(s.longitude.data,Send{:}); 
            obj.graphObj.(T).UserData.main = id;
            ButtonCall = obj.graphObj.(T).Parent.ButtonDownFcn;
            obj.graphObj.(T).ButtonDownFcn = ButtonCall;
            obj.Axis = 'geo';
            
            % setup google plot
            obj = setupGMaps(obj);    % pull GMaps Plot conditions. 
            obj = plotGoogleMap(obj); % create google maps plot.

            % set Y Axis Label for GAxes:
            obj.YLabel = 'Projected Value of Toolbox';
            
        end
        

        % Plot Time Series Data:
        function [obj,L] = addTimeSeriesPlot(obj,id,hdl)
            
            % setup new table entry:
            obj.GID = obj.GID + 1;       % Increment graph id
            T = ['n_',num2str(obj.GID)]; % generate field name str
            
            % setup graph settings
            ss.Page = 'Home'; % set up page
            ss.Color = GCNType(obj.GID-1); % set color 

            
            
            % graph table update:
            C = {obj.GID,1,'time'};
            obj.graphTbl = [obj.graphTbl;C];
        
            C = {obj.GID,id,'main'};
            obj.graph2data = [obj.graph2data;C];
            
            
            % obtain data:
            [s,L] = getData(obj,id,hdl,{'date'});
            if ~L, return, end
            field = obj.idTbl.field{obj.idTbl.id == id};

            ss.y = s.(field).data';
            ss.x = s.date.data';
            
            
            if gcf ~= obj.GAxes, axes(obj.GAxes); end, hold on
            obj.graphObj.(T) = UIGrapher(ss);
            obj.graphObj.(T).UserData.main = id;
            axis([0,1,0,1]);
            obj.Axis = 'date';
            obj.YLabel = 'Projected Value of Toolbox';
            
            
            
        end
        
        
        % Plot to google Maps:
        function obj = plotGoogleMap(obj)
            % obj.MapType = 'scatter';
            height      = obj.GMaps.height;
            width       = obj.GMaps.width;
  
            hold on
            
            CAx = axis(obj.GAxes);
            if max(abs(CAx)) > 500 || CAx(3) > 90 || CAx(4) < -90
                warning('Axis limits are not in WGS1984 Format,')
                return;
            end
            
            % Enforce Latitude constraints of EPSG:900913
            if CAx(3) < -90, CAx(3) = -90;    end
            if CAx(4) > 90,  CAx(4) = 90;     end
            if CAx(1) < -180, CAx(1) = -180;
            elseif CAx(1) >= 180, CAx(1) = 0; end
            if CAx(2) > 180, CAx(2) = 180;
            elseif CAx(2) < -180, CAx(2) = 0; end
            
            
            % Empty Figure Case
            if isequal(CAx,[0 1 0 1])
                CAx = [-200 200 -85 85]; axis(CAx)
            end
            
            
            if obj.GMaps.autoAxis % avoids strectching maps
                [xEx,yEx] = latLonToMeters(CAx(3:4),CAx(1:2));
                xEx = diff(xEx); yEx = diff(yEx);
                % get axes aspect ratio
                org_units = obj.GAxes.Units; obj.GAxes.Units = 'Pixels';
                ax_pos = obj.GAxes.Position; obj.GAxes.Units = org_units;
                aspect_ratio = ax_pos(4)/ax_pos(3);
                if xEx*aspect_ratio > yEx % enlarge the Y extent
                    cenX = mean(CAx(1:2)); cenY = mean(CAx(3:4));
                    SPX = (CAx(2)-CAx(1))/2; SPY = (CAx(4)-CAx(3))/2;
                    SPY = SPY*xEx*aspect_ratio/yEx; % new span
                    if SPY > 85,SPX = SPX*85/SPY; SPY = SPY*85/SPY; end
                    CAx(1) = cenX-SPX; CAx(2) = cenX+SPX;
                    CAx(3) = cenY-SPY; CAx(4) = cenY+SPY;
                elseif yEx > xEx*aspect_ratio % enlarge the X extent
                    cenX = mean(CAx(1:2));    cenY = mean(CAx(3:4));
                    SPX = (CAx(2)-CAx(1))/2;  SPY = (CAx(4)-CAx(3))/2;
                    SPX = SPX*yEx/(xEx*aspect_ratio); % new span
                    if SPX > 180, SPY = SPY*180/SPX; SPX = SPX*180/SPX; end
                    CAx(1) = cenX-SPX; CAx(2) = cenX+SPX;
                    CAx(3) = cenY-SPY; CAx(4) = cenY+SPY;
                end
                % Enforce Latitude constraints of EPSG:900913
                if CAx(3) < -85, CAx(3:4) = CAx(3:4) + (-85 - CAx(3)); end
                if CAx(4) > 85, CAx(3:4) = CAx(3:4) + (85 - CAx(4));   end
                axis(CAx); % drawnow
            end
            
            % Note: ~156543.034 for tileSize 256 pixels
            % Calculate zoom level for current axis limits
            [xEx,yEx] = latLonToMeters(CAx(3:4), CAx(1:2) );
            minRX = diff(xEx)/width; minRY = diff(yEx)/height;
            minRes = max([minRX minRY]);
            tileSize = 256;
            IResolution = 2*pi*6378137/tileSize;
            zoomlvl = floor(log2(IResolution/minRes));
            
            % Enforce valid zoom levels
            if zoomlvl < 0, zoomlvl = 0;
            elseif zoomlvl > 19, zoomlvl = 19; end
            
            if obj.GMaps.Zoom == zoomlvl, return, end
            if obj.GMaps.URL_Query.MapLgc, cvrt = 0; else, cvrt = 1; end
            
            % Calculate center: Units (WGS1984)
            lat = (CAx(3)+CAx(4))/2;
            lon = (CAx(1)+CAx(2))/2;
            
            
            
            location = ['?center=',num2str(lat,10),',',num2str(lon,10)];
            zoomStr =  ['&zoom=',num2str(zoomlvl)];
            
            HTTP   = obj.GMaps.URL_Query.http;
            ENDING = obj.GMaps.URL_Query.ending;
            url    = [HTTP,location,zoomStr,ENDING];
            
            try [M, Mcolor] = webread(url);
            catch % error downloading map
                warning('no image collected')
                return
            end
            
            Mcolor = uint8(Mcolor * 255);
            width = size(M,2);
            height = size(M,1);
            
            
            % Convert image from colormap type to RGB truecolor, if PNG
            if cvrt, imag = zeros(height,width,3, 'uint8');
                for Ix = 1:3
                    imag(:,:,Ix) = reshape(Mcolor((M+1),Ix),height,width);
                end, else, imag = M;
            end
            
            % Resize if needed
            resize = obj.GMaps.resize;
            scale = obj.GMaps.scale;
            if resize ~= 1, imag = imresize(imag,resize,'bilinear'); end
            
            width = size(imag,2);
            height = size(imag,1);
            cenPixY = round(height/2);
            cenPixX = round(width/2);
            [cenX,cenY] = latLonToMeters(lat, lon );
            curRez = IResolution/2^zoomlvl/scale/resize;
            xVec = cenX + ((1:width)-cenPixX) * curRez; % x vector
            yVec = cenY + ((height:-1:1)-cenPixY) * curRez; % y vector
            [xMesh,yMesh] = meshgrid(xVec,yVec); % construct meshgrid
            [lonMesh,latMesh] = metersToLatLon(xMesh,yMesh);
            
            % Next, project the data into a uniform WGS1984 grid
            uniHeight = round(height*resize);
            uniWidth = round(width*resize);
            latVec = linspace(latMesh(1,1),latMesh(end,1),uniHeight);
            lonVec = linspace(lonMesh(1,1),lonMesh(1,end),uniWidth);
            [uiLonM,uiLatM] = meshgrid(lonVec,latVec);
            
            % Fast Interpolation to uniform grid
            uniImag =  myTurboInterp2(lonMesh,latMesh,imag,uiLonM,uiLatM);
            if obj.GAxes~=gca, axes(obj.GAxes); end, hold on
            delete(findobj(obj.GAxes.Children,'tag','gmap'))
            
            T = obj.Tag;
            B = @(hObject,eventdata)graphClick(T,guidata(hObject),hObject);
            h = image(lonVec,latVec,uniImag,'Parent',obj.GAxes); axis(CAx);
            h.ButtonDownFcn = B;
            obj.GAxes.YDir = 'Normal'; h.Tag = 'gmap';
            h.AlphaData = obj.GMaps.alphaData;
            uistack(h,'bottom');
            obj.GMaps.Graph  = h;
            obj.GMaps.Zoom   = zoomlvl;
            obj.GMaps.latLim = [latMesh(1,1),latMesh(end,1)];
            obj.GMaps.lonLim = [lonMesh(1,1),lonMesh(1,end)];
        end
        
        
        % Setup google Maps:
        function obj = setupGMaps(obj,Num,APK)
            
            if nargin < 3, APK = ''; end
            if nargin < 2, Num = 1; end
            obj.GMaps.apiKey             = APK;
            obj.GMaps.axN                = Num;
            obj.GMaps.height             = 640;
            obj.GMaps.width              = 640;
            obj.GMaps.scale              = 2;
            obj.GMaps.resize             = 1;
            obj.GMaps.alphaData          = 1;
            obj.GMaps.autoRefresh        = 1;
            obj.GMaps.figureResizeUpdate = 1;
            obj.GMaps.autoAxis           = 1;
            obj.GMaps.showLabels         = 1;
            obj.GMaps.language           = '';
            obj.GMaps.markeridx          = 1;
            obj.GMaps.markerlist         = {};
            obj.GMaps.style              = '';
            obj.GMaps.URL_Query          = [];
            obj.GMaps.Zoom               = -1;
            obj.GMaps.Graph              = [];
            obj.GMaps.maptype = 'roadmap';
            
            
            % Part II:
            Syl    = obj.GMaps.style;
            mrks   = obj.GMaps.markerlist;
            width  = num2str(obj.GMaps.width);
            height = num2str(obj.GMaps.height);
            LNG    = obj.GMaps.language;
            APK    = obj.GMaps.apiKey;
            Sensor = '&sensor=false';
            SylStr = 'feature:all|element:labels|visibility:off';
            MLgc   = ismember(obj.GMaps.maptype,{'satellite','hybrid'});
            showBl = obj.GMaps.showLabels;
            
            if showBl == 0 && ~isempty(Syl), Syl(end+1) = '|'; end
            if showBl == 0, Syl = [Syl,SylStr]; end
            
            mtpe = ['&maptype=',obj.GMaps.maptype];
            mrks = ['&markers=',strjoin(mrks,'%7C&markers=')];
            Size = ['&size=',width,'x',height];
            Scle = ['&scale=',num2str(obj.GMaps.scale)];
            
            if isa(APK,'double'), APK = ''; end
            if ~isempty(Syl), Syl = ['&style=' Syl]; else, Syl = ''; end
            if ~isempty(LNG),LNG = ['&language=',LNG]; else, LNG = ''; end
            if MLgc, fmat = '&format=jpg'; else, fmat = '&format=png';  end
            APK = ['&key=' APK];
            
            Endg = [Scle,Size,mtpe,fmat,mrks,LNG,Sensor,APK,Syl];
            s.http = 'http://maps.googleapis.com/maps/api/staticmap';
            s.ending = Endg;
            s.MapLgc = MLgc;
            obj.GMaps.URL_Query = s;
            
            
        end
        
        
    end
    
    
    % Callback Methods Zoom, Highlight and Pan:
    methods
        
        % Highlight (Setup):
        function [Hdl,Hob] = setupHighlightBox(O,Hdl,AxH,Hob)
            
            T = O.Tag;
            O.HBox.Last = AxH.CurrentPoint(1,[1,2]);
            B = @(hObject,eventdata)dragBox(T,guidata(hObject),hObject);
            C = @(hObject,eventdata)endDrag(T,guidata(hObject),hObject);
            
            % calculate width and hight.
            xy = ([AxH.XLim(1:2);AxH.YLim(1:2)]*[-1;1])';
            O.HBox.XY   = [AxH.XLim(1),AxH.YLim(1),xy];
            O.HBox.GPos = AxH.Position;
            
            % calculate start position.
            S = (O.HBox.Last - O.HBox.XY([1,2]))./O.HBox.XY([3,4]);
            O.HBox.Start = O.HBox.GPos([1,2]) + S.*O.HBox.GPos([3,4]);
            
            % remove highlight plot if exists
            if isfield(O.HBox,'Plot'), delete(O.HBox.Plot)
               O.HBox = rmfield(O.HBox,'Plot');
            end
            
            % calculate new highlight plot x and y positions.
            x = O.HBox.Last([1,1,1,1]); y = O.HBox.Last([2,2,2,2]);
            if gcf ~= O.GAxes, axes(O.GAxes); end, hold on
            O.HBox.Plot = fill(x,y,O.HBox.FaceColor);
            O.HBox.Plot.FaceAlpha = O.HBox.FaceAlpha;
            O.HBox.Plot.EdgeColor = O.HBox.EdgeColor;
            O.HBox.Plot.EdgeAlpha = O.HBox.EdgeAlpha;
            
            
            % load to handles and save set figure motion settings.
            Hdl.(O.Tag) = O;
            Hob = setFigureWM(Hob,B);
            Hob = setFigureWR(Hob,C);
            
        end
        
        
        % Highlight (Drag):
        function O = dragHighlightBox(O,AxH)
            
            
            Current = AxH.CurrentPoint;
            XY = (Current - O.HBox.GPos([1,2]))./ O.HBox.GPos([3,4]);
            XY = O.HBox.XY([1,2]) + XY.*O.HBox.XY([3,4]);
            
            if XY(1) > O.GAxes.XLim(2), XY(1) = O.GAxes.XLim(2); 
            elseif XY(1) < O.GAxes.XLim(1), XY(1) = O.GAxes.XLim(1); end
            
            
            if XY(2) > O.GAxes.YLim(2), XY(2) = O.GAxes.YLim(2);
            elseif XY(2) < O.GAxes.YLim(1), XY(2) = O.GAxes.YLim(1); end
            
            [x,y] = findThem(O.HBox.Last(1),O.HBox.Last(2),XY(1),XY(2));
            O.HBox.Plot.Vertices = [x,y];
            
        end
        
        
        % Highlight (End):
        function O = endDragHighlight(O,AxH)
            
             
            Current = AxH.CurrentPoint;
            XY = (Current - O.HBox.GPos([1,2]))./ O.HBox.GPos([3,4]);
            XY = O.HBox.XY([1,2]) + XY.*O.HBox.XY([3,4]);
            
            if XY(1) > O.GAxes.XLim(2), XY(1) = O.GAxes.XLim(2); 
            elseif XY(1) < O.GAxes.XLim(1), XY(1) = O.GAxes.XLim(1); end
            
            
            if XY(2) > O.GAxes.YLim(2), XY(2) = O.GAxes.YLim(2);
            elseif XY(2) < O.GAxes.YLim(1), XY(2) = O.GAxes.YLim(1); end
 
            O.HBox.End = XY;
            
        end
        
        
        % scroll function (Zoom in/out):
        function hdl = AxesoScroll(O,P,D,hdl)
            
            
            Dlt = 1-.1*D; % get zoom in/out percentage
            L = [O.GAxes.XLim,O.GAxes.YLim];   
            XY = (P - O.GNormPos([1,2]))./ O.GNormPos([3,4]);
            P1 = [L(1)+XY(1)*(L(2) - L(1)), L(3)+XY(2)*(L(4) - L(3))];
            L = L.*Dlt;
            
            P2 = [L(1)+XY(1)*(L(2) - L(1)), L(3)+XY(2)*(L(4) - L(3))];
            L = L + (P1([1 1 2 2]) - P2([1 1 2 2]));
            set(O.GAxes,{'XLim','YLim'},{L([1,2]),L([3,4])});
            hdl.(O.Tag) = O;
            
            
        end
        
        
        % Pan (Setup):
        function [hdl,hOb] = PanSetup(O,hdl,AxH,hOb)
            
            if O.GAxes ~= gca, axes(O.GAxes); end,  hold on
            T = O.Tag;
            
            O.PMot.Last = AxH.CurrentPoint(1,[1,2]);
            B = @(hObject,eventdata)PAxes(T,guidata(hObject),hObject);
            C = @(hObject,eventdata)endPan(T,guidata(hObject),hObject);
            
            
            % calculate width and hight.
            xy = ([O.GAxes.XLim(1:2);O.GAxes.YLim(1:2)]*[-1;1])';
            O.PMot.XY   = [O.GAxes.XLim(1),O.GAxes.YLim(1),xy];
            O.PMot.GPos =  O.GAxes.Position;
            O.PMot.Lim  = [O.GAxes.XLim O.GAxes.YLim];
            
            % calculate start position.
            S = (O.PMot.Last - O.PMot.XY([1,2]))./O.PMot.XY([3,4]);
            O.PMot.Start = O.PMot.GPos([1,2]) + S.*O.PMot.GPos([3,4]);
            
            % load to handles and save set figure motion settings.
            hdl.(O.Tag) = O;
            hOb = setFigureWM(hOb,B);
            hOb = setFigureWR(hOb,C);
            
        end
        
        
        % Pan (End):
        function O = PanAxes(O,hOb)
          
            % Set up Current Axies:
            C = hOb.CurrentPoint - O.PMot.Start;
            XY = C ./ O.GNormPos([3,4]); L = O.PMot.Lim;
            O.GAxes.XLim = L([1,2]) - XY(1)*(L(2) - L(1));
            O.GAxes.YLim = L([3,4]) - XY(2)*(L(4) - L(3));
             
        end
        
        
    end
    

    
end


% get interesting colors.
function c = GCNType(type)

switch type
    case {'pink',0}, c = [219,10,91]./255;
    case {'blue',1}, c = [0.0 0.45 0.74];  
    case {'green',2}, c = ([38, 194, 129])./255;
    case {'oran',3}, c = ([242, 120, 75])./255;
    case {'grey',4}, c = [.5 .5 .5];
    case {'yellow',5},  c = [0.929 0.694 0.125];
    case {'orange',6}, c = [0.85 0.33 0.1];
    case {'teal',7}, c = ([134, 226, 213])./255;
    case {'purple',8}, c = ([155, 89, 182])./255;
    otherwise,  c = [rand rand rand];
        
end

end


function graphClick(Tag,hdl,hOb)

H = hOb;
while 1
    if strcmpi('figure',H.Type)
        Select = H.SelectionType; break
    elseif strcmpi('axes',H.Type)
        AxesoHdl = H;
    end
    H = H.Parent;
end

if strcmpi(Select,'normal')
    [hdl,hOb] = setupHighlightBox(hdl.(Tag),hdl,AxesoHdl,hOb);
elseif strcmpi(Select,'alt')
    [hdl,hOb] = PanSetup(hdl.(Tag),hdl,AxesoHdl,hOb);
end

guidata(hOb, hdl);

end


function PAxes(Tag,hdl,hOb)

hdl.(Tag) = PanAxes(hdl.(Tag),hOb);    
guidata(hOb, hdl);

end


function dragBox(Tag,hdl,hOb)

hdl.(Tag) = dragHighlightBox(hdl.(Tag),hOb);
guidata(hOb, hdl);

end


function endDrag(Tag,hdl,hOb)

hdl.(Tag) = endDragHighlight(hdl.(Tag),hOb);
hdl = selectPage(hdl.UIControl,hdl.UIControl.Page,hdl);
    [hOb,hdl] = setDefinateMotion...
        (hdl.UIControl,hOb,hdl);
guidata(hOb, hdl);


end


function endPan(Tag,hdl,hOb) %#ok

hdl = selectPage(hdl.UIControl,hdl.UIControl.Page,hdl);
    [hOb,hdl] = setDefinateMotion...
        (hdl.UIControl,hOb,hdl);
guidata(hOb, hdl);


end


function tostate(Tag,state,hdl,hOb)

hdl = defineState(hdl.(Tag),state,hdl);
guidata(hOb, hdl);

end


function toGraph(Tag,state,hdl,hOb)

hdl.(Tag) = GraphState(hdl.(Tag),state,hdl);
guidata(hOb, hdl);

end


function [x,y] = findThem(x1,y1,x2,y2) 

L = min([x1,x2]); R = max([x1,x2]);
B = min([y1,y2]); T = max([y1,y2]);
x = [L; L; R; R]; y = [B; T; T; B];

end


function ZI = myTurboInterp2(X,Y,Z,XI,YI)
% An extremely fast nearest neighbour 2D interpolation, assuming both input
% and output grids consist only of squares, meaning:
% - uniform X for each column
% - uniform Y for each row
XI = XI(1,:);
X = X(1,:);
YI = YI(:,1);
Y = Y(:,1);

xiPos = nan*ones(size(XI));
xLen = length(X);
yiPos = nan*ones(size(YI));
yLen = length(Y);
% find x conversion
xPos = 1;
for idx = 1:length(xiPos)
    if XI(idx) >= X(1) && XI(idx) <= X(end)
        while xPos < xLen && X(xPos+1)<XI(idx)
            xPos = xPos + 1;
        end
        diffs = abs(X(xPos:xPos+1)-XI(idx));
        if diffs(1) < diffs(2)
            xiPos(idx) = xPos;
        else
            xiPos(idx) = xPos + 1;
        end
    end
end
% find y conversion
yPos = 1;
for idx = 1:length(yiPos)
    if YI(idx) <= Y(1) && YI(idx) >= Y(end)
        while yPos < yLen && Y(yPos+1)>YI(idx)
            yPos = yPos + 1;
        end
        diffs = abs(Y(yPos:yPos+1)-YI(idx));
        if diffs(1) < diffs(2)
            yiPos(idx) = yPos;
        else
            yiPos(idx) = yPos + 1;
        end
    end
end
ZI = Z(yiPos,xiPos,:);
end


% Coordinate transformation functions
function [lon,lat] = metersToLatLon(x,y)
% Converts XY point from Spherical Mercator EPSG:900913 to lat/lon in WGS84 Datum
originShift = 2 * pi * 6378137 / 2.0; % 20037508.342789244
lon = (x ./ originShift) * 180;
lat = (y ./ originShift) * 180;
lat = 180 / pi * (2 * atan( exp( lat * pi / 180)) - pi / 2);

end


function [x,y] = latLonToMeters(lat, lon )
% Converts given lat/lon in WGS84 Datum to XY in Spherical Mercator EPSG:900913"
originShift = 2 * pi * 6378137 / 2.0; % 20037508.342789244
x = lon * originShift / 180;
y = log(tan((90 + lat) * pi / 360 )) / (pi / 180);
y = y * originShift / 180;

end


% Interpulated Range
function [Y,Range,Size] = interpData(X,Size)

Max = max(X);
Min = min(X);

X = (X - Min)/(Max - Min);
if nargin ==1 , Size = [320,40]; end
Y = spline([1,.9,1/3,0],[1 .45 .15 0],X);
Y = Size(1) + Y*(Size(2) - Size(1));
Range = [Max Min];

end



