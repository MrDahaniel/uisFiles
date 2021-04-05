vals = [-8 6.8; -2 5.0; 0 2.2; 4 0.5; 6 -1.3];

f = lsquare(vals)
f = matlabFunction(f);
[n, ~] = size(vals);

funVal = [];
for index = 1:n
    funVal = [funVal; f(vals(index,1))];
end

funVal