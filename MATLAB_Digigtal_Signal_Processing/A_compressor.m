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


%A-law compressor
normalized_signal = noisy_signal/max(abs(noisy_signal));
compressed_signal = compand(normalized_signal,255,max(abs(noisy_signal)),'A/compressor');


%Manual A-Compressor
%for i= 1:length(normalized_signal)
%   if(1/87.56<=abs(normalized_signal(i)) && abs(normalized_signal(i))<=1)
%        compressed_signal(i) = (1+log(87.56*abs(normalized_signal(i)))/(1+log(87.56)))*sign(normalized_signal(i));
%    elseif((0<=abs(normalized_signal(i))) && (abs(normalized_signal(i))<=(1/87.56)))
%        compressed_signal(i) = ((87.56*abs(normalized_signal(i)))/(1+log(87.56)))*sign(normalized_signal(i));
%    end
%end


%Quantization
    bit = 3;
    levels = 2^bit;
    quantized_layers = linspace(min(compressed_signal),max(compressed_signal),levels);
    delta = abs(quantized_layers(1) - quantized_layers(2));
    xq = zeros(1,length(compressed_signal));
    xbin = zeros(1,length(compressed_signal));

    for i = 1:length(x2)
        for j = 1:length(quantized_layers)
            if((compressed_signal(i) >= quantized_layers(j)) && (compressed_signal(i) < (quantized_layers(j)+delta/2)))
                xq(i) = quantized_layers(j);
                xbin(i) =j-1;
            elseif((compressed_signal(i) >= (quantized_layers(j)+delta/2)) && (compressed_signal(i) <= quantized_layers(j+1)))
                xq(i) = quantized_layers(j+1);
                xbin(i) = j;
            end
        end
    end
    
    subplot(2,3,1);
    plot(t1,x1);%Original_Signal_Plot
    grid on;
    title('Original Signal');
    subplot(2,3,2);
    plot(t1,x_noise);
    grid on;
    title('Noise');
    subplot(2,3,3);
    stem(t2,compressed_signal);%Quantized Signal Plot
    grid on;
    title('Compressed samples');
    hold off;
   
    %Generating Bit Pattern
    xbin_final=dec2bin(xbin);
    xbin_final
    pattern = num2str(xbin_final(1,:));
    for i = 2:length(xbin_final)
        string = num2str(xbin_final(i,:));
        pattern = strcat(pattern,string);
    end
    pattern
    
    
    %Generating Transmitted signal plot
    voltage = [];
    for j = 1:length(pattern)
        if(pattern(j) == '0')
            voltage = [voltage 0];
        else
            voltage = [voltage 1];
        end
    end
    subplot(2,3,4);
    stairs(voltage);
    title('Bit Pattern for Transmission');
    axis([0 80 -1 2]);
    grid on
    
    
    %Reconstructed Signal
    expand_A = compand(compressed_signal,255,max(noisy_signal),'A/expander');
    subplot(2,3,5);
    plot(t2,expand_A);
    title('Reconstructed Signal');
    axis([0 0.2 -3 3]);
    grid on;
    
    
    
    %Histogram of quantization Noise
    quantization_noise = xq-noisy_signal;
    subplot(2,3,6)
    hist(quantization_noise,100);
    grid on;
    title('Histogram of quantization noise')
   
    
    %SQNR
    en = compressed_signal - xq;
    quantization_noise_power = sum(en.^2)/length(en);
    sampled_signal_power = sum(compressed_signal.^2)/length(compressed_signal);
    SQNR = 10*log10(sampled_signal_power/quantization_noise_power)
    SQNR_theory = 1.76+6.02*bit
    
    
    %SNR
    noise_power = sum(noise.^2)/length(noise);
    SNR = 10*log10(sampled_signal_power/noise_power)
