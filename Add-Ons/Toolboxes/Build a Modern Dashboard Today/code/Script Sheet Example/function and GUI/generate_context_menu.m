% generate contax menu
% the context menu is a 2xn menu


% input settings:
s.FaceColor = [.97 .97 .97];
s.EdgeColor = 'b';
s.Callback = [];
s.fields = {'latitude','longitude','date','identity'};
s.Position = [0,0,2,.75];
objs = contextMenu(s);




