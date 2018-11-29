function HSI = rgb2hsi(rgb)

    rgb = im2double(rgb);
    r = rgb(:,:,1);
    g = rgb(:, :, 2);
    b= rgb(:,:,3);
    
    num = 0.5 * ((r-g)+(r-b));
    den = sqrt((r-g).^2 + (r-b).*(g-b));
    theta = acos(num./den);
    
    H = theta;
    H(b>g) = 2*pi - H(b>g);
    H = H/(2*pi);
    
    num2 = min(min(r,g),b);
    av = (r+g++b);
    S = 1 - 3.*num2./av;
    
    H(S == 0) = 0;
    
    I = (r+g+b)/3;
    
    HSI = cat(3,H,S,I);

end

