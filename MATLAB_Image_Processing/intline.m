function [x, y] = intline(x1,x2,y1,y2)

    % [X, Y] = INTLINE(X1, X2, Y1, Y2) computes an
    % approximation t o the l i n e segment j o i n i n g (Xl, Y1) and
    % (X2, Y2) with integer coordinates. XI, X2, Y1, and Y2
    % should be integers. INTLINE i s reversible; t h a t i s ,
    % INTLINE(X1, X2, Y1, Y2) produces the same r e s u l t s as
    % FLIPUD(INTLINE(X2, XI, Y2, YI)) .
    
    dx = abs(x2 - x1);
    dy = abs(y2 - y1);
    
    %check for degenerate case
    if((dx == 0) & (dy == 0))
        x = x1;
        y = y1;
        return;
    end
    
    flip = 0;
    if(dx >= dy)
        if(x1 > x2)
            %Always draw from left to right
            t = x1;
            x1 = x2;
            x2 = t;
            
            t = y1;
            y1 = y2;
            y2 = t;
            flip = 1;
        end
        
        m = (y2 - y1)/(x2 - x1);
        x = (x1:x2).';
        y = round(y1 + m*(x - x1));
    else
        if(y1 > y2)
            %Always draw from bottom to right
            t = x1;
            x1 = x2;
            x2 = t;
            
            t = y1;
            y1 = y2;
            y2 = t;
            flip = 1;
        end
        m = (x2 - x1)/(y2 - y1);
        y = (y1:y2).';
        x = round(x1 + m*(y - y1));
    end
    
    
    if(flip)
        x = flipud(x);
        y = flipud(y);
    end
       
end

