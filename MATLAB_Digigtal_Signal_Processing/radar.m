clc
clear all
close all

t = 0:1:1500
x=@(t) sin(2*pi*(1/100)*t)
for ii = 1:length(t)
    if t(ii) <= 300
        x_tran(ii) = x(t(ii)) ;
    else
        x_tran(ii) = 0 ;
    end
end
for ii = 1:length(t)
    if t(ii) <= 800 && t(ii) >= 500 
        x_re(ii) =x(t(ii)) ;
    else
        x_re(ii) = 0 ;
    end
end
plot(t,x_tran)
figure
plot(t,x_re)


px=sum(x_tran.^2)/length(x_tran);
SNR=-10;
py=px/(10^(SNR/10));
n=sqrt(py)*randn(1,length(t));
y=x_re+n;
figure;
plot(t,y);
[ACF,u]=xcorr(y,x_tran);
figure;
plot(u,ACF)

grid on