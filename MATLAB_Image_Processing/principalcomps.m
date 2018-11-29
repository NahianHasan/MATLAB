function P = principalcomps(X,q)

    %PR I N C I PALCOMPS P r incipal - component vectors and related quant ities .
    % P = P R I N C I PALCOMPS ( X , Q ) Compu t e s t h e principal - component
    % v e c t o r s of t h e v e c t o r population contained in t he rows of X , a
    % matrix of size K - by - n where K ( as sumed to be > 1 ) is t h e number
    % of vectors and n is t h e i r dimensio n a l it y . a , with values in the
    % range 1 0 , n ] , is t h e number of e igenvectors u sed in const ruct ing
    % t h e principal - compo n e n t s t ransformation mat rix . P is a st ructure
    % with the fol lowing f ields :
    %
    % P . Y     K - by - Q mat r ix whose columns a re t h e princ ipal compon
    %            e n t vecto r s .
    %
    % P . A      Q - by - n p r i n c ipal components t ra n s f o rmation matrix
    %           whose rows are the a eigenvec tors of ex c o r respond ing
    %           t o the a largest eigenvalues .
    %
    %
    % P . X      K - by - n matrix whose rows a r e the vectors
    %           reconstructedf rom t h e princ ipal - component vectors .
    %            P . X and P . Y are identical if Q = n .
    %
    %
    % P . ems    The mean s q u a re e r r o r i n c u r red in u s ing only the a
    %            eigenvectors c o r respond ing to t h e largest
    %            eigenvalu e s . P . ems is 0 if Q = n .
    %
    %
    % P . Cx     The n - by - n covariance mat rix of t h e population in X .

    % P . mx     The n - by - 1 mean v e c t o r of t h e population i n X .
    % P . Cy     The Q - by - Q covariance mat rix of the population in
    %           Y. The main diagonal contains the e igenvalues ( in
    %            descend ing orde r ) c o r responding to the a
    %            e igenvecto r s .
    %
    %
    %
    
    K = size(X, 1);
    X = double(X);
    
    % Obtain t h e mean vector and covariance matrix of t he vectors in X .
    [P.Cx, P.mx] = covmatrix(X);
    P.mx = P.mx'; %Convert mean vector to a row vector
    
    % Obtain t h e eigenvectors and corresponding eigenvalues o f Cx . The
    % eigenvectors are t h e columns of n - by - n matrix v . D is an n - by - n
    % d iagonal matrix whose eleme n t s a long t h e main diagonal are t h e
    % eigenvalues corresponding t o t h e eigenvectors i n V , s o t h at X * V =
    % D*V .
    [V, D] = eig(P.Cx);

    % Sort t h e eigenvalues in decreasing o rd e r . Rearrange t h e
    % e igenvectors t o match .
    d = diag(D);
    [d, idx] = sort(d);
    d = flipud(d);
    idx = flipud(idx);
    
    D = diag(d);
    V = V(:, idx);
    
    % Now form t h e q rows of A f rom t h e f i rst q columns of V .
    P.A = V(:, 1:q)';
    
    
    % Compute t h e principal component vectors .
    Mx = repmat(P.mx, K, 1);
    P.Y = P.A * (X - Mx)';
    
    %Obtain the reconstructed vectors
    P.X = (P.A' * P.Y)' + Mx;
    
    P.Y =  P.Y';
    P.mx = P.mx';
    
    % The mean square error is g iven by t h e sum of a l l t h e
    % e igenvalues m i n u s t h e s u m of t h e q largest eigenva l ue s .
    d = diag(D);
    P.ems = sum(d)- sum(d(1:q));
    
    
    %Covariance matrix of the Y's
    P.Cy = P.A * P.Cx * P.A';
    
end