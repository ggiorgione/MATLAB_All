function hObject = setFigureWM(hObject,B2)

if strcmpi(hObject.Parent.Type,'figure')
    hObject.Parent.WindowButtonMotionFcn = B2;
elseif strcmpi(hObject.Parent.Parent.Type,'figure')
    hObject.Parent.Parent.WindowButtonMotionFcn = B2;
elseif strcmpi(hObject.Parent.Parent.Parent.Type,'figure')
    hObject.Parent.Parent.Parent.WindowButtonMotionFcn = B2;
end

end

