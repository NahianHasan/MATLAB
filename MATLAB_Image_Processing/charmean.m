function f = charmean(g,m,n ,Q)
    inclass = class(g);
    g = im2double(g);
    f = imfilter(g.^(Q+1), ones(m,n), 'replicate');
    f = f./ (imfilter(g.^Q, ones(m, n), 'replicate') + eps);   
    f = changeclass(inclass, f);
end

