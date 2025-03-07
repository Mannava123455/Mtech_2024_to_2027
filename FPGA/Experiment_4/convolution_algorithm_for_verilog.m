function [out] = fir_filter_with_verilog_logic(x,h)
N = length(x);
M = length(h);

shift_reg = zeros(1,N);
buffer = zeros(1,N);
out = zeros(1,M+N-1);


i = 1;
for n = 1:N+M-1
    % shift the shift register to right
    shift_reg(2:end) = shift_reg(1:end-1);
    
    % feed the input
    if(n <= N)
        shift_reg(1) = x(n);
    end
 

    buffer(1) = shift_reg(1) * h(1);
    for j=2:N
        if(j <= M)
            buffer(j) = buffer(j-1) + shift_reg(j)*h(j);
        end
    end

    if i < N
        out(n) = buffer(i);
        i = i+1;
    else
        out(n) = buffer(i);
    end

end
end


fs = 48000;
f1 = 100;

cycles = 5;
data = load("exp_4.mat"); 
var_name = fieldnames(data); 
filter_coeff = data.(var_name{1});



no_of_samples_for_f1 = round(cycles*fs/f1);
t1 = (0:1:no_of_samples_for_f1-1)/fs;
x1 = sin(2*pi*f1*t1);
filter_out_1 = fir_filter_with_verilog_logic(x1,filter_coeff);
filter_out_1 = filter_out_1(round(length(filter_coeff_fix)/2) :1:round(length(filter_coeff_fix)/2)-1 + no_of_samples_for_f1);


figure(1);
subplot(2,1,1)
plot(t1,x1)
title("Input signal with frequency 100 Hz",'12')

subplot(2,1,2)
plot(t1,filter_out_1)
title("Filter output in floating point (signal is attenuated)",'12')


