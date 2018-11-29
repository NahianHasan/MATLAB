function sum_y = double_integral(xl,xh,yl,yh,del_x,del_y)

    f = inline('exp(2*x - y)','x','y');
    
    Y = [];
    sum_y = 0;
    for j = yl:del_y:yh
        sum_x = ((f(xl,j)+f(xh,j))/2 + sum(f(xl+del_x:del_x:xh-del_x,j)))*del_x;
        Y = [Y sum_x];
    end
    
    sum_y = (Y(1)+Y(end)+2*sum(Y(2:end-1)))* (del_y/2);
end

