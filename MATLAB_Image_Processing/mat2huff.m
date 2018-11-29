function y = mat2huff(x)
    if ndims(x) ~= 2| ~isreal(x) | (~isnumeric(x) & ~islogical(x))
        error('X must be a 2-D real numeric or logical matrix');
    end
    
    %size
    y.size = uint32(size(x));
    
    %minimum and maximum
    x = round(double(x));
    xmin = min(x(:));
    xmax = max(x(:));
    pmin = double(int16(xmin));
    pmin = uint16(pmin + 32768);
    y.min = pmin;
    
    %histogram
    x = x(:)';
    h = histc(x,xmin:xmax);
    if(max(h) > 65535)
        h = 65535 * h / max(h);
    end
    h = uint16(h);
    y.hist = h;
    
    %coding
    map = huffman(double(h));
    hx = map(x(:) - xmin + 1);
    hx = char(hx)';
    hx = hx(:)';
    hx(hx == ' ') = [];
    ysize = ceil(length(hx) / 16);
    hx16 = repmat('0', 1, ysize*16);
    hx16(1:length(hx)) = hx;
    hx16  = reshape(hx16, 16, ysize);
    hx16 = hx16' - '0';
    twos = pow2(15:-1:0);
    y.code = uint16(sum(hx16 .* twos(ones(ysize,1),:),2))';
    
end

