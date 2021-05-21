% Run Example Program of how to build a good looking GUI
% *** Note all positions are normalized ****

%% 1. Load Data:
% so you may view it:
load demo_variables
Pos = genButtonPos([0.035 0.75 0.132 0.041],.05,4);

%% 2.1 Load Controller:
[handles,hObject] = funControl(handles,hObject);


%% 2.2 Setup Pannels and Backround Pictures:
% Set backround of figure.
PictureName = 'backroundPic.jpg';
handles = setBackround(handles,PictureName);

% 2.3 load pannels:
loadPannelExample


%% 3. Setup The Menu:
Tag      = 'Menu_1'; % tag for menu
flds     = {'Home','Next','Back','Settings'}; % fields of menu
Position = [0 .93 1 .07]; % position of menu on graph
Callback = {'exampleFunction'}; % callback function

s = funBuildo('menu',Tag,Position,flds); % build structure
handles = funControl('menu',handles,s);  % build object
handles.(Tag).CallBack = Callback;       % set callback


%% 4.1 Build Tables:
% Table 1
Tag      = 'Table_1';           % tag of table in in handles
Position = [.45,0.01,.50,.515]; % position of the table (normalized)
Callback = {'exampleFunction'}; % set callback

s = funBuildo('table',Tag,Position,'Callback',Callback,'Page','Back');
handles = funControl('table',handles,s); % bld
handles.(Tag).Table = T; % upload table through dynamic dot notation.
handles.(Tag).Callback = Callback; % set callback

% Table 2
Tag      = 'Table_2';           % tag of table in in handles
Position = [.45,.54,.54,.35];   % position of the table (normalized)
Callback = {'exampleFunction'}; % set callback

s = funBuildo('table',Tag,Position,'Callback',Callback,'Page','Home');
handles = funControl('table',handles,s); % bld
handles.(Tag).Table = T; % upload table through dynamic dot notation.
handles.(Tag).Callback = Callback; % set callback

%% 5. Setup Buttons:
% buttons has the ability to process a cell array of strucutures. therefore
% you only need to call funControl once instead of calling in multiple
% times for each element in cell array.

Color = [.149,.7608,.5059];
A = {'Callback',{'featuredCalls','docs'},'String','View Documentation'};
B = {funBuildo('button','Button_1',Pos(1,:),A{:},'Color',...
    Color,'Highlight',Color.*1.1,'CColor',Color*.2)};

A = {'Callback',{'featuredCalls','tbl_vs'},'String','Table Visibility'};
B(2) = {funBuildo('button','Button_2',Pos(2,:),A{:})};

A = {'Callback',{'featuredCalls','menu_vs'},'String','Menu Visibility'};
B(3) = {funBuildo('button','Button_3',Pos(3,:),A{:})};

A = {'Callback',{'featuredCalls','print'},'String','Print Info'};
B(4)    = {funBuildo('button','Button_4',Pos(4,:),A{:})};
handles = funControl('button',handles,B);


%% 6. Setup Multi Toggle Button Circle:
flds = {'Profit','Sales','Cash Flow'};
Callback = {'exampleFunction'};
pos = [.25,Pos(4,2),0.18 - .02 ,Pos(1,4) + Pos(1,2) - Pos(4,2)+.02];

s = funBuildo('wheel','spinner',pos,flds,'Callback',Callback);
handles = funControl('wheel',handles,s);


%% 7. Setup The Drag and Drop Trees:

% Setup UI Tree 1:
s = funBuildo('tree','Drang_Drop_1',[.042 0.025 .15 0.24],TblImport);
handles = funControl('tree',handles,s);


% Setup UI Tree 2:
TblImport.latitude = [];
TblImport.Profit = [];
s = funBuildo('tree','Drang_Drop_2',[.265 0.025 .15 0.24],TblImport);
handles = funControl('tree',handles,s);


%% 8. Load hObject into handles and update GUI Data

s = funBuildo('slider','Slider_1',[0.1150,0.36,.25,.025],'Slider','left');
handles = funControl('slider',handles,s);


s = funBuildo('slider','Slider_2',[.115,.395,.25,.025],'Slider','center');
handles = funControl('slider',handles,s);


s = funBuildo('slider','Slider_3',[.115,.43,.25,.025],'Slider','right');
handles = funControl('slider',handles,s);


%% 9. Load hObject into handles and update GUI Data
s=funBuildo('axeso','graph_1',[.50,0.05,.48,0.39]);
handles = funControl('axeso',handles,s);


%% Finish Program setup:
handles = selectPage(handles.UIControl,'Home',handles);
[hObject,handles] = setDefinateMotion(handles.UIControl,hObject,handles);


%% 10. Load hObject into handles and update GUI Data

% Choose default command line output for DemoFigure
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


%% 9. For Fun Try These settings

% handles.('Table_1').Color           = [.5 .5 .5];
% handles.('Table_1').FontColor       = [1 1 1];
% handles.('Table_1').HeaderColor     = [0 1 0];
% handles.('Table_1').HeaderFontColor = [1 1 1];
% handles.('Table_1').ButtonColor     = [0 0 0];
% handles.('Table_1').ButtonFontColor = [1 1 1];
% handles.('Table_1').ButtonColor     = [0 0 0];
% handles.('Table_1').MenuColor       = [0 0 0];
% handles.('Table_1').BarColor        = [1 1 1];




