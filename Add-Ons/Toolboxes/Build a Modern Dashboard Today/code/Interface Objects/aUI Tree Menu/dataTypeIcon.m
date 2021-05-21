classdef dataTypeIcon
    % build data type icon
    
    % Dependent Properties:
    properties (Dependent)
        ButtonDownFcn
        Position
        Visible
        Page;
    end
    
    % general Properties:
    properties
        
        Visibility
        Bubble
        Text
        txt_pos
    end
    
    % general methods:
    methods
        
        % Edit Visibility
        function O = set.ButtonDownFcn(O,T)
            
            O.Bubble.ButtonDownFcn = T;
            O.Text.ButtonDownFcn   = T;
            
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
            
            
            O.Bubble.Visible = K;
            O.Text.Visible   = K;
            
        end
        
        % get visible:
        function T = get.Visible(obj)
            
            T = obj.Visibility;
            
        end
        
        % set position:
        function O = set.Position(O,P)
            
            txt = P(1:2) + P(3:4)/2;
            O.Bubble.Position    = P;
            O.Text.Position(1:2) = txt(1:2) - [O.Text.Extent(3)/2,0];
            
            
        end
        
        % build icon graphic:
        function O = dataTypeIcon(P)
            
            % text position:
            O.Visibility = true;
            O.txt_pos = P(1:2) + P(3:4)/2;
            
           
            hold on % create bubble
            O.Bubble = rectangle('Position',P,'FaceColor','none');
            O.Bubble.EdgeColor = 'none';
            O.Bubble.Curvature = [1,1];
            
            % create display text:
            O.Text = text(O.txt_pos(1),O.txt_pos(2),'');
            O.Text.Color = [.85,.85,.90];
            O.Text.Position(1) = O.txt_pos(1) - O.Text.Extent(3)/2;
            O.Text.FontSize = 9;
        end
        
        
        function O = designIcon(O,s)
            
            O.Text.String = s.Symbol;
            O.Text.Position = [O.txt_pos(1:2),0];
            O.Text.Color = [.85,.85,.90];
            O.Text.Position(1) = O.txt_pos(1) - O.Text.Extent(3)/2;
            O.Text.UserData    = s.id;
            O.Text.Clipping = 'on';
            
            O.Bubble.FaceColor = s.Color;
            O.Bubble.UserData  = s.id;
            O.Bubble.Clipping = 'on';
            
            
            O.ButtonDownFcn = s.Call;
            
        end
        
        
        function O = updateDesign(O,s)
            
            O.Text.String      = s.Symbol;
            O.Bubble.FaceColor = s.Color;

        end
        
        function delete(O)
            delete(O.Bubble)
            delete(O.Text)
            
        end
    end
    
    
end

