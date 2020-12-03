function [output] = intervalFinder(aFunction)
    if isa(aFunction,'function_handle')

        negTracer = 0;
        posTracer = 0;
        
        lowerIndex = 1;
        upperIndex = 1500;
        
        for index = lowerIndex:upperIndex        
            negLead = index*(-1)-1;
            posLead = index+1;
            
            if aFunction(negLead)*aFunction(negTracer) < 0
                output = [negLead negTracer];
                return;
            elseif aFunction(posTracer)*aFunction(posLead) < 0
                output = [posTracer posLead];
                return;
            else
                %do nothing, keep the loop
            end

            negTracer = index*(-1);
            posTracer = index;
        end
    disp('Interval not found!')    
    else
        disp('Given parameters are invalid! Check params and try again')
    end

end