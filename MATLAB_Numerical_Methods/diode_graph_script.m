clear all
close all
clc

m = input('For how many cycle you want to see the graphs: ');
n = 0.02*m;
A = bisection(-1,1,0.0000001)

Y = [];
for x = 0:0.0001:n
    c = 5*sin(100*pi*x);
    if c >= 0
        y = A*sin(100*pi*x)*100;
        Y = [Y y];
    elseif (c < 0)
        y = 0;
        Y = [Y y];
    end
end
    
k = 0:0.0001:n;
plot(k,Y);
[val,idx] = max(Y);
strmax = ['Max Vout = ',num2str(val)];
text(k(idx),val,strmax,'HorizontalAlignment','left');
grid on
hold on;
q = 5*sin(100*pi*k);
plot(k,q);
hold off;
xlabel('Time');
ylabel('input,output voltage');
legend('Output Graph','Input Signal');

