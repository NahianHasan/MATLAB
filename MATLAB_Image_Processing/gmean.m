function f = gmean(g,m,n)
    inclass = class(g);
    g = im2double(g);
    warning off;
    f = exp(imfilter(log(g), ones(m, n), 'replicate').^(1/m/n));
    warning on;
    f = changeclass(inclass, f);
end

