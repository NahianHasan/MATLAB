function [p, npix] = histroi(f,c,r)%computes the histogram of a ROI in an image
    B = roipoly(f , c, r);
    p = imhist(f(B));%computes the histogram of image f in the ROI
    if nargout > 1
        npix = sum(B(:));%obtain the number of pixels in the ROI if requested in the output
    end
end

