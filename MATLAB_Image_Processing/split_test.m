function v = split_test(B,mindim,fun)

    k = size(B,3);% k is the number of regions in B at this point in the procedure
    
    v(1:k) = false;
    for I = 1:k
        quadregion = B(:,:,k);
        if size(quadregion,1) <= mindim
            v(I) = false;
            continue;
        end
        flag = feval(fun, quadregion);
        if flag 
            v(I) = true;
        end
    end
end

