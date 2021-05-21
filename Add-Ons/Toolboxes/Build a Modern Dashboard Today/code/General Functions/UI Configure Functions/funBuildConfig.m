function d1 = funBuildConfig(type)

switch type
   
    case 'measure',   d1 = buildMeasure();
    case 'dimension', d1 = buildDimension();
    case 'double',    d1 = buildDouble();
    case 'id',        d1 = buildId();
end

end


function M = buildMeasure()

H = [.95 .95 .95];
h = 'none';

% Settings:
M = NodeConfiguration('Measures');
M.Settings.Import = 1;
M.Settings.Parent = 1;

% set theory settings:
M.superset = {'table'};
M.subset = {'double','catigorical','profit','double','factorian'};

% Highlight:
M = addConfig(M,'Box','Highlight','FaceColor',H,'EdgeColor',H);
M = addConfig(M,'Pill','Highlight','FaceColor',h,'EdgeColor',h);

% Normal:
M = addConfig(M,'Pill','Normal','FaceColor',h,'EdgeColor',h);

% Import:
M = addConfig(M,'Pill','Import','FaceColor',h,'EdgeColor',h);

end


function D = buildDimension()

H = [.95 .95 .95];
h = 'none';

% Settings:
D = NodeConfiguration('Dimensions');
D.Settings.Import = 1;
D.Settings.Parent = 1;

% set theory settings:
D.superset = {'table'};
D.subset = {'id','latitude','longitude','date'};

% Highlight:
D = addConfig(D,'Box','Highlight','FaceColor',H,'EdgeColor',H);
D = addConfig(D,'Pill','Highlight','FaceColor',h,'EdgeColor',h);

% Normal:
D = addConfig(D,'Pill','Normal','FaceColor',h,'EdgeColor',h);

% Import:
D = addConfig(D,'Pill','Import','FaceColor',h,'EdgeColor',h);



end


function D = buildDouble()


H = 'none'; h = ([38, 194, 129])./255;
D = NodeConfiguration('double');


% set theory settings:
D.superset = {'Measures'};
D.subset = [];

% Normal Configuration:
D = addConfig(D,'Pill','Normal','FaceColor',H,'EdgeColor',H);

% Highlight Configuration:
D = addConfig(D,'Pill','Highlight','FaceColor',h,'EdgeColor',h);
 
D = addIcon(D,'Color',h,'Symbol','#');

end


function I = buildId()

C = ([92,151,191])./255;
H = 'none';
I = NodeConfiguration('id');

% set theory settings:
I.superset = {'Dimensions'};
I.subset = [];


I = addConfig(I,'Pill','Normal','FaceColor',H,'EdgeColor',H);
I = addIcon(I,'Color',C,'Symbol','i');

end