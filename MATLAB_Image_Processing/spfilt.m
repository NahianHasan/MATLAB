function f = spfilt(g,'type',m, n, parameter)
    if nargin == 2
        m = 3;
        n = 3;
        Q = 1.5;
        d = 2;
    elseif nargin == 5
        Q = prameter;
        d = parameter;
    elseif nargin == 4
        Q = 1.5;
        d = 2;
    else
        error('Wrong Number of Inputs');
    end
    switch type
        case 'amean'
            w = fspecial('average',[m n]);
            f = imfilter(g, w, 'replicate');
        case 'gmean'
            f = gmean(g, m, n);
        case 'hmean'
            f = harmean(g, m, n);
        case 'chmean'
            f = charmean(g, m, n ,Q);
        case 'median'
            f = medfilt2(g,[m n], 'symmetric');
        case 'max'
            f = ordfilt2(g, m*n, ones(m,n), 'symmetric');
        case 'min'
            f = ordfilt2(g, 1, ones(m,n), 'symmetric');
        case 'midpoint'
            f1 = ordfilt2(g, 1, ones(m,n), 'symmetric');
            f2 = ordfilt2(g, m*n, ones(m,n), 'symmetric');
            f = imlincomb(0.5, f1, 0.5, f2);
        case 'attrimmed'
            if(d < 0 | ((d/2) ~= round(d/2)))
                error('d must be nonnegative or even integer');
            end
            f = alphatrim(g, m, n, d);
        otherwise
            error('Unknown type of Filter type');
    end                
end

