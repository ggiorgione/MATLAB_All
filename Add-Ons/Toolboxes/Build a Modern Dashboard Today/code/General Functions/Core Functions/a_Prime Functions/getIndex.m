function [I,II,III] = getIndex(nameList,name,Type,Key)
% get Index of Names in Name List.

I = []; II = (1:length(nameList))';
switch nargin
    case 2, [~,I] = ismember(name,nameList); return
    case 3, I = SolveType(nameList,name,Type); return
    case 4, I = SolveType(nameList,name,Type);
        switch Key, case 'delete', DEL = (I == 0);
            if nargout == 3, III = II.*I; III(DEL) = []; end
            I(DEL) = []; II(DEL) = [];
            otherwise, disp('Invalid Key')
        end, return
end, if nargout == 3, if isempty(I) == 0, III = II(I); end, end



end

function I = SolveType(L,N,T)
% L is the list of names, N is the name, T is the type

switch T
    case 'repeat', L = unique(L); [~,I] = ismember(L,N);    
    case 'delete', [~,I] = ismember(N,L); I = I(I~=0);  
    case 'mixed', if isNumber(L), I = L; else, [~,I] = ismember(N,L); end  
    otherwise, [~,I] = ismember(N,L);  
end

end