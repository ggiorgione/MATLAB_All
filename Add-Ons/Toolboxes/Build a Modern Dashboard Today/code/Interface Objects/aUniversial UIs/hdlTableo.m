classdef (Abstract) hdlTableo
    
    
    properties
        
        exportTbl;
        importTbl;
        
    end
    
    
    
    % Export Table
    methods
        

        % add data to table:
        function obj = addExportTbl(obj,L,Cell)
            % Setup Export Table:
            if L == 1
                obj.exportTbl = [obj.exportTbl;Cell];
            end
        end
        
        
        % clear table:
        function obj = clearExportTbl(obj)
            if size(obj.exportTbl,1) ~= 0
                obj.exportTbl(:,:) = [];
            end
            
        end 
        
    end
    
    % Import Table
    methods

        % add data to table:
        function obj = addImportTbl(obj,L,Cell)
            % Setup Export Table:
            if L == 1
                obj.importTbl = [obj.importTbl;Cell];
            end
        end
            
        
        % clear table:
        function obj = clearImportTbl(obj)
            if size(obj.importTbl,1) ~= 0
                obj.importTbl(:,:) = [];
            end
            
        end
        
        
        
    end
    
    
    
    methods
        
        
        % Constructor:
        function obj = setupTables(obj)
            
            Names = {'id','tag','pos'};
            obj.exportTbl = cell2table(cell(0,3));
            obj.exportTbl.Properties.VariableNames = Names;
            
            Names = {'id','tag','idx','pos','type','shift'};
            obj.importTbl = cell2table(cell(0,6));
            obj.importTbl.Properties.VariableNames = Names;
        end
        
        
        % Clear Import Export Tables:
        function obj = clearTbls(obj)
            
            if size(obj.importTbl,1) ~= 0
                obj.importTbl(:,:) = [];
            end
            
            if size(obj.exportTbl,1) ~= 0
                obj.exportTbl(:,:) = [];
            end
            
            
        end
        
        
        % Update Table Controller:
        function handles = updateTblController(obj,handles)

            if ~isfield(handles,'UIControl')
                error('Controller needs to be defined')
            end
            
            
            % update View table
            handles.UIControl = updateTable...
                (handles.UIControl,'view',obj.exportTbl,obj.Tag);
            
            % update export table
            handles.UIControl = updateTable...
                (handles.UIControl,'import',obj.importTbl,obj.Tag);
            
        end
        
    end
    
end

