function Logic = strCellLogic(univ,comp)

Logic = sum(ismember(univ,comp)) ~= 0;

end

