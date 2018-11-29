function [g, NR, SI, TI] = regiongrow(f,S,T)
    f = double(f);
    if numel(S) == 1
        SI = f == S;
        S1 = S;
    else
        SI = bwmorph(S, 'shrink', Inf);
        J = find(SI);
        S1 = f(J);%array of seed values
    end
    
    TI = false(size(f));
    for k = 1:length(S1)
        seedvalue = S1(k);
        S = abs(f - seedvalue) <= T ;
        TI = TI | S;
    end
    
    [g, NR] = bwlabel(imreconstruct(SI,TI));
    
end

