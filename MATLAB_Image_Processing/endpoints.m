function g = endpoints(f)
    persistent lut;
    
    if isempty(lut)
        lut = makelut(@endpoint_fcn,3);
    end
    
    g = applylut(f,lut);
    
end

