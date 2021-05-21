function D1 = bigDataArith(D1,Arth,D2)


switch Arth
    case '/', D1 = D1./D2;
    case '*', D1 = D1.*D2; 
    case '+', D1 = D1 + D2;
    case '-', D1 = D1 - D2;
    case 'ratio', D1 = D1./D2 - 1;   
end

TotalInf = sum(all(isinf(D1),2));
if TotalInf ~= 0
    disp('infinities were replaced with nans: bigDataArith')
    fprintf('%0.0f Samples Removed\n',TotalInf)
    fprintf('%0.0f Total Samples\n',length(D1))
    D1(all(isinf(D1),2),:) = NaN;
end


end

