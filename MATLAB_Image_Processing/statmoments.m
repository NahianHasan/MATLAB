function [v,unv] = statmoments(p,n)

    %STATMOMENTS Computes statistical central moments o f image histogram .
    % [ W , UNV ] = STATMOMENTS ( P , N ) compu t e s up t o t h e N t h s t a t i s t i c a l
    % cent ral mome nt of a histog ram whose compon e n t s a r e in v e c t o r
    % P . The lengt h of P must equal 256 or 65536 .
    %
    % The p rogram outputs a vector V with V ( 1 ) = mean , V ( 2 ) = v a r iance ,
    % V ( 3 ) = 3rd moment , . . . V ( N ) = Nth c e n t r a l moment . The random
    % variable values are n o rmalized to t h e range [ O , 1 ] , so a l l
    % moments also are in t h i s range .
    %
    % The p rog ram also outputs a vector UNV containing t h e same momen t s
    % as V , but using u n - n o rmalized random v a r i able values ( e . g . , O to
    % 255 if lengt h ( P ) = 2 " 8 ) . For ex ample , if l e n g t h ( P ) = 256 and V ( 1 )
    % = 0 . 5 , t hen UNV ( 1 ) would have t h e value UNV ( 1 ) = 1 27 . 5 ( h alf of
    % the [ O 255 ] range ) .
    Lp = length(p);
    if (Lp ~= 256 ) && (Lp ~= 65536)
        error('P must be a 256 or 65536 element vector');
    end
    G = Lp - 1;
    
    % Make s u re t h e h i s t og ram has u n it area , and c o n v e rt it to a
    % column vecto r .
    p = p / sum(p);
    p = p(:);
    
    % Form a vector of all t h e possible values of t h e
    % random va riable .
    z = 0:G;
    
    %normalize the z
    z = z./ G;
    
    %mean
    m = z*p;
    
    %Center random variables about the mean
    z = z- m;
    
    %Compute the central Moments
    v = zeros(1,n);
    v(1) = m;
    for j = 2:n
        v(j) = (z.^j)*p;
    end
    
    if nargout > 1
        %Compute the uncentralized moments
        unv = zeros(1, n);
        unv(1) = m.* G;
        for j = 2:n
            unv(j) = ((z*G).^ j) * p;
        end
    end
end

