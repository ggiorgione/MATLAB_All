classdef uiButtono
    %         % Box
    %         Color;
    %         CColor;
    %         Highlight;
    %
    %         % Text
    %         FontColor;
    %         FontCColor;
    %         FontHColor;
    %         FontSize;
    %         FontAngle;
    %         FontWeight;
    %         Curvature;
    
    
    
    
    properties (SetAccess='public',GetAccess='public',Hidden=false)
        
        id; % Info
        Box;
        Text;
    end
    
    properties (Dependent)
        
        Color;
        FontColor;
        String;
        CallFun;
        FontSize;
        FontAngle;
        FontWeight;
        Curvature;
        
    end
    
    
    methods
        
        function delete(obj)
            
            for i = 1:length(obj)
                delete(obj(i).Box);
                delete(obj(i).Text);
            end
            
        end
        
        function O = set.String(O,T)
            set(O.Text,'String',T)
        end
        
        function O = set.FontSize(O,T)
            set(O.Text,'FontSize',T)
        end
        
        function O = set.FontAngle(O,T)
            set(O.Text,'FontAngle',T)
        end
        
        function O = set.FontWeight(O,T)
            set(O.Text,'FontWeight',T)
        end
        
        function O = set.FontColor(O,T)
            set(O.Text,'Color',T)
        end
        
        function O = set.Color(O,T)
            set(O.Box,'FaceColor',T)
            set(O.Box,'EdgeColor',T)
        end
        
        function O = set.Curvature(O,T)
            set(O.Box,'Curvature',T)
        end
        
    end
    
    
    
    methods
        
        % Constructor
        function obj = uiButtono(s,O)
            if nargin ~= 0, obj.id = s.id;
                obj = plotBox(obj,s.pos,s);
                obj = PlotTextField(obj,s.pos,s);
                if nargin == 2, if ~isempty(O), obj = [O;obj]; end, end
            end
        end
        
    end
    
    % build methods:
    methods
        
        
        % Build Button:
        function obj = buildButton(obj,id,s)
            
            [~,I] = ismember(id,[obj.id]);
            obj(I) = plotBox(obj(I),s.pos,s);
            obj(I) = PlotTextField(obj(I),s.pos,s);
            
        end
        
        
        % Plot Rectangular Box:
        function obj = plotBox(obj,pos,s)
            
            if isempty(obj.Box)  % Set Rectangluar Box:
                Rec = rectangle('Position',pos,'Curvature',s.Curvature);
                S1 = {'ButtonDownFcn','UserData','FaceColor','EdgeColor'};
                S2 = {s.CallFun,obj.id,s.Color,s.Color};
                set(Rec,S1,S2); obj.Box = Rec; else
                obj.Box.Position = pos;
            end
            
        end
        
        
        % Plot Text Field:
        function O = PlotTextField(O,pos,s)
            
            p = [pos(1)+pos(3)/2,pos(2)+pos(4)/2];
            if isempty(O.Text) % Set Text Box:
                Tx = plotTxtMiddle(p(1),p(2),s.String,'Clipping','on');
                S1 = {'Color','FontSize','ButtonDownFcn','UserData',...
                    'FontWeight','FontAngle'}; S2 = {s.FontColor,...
                    s.FontSize,s.CallFun,O.id,s.FontWeight,s.FontAngle};
                set(Tx,S1,S2); Tx.Units = 'centimeter'; O.Text = Tx; else
                O.Text.Position   = [p,0];
            end
        end
    end
    
    
    % Callbacks:
    methods
        
        
        function obj = editColor(obj,id,color,fontcolor)
            
            
            [~,I] = ismember(id,[obj.id]);
            set(obj(I).Text,'Color',fontcolor)
            set(obj(I).Box,'FaceColor',color)
            set(obj(I).Box,'EdgeColor',color)
            
        end
        
        
        % Highlight
        function obj = highlightCall(obj,id)
            
            if nargin == 1, I = 1:length(O); else
                [~,I] = ismember(id,[obj.id]);
            end
            
            obj(I).Text.Color = obj(I).FontHColor;
            obj(I).Box.FaceColor = obj(I).Highlight;
            obj(I).Box.EdgeColor = obj(I).Highlight;
        end
        
        
        % Unhighlight
        function obj = unhighlightCall(obj,id)
            
            if nargin == 1, I = 1:length(O); else
                [~,I] = ismember(id,[obj.id]);
            end
            
            obj(I).Text.Color = obj(I).FontColor;
            obj(I).Box.FaceColor = obj(I).Color;
            obj(I).Box.EdgeColor = obj(I).Color;
        end
        
        
        % Unhighlight
        function obj = editButtonColor(obj,T,id)
            
            if nargin == 2, I = 1:length(O); else
                [~,I] = ismember(id,[obj.id]);
            end
            
            switch T
                case 1
                    obj(I).Text.Color = obj(I).FontColor;
                    obj(I).Box.FaceColor = obj(I).Color;
                    obj(I).Box.EdgeColor = obj(I).Color;
                    
                case 2
                    obj(I).Text.Color    = obj(I).FontHColor;
                    obj(I).Box.FaceColor = obj(I).Highlight;
                    obj(I).Box.EdgeColor = obj(I).Highlight;
                    
                case 3
                    obj(I).Text.Color    = obj(I).FontCColor;
                    obj(I).Box.FaceColor = obj(I).CColor;
                    obj(I).Box.EdgeColor = obj(I).CColor;
                    
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
                obj(I(i)).Box.Visible  = T;
                obj(I(i)).Text.Visible = T;
            end
            
        end
        
        
        % edit the visibility of the Objects
        function O = deleteObjects(O,id)
            
            if nargin == 1, I = 1:length(O); else
                I = ismember([O.Id],id);
            end
            
            % Delete all Objects
            for i = 1:I, delete(O(I(i)).Box); delete(O(I(i)).Text); end
            O(I) = [];
        end
        
        
    end
    
    
end



% plot text in middle of location:
function H = plotTxtMiddle(W,H,varargin)

H = text(W,H,varargin{:});
tPos = H.Extent;
H.Position(1) = W - tPos(3)/2;

end



