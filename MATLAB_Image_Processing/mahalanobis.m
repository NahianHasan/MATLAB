function D = mahalanobis(varargin)

    %MAHALANO B I S Compu t e s t h e Mahalanobis distance .
    % D = MAHALANOB IS ( Y , X ) computes t h e Mahalanobis distance between
    % each v e c t o r in Y to t h e mean ( c ent roid ) of t h e vectors in X , and
    % o u t p u t s t h e result in vector D , whose length is size ( Y , 1 ) . The
    % vectors in X and Y a r e as s umed to be organized as rows . The
    % input d a t a can be real or complex . The outputs are real
    % qu antities .
    %
    % D = MAHALANOB I S ( Y , CX , MX ) compu tes t h e Mahalanobis distance
    % between each v e c t o r in Y and t h e given mean vect o r , MX . The
    % r e s u l t s a r e output in v e c t o r D , whose length is size ( Y , 1 ) . The
    % vectors in Y a r e as sumed to be o rganized as t h e rows of t h is
    % a r ray . The input d a t a c a n be real or complex . The outputs are
    % real q u a n t i t i e s . I n addition to t h e mean vector MX , t h e
    % covariance m a t r i x ex of a population of vectors X must be
    % p rovided also . Use f u n c t io n COVMAT R I X ( Section 1 2 . 5 ) to compute
    % MX and ex .
    % Referen c e : Ack lam , P . J . [ 2002 ] . " MATLAB Array Manipulat ion Tips
    % and Tric k s , " available at
    % home . on l i n e . no / -p j acklam / ma t l a b / doc / mtt / index . html
    % o r in t h e Tutorials s e c t i o n at
    % www. image processingplace . com

    param = varargin; %param is a cell array
    Y = param{1};
    
    if length(param) == 2
        X = param{2};
        [Cx, Mx] = covmatrix(X);
    elseif length(param) == 3
        Cx = param{2};
        Mx = param{3};
    else
        error('Wrong number of inputs');
    end
    
    Mx = Mx(:)'; % for making Mx a row vector
    
    Yc = bsxfun(@minus, Y, Mx);
    
    D = real(sum(Yc/Cx .* conj(Yc), 2));   
    
end

