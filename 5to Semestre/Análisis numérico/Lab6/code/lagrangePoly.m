function output = lagrangePoly(pointMatrix)
    
    syms x

    [vS, hS] = size(pointMatrix);

    output = NaN;

    if(hS == 2 && vS > 1) %%Las entradas son correctas cuando los puntos son de (x,y)
        L = [];
        for index = 1:vS
            tempFun = 1;
            for pain = 1:vS
                if(pain == index)
                    %%  ¯\_(?)_/¯
                else
                    tempFun = tempFun * ((x-pointMatrix(pain,1))/(pointMatrix(index,1) - pointMatrix(pain,1)));
                end
            end
            L = [L tempFun];
        end

        fullFunc = 0;

        for finex = 1:vS
            fullFunc = fullFunc + pointMatrix(finex,2) * L(finex);
        end

        output = fullFunc;

    end

end