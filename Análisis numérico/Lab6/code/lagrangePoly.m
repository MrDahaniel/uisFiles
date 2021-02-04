function output = lagrangePoly(pointMatrix)
    
    [vS, hS] = size(pointMatrix);

    output = NaN;

    if(hS == 2 && vS > 1) %%Las entradas son correctas cuando los puntos son de (x,y)

        for index = 1:vS
            tempFun = @(x) 1;
            for pain = 1:vS
                if(pain == index)
                    %%  ¯\_(?)_/¯
                else
                    tempFun = @(x) tempFun(x) * ((x-pointMatrix(pain,1))/(pointMatrix(index,1) - pointMatrix(pain,1)));
                end
            end
            L{index} = tempFun;
        end

        fullFunc = @(x) 0;

        for finex = 1:vS
            fullFunc = @(x) fullFunc(x) + pointMatrix(finex,2) * L{finex}(x);
        end

        output = fullFunc;

    end

end