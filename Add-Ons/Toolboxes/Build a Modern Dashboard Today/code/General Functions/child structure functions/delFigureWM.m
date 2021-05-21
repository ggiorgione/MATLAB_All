function hObject = delFigureWM(hObject)

if strcmpi(hObject.Parent.Type,'figure')
    hObject.Parent.WindowButtonMotionFcn = [];
elseif strcmpi(hObject.Parent.Parent.Type,'figure')
    hObject.Parent.Parent.WindowButtonMotionFcn = [];
elseif strcmpi(hObject.Parent.Parent.Parent.Type,'figure')
    hObject.Parent.Parent.Parent.WindowButtonMotionFcn = [];
end

end

