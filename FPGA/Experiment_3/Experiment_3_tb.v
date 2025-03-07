`timescale 1ns/1ps

module newton_raphson_tb;
    reg signed [63:0] numerator;
    reg [63:0] denominator;
    wire signed [63:0] out; 

    integer read_status, i, f1, temp,f2,flag = 0;  

    newton_raphson_division uut (
        .numerator(numerator),
        .denominator(denominator),
        .out(out)  
    );

    initial 
    begin
        f1 = $fopen("division_input.txt", "r");  
        f2 = $fopen("output.txt", "w");

        if (f1 == 0) begin
            $display("Error: Could not open file!");
            $finish;
        end

        numerator = 10 << 16;  

        for (i = 0; i <= 100; i++) 
        begin
            read_status = $fscanf(f1, "%d\n", temp);  
                if(temp < 0)
                begin
                    temp = -temp;
                    flag = 1;
                end
                denominator = temp;


                #10; 

                if(flag)
                begin
                $fwrite(f2, "%d\n", -out);
                flag = 0;
                end
                else
                $fwrite(f2, "%d\n", out);
        end

        $fclose(f1);  
        $fclose(f2); 
        $finish;
    end

endmodule
