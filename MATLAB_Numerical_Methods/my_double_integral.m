function [ result ] = my_double_integral( f,dx,dy,x1,x2,y1,y2 )
    nx=(x2-x1)/dx;
    ny=(y2-y1)/dy;
    sum=0;
    sum1=0;
    result=0;
    y=y1;
    x=x1;
        for i=1:1:nx
            sum=sum+dx*(f(x,y)+f(x+dx,y))/2;
            x=x+dx;
        end
    sum1=sum;
    y=y+dy;    
    for j=1:1:ny
        x=x1;
        sum=f(x1,y1);
        for i=1:1:nx
            sum=sum+dx*(f(x,y)+f(x+dx,y))/2;
            x=x+dx;
        end
        y=y+dy;
        result=result+((sum1+sum)*dy)/2;
        y=y+dy;
        sum1=sum;        
end

