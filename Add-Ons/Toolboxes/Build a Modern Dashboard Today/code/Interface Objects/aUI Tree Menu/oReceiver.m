classdef oReceiver
    % 
    
    properties
        
        Requests;
        Password;
        ReceiverID;
        ReceiverReady;
        Tag;
        id;         % note the id of the transmitter.
        
    end
    
    methods
        
        % create reciever:
        function obj = oReceiver(id)
            obj.ReceiverReady = false;
            obj.ReceiverID = id;
            
        end
        
        % sync tranmitter and receiever
        function [Receiver,Transmitter] = Sync(Receiver,Transmitter)
            
            Receiver.Password = randi([0,9],1,16);
            Transmitter.Password = Receiver.Password;
            Transmitter.ReceiverID = Receiver.ReceiverID;
            
        end
        
        % authenticate data:
        function L = authenticate(Receiver,Transmitter)
            
           L = isequal(Receiver.Password,Transmitter.Password);
            
        end
        
        % delete Transmitter:
        function hdl = DeleteTransmitter(obj,hdl)
            
            hdl.(obj.Tag) = DeleteData(hdl.(obj.Tag),obj.id,hdl);
            
            
        end

    end
    
end

