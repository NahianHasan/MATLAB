function ice_OpeningFcn(hObject,eventdata, handles, varargin)
        handles.updown = 'none';
        handles.plotbox = [0 0 1 1];
        handles.set1 = [0 0;1 1];
        handles.set2 = [0 0;1 1];
        handles.set3 = [0 0;1 1];
        handles.set4 = [0 0;1 1];
        handles.curve = 'set1';
        handles.Cindex = 1;
        handles.node = 0;
        handles.below = 1;
        handles.above = 2;
        handles.smooth = [0;0;0;0];
        handles.slope = [0;0;0;0];
        handles.cdf = [0;0;0;0];
        handles.pdf = [0;0;0;0];
        handles.output = [];
        handles.df = [];
        handles.colortype = 'rgb';
        handles.input = [];
        handles.imagemap = 1;
        handles.barmape = 1;
        handles.graybar = [];
        handles.colorbar = [];
        
        wait on;
        
        if(nargin > 3)
            for i = 1:2:(nargin-3)
                if nargin-3 == i
                    break;
                end
                switch lower(varargin{i})
                    case 'image'
                        if ndims(varargin{i+1}) == 3
                            handles.input = varargin{i+1};
                        elseif ndims(varargin{i+1}) == 2
                            handles.input = cat(3, varargi{i+1}, varargin{i+1}, varargin{i+1});
                        end
                        handles.input = double(handles.input);
                        inputmax = max(handles.input(:));
                        if inputmax > 255
                            handles.input = handles.input/65535;
                        elseif inputmax > 1
                            handles.input = handles.input/255;
                        end
                    case 'space'
                        handles.colortype = lower(varargin{i+1});
                        switch handles.colortype
                            case 'cmy'
                                list = {'CMY' 'Cyan' 'Magenta' 'Yellow'};
                            case {'ntsc', 'yiq'}
                                list = {'YIQ' 'Luminance' 'Hue' 'Saturation'};
                                handles.colortype = 'ntsc';
                            case 'ycbcr'
                                list = {'YCbCr' 'Luminance' 'Blue' 'Difference' 'Red Difference'};
                            case 'hsv'
                                list = {'HSV' 'Hue' 'Saturation' 'Value'};
                            case 'hsi'
                                list = {'HSI' 'Hue' 'Saturation' 'Intensity'};
                            otherwise
                                list = {'RGB' 'Red' 'Green' 'Blue'};
                        end
                        set(handles.component_popup, 'String', list);
                    case 'wait'
                        wait = lower(varargin{i+1});
                end
            end
        end
        
        xi = 0:1/127:1;
        x = 0:1/6:1;
        x = x';
        y = [1 1 0 0 0 1 1; 0 1 1 1 0 0 0; 0 0 0 1 1 1 0]';
        gb = repmat(xi, [1 1 3]);
        cb = interpiq(x,y,xi');
        cb = reshape(cb, [1 128 3]);
        if ~strcmp(handles.colortype,'rgb')
            gb = eval(['rgb2' handles.colortype '(gb)']);
            cb = eval(['rgb2' handles.colortype '(cb)']);
        end
        
        gb = round(255*gb);
        gb = max(0,gb);
        gb = min(255,gb);
        cb = round(255*cb);
        cb = max(0,cb);
        cb = min(255,cb);
        handles.graybar = gb;
        handles.colorbar = cb;
        
        if size(handles.input, 1)
            if ~strcmp(handles.colortype, 'rgb')
                handles.input = eval('rgb2' handles.colortype '(handles.input)');
            end
            handles.input = round(255*handles.input);
            handles.input = max(0,handles.input);
            handles.input = min(255, handles.input);
            for i = 1:3
                color = handles.input(:,:,1);
                df = hist(color(:), 0:255);
                handles.df = [handles.df;df/max(df(:))];
                df = df / sum(df(:));
                df = cumsum(df);
                handles.df = [handles.df;df];
            end
            figure;
            handles.output = gcf;
        end
        set(0, 'Units', 'Pixels');
        set(handles.ice, 'Units', 'Pixels');
        ssz = get(0,'Screensize');
        uisz(handles.ice, 'Position');
        if size(handles.input, 1)
            fsz = get(handles.output, 'Position');
            bc = (fsz(4) - uisz(4)) / 3;
            if bc > 0
                bc = bc + fsz(2);
            else
                bc = fsz(2) + fsz(4) - uisz(4) - 10;
            end
            lc = fsz(1) + (size(handles.input, 2)/4) + (3 * fsz(3)/4);
            lc = min(lc, ssz(3) - uisz)(3) - 10);
            set(handles.ice, 'Position', [lc bc uisz(3) uisz(4)]);
        end
        set(handles.ice, 'Units', 'normalized');
        graph(handles);
        render(handles);
        
        
        guidata(hObject, handles);
        if strcmpi(wait, 'on')
            uiwit(handles.ice);
        end    
    end
    %end of function ice_OpeningFcn()
