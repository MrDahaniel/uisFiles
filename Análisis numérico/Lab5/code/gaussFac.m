function output = gaussFac(inTrix)
    funTrix = inTrix;
    [vert, hori] = size(inTrix);
    counter = 1;
    if vert == hori
        for outer = 1:hori
            counter = counter + 1; 

            temp = funTrix(outer,:);
            tempFac = temp/temp(outer);

            for subber = counter:vert
                funTrix(subber,:) = funTrix(subber,:) - tempFac*funTrix(subber,outer);
            end
        end
        output = funTrix;
    end
end