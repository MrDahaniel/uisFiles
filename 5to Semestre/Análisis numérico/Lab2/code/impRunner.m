f = @(x) 1500*exp(1)^(x) + (475*(exp(1)^(x)-1))/x - 2264;
low = 0.01;
upp = 1;
ite = 150;

bisection(f,low,upp,ite)