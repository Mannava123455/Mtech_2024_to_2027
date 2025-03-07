f1 = fopen('division_input.txt', 'wb'); 
f2 = fopen('division_output.txt', 'wb'); 
filename = 'newton_raphson_division_plots.pdf';

%function for generating lookup table for initial estimate
function fix_output = lookup_table_generation(n,fix_Q_format)
    N = 2^n;                  
    index_arr = 0:1:N-1;
    d = 0.5+ (index_arr./N).*0.5;
    output = 2.9282 - 2 .* d;
    fix_output = round(output.*(2^fix_Q_format));
end


%function for normalizing the denominator to make it in range of [o.5,1)
function [input,shift] = normalize_denominator(input,fix_Q_format)
shift = 0;
while(input < (2^(fix_Q_format-1)))
    input = int32(input*2);
    shift = shift+1;
end
while(input >= (2^(fix_Q_format)))
    input = int32(input/2);
    shift = shift-1;
end
end


function result = newton_raphson_division(numerator,denominator,lookup_table)
if(denominator ~= 0)
[denominator,no_of_shifts] = normalize_denominator(denominator,16);
x0_index = bitshift((denominator - 32768),-9);
x0 = lookup_table(x0_index+1);

for i=0:1:3
    temp = bitshift(int64(x0)*int64(denominator),-16);
    temp = 131072 - temp;
    x0 = bitshift((temp*x0),-16);
end

result = bitshift((int64(numerator) * int64(x0)),-16);
result = bitshift(result,no_of_shifts);
else
result = 0;
end

end


%Generate some random signal 
N = 100;                      
amplitude = 100;             
t = linspace(0, 10, N);  
x = amplitude * besselj(0, t);

fix_x = round(x.*(2^16));

for i = 1:1:N
    fprintf(f1, '%d\n', fix_x(i));
end

numerator = 10;
numerator = bitshift(numerator,16);


output = zeros(1,N);

%generate the lookup table 
n = 6;
lookup_table  = lookup_table_generation(n,16);



for i = 1:N
    temp_numerator = numerator; 

    if fix_x(i) < 0
        denominator = -fix_x(i);
        temp_numerator = -temp_numerator;
    else
        denominator = fix_x(i);
    end

    result = newton_raphson_division(temp_numerator, denominator, lookup_table);
    output(i) = result;
    fprintf(f2, '%d\n', output(i));
end

actual_output = int64(numerator*(2^16))./int64(fix_x);
diff = int64(output) - int64(actual_output);


figure(1);
subplot(4,1,1)
plot(x);
grid();
title("x[n]", 'FontSize', 8, 'Interpreter', 'none');
subplot(4,1,2)
plot(1./x);
grid();
title("10/x[n] in floating point", 'FontSize', 8, 'Interpreter', 'none');
subplot(4,1,3)
plot(actual_output);
grid();
title("10/x[n] in fixed point", 'FontSize', 8, 'Interpreter', 'none');
subplot(4,1,4)
plot(output);
grid();
title("10/x[n] in fixed point using newton raphson method", 'FontSize', 8, 'Interpreter', 'none');
exportgraphics(gcf, filename, 'Append', true);

