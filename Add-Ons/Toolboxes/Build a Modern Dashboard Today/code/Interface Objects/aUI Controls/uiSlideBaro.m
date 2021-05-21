classdef uiSlideBaro
    % Class for graphical slide bar.
    
    properties (Dependent)
        
        getLast;
       	Color;
        BarColor;
        GlowColor;
        Height;
        Radius;
        Visible
    end
    
    % Visibile Properties:
    properties (SetAccess='public',GetAccess='public',Hidden=false)
        
        Page;
        Tag;       % Name of object in handles
        Pos;       % position of figure window (cm)
        NormPos;   % normal position
        Slider;    % type        
        Values;    % values
        Callback;
        
    end
    
    
    % Hidden Properties:
    properties (SetAccess='public',GetAccess='private',Hidden=true)
        
        Axes;         % auto generated axes
        Circles;
        Recs;
        SlideMotion;
        Centers;
        Settings;
        Visibility;
    end
    
    
    
    % Dependent Properties:
    methods 
 
        function O = set.Visible(O,T)
            
            if isempty(O.Circles)||isempty(O.Recs), return, end
            
            
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

            if O.Visibility, O.Axes.Visible = 'on';    
                set(O.Recs,'Visible','on'),
                set(O.Circles,'Visible','on')
            else, set(O.Circles,'Visible','off')
                set(O.Recs,'Visible','off')
                O.Axes.Visible = 'off';
            end
            
            
        end
        
        function obj = set.Color(obj,s)
            obj.Settings.Color = s;
            
            if ~isempty(obj.Circles)
                for i = 1:2
                    obj.Circles(i).EdgeColor = obj.Settings.Color;
                    obj.Circles(i).FaceColor = obj.Settings.Color;
                end
            end
            
        end
        
        
        function obj = set.BarColor(obj,s)
            obj.Settings.BarColor = s;
            
            if ~isempty(obj.Circles)
                switch lower(obj.Slider)
                    case 'center', n = 3; k = 2;
                    case 'left',   n = 2; k = 1;
                    case 'right',  n = 2; k = 2;
                end
                
                for i = 1:n
                    if i ~= k
                        obj.Recs(i).FaceColor = obj.Settings.BarColor;
                        obj.Recs(i).EdgeColor = obj.Settings.BarColor;
                    end
                end
            end
            
        end
        
        
        function obj = set.GlowColor(obj,s)
            obj.Settings.GlowColor = s;
            
            
            if ~isempty(obj.Circles)
                switch obj.Slider
                    case 'center'
                        obj.Recs(2).FaceColor = obj.Settings.GlowColor;
                        obj.Recs(2).EdgeColor = obj.Settings.GlowColor;
                        
                    case 'left'
                        obj.Recs(1).FaceColor = obj.Settings.GlowColor;
                        obj.Recs(1).EdgeColor = obj.Settings.GlowColor;
                        
                    case 'right'
                        obj.Recs(2).FaceColor = obj.Settings.GlowColor;
                        obj.Recs(2).EdgeColor = obj.Settings.GlowColor; 
                end
                
            end
   
        end
        
        
        function obj = set.Height(obj,H)
            obj.Settings.Height = H;
            
            
            if ~isempty(obj.Recs),C = obj.Centers; M = obj.Pos(4)/2 - H/2;
                switch obj.Slider
                    case 'center', n = 3; P = [0;C(1);C(2);obj.Pos(3)];
                    case 'left',   n = 2;  P = [0;C(1);obj.Pos(3)];
                    case 'right',  n = 2;  P = [0;C(1);obj.Pos(3)];
                end, OV = ones(n,1);
                Position = [P(1:end-1),M.*OV,P(2:end)-P(1:end-1),H.*OV];
                for i = 1:n, obj.Recs(i).Position = Position(i,:); end
            end
 
        end
        
        
        function obj = set.Radius(obj,s)
            obj.Settings.Radius = s;
            
            if ~isempty(obj.Circles)
                THETA = linspace(pi/2,3*pi/2,100);
                [X,Y] = pol2cart(THETA,ones(1,100)*obj.Radius);
                obj.Circles(1).XData = X + obj.Centers(1);
                obj.Circles(1).YData = Y + obj.Pos(4)/2;
                
                obj.Circles(2).XData = -1.*X + obj.Centers(2);
                obj.Circles(2).YData =  Y    + obj.Pos(4)/2;
            end
            
            
        end
        
        
        function s = get.Radius(obj)
            s = obj.Settings.Radius;
        end
        
        
        function s = get.Height(obj)
            s = obj.Settings.Height;
        end
        
        
        function s = get.Color(obj)
            s = obj.Settings.Color;
        end
        
        
        
        
       % get Last Slider Positions:
        function last = get.getLast(obj)
            
            switch obj.Slider
                case 'left',   last = (obj.Centers(1))/(obj.Pos(3));
                case 'right',  last = (obj.Centers(1))/(obj.Pos(3));
                case 'center', last = (obj.Centers)./(obj.Pos(3));
            end
            
            last =  obj.Values(1:2)*[-1;1]*last + obj.Values(1);
            
        end 
        
        
        % Set Values of Slider:
        function obj = set.Values(obj,vals)
            
            obj.Values = vals;
            
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
        
        
    end
    
    
    
    % General Methods:
    methods (Access = 'public', Static = false, Hidden = true)
        
        
        % Constructor:
        function obj = uiSlideBaro(s)
            
            pos = s.Position;  N = properties(obj);
            F = fieldnames(s); N = N(ismember(N,F)); obj.Page = s.Page;
            
            for i = 1:length(N)
                obj.(N{i}) = s.(N{i});
            end
            
            Default = 'none';
            
            
            % Create Axeses
            obj.Axes = axes('Position',pos,'Units','normalized');
            Flds ={'YColor','XColor','XTick','YTick','Tag','Color'};
            Sets = {'none','none',[],[],obj.Tag,Default}; % Set Defaults
            set(obj.Axes,Flds,Sets); obj = setAxesLimits(obj);
            
            obj = setupSlideBar(obj);
            
        end
        
        
        % Setup Axes Limits:
        function obj = setAxesLimits(obj)
            
            obj.Axes.Units = 'centimeters'; obj.Pos = obj.Axes.Position;
            obj.Axes.Units = 'normalized'; obj.NormPos = obj.Axes.Position;
            obj.Axes.XLim = [0,obj.Pos(3)]; obj.Axes.YLim = [0,obj.Pos(4)];
            
        end
        
        
        % setup Slidebar:
        function obj = setupSlideBar(obj)
            
            hold on
            H = obj.Height;        % height of bar
            T = obj.Tag;            % tag
            C = obj.Pos([3 3])./2; % left circle center
            PD2 = obj.Pos(4)/2;
            M = obj.Pos(4)/2 - H/2;
        
            CBF = @(hObject,eventdata)c2DSlide(T,hObject,guidata(hObject));
            

            switch lower(obj.Slider)
                
                case 'center', C = C + [-1 1];
                    n = 3; k = 2; P = [0;C(1);C(2);obj.Pos(3)];
                    
                case 'left'
                    n = 2; k = 1; P = [0;C(1);obj.Pos(3)];
                    
                case 'right'
                    n = 2; k = 2; P = [0;C(1);obj.Pos(3)];
                    
            end
            
            OV = ones(n,1);
            Position = [P(1:end-1),M.*OV,P(2:end)-P(1:end-1),H.*OV];
            
            for i = 1:n
                if i == 1
                    obj.Recs = rectangle('Position',Position(i,:)); else
                    obj.Recs(i) = rectangle('Position',Position(i,:));
                end
                
                obj.Recs(i).Curvature = 1;
                obj.Recs(i).Clipping = 'off';
                if i ~= k
                    obj.Recs(i).FaceColor = obj.Settings.BarColor;
                    obj.Recs(i).EdgeColor = obj.Settings.BarColor; else
                    obj.Recs(i).FaceColor = obj.Settings.GlowColor;
                    obj.Recs(i).EdgeColor = obj.Settings.GlowColor.*1.1;
                end
                
            end
            
            % generate circle:
            obj.Centers = C; THETA = linspace(pi/2,3*pi/2,100);
            [X,Y] = pol2cart(THETA,ones(1,100)*obj.Radius);
            obj.Circles    = fill(X + C(1),Y + PD2,obj.Color);
            obj.Circles(2) = fill(-1.*X + C(2), Y + PD2,obj.Color);

            for i = 1:2
                obj.Circles(i).EdgeColor      = obj.Settings.Color;
                obj.Circles(i).UserData       = i;
                obj.Circles(i).ButtonDownFcn  = CBF;
                obj.Circles(i).Clipping       = 'off';
            end
            
        end
        
        
        % setup Slidebar:
        function [obj,hObject] = setupSlideMotion(obj,type,hObject)
            
            
            T = obj.Tag;
            CBF = @(hObject,eventdata)DSer(T,hObject,guidata(hObject));
            RBF = @(hObject,eventdata)RLDSer(T,hObject,guidata(hObject));
            CBR = @(hObject,eventdata)RSer(T,hObject,guidata(hObject));
            
            obj.SlideMotion.type  = type;
            
            if type == 1, obj.SlideMotion.minor = 2; else
                obj.SlideMotion.minor = 1;
            end
            
            obj.SlideMotion.XData  = obj.Circles(type).XData;
            obj.SlideMotion.start  = hObject.Parent.CurrentPoint;
            obj.SlideMotion.center = obj.Centers;
            
            
            switch obj.Slider
                case 'center', RCBF = CBF;
                case 'left',   RCBF = RBF;
                case 'right',  RCBF = RBF;
            end
            
            
            hObject = setFigureWM(hObject,RCBF);
            hObject = setFigureWR(hObject,CBR);
            
        end
        
        
        % setup Slidebar:
        function [O,hObject] = SMotion(O,hObject)
            
            I = O.SlideMotion.type;
            M = hObject.CurrentPoint; % Transform Current Point
            D = O.Pos(3)./O.NormPos(3).*(M(1)-O.NormPos(1));
            X = D - O.SlideMotion.start(1); % Move Circle:
            O.SlideMotion.center(I) = O.Centers(I) + X;
            
            if O.SlideMotion.center(I) > O.Pos(3)
                O.SlideMotion.center(I) = O.Pos(3);
                X = O.Pos(3) - O.Centers(I);
            elseif O.SlideMotion.center(I) < 0
                O.SlideMotion.center(I) = 0;
                X = -1*O.Centers(I);
            end
            
            O.Circles(I).XData = O.SlideMotion.XData + X;
            if O.SlideMotion.center(2) < O.SlideMotion.center(1)
                II = O.SlideMotion.minor;
                O.SlideMotion.center(II) = O.SlideMotion.center(I);
                Change = O.SlideMotion.center(II) - O.Centers(II);
                O.Circles(II).XData = O.Circles(II).XData + Change;
                O.Centers(II) = O.SlideMotion.center(II);
            end
            
      
            P = [0,O.SlideMotion.center([1 2]),O.Pos(3)];
            O.Recs(1).Position([1,3]) = [P(1),P(2)-P(1)];
            O.Recs(2).Position([1,3]) = [P(2),P(3)-P(2)];
            O.Recs(3).Position([1,3]) = [P(3),P(4)-P(3)];
            
            
        end
        
        
        % setup Slidebar:
        function [O,hObject] = SOMotion(O,hObject)
            
            I = O.SlideMotion.type;
            II = O.SlideMotion.minor;
            
            M = hObject.CurrentPoint; % Transform Current Point
            D = O.Pos(3)./O.NormPos(3).*(M(1)-O.NormPos(1));            
            X = D - O.SlideMotion.start(1); % Move Circle
            O.SlideMotion.center(I) = O.Centers(I) + X;
            
            if O.SlideMotion.center(I) > O.Pos(3)
                O.SlideMotion.center(I) = O.Pos(3);
                X = O.Pos(3) - O.Centers(I);
            elseif O.SlideMotion.center(I) < 0
                O.SlideMotion.center(I) = 0;
                X = -1*O.Centers(I);
            end
            
            O.Circles(I).XData = O.SlideMotion.XData + X;
            O.SlideMotion.center(II) = O.SlideMotion.center(I);
            Change = O.SlideMotion.center(II) - O.Centers(II);
            O.Circles(II).XData = O.Circles(II).XData + Change;
            O.Centers(II) = O.SlideMotion.center(II);

            
            P = [0,O.SlideMotion.center(1),O.Pos(3)];
            O.Recs(1).Position([1,3]) = [P(1),P(2)-P(1)];
            O.Recs(2).Position([1,3]) = [P(2),P(3)-P(2)];
                        
        end
        
        
        % End Motion:
        function obj = EMotion(obj)
            
            obj.Centers = obj.SlideMotion.center;
            
        end
        
        
        % Run Callback Function:
        function [hdl,hOb] = runSliderCallback(obj,hOb,hdl)
            
            if ~isempty(obj.Callback)
                [hdl,hOb] = feval(obj.Callback{:},obj.Tag,hdl,hOb);
            end
        end
        
        
    end
    
    
end


% end click and drag
function RSer(Tag,hOb,hdl)

hdl.(Tag) = EMotion(hdl.(Tag));
hOb.WindowButtonMotionFcn = '';
guidata(hOb, hdl);
[hdl,hOb] = runSliderCallback(hdl.(Tag),hOb,hdl);
[hOb,hdl] = setDefinateMotion(hdl.UIControl,hOb,hdl);
guidata(hOb, hdl);

end

% setup drag slider
function c2DSlide(Tag,hOb,hdl)

[hdl.(Tag),hOb] = setupSlideMotion(hdl.(Tag),hOb.UserData,hOb);
guidata(hOb, hdl);

end

% center slider drag
function DSer(Tag,hOb,hdl)

[hdl.(Tag),hOb] = SMotion(hdl.(Tag),hOb);
guidata(hOb, hdl);

end

% right slider drag
function RLDSer(Tag,hOb,hdl)

[hdl.(Tag),hOb] = SOMotion(hdl.(Tag),hOb);
guidata(hOb, hdl);

end
