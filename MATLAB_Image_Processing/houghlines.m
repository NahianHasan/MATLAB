function Lines = houghlines(f,theta,rho,rr,cc,fillgap,minlength)
    if nargin < 6
        fillgap = 20;
    end
    if nargin < 7
        minlength = 40;
    end
    
    numlines = 0;
    Lines = struct;
    
    for k = 1:length(rr)
        rbin = rr(k);
        cbin = cc(k);
        [r, c] = houghpixels(f, theta, rho, rbin, cbin);
        if isempty(r)
            continue;
        end
        omega= (90 - theta(cbin))*pi/180;
        T = [cos(omega) sin(omega);  -sin(omega) cos(omega)];
        xy = [r-1 c-1] * T;
        x = sort(xy(:,1));
        
        diff_x = [diff(x); Inf];
        idx = [0; find(diff_x > fillgap)];
        
        for p = 1:length(idx) - 1
            x1 = x(idx(p) + 1);
            x2 = x(idx(p+1));
            linelength = x2 - x1;
            if(linelength >= minlength)
                point1 = [x1 rho(rbin)];
                point2 = [x2 rho(rbin)];
                
                Tinv = inv(T);
                point1 = point1 * Tinv;
                point2 = point2 * Tinv;
                
                numlines = numlines + 1;
                Lines(numlines).point1 = point1 + 1;
                Lines(numlines).point2 = point2 + 1;
                Lines(numlines).length = linelength;
                Lines(numlines).theta = theta(cbin);
                Lines(numlines).rho = rho(rbin);
            end
        end
    end     
end

