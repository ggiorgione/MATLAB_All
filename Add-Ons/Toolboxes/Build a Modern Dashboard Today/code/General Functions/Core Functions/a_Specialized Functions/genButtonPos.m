function start = genButtonPos(start,space,D)

out = zeros(D,4);
out(:,2) = ones(D,1).*(0:space:space*(D-1))';
start = start - out;

end

