function root = bisection(f,xlower,xupper,tol)

    ylower = f(xlower);
    xmid = (xlower+xupper)/2;
    ymid = f(xmid);
    
    iter = 0;
    while((xupper-xlower)/2 > tol)
        iter = iter + 1;
        if(ylower*ymid > 0)
            xlower = xmid;
        elseif(ylower*ymid < 0)
            xupper = xmid;
        else
            root = xmid;
            return;
        end
        root = xmid;
        xmid = (xlower+xupper)/2;
        ymid = f(xmid);
    end    
end

