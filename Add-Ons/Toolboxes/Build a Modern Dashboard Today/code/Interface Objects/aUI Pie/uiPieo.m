classdef uiPieo
    % UI Interface Pie Chart.
    
    properties (Dependent)
       
        Visible;
        
    end
    
    % General Properties:
    properties
        
        Visibility
        
        % Data Settings:
        id;
        FontColor;
        Color;
        EdgeColor;
        Call;
        String;
        txtVisible;
        midAngle;
        startAngle;
        
        % Graphical Objects
        Pieo;
        
        % Pie Info
        Center;
        radius;
        Theta;
        Rho;
        
    end
    
    
    % Methods:
    methods
        
        
        function s = getString(O,K)
            
            s = O(K == [O.id]).String;
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
            O.Pieo.Visible = K;
        end
        
        
        % Constructor:
        function obj = uiPieo(info,O)
            
            obj.id      = info.Id;
            obj.radius  = info.Radius;
            obj.Center  = info.Center;
            obj.Call    = info.Call;
            obj.Color   = info.Color;
            obj.FontColor = info.fontColor;
            obj.EdgeColor = info.edgeColor;
            obj.String     = info.String;
            obj.txtVisible = 'false';
            if ~isempty(O), obj = [O;obj]; end
            
        end
        
        
        
        % Build Object:
        function O = buildPio(O,Start,Pct,Setoff)
     
            % Nargin Inputs
            if nargin == 3, Setoff = 0; end
            
            % Setup Start and Stop N's
            O.startAngle = 2*pi*Start     - Setoff;
            O.midAngle = 2*pi*(Start+Pct) - Setoff;
            
            % Pie Plot:
            O.Theta = linspace(O.startAngle,O.midAngle,1000);
            O.Rho   = ones(1,1000)*O.radius;

            XY = [O.Rho.*cos(O.Theta);O.Rho.*sin(O.Theta)];
            XY = [O.Center(1:2)',XY + O.Center(1:2)',O.Center(1:2)']';
            
            O.Pieo = fill(XY(:,1),XY(:,2),O.Color,'Facealpha',.9);
            O.Pieo.ButtonDownFcn = O.Call;
            O.Pieo.EdgeColor     = [.8 .8 .8];
            O.Pieo.UserData      = O.id;
            
        end
        
        
        
        % Rotate Wheel or Pie graph:
        function O = rotateWheel(O,K)
            
            I = (K == [O.id]);
            n = length(O);
            D =  - O(I).startAngle-(O(I).midAngle-O(I).startAngle)/2;
             
            
            for i = 1:n
                
                T = O(i).Theta;
                R   = O(i).Rho;
                XY = [R.*cos(T + D);R.*sin(T + D)] + O(i).Center(1:2)';
                XY = [O(i).Center(1:2)',XY,O(i).Center(1:2)']';
                set(O(i).Pieo,{'XData','YData'},{XY(:,1)',XY(:,2)'});
                
            end
            
        end
        
        
        
    end
    
end


