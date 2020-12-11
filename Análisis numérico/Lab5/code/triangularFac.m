function [L, U] = triangularFac(inTrix)
    [vert, hori] =  size(inTrix);
    if vert == hori 
        U = gaussFac(inTrix);
        L = inTrix/U;
    end
end