 classdef UIelemento
    % an important sub-object
    
    
    
    properties (Dependent)
        
        % Font Colors:
        Color;
        FontColor;
        FontSize;
        String;
        
    end
    
    % General Methods:
    properties (SetAccess='public',GetAccess='public',Hidden=false)
         
        Row;
        Column;
        Callback;
        
        
    end
    
    
    properties (SetAccess='public',GetAccess='public',Hidden=false)        
        
        Id;         % id will be columns for rows
        Box;
        Text;
        
    end
    
    
    methods
        
        function O = set.String(O,T)
            if ~isempty(O.Text)
                set(O.Text,'String',T)
            end
        end
        
        function O = set.FontSize(O,T)
            if ~isempty(O.Text)
                set(O.Text,'FontSize',T)
            end
            
        end
        
        function O = set.FontColor(O,T)
            if ~isempty(O.Text)
                set(O.Text,'Color',T)
            end
        end
        
        function O = set.Color(O,T)
            
            if ~isempty(O.Box)
                set(O.Box,'FaceColor',T)
                set(O.Box,'EdgeColor',T)
            end
            
        end
        
    end
    
    
    
    
    
    methods
        
        
        % Constructor:
        function obj = UIelemento(s,O)
            % Info should have boxPosition
            
            % Setup Identification Markers:            
            obj.Id = s.Id;
            obj.Column = s.Column;
            obj.Row    = s.Row;
            obj = PlotRectangularBox(obj,s);
            obj = PlotTextField(obj,s);
            if nargin == 2, if ~isempty(O), obj = [O;obj]; end, end
            
        end
        
        
        % Plot Rectangular Box:
        function O = PlotRectangularBox(O,S)
            
           % Set Rectangluar Box:
           if isempty(O.Box)
               Rec = rectangle('Position',S.boxPosition);
               Rec.ButtonDownFcn = S.Callback;
               Rec.UserData = S.Id; Rec.FaceColor = S.Color;
               Rec.EdgeColor = S.Color; O.Box = Rec; else
               O.Box.Position = O.Settings.boxPosition;
           end
           
        end
        
        
        % Plot Text Field:
        function O = PlotTextField(O,S)
            
            
            P = S.txtPosition;
            if isempty(O.Text) % Set Text Box:
                Txt = text(P(1),P(2),S.String,'Clipping','on');
                Txt.Color = S.FontColor;
                Txt.FontSize = S.FontSize;
                Txt.ButtonDownFcn = S.Callback;
                Txt.Units = 'centimeter';  
                Txt.UserData = O.Id;
                O.Text = Txt; else
                O.Text.Units = 'centimeter';  
                O.Text.Position = [P(1),P(2), 0];
            end

        end
        
        
        % Update String
        function O = updateString(O,T,row,col)
            
            I = ismember(([O.Row;O.Column])',[row col],'rows');
            if islogical(T),if T == 1, T = 'true'; else, T = 'false'; end
            elseif isNumber(T), T =  val2str(T,'double','char');
            elseif iscell(T),  T = char(T); 
            end, O(I).Text.String = T;
            
        end
        
        
    end
    
    
    methods
        
        % Element Settings:
        function obj = ElementColor(obj,id,color,fontcolor)
            
            I = ismember([obj.Id],id);
            set([obj(I).Box],'FaceColor',color)
            set([obj(I).Box],'EdgeColor',color)
            set([obj(I).Text],'Color',fontcolor)
            
            
            
        end
        
        
        % Row Settings:
        function obj = RowColor(obj,row,color,fontcolor)
            % FC = cell(3,sum(I)); FC(1,:) = {'FaceColor'};
            % FC(2,:) = {'EdgeColor'}; FC(3,:) = {'Color'};
            % set([obj(I).Box],FC(1,:),{obj(I).Color})
            % set([obj(I).Box],FC(2,:),{obj(I).Color})
            % set([obj(I).Text],FC(3,:),{obj(I).FontColor})
            
            I = ismember([obj.Row],row); 
            set([obj(I).Box],'FaceColor',color)
            set([obj(I).Box],'EdgeColor',color)
            set([obj(I).Text],'Color',fontcolor)
            
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

