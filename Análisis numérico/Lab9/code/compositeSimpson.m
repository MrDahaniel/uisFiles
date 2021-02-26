function output = compositeSimpson(f, M, a, b)
    if (isa(f, 'function_handle') && (M > 0))
        sumPart  = 0;
        sumPart2 = 0;
        h = (b-a)/(2*M);

        for k = 1:(M-1)
            sumPart = sumPart + f(a+2*k*h);
        end

        for k = 1:M
            sumPart2 = sumPart2 + f(a+(2*k-1)*h);
        end

        output = (h/3) * (f(a) +  f(b) + 2*sumPart + 4*sumPart2);

    end
end