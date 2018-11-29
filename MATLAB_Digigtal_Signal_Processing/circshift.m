function [y,x] = circshift(x,m,N)
    
    x = [x zeros(1,N-length(x))];
    n=0:N-1;
    n = mod(n-m,N);
    y=x(n+1);
    

end

