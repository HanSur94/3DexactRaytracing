function [isSize] = isSize(input, n, m)
%ISSIZE will check if a 2D input has the wanted size. If the dimension dont
%match, then the function woll return 0, otherwise it returns 1.
%
%   [isSize] = isSize(input, n, m)
  
    [nInput, mInput] = size(input);
    
    if n == nInput && m == mInput
        isSize = 1;
    else
        isSize = 0;
    end

end

