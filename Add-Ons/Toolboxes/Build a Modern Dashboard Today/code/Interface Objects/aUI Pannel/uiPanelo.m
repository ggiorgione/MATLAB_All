classdef uiPanelo
    % Position - Position of panel
    
    
    
    properties (Dependent)
        
        Visible
    end
    
    properties
        
        Tag;
        Page;
        Axes;
        Pos;
        NormPos;
        Base;
        Header;
        Text;
        subText;
        Visibility;
    end
    
    methods
        
        
        % get Visibility:
        function v = get.Visible(O)
            
            v = O.Visibility;
            
        end
        
        
        % set visibility:
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
           
            
            if O.Visibility
                O.subText.Visible = 'on';
                O.Base.Visible    = 'on';
                O.Header.Visible  = 'on';
                O.Text.Visible    = 'on';
                O.Axes.Visible    = 'on';
            else
                O.subText.Visible = 'off';
                O.Base.Visible    = 'off';
                O.Header.Visible  = 'off';
                O.Text.Visible    = 'off';
                O.Axes.Visible    = 'off';
            end
            
            
            
            
        end
        
        
    end
    
    
    
    methods
        
        function O = uiPanelo(s)
            
            O.Tag  = s.Tag;
            Position = s.Position;
            O.Page = s.Page;
            O.Axes = axes('Position',Position,'Units','normalized');
            O.Axes.Tag = s.Tag;
            O.Axes.YColor = 'none'; O.Axes.XColor = 'none';
            O.Axes.XTick = []; O.Axes.YTick = [];
            O.Axes.Color = 'none'; O = setAxesLimits(O);
            
            
            FC = s.FaceColor;   % face color (base)
            EC = s.EdgeColor;   % edge color (base)
            HC = s.HeaderColor; % header color (base)
            BP = [0,0,O.Pos(3),O.Pos(4) - s.Header/2]; % base position
            HP = [0,O.Pos(4)-s.Header,O.Pos(3),s.Header]; % header position
            
            O.Base = rectangle('Position',BP,'FaceColor',FC);
            O.Base.EdgeColor = EC;
            O.Base.Curvature = .025;
            
            O.Header = rectangle('Position',HP,'FaceColor',HC);
            O.Header.EdgeColor = HC;
            O.Header.Curvature = .025;
            
            O.Text = text(.25,O.Pos(4) - s.Header/3,s.String{1});
            O.Text.Color = s.FontColor;
            O.Text.FontWeight = s.Weight;
            O.Text.FontName = s.FontName; 
            O.Text.FontSize = s.FontSize;
            
            O.subText = text(.25,O.Pos(4) - 2*s.Header/3,s.SubString{1});
            O.subText.Color      = s.FontColor;
            O.subText.FontWeight = s.Weight;
            O.subText.FontName   = s.FontName; 
            O.subText.FontSize = s.SubFontSize;
            
            
            
        end
        
        % Setup Axes Limits:
        function obj = setAxesLimits(obj)
            
            obj.Axes.Units = 'centimeters'; obj.Pos = obj.Axes.Position;
            obj.Axes.Units = 'normalized'; obj.NormPos = obj.Axes.Position;
            obj.Axes.XLim = [0,obj.Pos(3)]; obj.Axes.YLim = [0,obj.Pos(4)];
            
        end
        
        
        
    end
    
end

