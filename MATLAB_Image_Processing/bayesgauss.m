function d = bayesgauss(X, CA, MA, P)

    %BAYESGAUSS Bayes classifier f o r Gau s s i a n patte r n s .
    % D = BAYESGAUSS ( X , CA , MA , P ) computes t h e Bayes decision
    % f u n c t ions of t h e n - dimensional p a t t e r n s in t h e rows of X . CA is
    % an array of size n - by - n - by -W c o n t a i n i n g W covariance mat rices of
    % size n - by - n , where W is the number of c l a s s e s . MA is an a r ray of
    % size n - by -W , whose columns a r e t h e c o r responding mean vecto r s . A
    % covariance mat rix and a mean v e c t o r must be specified f o r each
    % class . X is of size K - by - n , where K is t h e number of p a t t e r n s
    % to be classif ied . P is a 1 - by - W a r ray , c o n t a i n i n g t h e
    % p robabilities of occ u r rence of each c l as s . I f P is not included
    % in t h e a rgument , t he classes a r e as sumed to be equally l i k e ly .
    %
    % D is a column vector of length K . I t s ith e lement is t h e c l a s s
    % number a s s igned to t h e ith vector in X d u r ing c l a s s if icat ion .

    error(nargchk(3,4,nargin));
    n = size(CA, 1);
    
    % P rotect against the possibility t h at t h e c l a s s number is included
    % as an (n + 1 ) t h element of t h e vectors .
    X = double(X(:,1:n));
    W = size(CA,3);
    K = size(X,1);
    
    if nargin == 3
        P(1:W) = 1/W;
    else
        if sum(P) ~= 1
            error('Elements of P must sum to 1');
        end
    end
    
    for J = 1:W
        DM(J) = det(CA(:,:,J));
    end
    
    % Evaluate the decision f u n c t io n s . Note the use of f u n c t ion
    % mahalanobis d i s c u ssed in Section 1 3 . 2 .
    MA = MA';
    for J = 1:W
        C = CA(:,:,J);%selecting the covariance matrix
        M = MA(J,:); % selecting the mean vector
        L(1:K,1) = log(P(J));
        DET(1:K,1) = 0.5*log(DM(J));
        if P(J) == 0
            D(1:K,J) = -Inf;
        else
            D(:,J) = L - DET - 0.5*mahalanobis(X, C, M);
        end
    end
    
    % Find the coordinates of the max imum value in each row . These
    % max ima give the class of each pattern .
    [i, j] = find(bsxfun(@eq,D,max(D, [], 2)));%max ( D , ( ] , 2 ) finds lhc maximum of 0 along its second dimension (its rows). The result is <:1 veclor of size size ( D , 1 ) - by - 1 .
    
    % Re - use X . I t c o n t a i n s now t h e max value along each column .
    X = [i j];
    
    % E l iminate multiple c l a s s if ications of the same patte rns . Since
    % the class a s s ignment when two o r more decision f u nctions give
    % the same value is a r b i t rary , we need to keep only one
    X = sortrows(X);
    [b, m] = unique(X(:,1));
    X = X(m, :);
    
    % X is now sorted , with t h e 2nd column giving t h e class of the
    % pattern number in t h e 1 st co l . ; i . e . , X ( j , 1 ) ref e r s to the j t h
    % input pattern , and X ( j , 2 ) is its class number .
    
    % O u t p u t t h e result of c l a s s if ication . d is a column vector wit h
    % length equal to t h e t o t a l number of input pattern s . The elements
    % of d are t h e classes i n t o which t h e patterns were c l a s s if ied .
    
    d = X(:,2);
    
end

