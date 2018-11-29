function [r,c,hnew ] = houghpeaks(H,numpeaks,threshold,nhood)
    if nargin < 4
        nhood = size(H)/50;
        nhood = max(2*ceil(nhood/2)+1,1);
    end
    if nargin < 3
        threshold = 0.5*max(H(:));
    end
    if nargin < 2
        numpeaks = 1;
    end
    
    done = false;
    hnew = H;
    r = [];
    c = [];
    
    while ~done
        [p,q] = find(hnew == max(hnew(:)));
        p = p(1);
        q = q(1);
        if hnew(p,q) >= threshold
            r(end+1) = p;
            c(end+1) = q;
            
            p1 = p - (nhood(1) - 1)/2;
            p2 = p + (nhood(1) - 1)/2;
            q1 = q - (nhood(2) - 1)/2;
            q2 = q + (nhood(2) - 1)/2;
            
            [pp, qq] = ndgrid(p1:p2,q1:q2);
            pp = pp(:);
            qq = qq(:);
            
            badrho = find((pp < 1) | (pp > size(H,1)));
            pp(badrho) = [];
            qq(badrho) = [];
            
            theta_too_low = find(qq < 1);
            qq(theta_too_low) = size(H,2) + qq(theta_too_low);
            pp(theta_too_low) = size(H,1) - pp(theta_too_low) + 1;
            theta_too_high = find(qq > size(H,2));
            qq(theta_too_high) = qq(theta_too_high) - size(H,2);
            pp(theta_too_high) = size(H,1) - pp(theta_too_high) + 1;
            
            hnew(sub2ind(size(hnew)), pp, qq) = 0;
            
            done = length(r) == numpeaks;
        else
            done = true;
        end
    end
end

