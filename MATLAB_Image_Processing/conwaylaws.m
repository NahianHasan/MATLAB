function out = conwaylaws(nhood)
    num_nhood = sum(nhood(:)) - nhood(2,2);
    
    if nhood(2,2) == 1
        if num_nhood <= 1
            out = 0;
        elseif num_nhood >= 4
            out = 0;
        else
            out = 1;
        end
    else
        if num_nhood == 3
            out = 1;
        else 
            out = 0;
        end
    end
end

