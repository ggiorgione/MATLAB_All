classdef (Abstract) DBTree < UITreeo
    % Author:Alex Geiger
    % Email: ajg1444@rit.edu
    %
    % The following class handles the passing data between the UI-Tree and
    % axeso objects.
    
    % Dependent Properties:
    properties (Dependent)
        setTable
        dispMetaData
    end
    
    
    % general Properties:
    properties
        
        MainTable
        ImportObjects
        
        Transmitter
        Receiver
        
        ReceiverTbl
        ReceiverID
        
        InfoTable;
        MetaData;
        
        DefaultTable;
        
    end
    
    
    % get and set methods:
    methods
        
        function O = set.dispMetaData(O,T)
            
            disp(T)
            disp(O.DefaultTable)
            disp(O.InfoTable)
            
        end
        
        
        % Set table:
        function obj = set.setTable(obj,T)
            
            obj.MainTable = T;
            Nodes = deriveNodes(T);
            [obj,Nodes(:,1)] = LoadData(obj,Nodes(:,1));
            obj = ManageInfoTable(obj,Nodes,'table');
            
        end
        
    end
    
    
    % manage info tables:
    methods
        
        % set up table info:
        function obj = ManageInfoTable(obj,Nodes,type)
            K = 'DefaultTable';
            if isempty(obj.InfoTable)
                Names = {'id','fields','type','data_type'};
                obj.InfoTable = cell2table(cell(0,4));
                obj.InfoTable.Properties.VariableNames = Names;
                
                id = NaN(4,1);
                field = {'latitude';'longitude';'id';'date'};
                obj.DefaultTable =  table(id,field);
            end
            
            
            for i = 1:size(Nodes,1)
                data_type = Nodes{i,2}.data_type;
                C = {Nodes{i,1}.id,Nodes{i,1}.path{end},type,data_type};
                obj.InfoTable = [obj.InfoTable;C];
                
                if strcmp(type,'table')
                    str = ['n_',num2str(Nodes{i,1}.id)];
                    Nodes{i,2}.id = Nodes{i,1}.id;
                    obj.MetaData.(str) = Nodes{i,2};
                    
                    idx = ismember(obj.(K).field,data_type);
                    if isnan(obj.(K).id(idx))
                        obj.(K).id(idx) = Nodes{i,1}.id;
                    end
                end
            end
             
        end
        
        
        % pull meta data:
        function s = getMetaData(obj,id,hdl)
            
            
            
            I = ismember(obj.InfoTable.id,id);
            switch obj.InfoTable.type{I}
                case 'table'
                    s = obj.MetaData.(['n_',num2str(id)]);
                    
                case 'transmitter'
                    fld = ['n_',num2str(id)];
                    trm = obj.Transmitter.(fld);
                    s = TransmitterRequest(hdl.(trm.Tag),trm,hdl,Req);
            end
            
            
        end

        
        % setup tables:
        function obj = setupTRTables(obj)
            
            obj.ReceiverID = 0;
            Names = {'id','receiver'};
            obj.ReceiverTbl = cell2table(cell(0,2));
            obj.ReceiverTbl.Properties.VariableNames = Names;
            
            
        end
        
    end
    
    
    % Data Transmitting:
    methods
        
        % Package Data Transmitter:
        function [obj,s] = PackageData(obj,id,Package,~) % ~ = hdl
            
        
            % process start up:
            I = ismember(obj.InfoTable.id,id);
            if ~any(I), s = []; return, end
            if isempty(obj.ReceiverID), obj = setupTRTables(obj); end
            
            % build transmitter:
            s.transmitter = oTransmitter;
            s.transmitter.Configuration = id2Config(obj,id);
            s.transmitter.Field = id2pathfld(obj,id);
            s.transmitter.Tag   = obj.Tag;
            s.transmitter.Id    = id;
 
            
            switch Package
                
                case 'Shift'
                    s.child = getNodeStack(obj,id); % get child and math
                    
                    
                case 'Data'
                    % s.transmitter.UserData.Data = getData(obj,id,hdl);
                    s.child = getNodeStack(obj,id); % get child and math
                    obj.ReceiverID = obj.ReceiverID + 1;
                    recv = oReceiver(obj.ReceiverID);
                    [recv,s.transmitter] = Sync(recv,s.transmitter);
                    fld = ['n_',num2str(obj.ReceiverID)];
                    obj.ReceiverTbl    = [obj.ReceiverTbl;{id,fld}];
                    obj.Receiver.(fld) = recv;
                    

                case 'Satellite'
                    obj.ReceiverID = obj.ReceiverID + 1;
                    recv = oReceiver(obj.ReceiverID);
                    [recv,s.transmitter] = Sync(recv,s.transmitter);
                    fld = ['n_',num2str(obj.ReceiverID)];
                    obj.ReceiverTbl = [obj.ReceiverTbl;{id,fld}];
                    obj.Receiver.(fld) = recv;
                    s.child    = getNodeStack(obj,id); 
                    s.MetaData = getMetaData(obj,id);
                    
            end
            
        end
        
        
        % Recieve Transmitter Data:
        function [hdl,L] = ReceiveData(obj,s,Package,hdl,id,isParent)
            % Notes: For data and satelate the child must be in cell form
            % for upload.
            
            
            % id is the ID of the tag of object two the current object.
            T = obj.Tag; % pull object tag
            s.import_id = id;
            s.isParent = isParent;
            I_Tag = s.transmitter.Tag;
            I_id  = s.transmitter.Id;
            L = true;
            % package data switch statement:
            switch Package
                
                case 'Shift'
                    hdl.(T) = shiftParentList(obj,s,id,isParent);
                    return
                    
                case 'Data'
                    s = pullData(obj,s,hdl);
                    hdl = addData(obj,s,hdl);
                    hdl = deleteNode(hdl.(I_Tag),I_id,true,hdl);
                    
                case 'Satellite'
                    trm = s.transmitter; % pull transmitter
                    [obj,s.child] = snodeImport(obj,s.child,id);
                    trm.Id = s.child{1}.id;    % define new id.
                    s.child{1,2} = s.MetaData; % upload metadata
                    hdl.(trm.Tag) = syncTransmission(hdl.(trm.Tag),trm,T);
                    obj.Transmitter.(['n_',num2str(s.child{1}.id)]) = trm;
                    hdl.(T) = ManageInfoTable(obj,s.child,'transmitter');
                     
            end

            if isa(hdl.(T),'Axeso')
                [hdl.(T),L] = createPlot(hdl.(T),s.child{1}.id,hdl);
            end
            
            
        end
        
             
        % get Pull data via id:
        function [s,L] = getData(obj,id,hdl,Req,s)
            % the function to get data needs to be written inside of the
            % transmitter. A handle must be passed as well.
            L = true;
            I = ismember(obj.InfoTable.id,id);
            switch obj.InfoTable.type{I}
                case 'table'
                    
                    fld = obj.InfoTable.fields{I};
                    s.(fld) = getMetaData(obj,id);
                    s.(fld).data = obj.MainTable.(fld);
                    
                case 'transmitter'
                    fld = ['n_',num2str(id)];
                    trm = obj.Transmitter.(fld);
                    [s,L] = TransmitterRequest(hdl.(trm.Tag),trm,hdl,Req);
            end
        end

                        
        % Request Data from Passed Transmitter:
        function [s,L] = TransmitterRequest(obj,trm,hdl,Request)
            % id = obj.(N).id(ismember(obj.(N).receiver,fld));
            % fld = obj.idTbl.field(obj.idTbl.id == id);
            % s.(fld) = data;
            
            L = true;
            s = []; N = 'ReceiverTbl';
            fld = ['n_',num2str(trm.ReceiverID)];
            
            % authenticate transmitter
            if ~authenticate(obj.Receiver.(fld),trm), L = false;
                return
            end
            
            
            id = obj.(N).id(ismember(obj.(N).receiver,fld));
            s = getData(obj,id,hdl);
            
            
            
            if nargin == 3, return, end % if no extra data requested return
            K = 'DefaultTable';
            
            for i = 1:length(Request) % get request data
                id = obj.(K).id(ismember(obj.(K).field,Request{i}));
                if isnan(id)
                   T = obj.Tag;
                   fprintf('\n')
                   fprintf('\nObject %s has requested an invalid field',T)
                   fprintf('\nField Requested: %s',Request{i})
                   fprintf('\nReason: Default has not been sent\n')
                   L = false; 
                   return 
                end
                tmp = getData(obj,id,hdl);
                s.(Request{i}) = tmp.(char(fieldnames(tmp)));
            end
        end 
        
                
        % add data to table:
        function [hdl,type] = addData(O,s,hdl)
            
            fld = s.MetaData.field; % pull new field
            id = O.InfoTable.id(ismember(O.InfoTable.fields,fld));
            O.MainTable = join(O.MainTable,s.table); % join tables
            
            
           
            if ~isempty(id)  % check if the data pre exists
                
                % apply a shift to the data and do not create new node
                type = 'update';
                s.tbl = O.idTbl(O.idTbl.id == getSubNodes(O,id),:);
                s.child = getNodeStack(O,id);
                O = shiftParentList(O,s,s.import_id,s.isParent);
                if isempty(O.ReceiverTbl), hdl.(O.Tag) = O; return, end
                
 
                % inform transmitters data has been changed:
                Rec_id = O.ReceiverTbl.receiver(O.ReceiverTbl.id == id);
                for i = 1:length(Rec_id)
                    receiver = O.Receiver.(Rec_id{i});
                    if ~O.Receiver.(Rec_id{i}).ReceiverReady, continue, end
                    hdl = updateData(hdl.(receiver.Tag),receiver,hdl);  
                end,hdl.(O.Tag) = O; return
            end
            
            if isfield(s,'import_id') && isfield(s,'child')
                type = 'import';
                [O,s.child] = snodeImport(O,s.child,s.import_id);
                O = ManageInfoTable(O,{s.child{1},s.MetaData},'table');
                hdl.(O.Tag) = O; return % return
            end
            
            
            % if the s structure does not have a pre-packaged child create
            % a new child object via the node array then upload to manage
            % info table.
            
            type = 'load'; 
            s.table.(s.field) = [];       % delete primary key data
            Nodes = deriveNodes(s.table); % update derive nodes
            [O,Nodes(:,1)] = LoadData(O,Nodes(:,1)); % load data
            O = ManageInfoTable(O,Nodes,'table');    % update Info tabke
            hdl.(O.Tag) = O; return % return
            
            
            
        end
        
                        
        % NEED TO BUILD FUNCTION:
        function hdl = updateData(obj,receiver,hdl) %#ok
            
            
        end
        
                
        % delete data function:
        function hdl = DeleteData(O,pass,hdl)
            % R_id: Reciever id.
            
            
            % determine what is being passed.
            if isa(pass,'oTransmitter') % if pass is a transmitter
                RD = ['n_',num2str(pass.ReceiverID)]; % Reciever Id
                id = O.ReceiverTbl.id(ismember(O.ReceiverTbl.receiver,RD));
                from = 'transmitter';
                
            elseif isa(pass,'oReceiver') %if pass is a receiver object
                id = pass.id; from = 'receiver';
                
            elseif isa(pass,'numeric') % if data is numeric
                id   = pass; from = 'table';
                 
            end
            
            % pull the info table index of data to be deleted
            I = O.InfoTable.id == id;
            
            % use following line to delete data:
            info = O.InfoTable(I,:); % save info
            O.InfoTable(I,:) = []; % delete info table row
            
            
            % general for both transmitter and table based data:
            % delete data from default table if present.
            if ismember(id,O.DefaultTable.id)
                O.DefaultTable.id(O.DefaultTable.id == id) = NaN;
            end
            
            
            if isa(O,'Axeso') % get graph id and delete plots
                if isfield(O.HBox,'Plot')
                    delete(O.HBox.Plot);
                    O.HBox = rmfield(O.HBox,'Plot');
                end
                gid = unique(O.graph2data.GID(O.graph2data.id == id,:));
                for i = 1:length(gid), O.DeletePlot = gid(i); end
            end
            
            switch from % general processing
                
                case 'table' % pull list of recievers tied to id.
                    if isempty(O.ReceiverTbl), return, end
                    RD = O.ReceiverTbl.receiver(O.ReceiverTbl.id == id);
                    
                    % delete all transmitter tied to receivers
                    for i = 1:length(RD)
                        receiver = O.Receiver.(RD{i});
                        O.Receiver = rmfield(O.Receiver,RD{i});
                        
                        hdl.(O.Tag) = O;
                        if ~receiver.ReceiverReady, continue, end
                        T = receiver.Tag;
                        hdl = DeleteData(hdl.(T),receiver,hdl);
                        hdl = buildTree(hdl.(T),hdl);
                        
                        if strcmpi(hdl.(T).AxesoSetting,'legend')
                            continue
                        end
                        
                       hdl.(T) = StateVisibility(hdl.(T),'legend','off');
                    end,hdl.(O.Tag).MainTable.(char(info.fields)) = [];

                case 'receiver'
                    
                    field = ['n_',num2str(id)];
                    O.Transmitter = rmfield(O.Transmitter,field);
                    hdl.(O.Tag) = O;
                    hdl = deleteNode(O,id,true,hdl);
                    
                case 'transmitter'
                    RD = O.ReceiverTbl.receiver(O.ReceiverTbl.id == id);
                    O.Receiver = rmfield(O.Receiver,RD);
                    O.MainTable.(char(info.fields)) = [];
                    hdl.(O.Tag) = O;
                    
            end
            
            
        end
        
        
        % pull data & map data via transmitter:
        function s = pullData(O,s,hdl)
            % -------------------------------------------------------------
            % Input: Required only transmitter in structure s:
            % -------------------------------------------------------------
            % Outputs: Add the following structure properties:
            % table        - table of requested data with 
            % MetaData     - meta data of element in table
            % DefaultTable - update default table
            %
            % % Added Via pullKey.
            % field - field of table
            % -------------------------------------------------------------
            % Temp: Added Via PullKey and removed 
            % data  - data
            % -------------------------------------------------------------
            
            % build table
            tbl = O.DefaultTable(~isnan(O.DefaultTable.id),:);
            [~,I]  = ismember(tbl.id,O.InfoTable.id);
            tbl.id = O.InfoTable.fields(I);
            s.DefaultTable = tbl;
            
            % pull key data
            [hdl,s] = pullKey(hdl.(s.transmitter.Tag),s,hdl);
            trm = s.transmitter;
            s.MetaData = TransmitterRequest(hdl.(trm.Tag),trm,hdl);
            s.MetaData = s.MetaData.(char(fieldnames(s.MetaData)));
            
            % merge data into tables:
            End = {'VariableNames',{s.MetaData.field,s.field}};
            s.table = table(s.MetaData.data,s.data.(s.field).data,End{:});
            
            % remove fields to re-allocate ram:
            s.MetaData = rmfield(s.MetaData,'data');
            s = rmfield(s,{'data'});
            
        end
        

        % obtain key to link tables:
        function [hdl,s] = pullKey(O,s,hdl)
            
            % generate table to pull key
            tbl   = O.DefaultTable(~isnan(O.DefaultTable.id),:);
            [~,I] = ismember(tbl.id,O.InfoTable.id);
            tbl.fld = O.InfoTable.fields(I);
            
            % find matching primary keys
            tbl = tbl(ismember(tbl.fld,s.DefaultTable.id),:);
            
            % get index
            [~,I] = ismember({'id'},tbl.field);
            tbl   = tbl(I,:);

            % finish table processing
            if isempty(tbl), error('no id found for data transfer'), end
            s.data = getData(O,tbl.id,hdl); 
            s.field = char(tbl.fld);
            hdl.(O.Tag) = O;
            
        end
            
        
        % Finalize Transmision Process:
        function [obj,trm] = syncTransmission(obj,trm,T)
            
            fld = ['n_',num2str(trm.ReceiverID)];
            if ~authenticate(obj.Receiver.(fld),trm)
                return
            end
            
            obj.Receiver.(fld).Tag = T;
            obj.Receiver.(fld).id = trm.Id;
            obj.Receiver.(fld).ReceiverReady = true;
            trm.ReceiverReady = true;
            
        end
       
      
    end
    
    
    % config methods:
    methods
        
                
        % set up node configureation for graph:        
        function obj = setupGConfigNNodes(obj)
            
            % Build Nodes:
            Measurec = funBuildConfig('measure');
            DoubleC = funBuildConfig('double');
            IdC = funBuildConfig('id');
            
            % Add to Config:
            Config = {Measurec,DoubleC,IdC};
            obj.addConfig = Config;
            
            % Settings:
            s2 = createNode('Measures',{'M'},{'Measures'});
            obj.addNode = {s2}; % first here
        end
        
   
        % For Non-Graph:
        function obj = setupConfigNNodes(obj)
            
            % Build Nodes:
            Measurec = funBuildConfig('measure');
            Dimensionc = funBuildConfig('dimension');
            DoubleC = funBuildConfig('double');
            IdC = funBuildConfig('id');
           
            % Add to Config:
            Config = {Measurec,Dimensionc,DoubleC,IdC};
            obj.addConfig = Config;
            
            s1 = createNode('Dimensions',{'D'},{'Dimensions'});
            s2 = createNode('Measures',{'M'},{'Measures'});
            obj.addNode = {s1,s2};
        end
        
        
    end
    
 
    % context menu:
    methods 
        
        % exit context menu:
        function O = exitContextMenu(O)
            
            delete(O.CTxt_Menu.menu)
            delete(O.CTxt_Menu.axes)
            
        end
        
        % generate context menu
        function [O,hObject] = generateCMenu(O,id,hObject)
            % next level step:
            % only can implement if text boxes are made invisible during
            % the context menu intervention.
            % -------------------------------------------------------------
            % x = [0,0,1,1];                                              |
            % y = [1,0,0,1];                                              |
            % hold on                                                     |
            % O.CTxt_Menu.box = fill(x, y, 'b','FaceAlpha',.25);          |
            % hold off                                                    |
            % -------------------------------------------------------------
            
            % check if data is in table and not a transmitter:
           IT = 'InfoTable';
            if ~strcmpi('Table',O.(IT).type(id==O.(IT).id))
                disp('Data must not be a transmitter and must be present')
                disp('in the current table for more information on what a')
                disp('transmitter is please visit: goldenoakresearch.com')
                return
            end
            
            % derive and set positions:
            T = O.Tag; % object tag
            B = @(hObject,eventdata)clkmenu(T,hObject,guidata(hObject));
            P = O.TreeObj(findIndex(O.TreeObj,id)).Icon.Bubble.Position;
            newPos = (O.Pos(3:4)./O.NormPos(3:4)) - O.Pos(1:2); % trsfm
            boxpsy = [-O.Pos(2),newPos(2)]-O.ScrollBar.S; % box y
            boxps  = [-O.Pos(1),newPos(1),boxpsy]; % box ps
            pnew = [0,0,1,1]; % normalize to screen
            
            
            % setup Context Menu Structure:
            s.FaceColor = [.97 .97 .97]; % face color
            s.EdgeColor = [.96 .96 .97]; % edge color
            s.Callback  = B; % callback 
            s.fields    = {'Primary Key','Latitude','Longitude','Date','Double'};
            s.Position  = [([P([1,3]);P([2,4]).*[1,.5]]*[1;1])',3.45,.60];
            s.Position([1,5]) = s.Position([1,1])+[.3,0];
            s.Shift = P(4);
            s.B = boxps(3);
            
            % Build new axes:
            O.CTxt_Menu.axes = axes('Position',pnew,'Units','normalized');
            Flds ={'YColor','XColor','XTick','YTick','Color'};
            set(O.CTxt_Menu.axes,Flds,{'none','none',[],[],'none'})
            O.CTxt_Menu.axes.Clipping = 'off';
            axis(boxps);
            
            
            % create backround box:
            x = boxps([1,1,2,2]);
            y = boxps([4,3,3,4]); 
            hold on % turn pn hold.
                                                                                                    

            % create backround box and context menu:
            O.CTxt_Menu.box = fill(x,y,[52,73,94]./255,'FaceAlpha',.75);
            O.CTxt_Menu.menu = contextMenu(s);
            
            
            % setup exit context menu:
            B = @(hObject,eventdata)exitCMenu(T,hObject,guidata(hObject));
            O.CTxt_Menu.axes.ButtonDownFcn = B;
            O.CTxt_Menu.box.ButtonDownFcn = B;
            O.CTxt_Menu.id = id;
            
            % setup interface commands:
            B = @(hObject,eventdata)dragCMenu(T,hObject,guidata(hObject));
            hObject = setFigureWM(hObject,B);
            
        end
        
        % Context Menu Motion:
        function O = contextMotion(O,M)
            
            n = M.*O.Pos(3:4)./O.NormPos(3:4)-O.Pos(1:2)-[0,O.ScrollBar.S];
            [O.CTxt_Menu.menu] = getHover(O.CTxt_Menu.menu,n);

        end
        
        % switch data type from context menu:
        function [O,L] = switchDataType(O)
           % CType - configure type.
           % Type - Data Type.
           % new structure
           % 1. id   - obtain id.
           % 2. menu - context menu.
           % 3. type - configuration table.
           
           
           % constant variables:
           id = O.CTxt_Menu.id; % original id.
           new = O.CTxt_Menu.menu.Last; % context menu data.
           IT = 'InfoTable';
           
           % extract type information on original object
           ocg = char(O.idTbl.configuration(id==O.idTbl.id));
           Type  = char(O.(IT).data_type(id==O.(IT).id));
           
           
           % translate new type data:
           switch lower(new.field) % translate new type field.
               case 'latitude',    new.type = 'latitude';   
               case 'longitude',   new.type = 'longitude';
               case 'date',        new.type = 'date';
               case 'primary key', new.type = 'id';
               case 'double',      new.type = 'double';
           end
           
           
           % check if you are transforming to the same type.
           if strcmpi(new.type,Type)
              L = false;
              disp('You tried to set the field to its current data type')
              return
           end
           
           
           % print out a general statement:
           fprintf('\nProcessing Data: %s\n',new.field)
           fprintf('the new data type is %s\n',new.type)
           fprintf('the previous type was %s\n\n',Type)
           tblinfo = O.InfoTable(id==O.InfoTable.id,:);
            
            % derive nodes:
           [Nodes,L] = deriveNodes(O.MainTable,tblinfo.fields,new.type);
           
           if ~L % makes sure the nodes were derived correctly
               fprintf('\nThe field %s could not be switched\n',new.field)
               fprintf('To the data type %s\n',new.type)
               return
           end
           
           
           % remove if in default table
           O.DefaultTable.id(O.DefaultTable.id == id) = NaN;
           
           % if default table is empty set as primary
           fld_idx = ismember(O.DefaultTable.field,new.type);
           if ~any(fld_idx) 
           elseif isnan(O.DefaultTable.id(fld_idx))
               O.DefaultTable.id(fld_idx) = id;
           end
           
           
           % generate config data:
           W = char(Nodes{1,1}.config); % get new cofiguration
           
           
           % process meta data, info table & id table:
           O.MetaData.(['n_',num2str(id)]) = Nodes{1,2}; % switch out data.
           O.(IT).data_type(id==O.(IT).id) = cellstr(Nodes{1,2}.data_type);
           O.idTbl.configuration(O.idTbl.id == id) = cellstr(W);
           
           % process stack object
           Path = O.idTbl.path{O.idTbl.id == id};
           snew.child = strctDive(O.Stack,Path,'children');
           snew.child.config = new.type;
           
        
           % update icon:
           s = O.Configurations.(W).Icon;
           idx = findIndex(O.TreeObj,id);
           O.TreeObj(idx).Icon = updateDesign(O.TreeObj(idx).Icon,s);
           
           
           if ~checkSubset(O.Configurations.(W),O.Configurations.(ocg))
               N = char(O.Configurations.(W).superset);
               nid = O.idTbl.id(ismember(O.idTbl.configuration,N));
               O.LastImport.loc = 2;
               O = shiftParentList(O,snew,nid,true);
           end
           
           
        end
        
    end
    
    
end


% exit context menu:
function exitCMenu(Tag,hOb,hdl)

hdl = setSearchFun(hdl.UIControl,hdl,'on');
hdl = selectPage(hdl.UIControl,hdl.UIControl.Page,hdl);
[hOb,hdl] = setDefinateMotion(hdl.UIControl,hOb,hdl);
guidata(hOb, hdl);

hdl.(Tag) = exitContextMenu(hdl.(Tag));

end

% drag context menu:
function dragCMenu(Tag,hOb,hdl)

hdl.(Tag) = contextMotion(hdl.(Tag),hOb.CurrentPoint);
guidata(hOb, hdl);

end

% drag context menu:
function clkmenu(Tag,hOb,hdl)


  [hdl.(Tag),L] = switchDataType(hdl.(Tag));
  if ~L, return, end
  
  
  hdl = setSearchFun(hdl.UIControl,hdl,'on');
  hdl = buildTree(hdl.(Tag),hdl);
  
  hdl = selectPage(hdl.UIControl,hdl.UIControl.Page,hdl);
  [hOb,hdl] = setDefinateMotion(hdl.UIControl,hOb,hdl);
  
  guidata(hOb, hdl);
  hdl.(Tag) = exitContextMenu(hdl.(Tag));
  
end
