function varargout = ice_OutputFcn(hObject, eventdata, handles)
        if max(size(handles)) == 0
            figh = get(gcf);
            imageh = get(figh.Children);
            if max(size(imageh)) > 0
                image = get(imageh.Children);
                varargout{1} = image.CData;
            end
        else
            varargout{1} = hObject;
        end
    end
    % end of function varargout();

