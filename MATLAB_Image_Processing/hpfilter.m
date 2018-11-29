function H = hpfilter(type, M, N, Do, n)
    if nargin == 4
        n = 1;
    end
    Hlp = lpfilter(type, M,N,Do,n);
    H = 1 - Hlp;
end

