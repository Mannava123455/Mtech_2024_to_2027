`timescale 1ns/1ps
module fir_filter_tb;

reg clk;
reg rst;
reg signed [15:0] x;
wire signed [15:0] y;



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

initial
begin
    $dumpfile("wave.vcd");
    $dumpvars(0, fir_filter_tb);

    rst = 1;
    #15;

    rst = 0;

    x = 16'd1;
    $display("\ntime = %t input = %d,rst = %d ",$time,x,rst);
    
    #10;  
    x = 16'd2;
    $display("\ntime = %t input = %d,rst = %d ,out = %d",$time,x,rst,y);

    #10;  
    x = 16'd3;
    $display("\ntime = %t input = %d,rst = %d ,out = %d",$time,x,rst,y);

    #10;  
    x = 16'd4;
    $display("\ntime = %t input = %d,rst = %d out = %d",$time,x,rst,y);

    #10;  
    x = 16'd5;
    $display("\ntime = %t input = %d,rst = %d ,out = %d",$time,x,rst,y);

    #10;  
    $display("\ntime = %t input = %d,rst = %d ,out = %d",$time,x,rst,y);

    #10;  
    $display("\ntime = %t input = %d,rst = %d ,out = %d",$time,x,rst,y);

    #10;  
    $display("\ntime = %t input = %d,rst = %d ,out = %d",$time,x,rst,y);


    #10;  
    $display("\ntime = %t input = %d,rst = %d ,out = %d",$time,x,rst,y);


    #10;  
    $display("\ntime = %t input = %d,rst = %d ,out = %d",$time,x,rst,y);


    #10;  
    $display("\ntime = %t input = %d,rst = %d ,out = %d",$time,x,rst,y);

    #10;  
    $display("\ntime = %t input = %d,rst = %d ,out = %d",$time,x,rst,y);

    #10;  
    $display("\ntime = %t input = %d,rst = %d ,out = %d",$time,x,rst,y);

    #10;  

   
    #10;
    $finish;

end

endmodule