function B = bound2im(b,M,N,x0,y0)

    %BOUND2IM Converts a boundary t o an image.
    % B = BOUND2IM(b) converts b, an np-by-2 or 2-by-np array
    % representing t h e i n t e g e r coordinates of a boundary, i n t o a binary
    % image with 1s i n t h e l o c a t i o n s defined by the coordinates i n b
    % and 0s elsewhere.
    %
    % B = BOUND21M(bJ M, N) places the boundary approximately centered
    % i n an M-by-N image. If any part of the boundary i s outside the
    % M-by-N rectangle, an error i s issued.
    %
    % B = BOUND2IM(b, M, N, XO, YO) places the boiindary i n an image of
    % size M-by-N, with the topmost boundary point: located at XO and
    % the leftmost point located at YO. If the shi.fted boundary i s
    % outside the M-by-N rectangle, an error i s issued. XO and XO must
    % be p o s i t i v e integers.
    
    [np, nc] = size(b);
    if np < nc
        b = b'; %to convert to size np-by-2;
        [np, nc] = size(b);
    end
    
    %make sure the coordinates are integers
    x = round(b(:,1));
    y = round(b(:,2));
    
    %set up the default size parameters
    x = x - min(x) + 1;
    y = y - min(y) + 1;
    B = false(max(x), max(y));
    C = max(x) - min(x) + 1;
    D = max(y) - min(y) + 1;
    
    if nargin == 1
        %use the preceeding default values
        x = x - min(x) + 1;
        y = y - min(y) + 1;
        B = false(max(x), max(y));
        C = max(x) - min(x) + 1;
        D = max(y) - min(y) + 1;
    elseif nargin == 3
        if C>M | D>N
            error('The boundary is out of the M-by-N region');
        end
        %The image size will be M-by-N.Set up the parameters for this
        B = false(M,N);
        %Distribute extra rows approx. even between top and bottom
        NR = round((M-C)/2);
        NC = round((N-D)/2); %The same collumns
        x = x + NR; %Offset the boundary to new position
        y = y + NC;
    elseif nargin == 5
        if x0<0 | y0<0
            error('x0 and y0 must be positive integers');
        end
        x = x + round(x0) -1;
        y = y + round(y0) - 1;
        C = C + x0 - 1; 
        D = D + y0 - 1;
        if C>M | D>N
            error('The sifted boundary is out of the M-by-N region');
        end
        B = false(M,N);
    else
        error('Incorrect number of Inputs');
    end
    
    B(sub2ind(size(B),x,y)) = true;
    
end

