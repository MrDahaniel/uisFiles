function output = explicitBisection(aFunction, lowerBracket, upperBracket, iterations)
    %Checks function params%
    if (isa(aFunction,'function_handle') && (lowerBracket < upperBracket) && (aFunction(lowerBracket)*aFunction(upperBracket) <= 0) && (iterations > 0))
        disp(['Given parameters are valid!', newline, 'Calculating roots of ', func2str(aFunction)])

        bisector = @(a,b) (a+b)/2;

        
        if aFunction(lowerBracket) < 0
            lowerBound = lowerBracket;
            upperBound = upperBracket;
        else
            lowerBound = upperBracket;
            upperBound = lowerBracket;
        end
        
        for index = 1:iterations 
            disp(['a', num2str(index), ' = ', num2str(lowerBound), '    b', num2str(index), ' = ', num2str(upperBound), '    c', num2str(index), ' = ', num2str(bisector(lowerBound,upperBound)), '    newBound = ', num2str(aFunction(bisector(lowerBound,upperBound)))])
            newBound = bisector(lowerBound,upperBound);
            newRange = aFunction(newBound);
            if newRange == 0
                disp(['A root for ', func2str(aFunction), ' was found! Root for function is ', num2str(newBound), ' (Root found after ', num2str(index), ' iterations)']);
                output = newBound;
                return;
            elseif newRange < 0
                lowerBound = newBound;
            else %newRange > 0
                upperBound =  newBound;
            end
        end

        if (aFunction(newBound) == 0)
            disp(['A root for ', func2str(aFunction), ' was found! Root for function is ', num2str(newBound)])
            output = newBound;
        elseif (abs(aFunction(newBound)) < 0.00001)
            disp(['A possible root was found close to ', num2str(newBound), '. More iterations might confirm if it is a root.'])
            output = newBound;
        else
            disp('A root was not found. Increasing the number of iterations could help locating one but it is not completely certain.')
            output = NaN;
        end
    else 
        disp('Given parameters are invalid! Check params and try again')
    end
end