`timescale 1ns / 1ps

module prn_code_generator_tb;

    reg clk;
    reg rst;
    reg start;
    reg [2:0] prn_id;
    reg pd;

    wire [13:0] addr;
    wire out_valid;
    wire prn_bit;

    prn_code_generator uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .prn_id(prn_id),
        .pd(pd),
        .addr(addr),
        .out_valid(out_valid),
        .prn_bit(prn_bit)
    );

    always #5 clk = ~clk;

    integer f,i;

    initial 
    begin

        $dumpfile("wave.vcd");
        $dumpvars(0, prn_code_generator_tb);
        clk = 0;
        rst = 1;
        start = 0;
        prn_id = 3'b101;  
        pd = 1'b0;  //pd = 1 for data and pd = 0 for pilot       

        f = $fopen("prn_code_output.txt", "w");
        if (!f) 
        begin
            $display("Error: Could not open file.");
            $finish;
        end


        #20;
        rst = 0;
        start = 1;
        i = 0;
        prn_id = 3'b101;  //prn id
        pd = 1'b0;        //pd = 1 for data and pd = 0 for pilot 
        $display("pd = %d prn_id = %d\n",pd,prn_id);

        while (i < 10230) 
        begin
            @(posedge clk);
            if (out_valid) 
            begin
                $fwrite(f, "%b ", prn_bit);
                // $display("%d\n",prn_bit);
            end
            i=i+1;
        end
        $finish;

        $fclose(f);
    end

endmodule
