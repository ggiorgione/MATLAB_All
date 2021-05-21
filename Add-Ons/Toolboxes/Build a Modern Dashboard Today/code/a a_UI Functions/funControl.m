function [handles,hObject] = funControl(type,varargin)
% Overview:
% the following function enables users to generate the graphical objects 
% with ease directly onto their GUIDE. The objective is to have one
% function which generates all the graphical objects. 
%
%
% Debugging:
% Make sure you have generated the structure to feed into this function.
% Please note the purpose is to give you access to customize the graphical
% object settings.
%
%
% Author:Alex Geiger
% Email: ajg1444@rit.edu


if isstruct(type) % You do not have to specify 'create'.
    [handles,hObject] = createControl(type,varargin{:}); return
end

switch lower(type)
    case 'slider',   handles = createSlider(varargin{:});
    case 'menu',     handles = createMenu(varargin{:});
    case 'dragdrop', handles = createDragDrop(varargin{:});
    case 'wheel',    handles = createWheel(varargin{:});
    case 'button',   handles = createButton(varargin{:});
    case 'tree',     handles = createTree(varargin{:});
    case 'table',    handles = createTable(varargin{:});
    case 'axeso',    handles = createAxes(varargin{:});
    case 'panel',    handles = createPanel(varargin{:});
        
end


end


% Create Control:
function [handles,hObject] = createControl(handles,hObject)

handles.UIControl = UIController();
[hObject,handles] = setDefinateMotion(handles.UIControl,hObject,handles);

end


% Create Axes Object
function handles = createAxes(handles,varargin)

if isstruct(varargin{1}), s = varargin{1}; else
    error('input needs to be: (handles,structure)')
end

handles.(s.Tag) = Axeso(s);
handles.UIControl = addObject(handles.UIControl,s.Tag,s.Page,'table');
handles = setUpAxes(handles.(s.Tag),handles);
handles = buildTree(handles.(s.Tag),handles);
handles = defineState(handles.(s.Tag),'legend',handles);
end


% Create Slider:
function handles = createSlider(handles,varargin)

if isstruct(varargin{1}), s = varargin{1}; else
    error('input needs to be: (handles,structure)')
end, handles.UIControl = addObject(handles.UIControl,s.Tag,s.Page);
handles.(s.Tag) = uiSlideBaro(s);

end


% Create Menu:
function handles = createMenu(handles,s)

handles.(s.Tag) = UIMenuo(s);
handles = genMenu(handles.(s.Tag),handles);

end


% Create Button:
function hdl = createButton(hdl,S)

if iscell(S)
    for i = 1:length(S)
        hdl.UIControl = addObject(hdl.UIControl,S{i}.Tag,S{i}.Page);
        hdl.(S{i}.Tag) = UICButtono(S{i});
        hdl = buildUIButton(hdl.(S{i}.Tag),S{i},hdl);
    end
elseif isstruct(S)
    hdl.UIControl = addObject(hdl.UIControl,S.Tag,S.Page);
    hdl.(S.Tag) = UICButtono(S);
    hdl = buildUIButton(hdl.(S.Tag),hdl);
end


end


% Create Tree:
function hdl = createTree(hdl,s)

if iscell(s)
    for i = 1:length(s)
        hdl.UIControl = addObject(hdl.UIControl,s{i}.Tag,s{i}.Page,'tree');
        hdl.(s.Tag) = DBT(s);
        hdl = loadScroll(hdl.(s.Tag),hdl);
        hdl = buildTree(hdl.(s.Tag),hdl);
        
    end
elseif isstruct(s)
    hdl.UIControl = addObject(hdl.UIControl,s.Tag,s.Page,'tree');
    hdl.(s.Tag) = DBT(s);
    hdl = loadScroll(hdl.(s.Tag),hdl);
    hdl = buildTree(hdl.(s.Tag),hdl);
    
end

end


% Create Table:
function hdl = createTable(hdl,varargin)

if isstruct(varargin{1}), s = varargin{1}; else
    error('input needs to be: (handles,structure)')
end

hdl.UIControl = addObject(hdl.UIControl,s.Tag,s.Page,'table');
hdl.(s.Tag) = UItableo(s);
hdl = buildTable(hdl.(s.Tag),hdl);

end


% Create Pannel:
function hdl = createPanel(hdl,varargin)

if isstruct(varargin{1}), s = varargin{1}; else
    error('input needs to be: (handles,structure)')
end

hdl.UIControl = addObject(hdl.UIControl,s.Tag,s.Page);
hdl.(s.Tag) = uiPanelo(s);

end


% Create drag Drop (Inprogress):
function handles = createDragDrop(handles,Tag,pos,Cell)

Page = 'Home';
handles.UIControl = addObject(handles.UIControl,Tag,Page,'tree');
handles.(Tag) = UITreeo(Tag,pos);
handles.(Tag) = LoadData(handles.(Tag),Cell);
handles = buildTree(handles.(Tag),handles);

end


% Create Wheel (Inprogress):
function hdl = createWheel(hdl,varargin)

if isstruct(varargin{1}), s = varargin{1}; else
    error('input needs to be: (handles,structure)')
end

hdl.UIControl = addObject(hdl.UIControl,s.Tag,s.Page);
hdl.(s.Tag) = uiWheelo(s);

if isfield(s,'Callback')
    hdl.(s.Tag) = setCallBack(hdl.(s.Tag),s.Callback);
end

end





