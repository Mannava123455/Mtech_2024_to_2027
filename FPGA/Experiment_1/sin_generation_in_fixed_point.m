clc;
clear all
close all

filename = 'FixedPointPlots.pdf';

fc = 1000;
fs = 48000;
time = 1; %in seconds

t = (0:1:(fs*time))./fs;
x = 2*sin(2*pi*fc*t);

%convert the samples to fixed point Q(2,14)
x_in_Q2_14 = int32(round((x.*(2^14))));
x_in_Q4_12 = int32(round((x.*(2^12))));
x_in_Q8_4  = int32(round((x.*(2^4))));

%finding the errors 
error_in_Q2_14 = x - (double(x_in_Q2_14) ./ (2^14));
error_in_Q4_12 = x - (double(x_in_Q4_12) ./(2^12));
error_in_Q8_4 = x  - (double(x_in_Q8_4)  ./(2^4));


%finding the SQNR 
sqnr_Q2_14 = mean(x.^2)/(mean(error_in_Q2_14 .^2));
sqnr_Q4_12 = mean(x.^2)/(mean(error_in_Q4_12 .^2));
sqnr_Q8_4 = mean(x.^2)/(mean(error_in_Q8_4 .^2));


disp(sqnr_Q2_14)
disp(sqnr_Q4_12)
disp(sqnr_Q8_4)

%ploting for 5 cycles
cycles = 5;
no_of_samples_in_cycles = round(cycles*(fs/fc));
t = t(1:no_of_samples_in_cycles);

x = x(1:no_of_samples_in_cycles);
x_in_Q2_14 = x_in_Q2_14(1:no_of_samples_in_cycles);
x_in_Q4_12 = x_in_Q4_12(1:no_of_samples_in_cycles);
x_in_Q8_4 = x_in_Q8_4(1:no_of_samples_in_cycles);

error_in_Q2_14 = error_in_Q2_14(1:no_of_samples_in_cycles);
error_in_Q4_12 = error_in_Q4_12(1:no_of_samples_in_cycles);
error_in_Q8_4 = error_in_Q8_4(1:no_of_samples_in_cycles);


figure(1);
subplot(3,1,1);
plot(t,x);
grid();
title("Original sine signal");
subplot(3,1,2);
plot(t,x_in_Q2_14);
grid();
title("fixed point Q(2,14) sine signal");
subplot(3,1,3);
plot(t,error_in_Q2_14);
grid();
title("error in Q(2,14) Signal");
exportgraphics(gcf, filename, 'Append', true);



figure(2);
subplot(3,1,1)
plot(t,x);
grid();
title("Original sine signal")
subplot(3,1,2)
plot(t,x_in_Q4_12)
grid();
title("fixed point Q(4,12) sine signal")
subplot(3,1,3);
plot(t,error_in_Q4_12);
grid();
title("error in Q(4,12) signal");
exportgraphics(gcf, filename, 'Append', true);


figure(3)
subplot(3,1,1)
plot(t,x);
grid();
title("Original sine signal")
subplot(3,1,2)
plot(t,x_in_Q8_4)
grid();
title("fixed point Q(8,4) sine signal")
subplot(3,1,3);
plot(t,error_in_Q8_4);
grid();
title("error in Q(8,4) Signal");
exportgraphics(gcf, filename, 'Append', true);






