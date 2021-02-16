function output = secondDerivative(func, val, h)
    if isa(func, 'function_handle')
        output = (func(val+h)-2*func(val)+func(val-h))/(h^2);
    end
end