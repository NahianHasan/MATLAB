function  rmse = compare(f1,f2,scale)
    error(nargchk(2,3,nargin));
    if nargin < 3
        scale = 1;
    end
    
    e = double(f1) - double(f2);
    [M, N] = size(e);
    rmse = sqrt(sum(e(:) .^ 2) / (M*N));
    
    if rmse
        emax = max(abs(e(:)));
        [h, x] = hist(e(:), emax);
        if length(h) >= 1
            figure; bar(x,h,'k');
            emax = emax / scale;
            e = mat2gray(e, [-emax, emax]);
            figure;
            imshow(e);
        end
    end
    
end

