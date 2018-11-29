function [X, R] = imstack2vectors(S,MASK)

    %I MSTACK2VECTORS E x t racts vectors from an image stac k .
    % [ X , R ] = imstack2vect o rs ( S , MASK) e x t racts vectors f rom S , which
    % is an M - by - N - by - n s t a c k a r ray of n registered imag es of size
    % M - by - N each ( see Fig . 1 2 . 29 ) . The ext racted vectors are a r ranged
    % as t h e rows of a r ray X . I n put MASK is an M - by - N logical o r
    % numeric image wit h n o n z e r o v a l u e s ( 1 s if it is a logical a r ra y )
    % in t h e l o c a t i o n s where elements of S are to be u sed in f o rming X
    % and Os in locations to be ignored . The number of row vectors in
    % x is e q u a l t o t h e number of n o n z e ro elements of MASK . If MASK is
    % omitted , a l l M * N locations are used in f o rming X . A s imple way
    % t o obtain MASK i n t e r ac t ively is to use f u nction roipoly .
    % F i n a l l y , R is a column v e c t o r t h a t contains the linear indices
    % of t h e locations of t h e v e c t o r s ext racted f rom S .
    
    [M, N, n] = size(S);
    if nargin == 1
        MASK = true(M,N);
    else
        MASK = MASK ~= 0;
    end
    
    % Find the l i n e a r indices of the 1 - valued elemen t s in MASK . Each
    % element of R identifies t h e location i n t h e M - by - N a r ray of the
    % vector ext racted f rom S .
    R = find(MASK);
    
    %now find X
    % First reshape S into X by t u r n i n g each set o f n values along t h e
    % third dimension of S so that it becomes a r o w of x . The o rd e r is
    % f rom top t o bottom along the f i r s t column , t h e second c olumn , and
    % so on .
    Q = M*N;
    X = reshape(S, Q, n);
    
    % Now reshape MASK so that it c o rresponds to t h e right locations
    % vertically along t h e eleme n t s of X .
    MASK = reshape(MASK,Q,1);
    
    % Keep the rows of X at locations where MASK i s not O .
    X = X(MASK, :);

end

