function [newtonpoly] = newton(x,y)
    %A MATLAB function for implementing the Newton Polynomial interpolation
    %Outputs   :   newtonpoly = computed coefficients of newton polynomial
    %              
    %Parameters:            x = a 1*M vector of x values of datapoints
    %                       y = a 1*M vector of y values of datapoints
    %                       x1 = the point at which the polynomial is to be
    %                            computed
    
    M = length(x);
    D = zeros(M,M);%a M*M matrix of zeros;
    x = x';
    D(:,1) = y';
    
    for j = 2:M
        for i = j:M
            D(i,j) = (D(i,j-1) - D(i-1,j-1)) / (x(i,1) - x(i-j+1,1)); %computing divided difference values
        end
    end
    d = diag(D);%diagonal values of D matrix which are to be used in the main newton polynomial equation
    
    sum = 0;
    for i = 2:M
        c = 1;
        for j = 1:i-1
            c = conv(c,poly(x(j)));
        end
        c1 = c*d(i);
        c
        for k = 1:M-i
            c1 = [0 c1];
        end
        c1
        sum = sum + c1;
    end
    
    s = d(1);
    for i = 1:M-1
       s = [0 s];
    end
    newtonpoly = sum + s;
    
end

