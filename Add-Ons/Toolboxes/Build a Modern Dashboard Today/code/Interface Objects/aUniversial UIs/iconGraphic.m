classdef iconGraphic
    
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
        sGraphics
    end
    
    % general methods:
    methods
        
        % Edit Visibility
        function O = set.ButtonDownFcn(O,T)
            
            O.sGraphics.ButtonDownFcn = T;
             
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
            O.sGraphics.Visible = K;
            
        end
        
        % get visible:
        function T = get.Visible(obj)
            
            T = obj.Visibility;
            
        end
        
        % set position:
        function O = set.Position(O,P)
            
            P = [P(1),sum(P([1,3])),P(2),sum(P([2,4]))];
            O.sGraphics.XData = P(1:2);
            O.sGraphics.YData = P(3:4);
        end
        
        % build icon graphic:
        function obj = iconGraphic(type,P,Backround_Color)
            
            N = Backround_Color.*255;
            P = [P(1),sum(P([1,3])),sum(P([2,4])),P(2)];
            
            switch type
                
                case 'arrow'
                    hold on
                    o = {1,1,1};
                    myImg = load('arrow_pic.mat','arrow_pic');
                    myImg = myImg.arrow_pic;
                    myImg = changeColor(myImg,o{:},N(1),N(2),N(3),200,10);
                    obj.sGraphics = imagesc(P(1:2),P(3:4),myImg);
                
                  
                case 'document'
                    hold on
                    o = {1,1,1};
                    myImg = load('legend_pic.mat','legend_pic');
                    myImg = myImg.legend_pic;
                    myImg = changeColor(myImg,o{:},N(1),N(2),N(3),200,10);
                    obj.sGraphics = imagesc(P(1:2),P(3:4),myImg);
                    
                case 'chart'
                    o = {10,10,10};
                    myImg = load('chart_pic.mat','chart_pic');
                    myImg = myImg.chart_pic;
                    myImg = changeColor(myImg,o{:},N(1),N(2),N(3),200,10);
                    obj.sGraphics = imagesc(P(1:2),P(3:4),myImg);

                    case 'geo'
                    hold on
                    o = {1,1,1};
                    myImg = load('geo_plot.mat','geo_plot');
                    myImg = myImg.geo_plot;
                    myImg = changeColor(myImg,o{:},N(1),N(2),N(3),200,10);
                    obj.sGraphics = imagesc(P(1:2),P(3:4),myImg);
                    
                case 'fill'
                    o = {10,10,10};
                    myImg = load('fill_plot.mat','fill_plot');
                    myImg = myImg.fill_plot;
                    myImg = changeColor(myImg,o{:},N(1),N(2),N(3),200,10);
                    obj.sGraphics = imagesc(P(1:2),P(3:4),myImg);
                    
            end
        end
        
    end
    
    
end
