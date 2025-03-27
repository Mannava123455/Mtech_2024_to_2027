module pipelined (
    input wire clk,
    input wire [7:0] a,
    input wire [7:0] b,
    input wire [7:0] c,
    output reg [7:0] z
);

    reg [7:0] sum_ab; 

    always @(posedge clk) 
    begin
        sum_ab <= a+b; 
        z <= sum_ab+c;
        $display("a = %d,sum_ab = %d,z = %d",a,sum_ab,z);
    end

endmodule
