function h = entropy(x,n)
    error(nargchk(1,2,nargin));
    if nargin < 2
        n = 256;
    end
    
    x = double(x);
    xh = hist(x(:), n);
    xhp = xh / sum(x(:));
    
    idx = find(xhp);
    
    h = - sum(xh(idx) .* log2(xhp(idx)));
    
end

