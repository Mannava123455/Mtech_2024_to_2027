
// Experiment 5:
 
// Mannava Venkatasai 
// EE24MTECH12008
// FIR filter Design with pipeline

`timescale 1ns/1ps
module fir_filter_tb;

reg clk;
reg rst;
reg signed [15:0] x;
wire signed [15:0] y;
integer i;
integer f1,read_status;

reg signed [15:0] f_input;

parameter N = 123; 

fir_filter filter(
    .clk(clk),
    .rst(rst),
    .input_signal(x),
    .output_signal(y)
);

initial 
begin
    clk = 0;
    forever #5 clk = ~clk;
    
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, fir_filter_tb);
    f1 = $fopen("input_signal_1.txt", "r");  

    rst = 1;
    #15;
    rst = 0;

    for (i = 1; i <= 2400 + N -1 + 3; i++) 
    begin
        read_status = $fscanf(f1, "%d\n", f_input);  
        x = f_input;
        // $display("\ntime = %t input = %d, rst = %d, out = %d", $time, x, rst, y);
        $display("%d",y);
        #10;
    end

    #10;
    $finish;
end

endmodule