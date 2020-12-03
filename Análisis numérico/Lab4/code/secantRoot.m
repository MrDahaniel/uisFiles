function output = secantRoot(fun, iniA, iniB, iter)
    if (isa(fun, 'function_handle') && iter > 0 && iniA < iniB)
        leader = iniB;
        tracer = iniA;
        nextVal = NaN;

        secFun = @(fun,k,p) k - ((fun(k)*(k-p))/(fun(k)-fun(p)));
        
        for index = 1:iter
            nextVal = secFun(fun, leader, tracer);

            if fun(nextVal) ==  0 %root found%
                disp(['root found at ', num2str(nextVal),'! Found after ', num2str(index),' iterations']);
                output = nextVal;
                return;
            end

            tracer = leader;
            leader = nextVal;
        end

        if fun(nextVal) ==  0
            disp(['Root found! ', num2str(nextVal)]);
            output = nextVal;
        elseif abs(fun(nextVal)) < 10^(-5)
            output = nextVal;
            disp(['Approximate root found! ', num2str(nextVal)]);
        else
            disp('No roots found...')
        end

    else
        disp("invalid parameters! Check input")
    end
end