function output = visualSecantRoot(fun, iniA, iniB, iter)
    if (isa(fun, 'function_handle') && iter > 0 && iniA < iniB)
        leader = iniB;
        tracer = iniA;
        nextVal = NaN;

        secFun = @(fun,k,p) k - ((fun(k)*(k-p))/(fun(k)-fun(p)));
        
        for index = 1:iter
            nextVal = secFun(fun, leader, tracer);

            plot(nextVal, fun(nextVal),'-*',...
            'LineWidth',1,...
            'MarkerSize',5,...
            'MarkerEdgeColor', rand(1,3))
            hold on

            if fun(nextVal) ==  0 %root found%
                output = nextVal;
                break;
            end

            tracer = leader;
            leader = nextVal;
        end

        fplot(fun, [(nextVal-0.1), (nextVal+0.1)])
        hold on

        plot(nextVal, fun(nextVal),'-.ko',...
        'LineWidth',1,...
        'MarkerSize',10,...
        'MarkerEdgeColor','#A2142F')
        hold off

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