function [y,n] = my_conv(x,nx,h,nh)

    n= (min(nx)+min(nh)):(max(nx)+max(nh));
    
    Y = [];
    for i =1:length(n)
        [new_h,new_n] = sigfold(h,nh);
        [new_h,new_n] = sigshift(new_h,new_n,n(i));
        new_y = sigmul(x,new_h,nx,new_n);
        temp = sum(new_y(:));
        Y = [Y temp];
    end
    
    y = Y;
end