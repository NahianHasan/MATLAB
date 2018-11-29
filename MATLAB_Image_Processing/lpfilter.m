function [H,D] = lpfilter(type, M, N, Do, n)
    [U,V] = dftuv(M,N);
    D = sqrt(U.^2 + V.^2);
    switch type
        case 'ideal'
            H = double(D <= Do);
        case 'btw'
            if nargin == 4
                n = 1;
            end
            H = 1 ./ (1 + (D./Do).^(2*n));
        case 'gaussian'
            H = exp(-(D.^2)./(2*(Do^2)));
        otherwise 
            error('Unknown Filter Type')
    end    
end

