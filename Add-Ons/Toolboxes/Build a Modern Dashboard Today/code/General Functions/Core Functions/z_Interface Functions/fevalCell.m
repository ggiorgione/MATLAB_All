function y1 = fevalCell(fun,x1)

if nargin == 2
    y1 = feval(fun,x1{:});
else
    y1 = feval(fun);
end

%    disp(fun), disp(x1)
%    error('Failed to exicute')


end

