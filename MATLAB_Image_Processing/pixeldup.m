function  B = pixeldup(A, m, n)
    if nargin < 2
        error('Minimum number of inputs to the function is 2');
    end
    if nargin == 2
        n = m;
    end
    
    u = 1:size(A,1);
    m = round(m);
    u = u(ones(1,m),:);
    u = u(:);
    
    v = 1:size(A,2);
    n = round(n);
    v = v(ones(1,n), :);
    v = v(:);
    
    B = A(u, v);
    
end

