function f = spfilt2(g,type,M,N,parameter)
    if nargin == 2
        M = N = 3;
        Q = 1.5;
        d = 2;
    elseif nargin == 5
        Q = parameter;
        d = parameter;
    elseif nargin == 4
        Q = 1.5;
        d = 2;
    else
        error('Wrong number of inputs');
    end
    
    switch lower(type)
        case 'amean'
            w = fspecial('average', [M N]);
            f = imfilter(g, w, 'replicate');
        case 'gmean'
            f = gmean(g, M, N);
        case 'hmean'
            f = hmean(g, M, N);
        case 'conmean'
            f = charmean(g,M,N,Q);
        case 'median'
            f = medfilt2(g, [M N], 'symmetric');
        case 'max'
            f = ordfilt2(g, M*N, ones(M,N), 'symmetric');
        case 'min'
            f = ordfilt2(g, 1, ones(M,N), 'symmetric');
        case 'midpoint'
            f1 = ordfilt2(g, M*N, ones(M,N), 'symmetric');
            f2 = ordfilt2(g, 1, ones(M,N), 'symmetric');
            f = imlincomb(0.5, f1, 0.5, f2);
        case 'atrimmed'
            if((d < 0) | (d/2 ~= round(d/2)))
                error('d must be a non-negative even integer');
            end
            f = atrimmed(g,M,N,d);
        otherwise
            error('Wrong type of filter out of scope of this filter function');
    end           
end

