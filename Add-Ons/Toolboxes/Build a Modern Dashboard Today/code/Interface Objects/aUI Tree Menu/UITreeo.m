classdef UITreeo
    % Author:Alex Geiger
    % Email: ajg1444@rit.edu
    %
    % Looking for employment.
    %
    % The class is provided since few dynamic updates are provided which
    % will be done in future versions. Use the following class to edit
    % how colors, and how information is passed between objects.
    
    % Dependent Properties for get and sets
    properties (Dependent)
        
        setMute
        addNode;   % add node config.
        addConfig; % add a config
        addSet;    % add set
        
    end
    
    
    % oStack Properties:
    properties
        
        Id;       % Current Id number for generation
        Tag;      % Name of object in handles
        Settings; % settings of UI Tree
        NormPos;  % position of figure        (normalized)
        
        
        Pos;      % position of figure window (cm)
        objTbl;
        
        Stack;           % UI-Tree
        idTbl;           % Holds info on stack nodes and how to find them
        ConfigTable;     % Configuration table.
        Configurations;  % types of configuration
        
        ScrollBar;
        Axes;     % auto generated axes
        CTxt_Menu
    end
    
    
    % General Properties:
    properties

        % Legend objects:
        BRAxes;    % Axes for Menu and scrol Bar
        MenuBox;   % Menu Box ploted in BRAxes
        SearchBar; % Search Bar
        
        LastImport % Info about last import
        dragObj;   % Drag and drop object
        TriIdx;    % Triangle object
        TreeObj;   % Tree Graphed objects
        
    end
    
    
    % get & set Methods:
    methods
        
        % set mute of textbox.
        function O = set.setMute(O,T)
            O.SearchBar.setMute = T; 
        end
        
        % add Node:
        function obj = set.addNode(obj,C)
            obj = LoadData(obj,C);
        end
          
        
        % add configure:
        function obj = set.addConfig(obj,C)
            if iscell(C)
                for i = 1:length(C)
                   obj.Configurations.(C{i}.Tag) = C{i};
                end
            else
                obj.Configurations.(C.Tag) = C;
            end
        end
        
        
    end
   
    
    % General Methods:
    methods
        
                
        % Constructor (Will become abstract class):
        function obj = UITreeo(s)
            % Setup the initial object
            
            
            
            if nargin == 0, return, end % if no structure return object
            
            % note the following code has been switched by buildTreeAxes
            % however the function is not Dynamic yet. Therefore this code
            % here to be referanced in the future.
            
            
            % setup figure:
            obj.Axes = axes('Position',s.Position,'Units','normalized');
            Flds ={'YColor','XColor','XTick','YTick','Tag','Color'};
            set(obj.Axes,Flds,{'none','none',[],[],s.Tag,[.98,.98,.98]})
            obj = setAxesLimits(obj);
            
            % Setup Tables:
            obj = tblSetupID(obj);
            
            % Setup Variables:
            obj.Id = 0; obj.Tag = s.Tag; obj.Settings.Visible = true;
            
            % configure nodes and configs (now done in DBTree):
            if isfield(s,'Config'), obj.addConfig = s.Config; end
            if isfield(s,'Nodes'), obj.addNode = s.Nodes;     end
            
        end
        
        
        % build tree axes:
        function O = buildTreeAxes(O,P,T)
        
            % Settings (Make Dynamic in future)
            scrollWidth  = .4;
            MenuHeight   = .8;
            MenuBarColor = .65.*([0,48,91])./255 + .35.*([.98,.98,.98]);
            ScrollBarColor = [.97,.97,.98];
            ScrollColor    = [0.65,0.65,0.67];
            MenuCurve  = .35; % menu box curvature
            cm_height  = .44; % search bar height
            cm_width   = 2.5; % search bar width
            cm_indent  = .5;  % search bar indent
            cm_arrow   = .59; % return arrow (only axeso)
            
            % Backround Axes:
            O.Visibility = true;
            O.BRAxes.Axes = axes('Position',P,'Units','normalized');
            Flds ={'YColor','XColor','XTick','YTick','Tag','Color'};
            set(O.BRAxes.Axes,Flds,{'none','none',[],[],T,[.98,.98,.98]})
            
            % build BRAxes Axes to Figure Ratio's.
            O.BRAxes.Axes.Units = 'centimeters'; 
            O.BRAxes.Pos = O.BRAxes.Axes.Position;
            O.BRAxes.Axes.Units = 'normalized';
            O.BRAxes.NormPos   = O.BRAxes.Axes.Position;
            O.BRAxes.Axes.XLim = [0,O.BRAxes.Pos(3)]; 
            O.BRAxes.Axes.YLim = [0,O.BRAxes.Pos(4)];
            
            % Derive Scroll Width and Menu Height
            ScrollW = scrollWidth*O.BRAxes.NormPos(3)/O.BRAxes.Pos(3);
            MenuH = MenuHeight*O.BRAxes.NormPos(4)/O.BRAxes.Pos(4);
            
            TreeHight = O.BRAxes.NormPos(4) - MenuH;
            TreeWidth = O.BRAxes.NormPos(3) - ScrollW;
            hold on
            
            MP = O.BRAxes.Pos([3,4]) - [0,MenuHeight - .05];
            SP = O.BRAxes.Pos([3,4]) - [scrollWidth-.05,MenuHeight - .05];
            
            % Menu Section
            R1 = rectangle('Position',[0,MP(2),MP(1),MenuHeight]);
            R1.FaceColor = MenuBarColor;
            R1.EdgeColor = 'none';
            R1.Curvature = MenuCurve;
            R1.Clipping = 'off';
            
            
            % setup search bar:
            Bottom = O.BRAxes.Pos(4) - (MenuHeight- .05)/2 - cm_height/2;
            Left   = O.BRAxes.Pos(3) - cm_width - cm_indent;
            pos    = [Left,Bottom,cm_width,cm_height];
            O.SearchBar = uiEditText(-1,O.BRAxes.Pos,O.BRAxes.NormPos);
            O.SearchBar = buildEditText(O.SearchBar,pos);
            
            
            % build back arrow only for search bar:
            if isa(O,'Axeso')
                bot = O.BRAxes.Pos(4) - (MenuHeight - .05)/2 - cm_arrow/2;
                pos    = [.1,bot,MenuHeight,cm_arrow];
                Backround_Color = MenuBarColor;
                O.MenuBox.Back = iconGraphic('arrow',pos,Backround_Color);
                B = @(hObject,eventdata)toMenu(T,guidata(hObject),hObject);
                O.MenuBox.Back.ButtonDownFcn = B;
            end
            
            
            % Scroll Bar:
            R2 = rectangle('Position',[SP(1),0,scrollWidth,SP(2)]);
            R2.FaceColor = ScrollBarColor;
            R2.EdgeColor = 'none';
            
            SW = [scrollWidth/4,scrollWidth/2];
            R3 = rectangle('Position',[SP(1)+SW(1),0,SW(2),SP(2)]);
            R3.FaceColor = ScrollColor;
            R3.EdgeColor = 'none';
            R3.Curvature = 1;
            
            % Main Axes:
            P([3 4]) = [TreeWidth TreeHight];
            O.Axes = axes('Position',P,'Units','normalized');
            Flds ={'YColor','XColor','XTick','YTick','Tag','Color'};
            set(O.Axes,Flds,{'none','none',[],[],T,[.98,.98,.98]})
           
            
            O.Axes.Units = 'centimeters'; O.Pos = O.Axes.Position;
            O.Axes.Units = 'normalized'; O.NormPos = O.Axes.Position;
            O.Axes.XLim = [0,O.Pos(3)]; O.Axes.YLim = [0,O.Pos(4)];
            
            
            
            
            % (needs to be refined)
            % upload objecks to properties at end
            O.MenuBox.Box       = R1;
            O.ScrollBar.Box     = R2;
            O.ScrollBar.Bar     = R3;
            O.ScrollBar.Bottom  = 0;
            O.ScrollBar.Top     = SP(2);
            O.ScrollBar.O       = O.Axes.YLim;
            O.ScrollBar.TH      = TreeHight;
            O.ScrollBar.S       = 0;
            
     
        end
        
        
    end
    
    
    % Table Setup & Handle Methods:
    methods
        
             
        % Setup ConfigTable, idTbl and objTbl:
        function obj = tblSetupID(obj)
            
            Names = {'id','field','path','configuration'};
            obj.idTbl = cell2table(cell(0,4));
            obj.idTbl.Properties.VariableNames = Names;
            obj.Stack.children = [];
            obj.Stack.List     = [];
            obj.Id = 0;
            
            Names = {'id','pos','ppos'};
            obj.objTbl = cell2table(cell(0,3));
            obj.objTbl.Properties.VariableNames = Names;
            
        end
        
        
        % get Value Path:
        function [Path,S] = List2Path(O,List)
            
            S = O.Stack; L = length(List); Path = cell(1,L);
            for i = 1:L
                Path(i) = S.List(List(i));
                S = S.children.(Path{i});
            end
            
        end
        
        
        % get Value Path:
        function [List,S] = Path2List(O,Path) 
            L = length(Path); S = O.Stack; List = zeros(1,L);
            for i = 1:L
                [~,List(i)] = ismember(Path(i),S.List);
                S = S.children.(Path{i});
            end 
        end
        
        
        % Cell in Stack & Path to node:
        function Field = id2field(obj,id)
            
            Field = obj.idTbl.field{obj.idTbl.id == id};
            
        end
        
        
        % Cell in Stack & Path to node:
        function Field = id2pathfld(obj,id)
            
            Field = obj.idTbl.path{obj.idTbl.id == id}{end};
            
        end
        
        
        % get node configuration from id:
        function C = id2Config(obj,id)
            
            C = obj.idTbl.configuration{obj.idTbl.id == id};
            
        end
        
        
        % Cell in Stack & Path to node:
        function Path = getPathID(obj,id)
            
            Path = obj.idTbl.path(obj.idTbl.id == id); Path = Path{:};
            
        end
        
                
        % get subnodes of from node:
        function IdVec = getSubNodes(O,id)
            % Debugging: disp([Path,Data{1}])
            
            
            StartPath = O.idTbl.path(O.idTbl.id == id);
            StartPath = StartPath{1};
            [StartPath,~] = Path2List(O,StartPath);
            
            VecM   = zeros(1,length(StartPath)); IdVec  = [];
            j = length(StartPath); Path = StartPath;
            
            
            while 1
                
                % Get next idTbl:
                [~,Child] = List2Path(O,Path);
                PL = ~isempty(Child.List); % Parent Logic
                
                % Build Id Path Vector:
                if isempty(IdVec), IdVec = Child.id; else
                    IdVec(1+end) = Child.id; %#ok
                end
                
                if Child.view && PL, j = j + 1; Path(j) = 1;
                    VecM(j) = length(Child.List); % go down depth
                elseif ~Child.view && VecM(j) <= Path(j)
                    if j > length(StartPath)
                        Path = Path(1:end-1); j = j - 1;
                    end
                    if isequal(StartPath,Path), break, end
                    Path(j) = Path(j) + 1; % back bredth
                    
                elseif ~Child.view || VecM(j) > Path(j)
                    if isequal(StartPath,Path), break, end
                    Path(j) = Path(j) + 1; % current bredth
                else
                    break
                end
                
            end
            
        end
        
                
        % Save Child Function
        function obj = saveChild(obj,child,path)
            
            obj.Stack = strctSave(obj.Stack,child,path,'children');
            
        end


        % get entire level:
        function [Children,List] = getLevel(obj,path)
            
            Child = strctDive(obj.Stack,path,'children');
            Children = Child.children;
            List     = Child.List;
            
        end
        
                
        % Cell in Stack & Path to node:
        function [CStack,Path,L] = getNodeStack(obj,id)
            L = true; Path = obj.idTbl.path(obj.idTbl.id == id);
            Path = Path{:};
            if isempty(Path),  L = false; CStack = []; else
                CStack = strctDive(obj.Stack,Path,'children');
            end
        end
        
        
        % build index and injection path.
        function [child,idx] = getPathAndIndex(obj,child,ID)
            % updates path and generates index for injection.
            
            Path = obj.idTbl.path{obj.idTbl.id == ID}; % path to new obj
            [idx,KID] = Path2List(obj,Path(1:end-1));
            
            if 2 == obj.LastImport.loc || isempty(idx) % parent
                if isempty(idx), idx = 1; else, idx(end) = 1; end
                child.path = [Path,child.path(end)];
                
            else % child
                [~,idx(end)] = ismember(Path(end),KID.List);
                if 0 == obj.LastImport.loc
                    idx(end) = idx(end)+1; % add to front
                end
                
                child.path = [Path(1:end-1),child.path(end)];
            end
            
        end
        
        
        % import stack node
        function [obj,child] = snodeImport(obj,child,ID)
            
            % make sure child is in cell form
            if ~iscell(child), child = {child}; end
            
            for i = 1:length(child)
                [child{i},idx] = getPathAndIndex(obj,child{i},ID);
                [obj,child(i)] = LoadData(obj,child(i),idx);
            end
            
        end
        
        
    end
    

    % Node Create, Visibility, Delete Methods:
    methods
            
        % Build Visible Tree:
        function handles = buildTree(O,handles)
            % Debugging: disp([Path,Data{1}])
            
            if O.Axes ~= gca, axes(O.Axes); end
            
            if size(O.objTbl,1) ~= 0, O.objTbl(:,:) = []; end
            
            % Get poition data:
            TOP  = sum(O.Pos([4,2]));   % Maximum Height (Units*)
            BOT  = O.Pos(2);            % Lower Floor (Units*)
            NBOT = O.NormPos(2);        % Width (Normalize)
            L    = O.NormPos(1);          % Normalized Width
            R    = sum(O.NormPos([1,3])); % Normalized Height
            YR   = O.NormPos(4)/O.Pos(4); % Y-axis ratio
            
            
            % Example let us say we have a value of
            %                  x
            % we wish to transform to a new domain
            % to do this we will times x by YR the
            % ratio value and add it to BOT so,
            %       x' = BOT + x(YR);
            % Refer above to what the values are*
            
            % Set up Paths
            Path = ones(1,1); j = 1;                % Create Path
            VecM = ones(1,1).*length(O.Stack.List); % Create Zero Vector
            Bot = TOP - BOT;      % Setup default bottom value
            Import = zeros(1,1);  % Import Vector
            
            
            
            while 1 % Setup Data -----------------------------------------
                [~,Cld] = List2Path(O,Path); % Get next idTbl:
                Top = Bot; % Set Top to previous bottom (for new obj)
                
                % Setup temp values:
                clear Input                      % clear inputs
                infoId = Cld.id;                 % get Id Info
                I = findIndex(O.TreeObj,infoId); % get Index
                space = (length(Path)-1)*.5 + .5; % get path length
                if ~isempty(Cld.List), O.TreeObj(I).Parent = 1;  end
                
                
                
                % Build Sub-Object ----------------------------------------
                % Build the node:
                Bot = Top - O.TreeObj(I).Height;
                O.TreeObj(I).Position = [Bot,space];
                if ~O.TreeObj(I).Visible, O.TreeObj(I).Visible = 'on'; end
                % Setup Tables --------------------------------------------
                
                
                % Setup Table:
                MainPos = [L,R,([Bot,Top]).*YR+NBOT];
                CIN = {Cld.id,MainPos,[Bot Top]};
                O.objTbl = [O.objTbl;CIN];
               
                
                % unpack Next Node ----------------------------------------
                if Cld.view && ~isempty(Cld.List)
                    j = j + 1; Path(j) = 1;
                    VecM(j) = length(Cld.List); % go down depth
                elseif ~Cld.view && VecM(j) <= Path(j)
                    if j > 1, Path = Path(1:end-1); j = j - 1; end
                    Path(j) = Path(j) + 1; % back bredth
                    if length(Path) == 1
                        if length(O.Stack.List) < Path(j), break, end
                    end % v* below - Next will be current bredth
                elseif ~Cld.view || VecM(j) > Path(j)
                    Path(j) = Path(j) + 1; Import(j) = -1;
                    if length(Path) == 1
                        if length(O.Stack.List) < Path(j), break, end
                    end, else, break
                end
            end
            
            handles.(O.Tag) = O;
            handles = updateTblController(O,handles);
            % O.Visible = O.Visibility;
        end
        
        
        % Callback Functions drag and drop
        function Call = createCalls(obj,id)
            
            T = obj.Tag;
            
            Call.PillCall = @(hObject,eventdata)setDrag...
                (T,id,hObject,guidata(hObject));
            
            Call.TriCall  = @(hObject,eventdata)bchHdl...
                (T,id,hObject,guidata(hObject));
            
        end
        
        
        % Delete Node:
        function [hdl,child,tbl] = deleteNode(O,id,V,hdl)
            
            
            % Part I: Delete Subnodes from table:
            [child,Path,L] = getNodeStack(O,id); % get child and math
            
            % Check if nargin == 2 and Check if child exist
            if nargin == 2, eorror('define Logic V'); end
            if L == 0, error('Stack Does not exist'), end
            IdVec = getSubNodes(O,id);
            
            % Delete Child & List referance
            Parent = strctDive(O.Stack,Path(1:end-1),'children');
            Parent.List = Parent.List(~ismember(Parent.List,Path(end)));
            Parent.children = rmfield(Parent.children,Path(end));
            O.Stack = strctSave(O.Stack,Parent,Path(1:end-1),'children');
            
            % Delete Subnodes from table:
            tbl = O.idTbl(O.idTbl.id == IdVec,:);
            O.idTbl(O.idTbl.id == IdVec,:) = [];
            
            
            % Part II:
            hdl.(O.Tag) = O; % update handle
            if ~V, return, end % if data is not leaving table return
                
            % Detete Nodes and Vectors in Graph:
            hdl.(O.Tag).TreeObj = deleteNode(hdl.(O.Tag).TreeObj,IdVec);
            
            for i = 1:length(IdVec)
                hdl = DeleteData(hdl.(O.Tag),IdVec(i),hdl);
            end  
            
        end
        
        
    end
    

    % Stack Methods:
    methods
        
                
        % Load Data into Stack:
        function [O,D] = LoadData(O,D,idx)
            % -------------------------------------------------------------
            % Load the nodes into the stack, the nodes are stored in
            % variable D.
            % idTbl needs the following fields from D{i}:
            % field
            % path
            % -------------------------------------------------------------
            % When a node is added to the stack a tree node is created as
            % well. The tree node inputs include the following:
            % 1. Position
            % 2. field
            % 3. Id
            % -------------------------------------------------------------
            T = O.Tag;
            B1 = @(hObject,eventdata)CallIcon(T,hObject,guidata(hObject));
            if O.Axes ~= gca, axes(O.Axes); end
            if iscell(D)
                for i = 1:length(D)
                    
                    if nargin == 3
                        [O,D{i}] = add2stack(O,D{i},idx); else
                        [O,D{i}] = add2stack(O,D{i});
                    end
                    
                    S = Configuration(O,D{i}.id);
                    S.Call = createCalls(O,D{i}.id);
                    S.Icon.Call = B1;
                    S.Icon.id = D{i}.id;
                    O.TreeObj = treeNode(O.Pos,D{i},S,O.TreeObj);
                end
            else
                error('wrap structure in cell')
            end
        end
        
        
        % Add Data To Stack (Type 1):
        function [obj,Child] = add2stack(obj,Child,idx)
            % The Child needs to have the following fields:
            % 1. Id
            % 2. field
            % 3. path
            % 4. type
            % -------------------------------------------------------------
            
            % If no idx is given the new child is added to the back of the
            % stack on the path of which it was given
            %
            % Returns Reworked Child and object with added info
            
            % Increment & set up Id save to Child
            obj.Id   = obj.Id + 1; Child.id = obj.Id; % Set up Id
            
            % Document Child in Table:
            CFG = cellstr(Child.config);
            Cell = {obj.Id,cellstr(Child.field),{Child.path},CFG};
            obj.idTbl = [obj.idTbl;Cell];
            
            % Save child to Parent then add to stack
            Path   = Child.path(1:end-1);
            Parent = strctDive(obj.Stack,Path,'children');
            
            % repackage parent
            if isempty(Parent.List), Parent.List = Child.path(end);
            elseif nargin == 2, Parent.List(end+1) = Child.path(end);
            elseif nargin == 3, listL = length(Parent.List);
                if idx == 1,Parent.List = [Child.path(end),Parent.List];
                elseif listL < idx, Parent.List(end+1) = Child.path(end); 
                else, Front = Parent.List(1:idx-1);
                    Back  = Parent.List(idx:end);
                    Parent.List = [Front,Child.path(end),Back];
                end
            end
            
            
            Parent.children.(Child.path{end}) = Child;
            obj.Stack = strctSave(obj.Stack,Parent,Path,'children');
            
        end
        
        
        % Shift Parent List (Type 2):
        function O = shiftParentList(O,s,id2,isParent)
            % used to only shift the index of the node in the stack
            % structure field 'List'.
            % 
            
            
            [s.child,idx] = getPathAndIndex(O,s.child,id2);
            old_pth = O.idTbl.path{O.idTbl.id == s.child.id};
            
            if isParent
                path = O.idTbl.path{O.idTbl.id == id2}; 
            else
                path = O.idTbl.path{O.idTbl.id == id2}(1:end-1); 
            end
            
            
            if isequal(old_pth(1:end-1),path)
                type = true; % same parent
            else % if in two different locations.
                type = false; % same parent
                opth = old_pth(1:end-1);
                OPrt = strctDive(O.Stack,opth,'children');
                OPrt.List = OPrt.List(~ismember(OPrt.List,old_pth(end)));
                OPrt.children = rmfield(OPrt.children,old_pth(end));
                O.Stack = strctSave(O.Stack,OPrt,opth,'children');
            end
            
            
            Parent = strctDive(O.Stack,path,'children'); % parent struct.
            listLogic = ismember(Parent.List,old_pth(end)); % logic index
            
            % rework list information
            if idx == 1
                listLogic   = [false,listLogic];
                Parent.List = [s.child.path(end),Parent.List];
                
            elseif length(Parent.List) < idx
                listLogic(end+1)   = false;
                Parent.List(end+1) = s.child.path(end);
                
            else
                listLogic = [listLogic(1:idx-1),false,listLogic(idx:end)];
                Front = Parent.List(1:idx-1);
                Back  = Parent.List(idx:end);
                Parent.List = [Front,s.child.path(end),Back];
                
            end
            
            % update path:
            if ~type, Parent.children.(old_pth{end}) = s.child; end
            if type, Parent.List = Parent.List(~listLogic); end
            O.idTbl.path{O.idTbl.id == s.child.id} = s.child.path;
            O.Stack = strctSave(O.Stack,Parent,path,'children');
            
        end
        

    end
    
    
    % Configure Methods:
    methods
            
        % get config.
        function s = Configuration(O,id)
            
            if ischar(id), type = id; else
                if isstruct(id), id = id.id; end
                type = O.idTbl.configuration(O.idTbl.id == id);
            end
        
            s = O.Configurations.(char(type)).sendOut;
          
         
        end
        
        
        % get config.
        function s = ConfigObj(O,id)
            
            if ischar(id), type = id; else
                type = O.idTbl.configuration(O.idTbl.id == id);
            end
            
            s = O.Configurations.(char(type));
            
        end
        
    end
    
  
    % Drag and Drop Objects:
    methods
        
        % Plot Triange on Graph
        function obj = graphTriangleIdx(obj,shift)
            % Orange Triangle for Indexed data
            % Turn off Visibility: obj.TriIdx.Visible = 'off'
            
            y = shift + [-.100,0,.100]; % Y axes shift.
            if isempty(obj.TriIdx), L = true;
            elseif isstruct(obj.TriIdx), L = true;
            else, L = false;
            end
            
            if L
                if obj.Axes ~= gca, axes(obj.Axes); end
                x = [0,.200,0]; % x-axis shift
                Color = ([248,148,6])./255;
                obj.TriIdx = fill(x,y,Color);
                obj.TriIdx.EdgeColor = [.8 .8 .8];
                obj.TriIdx.EdgeColor = [.8 .8 .8];
                return
            end
            
            % if TriIdx exists:
            chld = allchild(obj.Axes);
            I = chld == obj.TriIdx;
            if ~I(1), set(obj.Axes,'Children',[chld(I);chld(I==0)]); end
            obj.TriIdx.Visible = 'on';
            obj.TriIdx.YData = y;

        end
         
        
        % Export Data Callback setup:
        function [hObject,handles] = setupDragMotion(O,id,hObject,handles)
            
            
             % Get poition data:
            axes(O.Axes), T = O.Tag;
            B1 = @(hObject,eventdata)getDrop...
                (T,hObject,guidata(hObject));
            B2 = @(hObject,eventdata)DragDrop...
                (T,hObject,guidata(hObject));
            
            % Build Floater:
            Child = getNodeStack(O,id);
            [~,I] = ismember(Child.id,[O.TreeObj.Id]);
      

            ptxt = O.TreeObj(I).Text.Position;
            String = O.TreeObj(I).Text.String;
            ppill = O.TreeObj(I).Pill.Position;
            pillColor = O.TreeObj(I).Pill.FaceColor;
            SPos = hObject.Parent.CurrentPoint;
            
            if ischar(pillColor)
               if strcmpi(pillColor,'none')
                   pillColor = O.TreeObj(I).Box.FaceColor;
               end
            end
            
            % very basic needs to be re adjusted.
            if ~isempty(O.dragObj)
                delete(O.dragObj.Pill)
                delete(O.dragObj.Text)
            end
            
            O.dragObj.Pill = rectangle('Position',ppill,'Curvature',1);
            O.dragObj.Text = text(ptxt(1),ptxt(2),String);
            
            O.dragObj.Pill.Clipping      = 'off';
            O.dragObj.id                 = Child.id;
            O.dragObj.Pill.FaceColor     = pillColor;
            O.dragObj.Pill.ButtonDownFcn = B1;
            O.dragObj.Text.ButtonDownFcn = B1;
            O.dragObj.Pill.EdgeColor     = pillColor;
            O.dragObj.ptxt               = ptxt - [0,O.ScrollBar.S,0];
            O.dragObj.ppill              = ppill - [0,O.ScrollBar.S,0,0];
            O.dragObj.Start              = [SPos(1,1),SPos(1,2)];
            
            handles.UIControl = turnoffView(handles.UIControl,handles);
            hObject = setFigureWM(hObject,B2);
            handles.(O.Tag) = O;
            
        end
        
        
        % Export Data Callback motion:
        function O = callbackDragMotion(O,hObject,handles)
            
            if O.Axes ~= gca, axes(O.Axes); end
            M = hObject.CurrentPoint; L = [1,2]; % Transform Current Point
            XY = O.Pos([3,4])./O.NormPos([3,4]).*(M-O.NormPos([1,2]));
            XY = XY - O.dragObj.Start([1,2]);
            
            % Shift Positions
            O.dragObj.Text.Position(L) = XY + O.dragObj.ptxt(L);
            O.dragObj.Pill.Position(L) = XY + O.dragObj.ppill(L);
   
            if O.Axes ~= gca,uistack(O.Axes,'top'), end
            O.dragObj.UserData.End = M; guidata(hObject, handles);
            
        end
        
    end
    
    
    % Scroll Functions:
    methods
                
        % Derive Scroll Table (Setup):
        function tbl = deriveLegendScroll(O)
            
            tag = cellstr(O.Tag); property = {'Axes'};
            pos = O.NormPos([1,3,2,4]);
            pos = pos + [0,pos(1),0,pos(3)];
            tbl = table(tag,pos,property);
            
        end
        
        
        % upload scroll function (Setup):        
        function hdl = loadScroll(O,hdl)
            
            tbl = deriveLegendScroll(O);
            hdl.UIControl = updateTable(hdl.UIControl,'scroll',tbl,O.Tag);
            
        end
        
        
        % Update Scroll Function (Update Setup):
        function hdl = scrollFunction(O,P,D,Type,hdl)
            
            switch Type
                
                case 'Axes'
                    hdl = updateTblController(O,hdl,D*-1);
                    
                case 'GAxes'
                    hdl = AxesoScroll(O,P,D,hdl);
                    
            end
            
        end
        
                
        % Update Scroll View (Update Setup):
        function O = updateScrollView(O,S)
            
            Shift = (O.Axes.YLim(2) - O.Axes.YLim(1)).*(-.1*S);
            O.ScrollBar.S = O.ScrollBar.S + Shift;
            
            if O.ScrollBar.Bottom == 0
                O.ScrollBar.S = 0;
            elseif O.ScrollBar.Bottom > -O.ScrollBar.S
                O.ScrollBar.S = -1*O.ScrollBar.Bottom;
            elseif O.ScrollBar.S < 0
                O.ScrollBar.S = 0;
            end
            
            O.Axes.YLim = O.ScrollBar.O - O.ScrollBar.S;
            G = O.ScrollBar.Avail*(1+O.ScrollBar.S/(O.ScrollBar.Bottom));
            
            if isnan(G), G = 0; end
            O.ScrollBar.Bar.Position(2) = G;
            
        end
        
        
        % Setup Scroll View (Update Setup):
        function O = setupScrollView(O)
            
            O.ScrollBar.Bottom = min(O.objTbl.ppos(:,1));
            if O.ScrollBar.Bottom > 0
                O.ScrollBar.Bottom = 0;
                O.ScrollBar.S = 0;
            end
            
            if ~isfield(O.ScrollBar,'Top')
                O.ScrollBar.Top = O.Axes.Position(4);
            end
            
            Delta = O.ScrollBar.Top - O.ScrollBar.Bottom;
            Percent = O.ScrollBar.Top*(O.ScrollBar.Top/Delta);
            O.ScrollBar.Avail = O.ScrollBar.Top - Percent;
            O.ScrollBar.Bar.Position(4) = Percent;
            
            
            G = O.ScrollBar.Avail*(1+O.ScrollBar.S/(O.ScrollBar.Bottom));
            if isnan(G), G = 0; end
            O.ScrollBar.Bar.Position(2) = G;
            
        end
        
        
        % get View and Import table for legend (Update Setup):
        function tbl = getLegendTable(O)
            
            T = O.NormPos(4)/O.Pos(4);
            B = O.objTbl.ppos;
            I = B(:,1) <= O.Axes.YLim(2) & B(:,2) >= O.Axes.YLim(1);
            pos = O.objTbl.pos(I,:) + [0,0,[1,1].*O.ScrollBar.S*T];
            id = O.objTbl.id(I);
            tag = cell(sum(I),1);
            tag(:) = cellstr(O.Tag);
            tbl = table(id,tag,pos);
            
        end
        
        
        % Update Table Controller (Update Setup):
        function hdl = updateTblController(O,hdl,S)


            if nargin == 3
                O = updateScrollView(O,S); else
                O = setupScrollView(O);
            end
            
            hdl.(O.Tag) = O;
            tbl = getLegendTable(O);
            
            
            % update View table
            hdl.UIControl = updateTable(hdl.UIControl,'view',tbl,O.Tag);
            hdl.UIControl = updateTable(hdl.UIControl,'import',tbl,O.Tag);
            
        end
        
    end
    
    
    % Button Callbacks:
    methods
        
            
        % Default Hover Callback:
        function obj = hoverDefault(obj,id)
            I = findIndex(obj.TreeObj,id);
            C = Configuration(obj,id);
            obj.TreeObj(I).Setup = C.H;
        end
        
        
        % Default Hover Callback:
        function O = importDefault(O,id,M,P,T,handles)
            
            C1 = ConfigObj(handles.(T),handles.(T).dragObj.id);
            C2 = ConfigObj(O,id);
            L = checkSubset(C1,C2);
            
            O.LastImport.id = id;
            
            if L == 2 % of parent child set
                I = findIndex(O.TreeObj,id);
                C = Configuration(O,id);
                O.TreeObj(I).Setup = C.H;
                O.LastImport.loc = 2;
                
            elseif L == 1 % of same set
                if mean(P) >= M(2) % add to bottom (higher index)
                    shift = O.objTbl.ppos(O.objTbl.id == id,1);
                    O.LastImport.loc = 0;
                else % add to top (lower index)
                    shift = O.objTbl.ppos(O.objTbl.id == id,2);
                    O.LastImport.loc = 1;
                end
                O = graphTriangleIdx(O,shift);
                
            else
                O.LastImport.id = [];
                
            end
            
        end
        
        
        % Animation for drag return:
        function obj = dragReturnAnimate(obj)
            K = 300;
            Tfm = obj.Pos([3,4])./obj.NormPos([3,4]);
            AddStart = obj.Pos([1,2]);
            Original = (AddStart + obj.dragObj.Start)./Tfm;
            Last = obj.dragObj.UserData.End;
            
            if obj.Axes ~= gca, axes(obj.Axes); end
            if obj.Axes ~= gca,uistack(obj.Axes,'top'), end
            
            
            D = funMth('mag',Original(1),Last(1),Original(2),Last(2));
            K = round(K*D);
            
            for i = 1:K
                
                M = (K-i).*(Last - Original)./K + Original;
                L = [1,2]; % Transform Current Point
                XY = Tfm.*(M-obj.NormPos([1 2]));
                XY = XY - obj.dragObj.Start([1 2]);
                
                % Shift Positions
                obj.dragObj.Text.Position(L) = XY + obj.dragObj.ptxt(L);
                obj.dragObj.Pill.Position(L) = XY + obj.dragObj.ppill(L);
                pause(.0015)
                
            end,pause(.1)
            
        end
        
  
    end
    
    
    % Visibility Settings:
    methods
        
                
        % Default Hover Callback:
        function O = turnOffImportDefault(O)
            
            O.TriIdx.Visible = 'off';
            if isempty(O.LastImport)
                return
                
            elseif isempty(O.LastImport.id)
                O.LastImport = [];
                return
                
            elseif O.LastImport.loc == 2
                I = findIndex(O.TreeObj,O.LastImport.id);
                C = Configuration(O,O.LastImport);
                O.TreeObj(I).Setup = C.N;
                
            end
            
            
        end
        
        
        % Turn off Hover Default:
        function obj = turnOffHoverDefault(obj,id)
            I = findIndex(obj.TreeObj,id);
            C = Configuration(obj,id);
            obj.TreeObj(I).Setup = C.N;
        end
        
               
        % Edit Visibility (with UIControl update):
        function handles = editVisibility(O,handles,T)
            % proper edit of visibility:
            if nargin == 2
                if O.Settings.Visible, O.Settings.Visible = false; else
                    O.Settings.Visible = true;
                end, T = O.Settings.Visible; else, O.Settings.Visible = T;
            end
            
            if T
                O.Axes.Visible = 'on';
                O.TreeObj  = turnOnVisibility(O.TreeObj);
                % update View table
                handles.UIControl = updateViewTbl...
                    (handles.UIControl,O.exportTbl,O.Tag);
                
                % update export table
                handles.UIControl = updateImportTbl...
                    (handles.UIControl,O.importTbl,O.Tag);
                
           
                
            else
                O.Axes.Visible = 'off';
                O.TreeObj  = turnOffVisibility(O.TreeObj);
                handles.UIControl = clearTagInViewTbl...
                    (handles.UIControl,O.Tag);
                
                handles.UIControl = clearTagInImportTbl...
                    (handles.UIControl,O.Tag);

            end
            
            handles.(O.Tag) = O;

        end
        

        % UI Tree Visibility:
        function O = UITreeVisibility(O,K)
            if isempty(O.objTbl)
                II = 1:length(O.TreeObj); else
                II = findIndex(O.TreeObj,O.objTbl.id);
            end
            
           for i = 1:length(II), O.TreeObj(II(i)).Visible = K;  end
           
            O.Axes.Visible          = K;
            O.BRAxes.Axes.Visible   = K;
            O.MenuBox.Box.Visible   = K;
            O.ScrollBar.Box.Visible = K;
            O.ScrollBar.Bar.Visible = K;
            O.SearchBar.Visible     = K;
            
            
            if isa(O,'Axeso'), O.MenuBox.Back.Visible = K; end
            
            
        end
        
        
        % Switch Node Visibility:
        function obj = switchNodeVisibility(obj,id)
            
            [Chd,Path] = getNodeStack(obj,id);
            
            I = findIndex(obj.TreeObj,id);
            obj.TreeObj(I).TriSwitch = Chd.view;
            if Chd.view, Chd.view = 0; % turn off view
                IdVec = getSubNodes(obj,id);
                obj.TreeObj = turnOffVisibility(obj.TreeObj,IdVec(2:end));
            else,Chd.view = 1; % turn on view
                obj = saveChild(obj,Chd,Path);
                IdVec = getSubNodes(obj,id);
                [Chd,Path] = getNodeStack(obj,id);
                obj.TreeObj = turnOnVisibility(obj.TreeObj,IdVec(2:end));
            end
            
            obj = saveChild(obj,Chd,Path);
            
        end
        
        
    end
    
    
    % moving out functions:
    methods
               
        % Setup Axes Limits:
        function obj = setAxesLimits(obj)
            if 1 == 1, error('removed function'); end
        end
        
    end
    
    
    
end


% Export Drag Setup Functon:
function setDrag(Tag,id,hObject,hdl)

hdl = setSearchFun(hdl.UIControl,hdl,'off');
[hObject, hdl] = setupDragMotion(hdl.(Tag),id,hObject,hdl);
guidata(hObject, hdl);

end


% Export Motion Function:
function DragDrop(Tag,hObject,handles)

handles = ImportMoition(handles.UIControl,hObject,handles,Tag);
handles.(Tag) = callbackDragMotion(handles.(Tag),hObject,handles);
guidata(hObject, handles);

end


% collapse tag:
function bchHdl(Tag,id,hObject,handles)

handles.(Tag) = switchNodeVisibility(handles.(Tag),id);
handles = buildTree(handles.(Tag),handles);
handles = selectPage(handles.UIControl,handles.UIControl.Page,handles);
[hObject,handles] = setDefinateMotion...
        (handles.UIControl,hObject,handles);
guidata(hObject, handles);

end


% end get drop:
function endGetDrop(Tag,hObject,hdl)

hdl = setSearchFun(hdl.UIControl,hdl,'on');

hdl = selectPage(hdl.UIControl,hdl.UIControl.Page,hdl);
[hObject,hdl] = setDefinateMotion...
    (hdl.UIControl,hObject,hdl);

try
    hdl.(Tag).dragObj.Text.Visible = 'off';
    hdl.(Tag).dragObj.Pill.Visible = 'off';
catch
   disp('dragObj could not be deleted in endGetDrop')
end


guidata(hObject, hdl);
return

end


% drop call back:
function getDrop(Tag,hObject,hdl)
% ---------------------------|---------------------------------------------
% idTbl: Table               | hdl.(Tag).LastImport: Structure
% id,    field,    path      | % id, loc,
% -------------------------------------------------------------------------
% PackageData s: structure (has been edited)
% 1. Data 2. Field 3. Tag
% -------------------------------------------------------------------------
% loc 2 - parent folder
% loc 1 - shares parent bottom
% loc 0 - shares parent top
% 
% variable overview
% id:  coming from id   | ID: going to id
% Tag: coming from tag  | T:  going to tag
% -------------------------------------------------------------------------


% preprocessing:
hObject = delFigureWM(hObject);  % erase mouse click
id = hdl.(Tag).dragObj.id;       % coming from


% if no destination found:
if isempty(hdl.UIControl.LastImport) % if drop was invalid.
    
    if ~isa(hdl.(Tag),'Axeso') % drag object:
        hdl.(Tag) = dragReturnAnimate(hdl.(Tag));
    else
        hdl = deleteNode(hdl.(Tag),id,true,hdl); % delete node
        hdl = buildTree(hdl.(Tag),hdl); % build tree with new config.
    end
     
    hdl = selectPage(hdl.UIControl,hdl.UIControl.Page,hdl);
    [hObject,hdl] = setDefinateMotion...
        (hdl.UIControl,hObject,hdl);

    endGetDrop(Tag,hObject,hdl); % end get drop
    return % end alg.
    
end


% setup going to location:
ID = hdl.UIControl.LastImport.id;       % going to
T = char(hdl.UIControl.LastImport.tag); % tag of object


LVec(1) = isa(hdl.(Tag),'Axeso');   % is object 1 a axeso?
LVec(2) = isa(hdl.(T),'Axeso');     % is object 2 a axeso?
LVec(3) = strcmpi(Tag,T);           % are object 1 and object 2 the same?
LVec(4) = hdl.(T).LastImport.loc == 2;



if LVec(1)
    fprintf('Future Update Required:\n')
    fprintf('The %s object tried to pass a transmitter \n',Tag)
    fprintf('as table data A transmitter is not able to pass \n')
    fprintf('data between two tables\n\n')
    
    hdl.(T).TriIdx.Visible = 'off';
    endGetDrop(Tag,hObject,hdl); % end get drop
    return
    
elseif LVec(3) && id == ID    % if drop was to same location.
    hdl.(T).TriIdx.Visible = 'off';
    endGetDrop(Tag,hObject,hdl); % end get drop
    return % end alg.
    
elseif LVec(3) % if coming from and going to the same place*
    hdl.(T).TriIdx.Visible = 'off';
    Package = 'Shift';     % same object
    
elseif LVec(2) % if obj going to is axeo
    Package = 'Satellite'; % send transmitter
    
else % if obj going to is not axeo and obj one & two are diff
    Package = 'Data';      % send data
    
end

[hdl.(Tag),s] = PackageData(hdl.(Tag),id,Package,hdl); % package data
[hdl,L] = ReceiveData(hdl.(T),s,Package,hdl,ID,LVec(4));   % retrieve data

if ~L
    hdl = guidata(hObject);
    endGetDrop(Tag,hObject,hdl);
    return
end

hdl = buildTree(hdl.(Tag),hdl); % build tree with new config.


if ~LVec(1), hdl = loadScroll(hdl.(Tag),hdl); end
if ~LVec(2) && ~LVec(3), hdl = loadScroll(hdl.(T),hdl); end
if ~LVec(3) % only process T if T does not equal Tag.
    hdl = buildTree(hdl.(T),hdl);
end

hdl.(T).TriIdx.Visible = 'off';
endGetDrop(Tag,hObject,hdl); % end get drop


end


% Axeso Call:
function toMenu(Tag,hdl,hOb)

hdl = defineState(hdl.(Tag),'menu',hdl);
guidata(hOb, hdl);

end


% Click on Icon and Build Context Menu Call:
function CallIcon(Tag,hOb,hdl)

hdl = setSearchFun(hdl.UIControl,hdl,'off');
[hdl.(Tag),hOb] = generateCMenu(hdl.(Tag),hOb.UserData,hOb);
guidata(hOb, hdl);

end



