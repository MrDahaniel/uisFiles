photos = [10 15 40; 1 -1 -1; 0 1 -2];
values = [300; 0; 0];

[L, U] = luFact(photos);

triangularBSolver(photos, values) 