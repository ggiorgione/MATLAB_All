function s = funBuildo(type,varargin)
% Overview ----------------------------------------------------------------
% the following function enables users to generate the structure
% which defines how the graphical objects are constructed. allowing you to
% fully customize your dashboard.
%
%
% Debugging ---------------------------------------------------------------
% Make sure you have generated the structure to feed into this function.
% Please note the purpose is to give you access to customize the graphical
% object settings.
%
%
% Example -----------------------------------------------------------------
% Tag      = 'Table_1';            % tag of table in in handles
% Position = [.45,0.01,.50,.515];  % position of the table (normalized)
%
% s = funBuildo('table',Tag,Position,'Page','Back');
% handles = funControl('table',handles,s); % create graphical objects
% 
% Contact Info ------------------------------------------------------------
% Author:Alex Geiger
% Email: ajg1444@rit.edu
%
% -------------------------------------------------------------------------


switch lower(type)
    case 'axeso',    s = bldAxeso(varargin{:});  
    case 'slider',   s = bldSlidero(varargin{:});
    case 'table',    s = bldTableo(varargin{:});      
    case 'menu',     s = bldMenuo(varargin{:});
    case 'dragdrop', s = bldDragDropo(varargin{:});
    case 'wheel',    s = bldWheelo(varargin{:});
    case 'button',   s = bldButtono(varargin{:});
    case 'tree',     s = bldTreeo(varargin{:});
    case 'panel',    s = bldPanelo(varargin{:});  
end


end


% Build Slider Structure:
function s = bldSlidero(varargin)

% General Settings:
so.Slider = 'center';  % type
so.Values    = [0 1];  % Slide Value Range
so.Page      = 'Home'; % Page location

% Size settings:
so.Radius    = .225; % radus of circle
so.Height    = .1;   % bar height

% Color Settings:
so.BarColor  = [189, 195, 199]./255; 
so.GlowColor = [.149,.7608,.5059];
so.Color     = .60.*([0 48 91])./255 + .30.*([.98 .98 .98]);

% Build Structure:
s = inputMethods('basic',{'Tag','Position'},varargin);
s = structMethods('join',so,s);

end


% Build Axeso Structure:
function s = bldAxeso(varargin)

% general settings:
so.Units     = 'normalized';
so.Page      = 'Home';

% Graph Settings:
so.Box       = 'on';
so.XColor    = [.5 .5 .5];
so.YColor    = [.5 .5 .5];
so.GridColor = [.5 .5 .5];
so.YTick     = [];
so.Color     = 'none';
so.FontSize  = 8;

% Highlight Box:
so.HBox.FaceAlpha = .3;
so.HBox.FaceColor = [0.2 0.2 1];
so.HBox.EdgeColor = [0.2 0.2 1];
so.HBox.EdgeAlpha = .3;
            
s = inputMethods('basic',{'Tag','Position'},varargin);
s = structMethods('join',so,s);

end


% build menu Structure:
function s = bldMenuo(varargin)

% General Settings:
Bar_Height    = .075; % Default Height
Color         = ([44,62,80])./255;
FontColor     = [253, 227, 167]./255;
Pannel2Color  = .8.*([0 48 91])./255 + .4.*([.98 .98 .98]);
Pannel22Color = .65.*([0 48 91])./255 + .35.*([.98 .98 .98]);

% bar settings
so.barHeight   = Bar_Height;
so.barColor    = FontColor;

% box settings
so.Indent      = 3;
so.Color       = Color;         % Box Color
so.CColor      = Pannel2Color;  % Box Color
so.Highlight   = Pannel22Color; % Box Highlight
so.Width       = 4;             % Box Width
so.Curvature   = 0; % set to .1 to curve edges
so.Page        = 'Home';
% text settings
so.FontColor   = FontColor;        % Color of text box
so.FontHColor  = FontColor;        % Color of text box
so.FontCColor  = FontColor.*1.15;  % Color of text box
so.FontSize    = 12;             % font size
so.FontAngle   = 'normal';     % font angle
so.FontWeight  = 'normal';     % font weight


so.FontColor(so.FontColor > 1)   = 1;
so.FontHColor(so.FontHColor > 1) = 1;
so.FontCColor(so.FontCColor > 1) = 1;


s = inputMethods('basic',{'Tag','Position','fields'},varargin);
s  = structMethods('join',so,s);

end


% Build Table Structure:
function s = bldTableo(varargin)

% Menu Top
HeaderColor = .65.*([0 48 91])./255 + .35.*([.98 .98 .98]);
FontColor   = [253, 227, 167]./255;


% Menu Elements
so.Page              = 'Home';
so.MenuHeight        = 2;
so.MenuColor         = HeaderColor; %([52,73,94])./255;
so.HeaderColor       = [.15 .76 .51];
so.HeaderCColor      = ([.15 .76 .51]).*1.12;
so.HeaderHighlight   = ([.15 .76 .51]).*1.05;
so.HeaderFontColor   = [.98 .98 .98];
so.HeaderFontHColor  = [.98 .98 .98];
so.HeaderFontCColor  = [.98 .98 .98];% Text Settings
so.HeaderFontSize    = 10;
                
% table settings:
so.Columns    = 4;
so.RowHeight  = .833;
so.FontSize   = 10;
so.FontHColor = [.98 .98 .98];
so.FontCColor = [.98 .98 .98];
so.FontColor  = [.5 .5 .68];
so.Color      = [.98 .98 .98];  % Box Color
so.Highlight  = [.85 .85 .9];   % Box Highlight
so.CColor     = [.85 .82 .92];  % Box Highlight
so.Visible    = true;

% Button bar & button settings
so.BarHeight   = 1;
so.BarColor    = HeaderColor;
so.ButtonColor     = 'none';
so.ButtonCColor    = 'none';
so.ButtonHighlight = 'none';


so.ButtonHeight = 0.5;
so.ButtonWidth  = 1.5;
so.ButtonIndent = 1.0;
so.ButtonSpace  = .2;

% Button Text Settings
so.ButtonFontSize   = 10;
so.ButtonFontColor  = [.98 .98 .98];
so.ButtonFontHColor = FontColor;
so.ButtonFontCColor = FontColor;
so.ButtonFont       = 'Open Sans Condensed';
so.ButtonWeight     = 'bold';
so.ButtonFontAngle  = 'normal';
so.ButtonCurvature  = 1;

s = inputMethods('basic',{'Tag','Position'},varargin);
s = structMethods('join',so,s);


end


% Build panel structure:
function s = bldPanelo(varargin)


% Colors
HeaderColor = .65.*([0 48 91])./255 + .35.*([.98 .98 .98]);
FontColor   = [253, 227, 167]./255;


% Panel Settings
so.FaceColor   = [.93,.93,.94];
so.EdgeColor   = [.98,.98,.98];
so.HeaderColor = HeaderColor;
so.Header      = 1;
so.Page        = 'Home';

% Text Settings
so.String      = '';
so.SubString   = '';
so.FontSize    = 10;
so.SubFontSize = 6;
so.FontColor = FontColor;
so.FontName = 'Open Sans Condensed';
so.Weight = 'bold';


s = inputMethods('basic',{'Tag','Position'},varargin);
s  = structMethods('join',so,s);


end


% Build Buttono:
function s = bldButtono(varargin)


FontColor     = [.98 .98 .98];
Highlight     = .75.*([0 48 91])./255 + .25.*([.98 .98 .98]);
Color         = .65.*([0 48 91])./255 + .35.*([.98 .98 .98]);
CColor        = .85.*([0 48 91])./255 + .15.*([.98 .98 .98]);

so.Color     = Color;  % Box Color
so.CColor    = CColor;  % Box Color
so.Highlight = Highlight; % Box Highlight

so.FontSize    = 10;             % font size
so.FontAngle   = 'normal';     % font angle
so.FontWeight  = 'normal';     % font weight
so.Curvature   = 1;
so.Page        = 'Home';
so.Visible  = true;
so.Callback = [];
so.String   = ' ';

so.FontHColor = FontColor;
so.FontCColor = FontColor;
so.FontColor  = FontColor;

s = inputMethods('basic',{'Tag','Position'},varargin);
s  = structMethods('join',so,s);


end


% Build Wheel:
function s = bldWheelo(varargin)

so.Page = 'Home';       
s = inputMethods('basic',{'Tag','Position','Fields'},varargin);
so.Vector = 1:length(s.Fields);
s = structMethods('join',so,s);


end


% Build Tree:
function s = bldTreeo(varargin)

so.Page = 'Home';       
s = inputMethods('basic',{'Tag','Position','table'},varargin);
s = structMethods('join',so,s);

end
