function output = lsquare(pointMatrix)

    syms x

    output = NaN;

    [vS, hS] = size(pointMatrix);

    if hS == 2 && vS > 1
        sumX = sum(pointMatrix(:,1))
        sumY = sum(pointMatrix(:,2))
        sumX2 = sum(pointMatrix(:,1).^2)
        sumXY = sum(pointMatrix(:,1).*pointMatrix(:,2))
        N = vS;

        coTrix = [sumX2, sumX; sumX, N];
        anTrix = [sumXY; sumY];

        vals = linsolve(coTrix, anTrix)

        output = vals(1)*x+vals(2);
    end
end

