function output = fixedPointV2(aFunction, lowerLimit, upperLimit, initalPoint, iterations)
  output = fixedPoint(aFunction, lowerLimit, upperLimit, initalPoint, iterations);
  if isnan(output)
    return;
  else
    visualVerification(aFunction, lowerLimit, upperLimit);
  end
 end