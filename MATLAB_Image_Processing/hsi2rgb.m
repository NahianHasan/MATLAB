function RGB = hsi2rgb(hsi)
    H = hsi(:,:,1);
    S = hsi(:,:,2);
    I = hsi(:,:,3);
    
    R = zeros(size(hsi,1), size(hsi,2));
    G = zeros(size(hsi,1), size(hsi,2));
    B = zeros(size(hsi,1), size(hsi,2));
    
    %RG Sector
    idx = find((0 <= H) & (H < (2*pi/3)));
    B(idx) = I(idx) .* (1 - S(idx));
    R(idx) = I(idx) .* (1 + (S(idx).*cos(H(idx))) ./ cos(pi/3 - H(idx)));
    G(idx) = 3*I(idx) - (R(idx) + B(idx));
    
    %GB Sector
    idx = find((2*pi/3 <= H) & (H < (2*pi/1.5)));
    R(idx) = I(idx) .* (1 - S(idx));
    G(idx) = I(idx) .* (1 + (S(idx).*cos(H(idx))) ./ cos(pi/3 - H(idx)));
    B(idx) = 3*I(idx) - (R(idx) + G(idx));
    
    %BR Sector
    idx = find((2*pi/1.5 <= H) & (H < (2*pi)));
    G(idx) = I(idx) .* (1 - S(idx));
    B(idx) = I(idx) .* (1 + (S(idx).*cos(H(idx))) ./ cos(pi/3 - H(idx)));
    R(idx) = 3*I(idx) - (G(idx) + B(idx));
    
    RGB = cat(3,R,G,B);
    RGB = max(min(RGB,1), 0);
    
end

