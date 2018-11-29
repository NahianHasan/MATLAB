clear all
close all
clc

x = @(t)(sin(2*pi*10*t));
fs = 500;
t1 = 0:0.0001:2*(1/10);
x1 = x(t1);


t2 = 0:(1/fs):2*(1/10);
x2 = x(t2);

t3 = 0:(1/(2*fs)):2*(1/10);
x3 = interp1(t2,x2,t3);



%stem(t2,x2,'--g');
%plot(t3,x3,'--r');


%Quantization
for m=1:4
    bit = [2 3 4 6];
    levels = 2^bit(m);
    quantized_layers = linspace(min(x2),max(x2),levels);
    delta = abs(quantized_layers(1) - quantized_layers(2));
    xq = zeros(1,length(x2));
    xbin = zeros(1,length(x2));

    for i = 1:length(x2)
        for j = 1:length(quantized_layers)
            if((x2(i) >= quantized_layers(j)) && (x2(i) < (quantized_layers(j)+delta/2)))
                xq(i) = quantized_layers(j);
                xbin(i) =j-1;
            elseif((x2(i) >= (quantized_layers(j)+delta/2)) && (x2(i) <= quantized_layers(j+1)))
                xq(i) = quantized_layers(j+1);
                xbin(i) = j;
            end
        end
    end
    
    subplot(2,2,m);
    plot(t1,x1);
    grid on;
    hold on;
    stairs(t2,xq,'r');
    hold off;
    title(num2str(bit(m)));
    
    quantization_noise_power = (delta^2)/12
    en = x2 - xq;
    quantization_noise_power2 = sum(en.^2)/length(en)
    xbin_final=dec2bin(xbin);
    xbin_final
end

sampled_signal_power = sum(x2.^2)/length(x2)




        
        
        
        
        
        
        
        
        