`timescale 1ns / 1ps

module pipelined_tb;

    // Inputs
    reg clk;
    reg [7:0] a;
    reg [7:0] b;
    reg [7:0] c;

    // Output
    wire [7:0] z;

    // Instantiate the Pipelined module
    pipelined uut (
        .clk(clk),
        .a(a),
        .b(b),
        .c(c),
        .z(z)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Stimulus
    initial begin

        $dumpfile("wave.vcd");
        $dumpvars(0, pipelined_tb);
        // Initialize inputs

        #15
        a = 1;
        b = 2;
        c =3;
        $display("\nTime = %0t | a = %d | b = %d | c = %d | z = %d",$time, a, b, c, z);

        #30
        a = 2;
        b = 3;
        c =4;
        $display("\nTime = %0t | a = %d | b = %d | c = %d | z = %d",$time, a, b, c, z);

         #30
        a = 3;
        b = 4;
        c = 5;

        $display("\nTime = %0t | a = %d | b = %d | c = %d | z = %d",$time, a, b, c, z);


         #30
        a = 4;
        b = 5;
        c = 6;
        $display("\nTime = %0t | a = %d | b = %d | c = %d | z = %d",$time, a, b, c, z);


         #30
        a = 5;
        b = 6;
        c = 7;
        $display("\nTime = %0t | a = %d | b = %d | c = %d | z = %d",$time, a, b, c, z);

        #30

        $finish;

    end


endmodule
