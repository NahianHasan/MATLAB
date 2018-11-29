function CODE = huffman(p)
    error(nargchk(1,1,nargin));
    if((ndims(p) ~= 2) | (min(size(p)) > 1) | (~isreal(p)) | (~isnumeric(p)))
        error('P must be a real numeric vector');
    end
    
    global CODE;
    CODE = cell(length(p),1);
    
    if length(p) > 1
        p = p / sum(p);
        s = reduce(p);
        makecode(s,[]);
    else
        CODE = {'1'};
    end
    
end

