function output = secondDerivative12(func, val, h)
    if isa(func, 'function_handle')
        output = (-func(val+2*h)+16*func(val+h)-30*func(val)+16*func(val-h)-func(val-2*h))/(12*(h^2));
    end
end