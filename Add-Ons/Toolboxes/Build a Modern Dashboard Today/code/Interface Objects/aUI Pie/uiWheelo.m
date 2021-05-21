classdef uiWheelo
    
    % Dependent Properties:
    properties (Dependent)
        
        Visible
        getLast;
    end
    
    % general properties:
    properties
        
        Axes;
        Tag;
        Pos
        NormPos
        Last;
        Visibility
        CenterText;
        
    end
    
    % General Properties:
    properties (SetAccess='public',GetAccess='private',Hidden=true)
        
        viewTbl
        Vector
        Hdl;
        Center;
        CPos;
        RPlus;
        r;
        PBCalls;
        Fields;
        GraphObj
        Callback;
        
    end
    
    % get and set properties:
    methods
       
        % get last:
        function last = get.getLast(obj)
            
            if isempty(obj.Last)
                last.id = NaN;
                last.Field = 'none';
                return
            end
            
            
            last = obj.Last;
            
        end
        
        
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
            for i = 1:length(O.GraphObj), O.GraphObj(i).Visible = K;  end
            
            O.CenterText.percent.Visible = K;
            O.CenterText.text.Visible = K;
            O.Axes.Visible = K;
            O.Center.Visible = K;
        end
        
        
    end
    
    % General Methods:
    methods (Access='public',Static=false,Hidden=true)
        
        
        % Constructor:
        function obj = uiWheelo(s)
  
            % Load Initial Conditions:
            % Default Button:
            if nargin == 0, s.Tag = 'temp';  
                s.position = [.40,.48,.5,.5];
                s.Fields = {'one','two','three'};
            end
            
            if ~isfield(s,'Default'), s.Default = [.98,.98,.98]; end
            
            obj.Tag    = s.Tag;
            obj.Fields = s.Fields;
            obj.Vector.data = s.Vector;
            obj.Vector.normalized =  s.Vector./sum(s.Vector);

            
            % set up axeso
            obj.Axes = axes('Position',s.Position,'Units','normalized');
            Flds ={'YColor','XColor','XTick','YTick','Tag','Color'};
            Sets = {'none','none',[],[],obj.Tag,s.Default}; % Set Defaults
            set(obj.Axes,Flds,Sets); 
            
            % setup ratio methods:
            obj.Axes.Units = 'centimeters'; obj.Pos = obj.Axes.Position;
            obj.Axes.Units = 'normalized'; obj.NormPos = obj.Axes.Position;
            obj.Axes.XLim = [0,obj.Pos(3)]; obj.Axes.YLim = [0,obj.Pos(4)];
            
            
             
            
             obj.CPos = obj.Pos([3,4])./2;
             obj.r = min(obj.Pos([3,4]))/2;
             obj = buildWheelPlot(obj);
             
             
             
        end
        
        
        % Setup Axes Limits:
        function obj = setAxesLimits(obj)
            
            obj.Axes.Units = 'centimeters'; obj.Pos = obj.Axes.Position;
            obj.Axes.Units = 'normalized'; obj.NormPos = obj.Axes.Position;
            obj.Axes.XLim = [0,obj.Pos(3)]; obj.Axes.YLim = [0,obj.Pos(4)];
            
        end
        
        
        % Set Callback
        function obj = setCallBack(obj,Callfun)
            
            obj.Callback = Callfun;
        end
        
        
        % build Wheel Plot:
        function O = buildWheelPlot(O)
            
            n  = length(O.Fields); T = O.Tag;
            CBF = @(hObject,eventdata)clckWhl(T,hObject,guidata(hObject));
            hold on, kr = 1.3; O.RPlus = O.r*.05;
        
            Setoff = deg2rad(360/n)/2;
            info.edgeColor = [.85,.85,.85];
            info.fontColor = [.25,.25,.3];
            info.Radius    = O.r;
            info.Call      = CBF;
            info.Center    = O.CPos;
            
            
            for i = 1:n
                
                % package pieo structure:
                info.String = O.Fields{i};
                info.Id = i;
                info.Color = GCNType(i); % get color
                
                % upload package:
                O.GraphObj = uiPieo(info,O.GraphObj);
                n1 = sum(O.Vector.normalized(1:i-1));
                n2 = sum(O.Vector.normalized(1:i));
                O.GraphObj(i) = buildPio(O.GraphObj(i),n1,n2 - n1,Setoff);
                
            end
            
            % setup constants:
            THETA = linspace(0,2*pi,1000);
            RHO   = ones(1,1000)*(O.r/kr);
            C = O.GraphObj(1).Pieo.Parent.Color;
            
            XY = [RHO.*cos(THETA);RHO.*sin(THETA)];
            XY = [O.CPos(1:2)',XY + O.CPos(1:2)',O.CPos(1:2)']';
            O.Center = fill(XY(:,1),XY(:,2),C,'EdgeColor',C);
             
            % preset data to field one:
            O.Last.id = 1;
            O.Last.Field = char(O.Fields{1});
            O.GraphObj = rotateWheel(O.GraphObj,1);
            O = plotCenterText(O,1);
            
            


        end
        
        
        function O = plotCenterText(O,K)
            
            pos = O.CPos([1,2]);
            str = getString(O.GraphObj,K);
            pct = val2str(O.Vector.normalized(K)*100,'percent');
            
            if isempty(O.CenterText)
                
                % generate plot
                O.GraphObj = rotateWheel(O.GraphObj,K);
                [O.CenterText.text,pos] = plotTxtMiddle(pos,str);
                pos = [pos(1),pos(2) - 3*pos(4)/5];
                O.CenterText.percent = plotTxtMiddle(pos,pct);
                
                % text settings
                O.CenterText.text.FontSize = 12;
                O.CenterText.percent.FontWeight = 'bold';
                O.CenterText.percent.FontSize = 12;
                
                return
                
            end
            
            
            % edit text settings:
            O.CenterText.text.Position(1) = O.CPos(1);
            O.CenterText.text.String = str;
            pos = O.CenterText.text.Extent;
            O.CenterText.text.Position(1) = O.CPos(1) - pos(3)/2;
            

            % edit percent settings:
            O.CenterText.percent.String      =  pct;
            O.CenterText.percent.Position(1) =  O.CPos(1);
            pos = O.CenterText.percent.Extent;
            O.CenterText.percent.Position(1) = O.CPos(1) - pos(3)/2;
            
            


                
        end
        
        % Rotate Wheel:
        function [hOb,hndl] = rotateWheel(obj,K,hOb,hndl)

            obj.Last.id = K;
            obj.Last.Field = char(obj.Fields{K});
            obj.GraphObj = rotateWheel(obj.GraphObj,K);
            obj = plotCenterText(obj,K);
            
            
            hndl.(obj.Tag) = obj;
            if ~isempty(obj.Callback)
                [hndl,hOb] = feval(obj.Callback{:},obj.Tag,hndl,hOb);
            end    
            
            
        end
        
        
    end
end


% get interesting colors.
function c = GCNType(type)

switch type
    
    case {'purple',1}, c = ([155, 89, 182])./255;   
    case {'green',2}, c = ([38, 194, 129])./255;
    case {'oran',3}, c = ([242, 120, 75])./255;
    case {'grey',4}, c = [.5 .5 .5];
    case {'yellow',5},  c = [0.929 0.694 0.125];
    case {'orange',6}, c = [0.85 0.33 0.1];
    case {'blue',7}, c = [0.0 0.45 0.74];
    case {'teal',8}, c = ([134, 226, 213])./255;
    otherwise,  c = [rand rand rand];
        
end

end


function clckWhl(tag,hOb,hdl)

[hOb,hdl] = rotateWheel(hdl.(tag),hOb.UserData,hOb,hdl);

% Update handles structure
guidata(hOb, hdl);

end

% plot text in middle of location:
function [H,tPos] = plotTxtMiddle(WH,varargin)

H = text(WH(1),WH(2),varargin{:});
tPos = H.Extent;
H.Position(1) = WH(1) - tPos(3)/2;
H.Position(2) = WH(2) + tPos(4)/2;

end



