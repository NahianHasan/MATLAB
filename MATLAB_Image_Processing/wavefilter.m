function [varargout] = wavefilter(wname,type)
    error(nargchk(1,2,nargin));
    
    if ((nargin == 1 && nargout ~= 4) | (nargin == 2 && nargout ~= 2))
        error('Wrong number of inputs and outputs');
    end
    
    if (nargin == 1 && ~ischar(wname))
        error('wname must be a string');
    end
    
    if (nargin == 2 && ~ischar(type))
        error('Type must be a string');
    end
    
    switch lower(wname)
        case{'haar', 'db1'}
            ld = [1 1]/sqrt(2);
            hd = [-1 1]/sqrt(2);
            lr = ld;
            hr = -hd;
    end
    
    if(nargin == 1)
        varargout(1:4) = {ld,hd,lr,hr};
    else
        switch lower(type(1))
            case 'd'
                varargout = {ld, hd};
            case 'r'
                varargout = {lr, hr};
            otherwise
                error('Unrecognizable filter type');
        end   
end

