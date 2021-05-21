classdef uiEditText
    % Creates Oval Text Box To Get the text box info a function will
    % be created where you pass an id and you will get the current text in
    % the text box.
    
    % General Propeties:
    
    properties (Dependent)
        
        Visible;
        setMute;
  
    end
    
    properties
   
        id;           % id Number
        Pos;          % axes position normalized
        NormPos       % normal position
        EditText;     % Edit Text Object
        ERef;         % edit box java referance
        Backround
        Visibility;
    end
    
    % General Methods:
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
            
            O.EditText.Visible  = K; % K;
            O.Backround.Visible = K;
            
        end
        
        % Edit Visibility
        function O = set.setMute(O,T)
            O.EditText.Visible  = T;
        end
        
        % Constructor:
        function obj = uiEditText(Id,p,np)
            obj.Pos     = p;
            obj.NormPos = np;
            obj.id      = Id;
        end
        
        
        % Build Edit Text:
        function obj = buildEditText(obj,p)
            % Radius = THW(4)./2; 
            % cm_Settings = .62;
            
            
            Color = [.98 .98 .98];
            Vx    = obj.NormPos([3 4])./obj.Pos([3 4]);
            
            TMWView = Vx([1 2 1 2]).*p([1 2 3 4]);
            THW = TMWView + [obj.NormPos([1 2]),0,0];
            Radius = Vx(2)*p(4)./(2);
            THW([1 3]) = [THW(1) + Radius,THW(3) - 2*Radius];
            
            if isempty(obj.EditText)
                obj.EditText = uicontrol('Style','Edit');
                obj.EditText.BackgroundColor = Color;
                obj.ERef = findjobj(obj.EditText); % find java object
                obj.ERef.Border = []; % delete java baorder
                obj.ERef.repaint;     % redraw the modified control
            end
            
            % Set up Edit text Settings
            obj.EditText.Units = 'normalized';
            obj.EditText.Position = THW;
            
            % Create two half circles*
            r =  p(4)/2; % recalculate radus
            shift = .01;
            shiftup = shift/2;
            Position = [p(1)+r,p(2)+shift,p(3)-2*r,p(4)+shiftup];
            
            if isempty(obj.Backround)
                obj.Backround = rectangle('Position',Position); else
                obj.Backround.Position = Position;
            end
            
            obj.Backround.FaceColor = [.98,.98,.98];
            obj.Backround.EdgeColor = 'none';
            obj.Backround.Curvature = 1;
            O.EditText.Visible  = 'off';
            
        end
        
        
        
        % Get Edit String Field:
        function str = getString(obj,id)
            
            if nargin == 1, I = 1:length(O); else
                [~,I] = ismember(id,[obj.Id]);
            end
            
            str = obj(I).EditText.String;

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
                obj(I(i)).EditText.Visible  = T; % T;
                obj(I(i)).Backround.Visible = T;
            end
            
        end
        
        
        
        % edit the visibility of the Objects
        function O = deleteObjects(O,id)
            
            if nargin == 1, I = 1:length(O); else
                I = ismember([O.Id],id);
            end
            
            % Delete all Objects
            for i = 1:I
                delete(O(I(i)).EditText); 
                delete(O(I(i)).Backround); 
            end,O(I) = [];
            
        end
        
        
    end
    
end


