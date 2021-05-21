% Create Pannel Structures:




% New demo Pannel Design
str    = {'Button Group Example'};
strSub = {'hover over buttons with cursor'};
Tag      = 'Pannel_1';
Position = [.017,.54,.42,.35];
Color    = [.97,.98,.98];

DemoPanel = funBuildo('panel',Tag,Position,'String',str,'SubString',strSub,'FaceColor',Color);
handles = funControl('panel',handles,DemoPanel);


% New demo Pannel Design
str    = {'Future toolboxes will have interactive graphs'};
strSub = {'Features will include Data Isolation, Scroll Zoom and Pan'};
Tag      = 'Pannel_2';
Position = [.45,0.01,.54,0.3550+0.16];
Color    = [.97,.98,.98];


DemoPanel = funBuildo('panel',Tag,Position,'String',str,'SubString',strSub,'FaceColor',Color);
handles = funControl('panel',handles,DemoPanel);

% % New demo Pannel Design
% str    = {'Free Pannel For Design'};
% strSub = {'Build Your Own World'};
% Tag      = 'Pannel_5';
% Position = [.45,.54,.54,.35];
% Color    = [.97,.98,.98];
% 
% 
% DemoPanel = funBuildo('panel',Tag,Position,'String',str,'SubString',strSub,'FaceColor',Color);
% handles = funControl('panel',handles,DemoPanel);

% New demo Pannel Design
str    = {'New Professional Dual Slide Bar'};
strSub = {'The First Step In a New Direction'};
Tag      = 'Pannel_3';
Position = [.017,0.3550,.42,0.17];
Color    = [.97,.98,.98];

DemoPanel = funBuildo('panel',Tag,Position,'String',str,'SubString',strSub,'FaceColor',Color);
handles = funControl('panel',handles,DemoPanel);

% New demo Pannel Design
str    = {'New Professional Dual Slide Bar'};
strSub = {'Drag n'' Drop Prototype'};
Tag      = 'Pannel_4';
Position = [.017,0.01,.42,0.33];


DemoPanel = funBuildo('panel',Tag,Position,'String',str,'SubString',strSub,'FaceColor');
handles = funControl('panel',handles,DemoPanel);

