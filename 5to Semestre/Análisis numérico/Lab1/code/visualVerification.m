function output = visualVerification(aFunction, lowerLimit, upperLimit)
  %Check inputs for errors%
  if (isa(aFunction, 'function_handle') && (lowerLimit < upperLimit))
    domain = [lowerLimit, upperLimit];
    range = aFunction;

    straightLineFunction = @(x)x;

    fplot(range, domain)
    hold on
    fplot(straightLineFunction, domain)

    set(get(gca, 'XLabel'), 'String', 'X');
    set(get(gca, 'YLabel'), 'String', 'Y');
    set(get(gca, 'Title'), 'String', 'Visual Verification');
  else 
    warning('Error! Given arguments for function visualVerification are not valid!')
    output = NaN;
  end
end