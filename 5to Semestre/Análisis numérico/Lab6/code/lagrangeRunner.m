f = @(x) 3 * sin(pi*x/6);
pointMatrix = [0 f(0); 1 f(1); 2 f(2); 3 f(3); 4 f(4)];

lagrangeP = lagrangePoly(pointMatrix)