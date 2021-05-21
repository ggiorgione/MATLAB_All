function s = createNode(field,path,config,reference,children,list)

if nargin < 1, error('need at least a feild'), end
if nargin < 2,path = {'a'};                    end
if nargin < 3, config = 'default';             end
if nargin < 4, reference = {};                 end
if nargin < 5, children = [];                  end
if nargin < 6, list = [];                      end
    
s.field     = field;
s.path      = path;
s.config    = config;
s.reference = reference;
s.children  = children;
s.List      = list;
s.view      = false;

end

