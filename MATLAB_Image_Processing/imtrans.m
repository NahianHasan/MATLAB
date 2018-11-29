function g = imtrans(f,varargin)
    method = varargin{1};
    switch method
        case 'neg'
            g = imcomplement(f);
        case 'log'
            if length(varargin) == 1
                c = 1;
            elseif length(varargin) == 2
                c = varargin{2};
            elseif length(varargin) == 3
                c = varargin{3};
            else
                error('incorrect number of inputs for the log function');
            end
            g = c*log(1+double(f));
        case 'gama'
            if length(varargin) < 2
                error('Incomplete number of inputs to the gamma function');
            end
            gam = vargin{2};
            g = imadjust(f,[],[],gam);
        case 'stretch'
            if length(varargin) == 1
                m = mean2(f);
                E = 4.0;
            elseif length(varargin) == 3
                m = varargin{2};
                E = varargin{3};
            else
                error('Incorrect number of inputs for the stretching function.either 1 or 3 varargin are allowed');
            end
            g = 1./(1 + (m./(f+eps)).^E);
        otherwise
            error('Unknown enhancement method');
end

