function [C,  m] = covmatrix(X)

    %COVMATR I X Computes t h e covariance matrix and mean vecto r .
    % [ C , M l = COVMATR I X ( X ) computes t h e covariance mat rix C and t h e
    % mean vector M of a vector popu lation organized as t h e rows of
    % matrix X . This mat rix is of size K - by - N , where K is t h e number
    % of samples and N is t h e i r dimensionalit y . C is of size N - by - N
    % and M is of size N - by - 1 . If t h e population contains a single
    % s amp le , t h i s f u n c t ion outputs M = X and c as an N - by - N matrix of
    % NaN ' s because t h e d e f i n i t io n of an u nbiased e s t imate of the
    % covariance mat rix divides by K - 1 .
    
    K = size(X,1);
    X = double(X);
    
    %Compute the unbiased estimate of m
    m = sum(X,1) / K;
    
    %Subtract the mean from each row of X
    X = X - m(ones(K,1), :);
    
    % Compute an u n biased e s t imate of C . Note t hat the p roduct i s X ' *X
    % because the v e c t o r s a re rows of X .
    C = (X'*X)/(K-1);
    
    m = m';
    
end
   
