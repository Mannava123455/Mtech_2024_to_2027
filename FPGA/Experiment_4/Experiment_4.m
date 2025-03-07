
% Experiment 4:
% 
% Mannava Venkatasai 
% EE24MTECH12008
% 
% 
% FIR filter Design
% 
% In MATLAB
% 
% 1. Enter filterDesigner in MATLAB command window
% 2. It opens a filter designer window.
% 3. Select following options:  
%     a. bandpass
%     b. FilterOrder = Minimum
%     c. Density factor = 20
%     d. Frequency spec :  Sampling freq = 48000, fstop1 = 500, fpass1 = 1500, fpass2 = 8000 ; fstop2 = 9000
% 
%  4. Press design filter.
%  5. You can see filter response plot with band-pass characteristics
%  6. Go to File->Export  and export MATLAB file. This will store all filter coefficients.
% 
%  7. Write a MATLAB code to
%      a. read the above values into a variable by using load command. Consider 20 filter coefficients
%      b. convert them into fixed point Q(2,14). Store these values into a file.
%      c. Generate 4 sinewaves of 100Hz, 2000Hz, 6000Hz, 11000Hz and sample at 48000Hz. consider 5 cycles
%      d. Convert these values into Q(2,14)format and store them into file(s).
%  8. Write MATLAB code to get the output for these 4 signals using the designed filter (consider 20 filter coefficients). Plot outputs for 4 signals
 








filename = 'matlab_outputof_band_pass_filter.pdf';

file_1 = fopen('filter_coefcients.txt', 'wb'); 
file_2 = fopen('input_signal_1.txt', 'wb'); 
file_3 = fopen('input_signal_2.txt', 'wb'); 
file_4 = fopen('input_signal_3.txt', 'wb'); 
file_5 = fopen('input_signal_4.txt', 'wb'); 

file_6 = fopen('output_signal_1.txt', 'wb'); 
file_7 = fopen('output_signal_2.txt', 'wb'); 
file_8 = fopen('output_signal_3.txt', 'wb'); 
file_9 = fopen('output_signal_4.txt', 'wb'); 


fs = 48000;
f1 = 100;
f2 = 2000;
f3 = 6000;
f4 = 11000;
cycles = 5;
data = load("exp_4.mat"); 
var_name = fieldnames(data); 
filter_coeff = data.(var_name{1});
filter_coeff_fix = round(filter_coeff.*(2^14));
length_of_coeff = length(filter_coeff_fix);

for i = 1:1:length(filter_coeff_fix)
    fprintf(file_1, '%d\n', filter_coeff_fix(i));
end




%signal 1
no_of_samples_for_f1 = round(cycles*fs/f1);
t1 = (0:1:no_of_samples_for_f1-1)/fs;
x1 = sin(2*pi*f1*t1);
filter_out_1 = conv(x1, filter_coeff);
filter_out_1 = filter_out_1(round(length(filter_coeff_fix)/2) :1:round(length(filter_coeff_fix)/2)-1 + no_of_samples_for_f1);


%compute the convolution in fixedpoint Q(2,14)
L = no_of_samples_for_f1;
M = length(filter_coeff_fix);
N = L + M -1;

filter_out_fix = int32(zeros(1, N));
fix_x1 = round(x1.*2^14);

for i = 1:1:length(fix_x1)
    fprintf(file_2, '%d\n', fix_x1(i));
end

for n = 1:N
    for k = 1:M
        if (n-k+1 > 0) && (n-k+1 <= L)
                filter_out_fix(n) = filter_out_fix(n) + bitshift(int32(fix_x1(n-k+1) * filter_coeff_fix(k)), -14);
        end
    end
end

filter_out_fix = filter_out_fix(round(length(filter_coeff_fix)/2) :1:round(length(filter_coeff_fix)/2)-1 + no_of_samples_for_f1);
for i = 1:1:length(filter_out_fix)
    fprintf(file_6, '%d\n', filter_out_fix(i));
end

figure(1);
subplot(4,1,1)
plot(t1,x1)
title("Input signal with frequency 100 Hz",'12')

subplot(4,1,2)
plot(t1,filter_out_1)
title("Filter output in floating point (signal is attenuated)",'12')

subplot(4,1,3)
plot(t1,fix_x1)
title("Input signal with frequency 100 Hz in fixedpoint Q(2,14)",'12')

subplot(4,1,4)
plot(t1,filter_out_fix)
title("Filter output in fixed point Q(2,14) (signal is attenuated)",'12')
exportgraphics(gcf, filename, 'Append', true);




%signal 2
no_of_samples_for_f2 = round(cycles*fs/f2);
t2 = (0:1:no_of_samples_for_f2-1)/fs;
x2 = sin(2*pi*f2*t2);
filter_out_2 = conv(x2, filter_coeff);
filter_out_2 = filter_out_2(round(length(filter_coeff_fix)/2) :1:round(length(filter_coeff_fix)/2)-1 + no_of_samples_for_f2);



%compute the convolution in fixedpoint Q(2,14)
L = no_of_samples_for_f2;
M = length(filter_coeff_fix);
N = L + M -1;

fix_x2 = round(x2.*2^14);
filter_out_fix = int32(zeros(1, N));

for i = 1:1:length(fix_x2)
    fprintf(file_3, '%d\n', fix_x2(i));
end



for n = 1:N
    for k = 1:M
        if (n-k+1 > 0) && (n-k+1 <= L)
                filter_out_fix(n) = filter_out_fix(n) + bitshift(int32(fix_x2(n-k+1) * filter_coeff_fix(k)), -14);
        end
    end
end

filter_out_fix = filter_out_fix(round(length(filter_coeff_fix)/2) :1:round(length(filter_coeff_fix)/2)-1 + no_of_samples_for_f2);
for i = 1:1:length(filter_out_fix)
    fprintf(file_7, '%d\n', filter_out_fix(i));
end


figure(2);
subplot(4,1,1)
plot(t2,x2)
title("Input signal with frequency 2000 Hz",'8')

subplot(4,1,2)
plot(t2,filter_out_2)
title("Filter output in floating point (signal is not attenuated)",'8')

subplot(4,1,3)
plot(t2,fix_x2)
title("Input signal with frequency 2000 Hz in fixedpoint Q(2,14)",'8')

subplot(4,1,4)
plot(t2,filter_out_fix)
title("Filter output in fixed point Q(2,14) (signal is not attenuated)",'8')
exportgraphics(gcf, filename, 'Append', true);




%signal 3
no_of_samples_for_f3 = round(cycles*fs/f3);
t3 = (0:1:no_of_samples_for_f3-1)/fs;
x3 = sin(2*pi*f3*t3);
filter_out_3 = conv(x3, filter_coeff);
filter_out_3 = filter_out_3(round(length(filter_coeff_fix)/2) :1:round(length(filter_coeff_fix)/2)-1 + no_of_samples_for_f3);


%compute the convolution in fixedpoint Q(2,14)
L = no_of_samples_for_f3;
M = length(filter_coeff_fix);
N = L + M -1;

fix_x3 = round(x3.*2^14);
filter_out_fix = int32(zeros(1, N));

for i = 1:1:length(fix_x3)
    fprintf(file_4, '%d\n', fix_x3(i));
end



for n = 1:N
    for k = 1:M
        if (n-k+1 > 0) && (n-k+1 <= L)
                filter_out_fix(n) = filter_out_fix(n) + bitshift(int32(fix_x3(n-k+1) * filter_coeff_fix(k)), -14);
        end
    end
end

filter_out_fix = filter_out_fix(round(length(filter_coeff_fix)/2) :1:round(length(filter_coeff_fix)/2)-1 + no_of_samples_for_f3);
for i = 1:1:length(filter_out_fix)
    fprintf(file_8, '%d\n', filter_out_fix(i));
end



figure(3);
subplot(4,1,1)
plot(t3,x3)
title("Input signal with frequency 6000 Hz")

subplot(4,1,2)
plot(t3,filter_out_3)
title("Filter output in floating point (signal is not attenuated)")

subplot(4,1,3)
plot(t3,fix_x3)
title("Input signal with frequency 6000 Hz in fixedpoint Q(2,14)")

subplot(4,1,4)
plot(t3,filter_out_fix)
title("Filter output in fixed point Q(2,14) (signal is not attenuated)")
exportgraphics(gcf, filename, 'Append', true);



%signal 4
cycles = 300;
no_of_samples_for_f4 = round(cycles*fs/f4);
t4 = (0:1:no_of_samples_for_f4-1)/fs;
x4 = sin(2*pi*f4*t4);
filter_out_4 = conv(x4, filter_coeff);
filter_out_4 = filter_out_4(round(length(filter_coeff_fix)/2) :1:round(length(filter_coeff_fix)/2)-1 + no_of_samples_for_f4);




%compute the convolution in fixedpoint Q(2,14)
L = no_of_samples_for_f4;
M = length(filter_coeff_fix);
N = L + M -1;

fix_x4 = round(x4.*2^14);
filter_out_fix = int32(zeros(1, N));

for i = 1:1:length(fix_x4)
    fprintf(file_5, '%d\n', fix_x4(i));
end


for n = 1:N
    for k = 1:M
        if (n-k+1 > 0) && (n-k+1 <= L)
                filter_out_fix(n) = filter_out_fix(n) + bitshift(int32(fix_x4(n-k+1) * filter_coeff_fix(k)), -14);
        end
    end
end

filter_out_fix = filter_out_fix(round(length(filter_coeff_fix)/2) :1:round(length(filter_coeff_fix)/2)-1 + no_of_samples_for_f4);
for i = 1:1:length(filter_out_fix)
    fprintf(file_9, '%d\n', filter_out_fix(i));
end



figure(4);
subplot(4,1,1)
plot(t4,x4)
title("Input signal with frequency 11000 Hz")

subplot(4,1,2)
plot(t4,filter_out_4)
title("Filter output in floating point (signal is attenuated)")

subplot(4,1,3)
plot(t4,fix_x4)
title("Input signal with frequency 11000 Hz in fixedpoint Q(2,14)")

subplot(4,1,4)
plot(t4,filter_out_fix)
title("Filter output in fixed point Q(2,14) (signal is attenuated)")
exportgraphics(gcf, filename, 'Append', true);










