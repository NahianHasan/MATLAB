function result = false_position(f,xlower,xupper,tol)

    ylower = f(xlower);
    xmid = (f(xlower)*xupper - f(xupper)*xlower)/(f(xlower) - f(xupper));
    ymid = f(xmid);
    
    iter = 0;
    for i = 1:10000
        if((xupper-xlower)/2 > tol)
            iter = iter+ 1;
            if(ylower*ymid > 0)
                xlower = xmid;
            elseif(ylower*ymid < 0)
                xupper = xmid;
            else
                result = xmid;
                return;
            end
            xmid = (f(xlower)*xupper - f(xupper)*xlower)/(f(xlower) - f(xupper));
            result = xmid;
            ymid = f(xmid);
        else
            result = xmid;
        end
    end
end

