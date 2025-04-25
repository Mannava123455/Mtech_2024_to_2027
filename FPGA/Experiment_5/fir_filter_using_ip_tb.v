
// Experiment 5:
 
// Mannava Venkatasai 
// EE24MTECH12008
// FIR filter Design using ip

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

    fir2 uut 
    (
    .clk(clk),
	.reset_n(rst),
    .ast_sink_data(x),
	.ast_sink_valid(valid_in),
	.ast_sink_error(2'd0),
	. ast_source_data(y),//10.28 format
	.ast_source_valid(valid_out),
	.ast_source_error()
    );

initial 
begin
    clk = 0;
    forever #5 clk = ~clk;
    
end

initial begin
    f1 = $fopen("input_signal_1.txt", "r");  

    rst = 1;
    #15;
    rst = 0;

    for (i = 1; i <= 2400 + N -1 + 3; i++) 
    begin
        read_status = $fscanf(f1, "%d\n", f_input);  
        x = f_input;
        valid_in=1;
        $display("%d",y);
        #10;
    end

    #10;
    $finish;
end

endmodule