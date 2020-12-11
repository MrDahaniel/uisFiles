
A = [ 1    2   -3    4;
      4    8   12   -8;
      2    3    2    1;
     -3   -1    1   -4];

B = [3; 60; 1; 5];

triangularSolver(A,B)


moddedA = [ 1    2   -3    4;
            2    3    2    1;
            -3   -1    1  -4;
            4    8   12   -8];

moddedB = [3; 1; 5; 60];

triangularSolver(moddedA, moddedB)