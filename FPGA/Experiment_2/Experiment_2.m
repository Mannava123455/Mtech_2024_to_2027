
f1 = fopen('operand_1_in_Q_2_14.txt', 'wb'); 
f2 = fopen('operand_2_in_Q_4_12.txt', 'wb'); 

f_sum = fopen('sum_matlab_out.txt', 'wb'); 
f_diff = fopen('diff_matlab_out.txt', 'wb');
f_product = fopen('product_matlab_out.txt', 'wb');

fc = 1000;
fs = 48000;
time = 1; %in seconds

%generation of sine signal
t = (0:1:(fs*time))./fs;
x = 2*sin(2*pi*fc*t);
cycles = 5;
no_of_samples_in_cycles = round(cycles*(fs/fc));
x = x(1:no_of_samples_in_cycles);


%convert the samples to fixed point Q(2,14)
x_in_Q2_14 = int32(round((x.*(2^14))));

%convert the samples to fixed point Q(4,12)
x_in_Q4_12 = int32(round((x.*(2^12))));

fprintf(f1, '%d\n', x_in_Q2_14);
fprintf(f2, '%d\n', x_in_Q4_12);




%------------------ fixed point Arthematic operations-----------------
%                   operand_1 = x_in_Q2_14
%                   operand_2 = x_in_Q4_12


%-------------------- Addition -----------------------------
fixed_point_sum = x_in_Q2_14 + (x_in_Q4_12.*4);


%-------------------- Difference ---------------------------
fixed_point_diff = x_in_Q2_14 - (x_in_Q4_12.*4);


%-------------------- Multiplication ------------------------
% fixed_point_product = (x_in_Q2_14 .* (x_in_Q4_12.*4))./(2^14);
fixed_point_product = bitshift((x_in_Q2_14 .* (x_in_Q4_12 .* 4)), -14);




%-------------------- Division ------------------------------
fixed_point_division = (x_in_Q2_14.*(2^14))./(x_in_Q4_12.*4);


for i = 1:length(fixed_point_sum)
    fprintf(f_sum, '%d\n', fixed_point_sum(i));
    fprintf(f_diff, '%d\n', fixed_point_diff(i));
    fprintf(f_product, '%d\n', fixed_point_product(i));
end


%All the above values are in Q(2,14) format


%verify the outputs with original values

%convert the fixed point values to floating point values
sum_1 = double(fixed_point_sum)./(2^14);
diff_1 = double(fixed_point_diff)./(2^14);
product_1 = double(fixed_point_product)./(2^14);
div_1 = double(fixed_point_division)./(2^14);


%check with actual values
error_sum = sum_1 - (x+x);
error_diff = diff_1 - (x-x);
error_product = product_1 - (x.*x);
error_div = div_1 - (x./x);




fclose(f1);
fclose(f2);
fclose(f3);





















