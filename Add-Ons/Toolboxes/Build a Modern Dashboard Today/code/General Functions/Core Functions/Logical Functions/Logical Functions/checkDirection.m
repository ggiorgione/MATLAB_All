function Logic = checkDirection(vec)
% check if direction is high -> low

if length(vec) == 1
   Logic = -1; 
else
    if vec(1) > vec(2)
        Logic = true;
    else
        Logic = false;
    end
end


end

