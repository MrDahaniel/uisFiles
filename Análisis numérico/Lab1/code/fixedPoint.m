function output = fixedPoint(aFunction, lowerLimit, upperLimit, initalPoint, iterations)
  %Check inputs for errors%
  if ((lowerLimit < upperLimit) && (0 < iterations) && (lowerLimit <= initalPoint <= upperLimit) && isa(aFunction, 'function_handle'))
    output = initalPoint;
    for index = 1:iterations
      older = output;
      output = aFunction(output);
      if (lowerLimit <= output <= upperLimit) 
        if older == output
          disp('fixed point was found:')
          disp(output)
          return;
        end
      else
        warning('given function breaks out of stablished range')
        return;
      end
    end
    if older-output == 0
      %just to avoid fun things
    elseif (abs(older - output) < 0.00001)
      disp(['A possible fixed point was found close to ', output, '. More iterations might confirm if it is a fixed point.'])
      output = NaN;
    else
      disp('A fixed point was not found. Increasing the number of iterations could help locating one but it is not completely certain.')
      disp('It is also possible than the given function fixed points can not be calculated using the iterative method.')
      output = NaN;
    end
  else
    warning('Error! Given arguments for function fixedPoint are not valid!')
    output = NaN;
  end
end