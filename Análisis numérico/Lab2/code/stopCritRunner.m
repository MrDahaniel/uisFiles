f = @(x) ((x-3)^2)*(x-8);
low = 4;
up = 10;
ite = 50;
sc = 0.0000000001;

stopCritBisection(f,low,up,ite,sc);
