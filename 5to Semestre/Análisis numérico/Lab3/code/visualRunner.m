f = @(x) (x^3)+(13*(x^2))-(297.5*x)+(0.00000375*(exp(x)));
der = @(x) (3*(x^2))+(26*x)-(297.5)+(0.00000375*(exp(x)));
ite = 4;
ini = -27;
visualNewtonRoot(f, der, ini, ite);