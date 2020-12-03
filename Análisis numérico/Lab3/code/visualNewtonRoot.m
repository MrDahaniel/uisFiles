function output = visualNewtonRoot(fun, der, ini, ite)
    if (isa(fun, 'function_handle') && isa(der, 'function_handle') && ite > 0)
        nextVal = ini;
        output = NaN;

        if(fun(nextVal) == 0) 
            disp(['Root found! ', num2str(nextVal), ' is the root for ', func2str(fun), '!'])
            output = nextVal;    
            return;
        else
            %% Skip %%
        end
        
        for index = 1:ite
            nextVal = nextVal - (fun(nextVal)/der(nextVal));

            plot(nextVal, fun(nextVal),'-*',...
            'LineWidth',1,...
            'MarkerSize',5,...
            'MarkerEdgeColor','#7EA28E')
            hold on

            if(fun(nextVal) == 0) 
                disp(['Root found! ', num2str(nextVal), ' is the root for ', func2str(fun), '!', ' Found after ', num2str(index), 'iterations'])
                output = nextVal;
                return;
            else
                %% Skip %%
            end
        end

        fplot(fun, [(nextVal - (fun(nextVal)/der(nextVal)))-1, (nextVal - (fun(nextVal)/der(nextVal)))+1])
        hold on

        line([nextVal-2 nextVal+2], [0 0])

        plot(nextVal, fun(nextVal),'-.ko',...
        'LineWidth',1,...
        'MarkerSize',10,...
        'MarkerEdgeColor','#A2142F')
        hold off

        if abs(fun(nextVal)) < 10^(-5)
            output = nextVal;
            disp(['Approximate root found! ', num2str(nextVal)]);
        else
            disp('No roots found...')
        end

    else
        disp('Passed params are invalid!')
    end
end     