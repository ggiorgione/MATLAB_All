function [handles,hObject] = featuredCalls(type,Tag,handles,hObject)

fprintf('The call came from %s \n',Tag)

switch type
    case 'docs', web('https://www.goldenoakresearch.com/moderngui')
    case 'tbl_vs', handles.Table_1.Visible = 'switch';
    case 'menu_vs', handles.Menu_1.Visible = 'switch';
    case 'print'
        
       handles.Drang_Drop_1.dispMetaData = 'hey';
        
        
    case 'print_original'  
        s = handles.Table_1.Last;
        fprintf('Table Row: %2.0f, Column %2,0f \n',s.row)
        fprintf('Last Spinner %s \n',handles.spinner.getLast.Field)
        fprintf('Last Menu %s \n',handles.Menu_1.getLast.field)
        fprintf('Slider Values %2.1f \n',handles.Slider_1.getLast)
end


end

