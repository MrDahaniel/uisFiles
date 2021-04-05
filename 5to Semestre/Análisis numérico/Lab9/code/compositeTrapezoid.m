function output = compositeTrapezoid(f, M, a, b)
    if (isa(f, 'function_handle') && (M > 0))
        h = (b-a)/M;
        sumPart = 0;
        xk = a;

        for index = 1:M
            sumPart = sumPart + f(xk);
            xk = xk + h;
        end
        output = (h/2)*(f(a)+f(b))+h*sumPart;
    end
end