function output = modNewtonRoot(fun, der, ini, ite)
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
            lastVal = nextVal;
            nextVal = nextVal - (fun(nextVal)/der(nextVal));

            disp(['Realizando iteracion #', num2str(index)] )
            disp(['Raiz actual: ', num2str(nextVal)])
            disp(['f(', num2str(nextVal),') = ', num2str(fun(nextVal))])
            disp(['f''(', num2str(nextVal),') = ', num2str(der(nextVal))])
            disp(['Error absoluto = ', num2str(abs(nextVal-lastVal))])
            disp('-----------')
            
            if(fun(nextVal) == 0) 
                disp(['Root found! ', num2str(nextVal), ' is the root for ', func2str(fun), '!', ' Found after ', num2str(index), 'iterations'])
                output = nextVal;
                return;
            else
                %% Skip %%
            end
        end

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