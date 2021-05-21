classdef oTransmitter
    % Transmitter Object
    
    properties
        
        ReceiverID
        ReceiverReady
        Password
        Id
        Field
        Tag
        UserData
        Configuration
        
    end
    
    methods
        
        function obj = oTransmitter()
            obj.ReceiverReady = false;
            
        end
        
        function obj = getData(obj,hdl,R)
            
            if nargin == 2
                hdl.(O.Tag) = TransmitterRequest(hdl.(O.Tag),obj,hdl);
            else
                hdl.(O.Tag) = TransmitterRequest(hdl.(O.Tag),obj,hdl,R);
            end
        end
        
    end
    
end

