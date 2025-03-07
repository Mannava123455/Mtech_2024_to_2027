/******************************************** Experiment 2 **************************************************

Perform basic fixed-point operations using Verilog on array of data (sum,
subtraction, multiplication and division) , write them to files and
verifiy using MATLAB reference


program.
Plot both outputs and show that both give same results.

Please use Q(2,14), Q(4,12) values from previous experiment as operand1 and operand2 
(store them in matlab as files and read them in Verilog). 
You need to take care of proper Q conversions. 
Also do only addition, subtraction and multiplications.
****************************************************************************************************************/


module fixed_point_arthematic(
input wire clk,
input signed [16:0] operand_1,
input signed [16:0] operand_2,
output reg signed [17:0] sum,
output reg signed [17:0] diff,
output reg signed [34:0] product
);


always @(posedge clk)
begin
    sum <= (operand_1 + (operand_2 << 2));
    diff <= (operand_1 - (operand_2 << 2));
    product <= (operand_1 * (operand_2 << 2)) >> 14;

end

endmodule
