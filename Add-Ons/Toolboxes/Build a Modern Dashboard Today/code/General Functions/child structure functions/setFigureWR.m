function hObject = setFigureWR(hObject,B2)

if strcmpi(hObject.Parent.Type,'figure')
    hObject.Parent.WindowButtonUpFcn  = B2;
elseif strcmpi(hObject.Parent.Parent.Type,'figure')
    hObject.Parent.Parent.WindowButtonUpFcn  = B2;
elseif strcmpi(hObject.Parent.Parent.Parent.Type,'figure')
    hObject.Parent.Parent.Parent.WindowButtonUpFcn  = B2;
end

end
