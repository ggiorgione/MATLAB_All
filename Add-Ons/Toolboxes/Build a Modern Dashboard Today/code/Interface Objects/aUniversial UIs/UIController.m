classdef UIController
    % Overview:
    % The following class you may thing of as the brain of the modern GUI
    % it is the class which outlines which page objects are on, and object
    % visibility.
    %
    % Author:Alex Geiger
    % Email: ajg1444@rit.edu
    %
    %
    % --------------------- Personal Notes --------------------------------
    % PosTbl Column Fields
    % 1. Property name
    % 2. Tick or Tag Name of property
    % 3. Position
    %
    % Universial Callbacks
    % 1. turnOffImportDefault (table view: importTbl)
    % 2. turnOffHoverDefault  (table view: viewTbl)
    % ---------------------------------------------------------------------
    
    
    
    % General Properties:
    properties
        
        Page;      % Current Page of the Program
        SOTables; 
        MOTable;
        OList;     % Object List
        
        
        
        % Last Item Choosen
        Last;       % Last Run Time Position
        LastImport; % Last Import Position
        
        
        % Last Table Choosen
        viewTbl;    % runtime position
        importTbl;  % import table
        scrollTbl;  % scroll table
        
        
    end
    
    
    % Callback Properties:
    properties
        
        % Callback Functions
        genMotion;  % callback
        genScroll;  % callback
        ScrollDirection;
    end
    
    
    % Setup Methods:
    methods
        
        % Constructor:
        function obj = UIController()
            
            obj.ScrollDirection = 1;
            
            obj.genMotion = @(hObject,eventdata)getRunMoition...
                (hObject,guidata(hObject)); obj.Last = [];
            
            obj.genScroll = @(hObject,eventdata)getScrollMoition...
                (hObject,guidata(hObject),eventdata);
            
        end
        
        
        % set Motion Function:
        function obj = setGenMotion(obj,hObject,handles)
            
            if strcmpi('figure',hObject.Type)
                hObject.WindowButtonMotionFcn = obj.genMotion;
                hObject.WindowScrollWheelFcn = obj.genScroll;
                guidata(hObject, handles);
            end
            
        end
        
        
        % Set Motion Function:
        function [hObject,handles] = setDefinateMotion(obj,hObject,handles) %#ok
            
            B1 = @(hObject,eventdata)getScrollMoition...
                (hObject,guidata(hObject),eventdata);
            
            B2 = @(hObject,eventdata)getRunMoition...
                (hObject,guidata(hObject));
            
            if strcmpi(hObject.Type,'figure')
                hObject.WindowButtonMotionFcn = B2;
                hObject.WindowScrollWheelFcn = B1;
            elseif strcmpi(hObject.Parent.Type,'figure')
                hObject.Parent.WindowButtonMotionFcn = B2;
                hObject.Parent.WindowScrollWheelFcn = B1;
            elseif strcmpi(hObject.Parent.Parent.Type,'figure')
                hObject.Parent.Parent.WindowButtonMotionFcn = B2;
                hObject.Parent.Parent.WindowScrollWheelFcn = B1;
            elseif strcmpi(hObject.Parent.Parent.Parent.Type,'figure')
                hObject.Parent.Parent.Parent.WindowButtonMotionFcn = B2;
                hObject.Parent.Parent.WindowScrollWheelFcn = B1;
            end,guidata(hObject, handles);
        end
        
        
    end
    
    
    % View Methods
    methods
        
        
        % Scroll Function Check:
        function [hdl,L] = GetScrollMoition(obj,hObject,hdl,D)

            % obj.scrollTbl
            if size(obj.scrollTbl,1) == 0, L = false; return, end
            P = obj.scrollTbl.pos;
            M = hObject.CurrentPoint;
            hObject.BusyAction = 'queue';
            L = (M(1)>P(:,1))&(M(1)<P(:,2))&(M(2)>P(:,3))&M(2)<P(:,4);
            if all(L == 0), L = false; return, end
            
       
            if D == 0
                obj.ScrollDirection = obj.ScrollDirection/2;
                D = obj.ScrollDirection;
            elseif obj.ScrollDirection ~= 0 && obj.ScrollDirection ~= D
                obj.ScrollDirection = D;
                hdl.UIControl = obj;
            end
            
            T = char(obj.scrollTbl(L,:).tag);
            Type = char(obj.scrollTbl(L,:).property);
            hdl = scrollFunction(hdl.(T),M,D,Type,hdl); 
            
        end
        
        
        % Runtime Motion:
        function [obj,L] = GetRunMoition(obj,hObject,hdl)
            
            if isempty(obj.viewTbl), L = false; return, end
            P = obj.viewTbl.pos;
            M = hObject.CurrentPoint;
            hObject.BusyAction = 'queue';
            L = (M(1)>P(:,1))&(M(1)<P(:,2))&(M(2)>P(:,3))&M(2)<P(:,4);
            
            if all(L == 0)
                if ~isempty(obj.Last)
                    H = char(obj.Last.tag);
                    hdl.(H) = turnOffHoverDefault(hdl.(H),obj.Last.id);
                end,obj.Last = []; L = false; return
            end
            
            if ~isempty(obj.Last)
                H = char(obj.Last.tag);
                if isequal(obj.Last,obj.viewTbl(L,:)), return, end
                hdl.(H) = turnOffHoverDefault(hdl.(H),obj.Last.id);
            end
            
            obj.Last = obj.viewTbl(L,:);
            H = char(obj.viewTbl(L,:).tag);
      
            hdl.(H) = hoverDefault(hdl.(H),obj.viewTbl(L,:).id);
   
        end
        
                
        % get Logic of UIController:
        function [handles,L] = ImportMoition(obj,hObject,handles,Tag)
            
            if size(obj.importTbl,1) == 0, L = false; return, end
            P = obj.importTbl.pos;
            M = hObject.CurrentPoint;
            
            L = (M(1)>P(:,1))&(M(1)<P(:,2))&(M(2)>P(:,3))&M(2)<P(:,4);
            
            if sum(L) == 0
                if ~isempty(obj.LastImport)
                    H = char(obj.LastImport.tag);
                    handles.(H) = turnOffImportDefault(handles.(H));
                    handles.UIControl.LastImport = [];
                end
                L = false; return
            end
            
            if ~isempty(obj.LastImport)
                if isequal(obj.Last,obj.importTbl(L,:)), return, end
                H = char(obj.LastImport.tag);
                handles.(H) = turnOffImportDefault(handles.(H));
            end
            
            obj.LastImport = obj.importTbl(L,:);
            I = obj.importTbl(L,:).id;
            H = char(obj.importTbl(L,:).tag);
            P = P(L,[3 4]);
            handles.(H) = importDefault(handles.(H),I,M,P,Tag,handles);
            handles.UIControl = obj;
        end
        
        
    end
    
    
    % Update table Methods:
    methods
        
        function hdl = setSearchFun(O,hdl,K)
            
          
            T = O.OList(ismember(O.OList.Page,O.Page)&O.OList.Search,:);
            if isempty(T), return, end
            
            for i = 1:size(T,1)
               hdl.(char(T{i,1})).setMute = K;
            end
            
            
        end
        
        
        % Add Object:
        function obj = addObject(obj,Tag,Page,type)
            Tag = cellstr(Tag); Page = cellstr(Page);
            
            
            if nargin ~= 4
                Search = false;
            elseif ismember(cellstr(type),{'table','axeso','tree'})
                Search = true;
            else
                Search = false;
            end
            
            
            Visibility = 1;
            if isempty(obj.OList)
                obj.OList = table(Tag,Page,Visibility,Search);
            else
                obj.OList = [obj.OList;{Tag,Page,Visibility,Search}];
            end
        end
        
        
        % Select Page:
        function hdl = selectPage(O,page,hdl)
        
            % Last Table Choosen:
            O.viewTbl   = [];
            O.importTbl = [];
            O.scrollTbl = [];
            
            
            O.Page = page;
            I  = ismember(O.OList.Page,cellstr(page));
            Tags = O.OList.Tag(I);
            
            II = O.OList.Visibility == 1;
            L1 = O.OList.Tag(~I & II); 
            L2 = O.OList.Tag(I & ~II);
            
            O.OList.Visibility(~I & II) = false;
            O.OList.Visibility(I & ~II) = true;
            
            if isfield(O.SOTables,'view')
                IV = ismember(O.SOTables.view.tag,Tags);
                O.viewTbl   = O.SOTables.view(IV,:);   
            end
            
            if isfield(O.SOTables,'import')
                IV = ismember(O.SOTables.import.tag,Tags);
                O.importTbl = O.SOTables.import(IV,:); 
            end
            
            if isfield(O.SOTables,'scroll')
                IV = ismember(O.SOTables.scroll.tag,Tags);
                O.scrollTbl = O.SOTables.scroll(IV,:); 
            end
            
            N = 'MOTable'; 
            L = isfield(O.MOTable,{'view','import','scroll'});
            if L(1), O.viewTbl = [O.viewTbl;O.(N).view];       end
            if L(2), O.importTbl = [O.importTbl;O.(N).import]; end
            if L(3), O.scrollTbl = [O.scrollTbl;O.(N).scroll]; end
            
            
            
            for i = 1:length(L1), hdl.(L1{i}).Visible = false; end
            for i = 1:length(L2), hdl.(L2{i}).Visible = true;  end
            hdl.UIControl = O;
            
        end
        
        
        % update import Tbl (Used for drag and Drop Menus):
        function [O,L] = updateTable(O,Type,tbl,Tag)
            % T: is Always Present on Screen
            % K: is on current page
            
            page = [];
            if ~ischar(Type), Type = Type{1}; end
            if isempty(O.OList), T = true;  else % get page
                page = O.OList.Page(ismember(Tag,O.OList.Tag));
                if isempty(page), T = true; else, T = false; end
            end
            
            if     isempty(page), K = false;
            elseif strcmpi(page,O.Page), K = true;
            else,  K = false;
            end
            
            
            if K % K: is on current page
                switch Type
                    case 'view',   TableName = 'viewTbl';
                    case 'import', TableName = 'importTbl';
                    case 'scroll',  TableName = 'scrollTbl';    
                end
                
                L = ismember(O.(TableName).tag,Tag);
                if sum(L) ~= 0, O.(TableName)(L,:) = []; end
                O.(TableName) = [O.(TableName);tbl];
            end
            
            if T % T: is Always Present on Screen, constant object* 
                if ~isfield(O.MOTable,Type), O.MOTable.(Type) = []; end
                if isempty(O.MOTable.(Type))
                    O.MOTable.(Type) = tbl; return
                end
                
                L = ismember(O.MOTable.(Type).tag,Tag);
                if sum(L) ~= 0, O.MOTable.(Type)(L,:) = []; end
                
                if size(O.MOTable.(Type),1) == 0
                    O.MOTable.(Type) = tbl; else
                    O.MOTable.(Type) = [O.MOTable.(Type);tbl];
                end, return
            end
            
            % if is normal object*
            if ~isfield(O.SOTables,Type), O.SOTables.(Type) = []; end
            if isempty(O.SOTables.(Type))
                O.SOTables.(Type) = tbl; return
            end
            
            L = ismember(O.SOTables.(Type).tag,Tag);
            if sum(L) ~= 0, O.SOTables.(Type)(L,:) = []; end
            if size(O.SOTables.(Type),1) == 0
                O.SOTables.(Type) = tbl; else
                O.SOTables.(Type) = [O.SOTables.(Type);tbl];
            end
            
        end
        
        
        % clear View Tbl:
        function obj = clearTagInViewTbl(obj,Tag)
            
            if isempty(obj.viewTbl), return, end
            L = ismember(obj.viewTbl.tag,Tag);
            if sum(L) ~= 0, obj.viewTbl(L,:) = []; end

            
        end
        
        
        % clear import Tbl (Used for drag and Drop Menus):
        function [obj,L] = clearTagInImportTbl(obj,Tag)
            
            if isempty(obj.importTbl), return, end
            L = ismember(obj.importTbl.handle,Tag);
            if sum(L) ~= 0, obj.importTbl(L,:) = []; end
           
        end
        

    end
    
    
    % Handle Last Table Properties
    methods
        
        % Turn off Last View:
        function obj = turnoffImport(obj,handles)
            
            if ~isempty(obj.LastImport)
                I = obj.LastImport.id;
                H = char(obj.LastImport.handle);
                handles.(H) = turnOffImportDefault(handles.(H),I);
                obj.LastImport = [];
            end
        end
        
        
        % Turn off Import:
        function obj = turnoffView(obj,handles)
            
            if ~isempty(obj.Last)
                I = obj.Last.id;
                H = char(obj.Last.tag);
                handles.(H) = turnOffHoverDefault(handles.(H),I);
                obj.Last = [];
            end
        end
        
        
    end
    
    
    % Old Functions for errors
    methods

        % old functions:
        function O = updateViewTbl(O,tbl,Tag) %#ok
            error('use updateTable')
        end
        function [O,L] = updateImportTbl(O,F,tbl,Tag) %#ok
            error('use updateTable')
        end
        function obj = updateScrollTbl(obj,tbl,Tag)%#ok
            error('use updateTable')
        end
        
    end
    
end


 function getRunMoition(hObject,handles)
       
    handles.UIControl = GetRunMoition(handles.UIControl,hObject,handles);
    guidata(hObject, handles);
    
 end
    
 
 function getScrollMoition(hOb,hdl,eventdata)
       
    D = eventdata.VerticalScrollCount;
    hdl = GetScrollMoition(hdl.UIControl,hOb,hdl,D);
    guidata(hOb, hdl);
    
 end
