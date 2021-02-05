syms x

dom = linspace(-3, 7);

orig = @(x) 3 * sin(pi*x/6);

inter = matlabFunction((3*x)/2 - (905051912390271*x*(x - 1))/4503599627370496 - (441695988904705*x*(x - 1)*(x - 2))/9007199254740992 + (8960769158908629*x*(x - 1)*(x - 2)*(x - 3))/1152921504606846976);


plot(dom, inter(dom))
hold on
plot(dom, orig(dom))
hold on
axis([-3, 7, -4, 4])
line([0,0], ylim, 'Color', 'k', 'LineWidth', 2)
line(xlim, [0,0], 'Color', 'k', 'LineWidth', 2) 
grid on

plot(0,orig(0),'*')
plot(1,orig(1),'*')
plot(2,orig(2),'*')
plot(3,orig(3),'*')
plot(4,orig(4),'*')
