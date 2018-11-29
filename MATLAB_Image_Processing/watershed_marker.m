function [wi, rm, fim, em] = watershed_marker(f,k,a,b)
    %this function implements the technique of watershad transform on the
    %gradient image by using both internal and external markers

    %f = input image
    %h = mask to be used in determining the gradient image
    %k = threshold to be used by imextendmin() function
    %a = superimposing constant value in extended minima on the original
    %     image
    %b = superimposing constant value in watershed ridge on the original
    %     image
    
    %wi = final segmented image
    %rm = an image showing all regional minima in a gradient image of a
    %   image
    %fim = internal markers
    %em = external markers
     
    p = fspecial('sobel');
    fd = double(f);
    g = sqrt(imfilter(fd,p,'replicate').^2 + imfilter(fd, p', 'replicate').^ 2);
    
    rm = imregionalmin(g);
    
    im = imextendedmin(f,k);
    fim = f;
    fim(im) = a;
    
    
    Lim = watershed(bwdist(im));
    em = Lim == 0;
    
    g2 = imimposemin(g, im | em);
    L2 = watershed(g2);
    wi = f;
    wi = L2 == 0;
    
end

