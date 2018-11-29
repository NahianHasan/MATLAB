clear all
close all
clc

f1 = 10;
f2 = 15;
fs = 100;
deviation = 0.1;

x = @(t)(sin(2*pi*f1*t+pi/6) + 2*cos(2*pi*f2*t));
xn = @(t)(deviation*randn(size(t)));

%Original Signal
t1 = 0:0.0001:2*(1/10);
x1 = x(t1);
x_noise = xn(t1);


t2 = 0:(1/fs):2*(1/10);%Sampled Frequency
x2 = x(t2);
noise = xn(t2);%Sampled Noise
noisy_signal = x2+noise;%Sampled Noisy Signal

subplot(2,3,1);
hist(noise,300);
grid on;
title('histogram of sampled noise')


%Quantization
    bit = [3 7 11 15 19];
for m =1:length(bit)
    levels = 2^bit(m);
    quantized_layers = linspace(min(noisy_signal),max(noisy_signal),levels);
    delta = abs(quantized_layers(1) - quantized_layers(2));
    xq = zeros(1,length(noisy_signal));
    xbin = zeros(1,length(noisy_signal));

    for i = 1:length(x2)
        for j = 1:length(quantized_layers)
            if((noisy_signal(i) >= quantized_layers(j)) && (noisy_signal(i) < (quantized_layers(j)+delta/2)))
                xq(i) = quantized_layers(j);
                xbin(i) =j-1;
            elseif((noisy_signal(i) >= (quantized_layers(j)+delta/2)) && (noisy_signal(i) <= quantized_layers(j+1)))
                xq(i) = quantized_layers(j+1);
                xbin(i) = j;
            end
        end
    end
    
      
    %Histogram of quantization Noise
    quantization_noise = xq-noisy_signal;
    subplot(2,3,m+1)
    hist(quantization_noise,100);
    grid on;
    title(['Bit Level ',num2str(bit(m))])
end
