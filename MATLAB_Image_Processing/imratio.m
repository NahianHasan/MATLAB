function cr = imratio(f1,f2)
    error(nargchk(2,2,nargin));
    cr = bytes(f1) / bytes(f2);
end

