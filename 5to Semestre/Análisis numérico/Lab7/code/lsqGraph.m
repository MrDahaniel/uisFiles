f = @(x) 66/25 - (117*x)/200;
xk = linspace(-9, 7);
scatter(-8, 6.8)
hold on
scatter(-2, 5.0) 
hold on
scatter(0, 2.2) 
hold on
scatter(4, 0.5) 
hold on
scatter(6, -1.3)
hold on 
plot(xk, f(xk))