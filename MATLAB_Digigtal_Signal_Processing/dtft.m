

x = [1,3,-9,5,10];
n1 = -1;
n2 = 3;
n=n1:n2;
M = 500;
w = (-2*M:2*M)*2*pi/M;
W = exp(-j*w'*n);
X = W*x';
X = W*x';
figure
subplot(2,1,1);
plot(w/(2*pi),abs(X));
subplot(2,1,2);
plot(w/(2*pi),angle(X));



nre=-40:120;
dw = w(2)-w(1);
xre = zeros(1,length(nre));
for i1 = 1:length(xre)
    for i2 = 1:length(M)
        xre(i1) = xre(i1) + (1/2*pi)*(X(i2)*exp(i*w(i2)*nre(i1)))*dw;
    end
end

stem(nre,xre)
xre