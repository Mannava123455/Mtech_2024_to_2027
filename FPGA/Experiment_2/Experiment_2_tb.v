`timescale 10ns/1ps  // 1 time unit = 10 ns

module fixed_point_arthematic_tb;
    reg clk;
    reg signed [16:0] a,b;
    wire signed [17:0] sum,diff;
    wire signed [34:0] product;

    integer f1,f2,file_out_sum,file_out_diff,file_out_product;
    integer read_status,i;


    fixed_point_arthematic uut(.clk(clk),
    .operand_1(a),
    .operand_2(b),
    .sum(sum),
    .diff(diff),
    .product(product));

    always #5 clk = ~clk;

    initial 
    begin
        clk=0;

        f1 = $fopen("operand_1_in_Q_2_14.txt","r");
        f2 = $fopen("operand_2_in_Q_4_12.txt","r");
        file_out_sum = $fopen("sum_verilog_out.txt","w");
        file_out_diff = $fopen("diff_verilog_out.txt","w");
        file_out_product = $fopen("product_verilog_out.txt","w");

        $dumpfile("wave.vcd");
        $dumpvars(0, fixed_point_arthematic_tb);
        // $monitor($time,"a=%d b=%d,sum = %d",a,b,sum);
        

        // while (!($feof(f1) || $feof(f2)))
        for(i=0;i<=240;i++)
        begin
             #10
            read_status = $fscanf(f1, "%d\n",a);
            read_status = $fscanf(f2, "%d\n",b);

            if ((sum != "X") && (diff != "X") && (product != "X")) 
            begin
            $fwrite(file_out_sum, "%d\n", sum);
            $fwrite(file_out_diff, "%d\n", diff);
            $fwrite(file_out_product, "%d\n", product);
            end
        end
        $fclose(f1);
        $fclose(f2);
        $fclose(file_out_sum);
        $fclose(file_out_diff);
        $fclose(file_out_product);

        $finish;

    end

endmodule