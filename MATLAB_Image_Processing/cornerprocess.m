function cp = cornerprocess(c,T, q)

    %CORNERPROCESS Processes t h e out put of functio n cornermetric .
    % CP = CORNERPROCESS ( C , T , Q ) postprocesses C , t h e o u t p u t of
    % f u n c t ion CORNERMETR I C , with t h e o b j ect ive of reducing t h e
    % number of irrelevant c o r n e r p o i n t s (with respect to t h re s h o ld T )
    % and the number of multiple c o r n e r s in a neighbo rhood of size
    % Q - by - Q . If t h e re are multiple c o r n e r p o i n t s c o n t a ined within
    % that n e ighborhood , they are e roded morphologically to one c o r n e r
    % point .
    %
    % A corner point is said to have been found at coordinates ( I , J )
    % if C ( I , J ) > T .
    %
    % A good practice is to n o rmalize t h e v a l u e s of C to t h e range [ O
    % 1 ] , in im2double f o rmat before inputt ing C into t h i s f u nct ion .
    % This facilitates inte rpretation of t h e r e s u l t s and makes
    % t h resholding more intuitive .

    
    %perform thresholding
    cp = c > T;
    
    %dilate cp to incorporate neighbours
    B = ones(q);
    cp = imdilate(cp, B);
    
    %shrink connecte dcomponents to single points
    cp = bwmorph(cp, 'shrink', Inf);
    
end
    
    
    
 
