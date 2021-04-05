function [L, U] = luFact(inTrix)
  [vert, hori] = size(inTrix);
  L = NaN;
  U = NaN;
  counter = 1;

  if vert == hori
    U = inTrix;
    L = eye(vert, hori);

    for outer = 1:hori
      counter = counter + 1;

      temp = U(outer, :);
      tempFac = temp / temp(outer);

      for subber = counter:vert
        aux = tempFac * U(subber, outer);
        L(subber, outer) = aux(1, outer) / temp(outer);
        U(subber, :) = U(subber, :) - aux;
      end
    end
  end
end
