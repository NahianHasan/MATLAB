function Fixpnt = fixed_point_iteration(x0,emax,imax,g)

    xr = x0;
    iter = 0;
    ea = 100;
    
    while((ea > emax) | (iter < imax))
        xrold = xr;
        xr = g(xrold);
        iter = iter + 1;
        if xr ~= 0
            ea = abs((xr-xrold)/xrold) * 100;
        end
    end
    Fixpnt = xr;
end

