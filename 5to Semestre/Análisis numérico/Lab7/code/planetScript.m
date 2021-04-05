syms x

temp = (562958924640903*x)/562949953421312 - 3143657320373185/70368744177664;
f = matlabFunction(temp);

dom = linspace(40, 70);

scatter(log((57.91e6)^3), log(87.97^2))
hold on
scatter(log((108.70e6)^3), log(224.70^2))
hold on
scatter(log((149.60e6)^3), log(365.26^2))
hold on
scatter(log((227.92e6)^3), log(686.98^2))
hold on
scatter(log((778.57e6)^3), log(4332.59^2))
hold on
scatter(log((1433.53e6)^3), log(10759.22^2))
hold on
scatter(log((2872.46e6)^3), log(30685.40^2))
hold on
scatter(log((4495.06e6)^3), log(60189.00^2))
hold on
text(log((57.91e6)^3)-4, log(87.97^2), 'Mercurio')
hold on
text(log((108.70e6)^3)-4, log(224.70^2), 'Venus')
hold on
text(log((149.60e6)^3)-4, log(365.26^2), 'Tierra')
hold on
text(log((227.92e6)^3)-4, log(686.98^2), 'Marte')
hold on
text(log((778.57e6)^3)-4, log(4332.59^2), 'Jupiter')
hold on
text(log((1433.53e6)^3)-4, log(10759.22^2), 'Saturno')
hold on
text(log((2872.46e6)^3)-4, log(30685.40^2), 'Urano')
hold on
text(log((4495.06e6)^3)-4, log(60189.00^2), 'Neptuno')
hold on
plot(dom, f(dom));
