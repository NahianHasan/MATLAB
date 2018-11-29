function t = statxture(f, scale)

    %STATXTURE Computes statistical measures of texture in an image .
    % T = STATXURE ( F , SCAL E ) compute s s i x measures of t e x t u re f rom an
    % image ( region ) F . Pa ramet e r SCALE is a 6 - d im row vector whose
    % e lement s mult iply t h e 6 co rresponding elements of T f o r scaling
    % purposes . If SCALE is not provided it defaults to all 1 s . The
    % output T is 6 - by - 1 v e c t o r wit h the following e lemen t s :
        % T ( 1 ) Ave rage gray l e v e l
        % T ( 2 ) Ave rage cont rast
        % T ( 3 ) Measure of smoot hness
        % T ( 4 ) Third moment
        % T ( S ) Measure of u n i f o rmity
        % T ( 6 ) E n t ropy

        if nargin == 1
            scale(1:6) = 1;
        else
            scale = scale(:);
        end
        
        %Obtain histogram and normalize it
        p = imhist(f);
        p = p./ numel(f);
        L = length(p);
        
        %Compute the first three moments
        [v, mu] = statmoments(p, 3);
        
        %Compute the six texture measures
        %Average gray level
        t(1) = mu(1);
        
        %Standard deviation
        t(2) = sqrt(mu(2));
        
        %Smoothness
        t(3) = 1 - (1 / (1 + (mu(1) / (L - 1)^2)));
        
        %Third moment
        t(4) = mu(3) / (L - 1)^2;
        
        %Uniformity
        t(5) = sum(p.^2);
        
        %Entropy
        t(6) = -sum(p .* (log2(p + eps)));
        
        
        %scale the values
        t = t.* scale;
       
end

