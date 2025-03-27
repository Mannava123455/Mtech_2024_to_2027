`timescale 1ns/1ps
module fir_filter_tb;

reg clk;
reg rst;
reg signed [15:0] x;
wire signed [15:0] y;

reg valid_in;
wire valid_out;

fir_filter filter(
    .clk(clk),
    .rst(rst),
    .input_signal(x),
    .valid_in(valid_in),
    .output_signal(y),
	.valid_out(valid_out)
);

initial 
begin
    clk = 0;
    forever #5 clk = ~clk;
    
end

initial
begin
    $dumpfile("wave.vcd");
    $dumpvars(0, fir_filter_tb);

    rst = 1;
    valid_in = 0;
    #15;

    rst = 0;


    x = 16'd0;
    valid_in = 1;
    $display("time = %t input = %d,rst = %d valid_in = %d",$time,x,rst,valid_in);
    
    #20;  
    valid_in = 1;
    x = 16'd1;
    $display("time = %t input = %d,rst = %d valid_in = %d,out = %d",$time,x,rst,valid_in,y);

    #10;  
    valid_in = 1;
    x = 16'd2;
    $display("time = %t input = %d,rst = %d valid_in = %d,out = %d",$time,x,rst,valid_in,y);

    #10;  
    valid_in = 1;
    x = 16'd3;
    $display("time = %t input = %d,rst = %d valid_in = %d,out = %d",$time,x,rst,valid_in,y);

    #10;  
    valid_in = 1;
    x = 16'd4;
    $display("time = %t input = %d,rst = %d valid_in = %d,out = %d",$time,x,rst,valid_in,y);

    #10;  
    valid_in = 1;
    x = 16'd5;
    $display("time = %t input = %d,rst = %d valid_in = %d,out = %d",$time,x,rst,valid_in,y);

    #10;
    $display("time = %t input = %d,rst = %d valid_in = %d,out = %d",$time,x,rst,valid_in,y);

    #10;
    $display("time = %t input = %d,rst = %d valid_in = %d,out = %d",$time,x,rst,valid_in,y);

    #10;
    $display("time = %t input = %d,rst = %d valid_in = %d,out = %d",$time,x,rst,valid_in,y);

    #10;
    $display("time = %t input = %d,rst = %d valid_in = %d,out = %d",$time,x,rst,valid_in,y);

    #10;
    $display("time = %t input = %d,rst = %d valid_in = %d,out = %d",$time,x,rst,valid_in,y);

    #10;
    $display("time = %t input = %d,rst = %d valid_in = %d,out = %d",$time,x,rst,valid_in,y);

    #10;
    $finish;

end

endmodule