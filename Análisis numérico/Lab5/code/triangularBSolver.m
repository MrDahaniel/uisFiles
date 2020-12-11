function output = triangularBSolver(A, B)
    [vert, hori] = size(A);
    [alt, anc] = size(B);

    if vert == hori && vert == alt && anc == 1 %VerificaciÃ³n de parÃ¡metros%
        [L, U] = triangularFac(A);

        y(1,1) = B(1,1);
        y(2,1) = B(2,1) - y(1,1)*L(2,1);
        y(3,1) = B(3,1) - y(1,1)*L(3,1) - y(2,1)*L(3,2);

        x(3,1) = (y(3,1))/U(3,3);
        x(2,1) = (y(2,1)-x(3,1)*U(2,3))/U(2,2); 
        x(1,1) = (y(1,1)-x(3,1)*U(1,3)-x(2,1)*U(1,2))/U(1,1);

        output = x;
    end
end