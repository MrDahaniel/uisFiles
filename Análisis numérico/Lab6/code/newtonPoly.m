function output = newtonPoly(pointMatrix)

    [vS, hS] = size(pointMatrix);

    output = NaN;

    if(hS == 2) %%Las entradas son correctas cuando los puntos son de (x,y)

        funTrix = zeros(vS,vS);

        for starex = 1:vS
            funTrix(starex,1) = pointMatrix(starex,2);
        end
        
        for index = 2:vS
            for pain = index:vS
                funTrix(pain,index) = ((funTrix(pain,index-1)-funTrix(pain-1,index-1))/(pointMatrix(pain,1)-pointMatrix((pain - index + 1), 1)));
            end
        end

        fullFunc = @(x) funTrix(1,1);
        fullFuncAux = @(x) 1;

        for fintrex = 2:vS 
            fullFuncAux = @(x) fullFuncAux(x) * (x-pointMatrix(fintrex-1,1));
            fullFunc = @(x) fullFunc(x) + funTrix(fintrex, fintrex) * fullFuncAux(x) ;
        end

        output = fullFunc;

    end 
end