
`timescale 1ns/1ps
module fir_filter( 
    input wire clk, 
    input rst, 
    input signed [15:0] input_signal,  
    output reg signed[15:0] output_signal  
); 

parameter N = 5;   

reg signed [15:0]filter_coefcients[0:N-1]; 
reg signed [15:0]shift_reg[0:N-1]; 
reg signed [15:0]shift_reg_temp[0:N-1]; 
reg signed [32:0]mul_reg[0:N-1]; 


integer i;  
integer k;
integer count;
reg [15:0]d_out;
reg [15:0]acc;
reg [15:0]temp;

initial    
    begin  
        filter_coefcients[0] = 1; 
        filter_coefcients[1] = 2;
        filter_coefcients[2] = 3; 
        filter_coefcients[3] = 4; 
        filter_coefcients[4] = 5; 

        shift_reg[0] = 0;
        shift_reg[1] = 0;
        shift_reg[2] = 0;
        shift_reg[3] = 0;
        shift_reg[4] = 0;
        count = 0;
    end

    always @ (posedge clk)
    begin
        if(rst)
        begin

            d_out = 0;

        end
        else
        begin

        for(i = N-1;i>0;i=i-1)
        begin
            shift_reg[i] <= shift_reg[i-1];
        end
        shift_reg_temp[0] <= shift_reg[0];
        if(count < N)
        begin
        shift_reg[0] <= input_signal;
        count <= count + 16'd1;
        end
        else
        begin
             shift_reg[0] <= 16'b0;
        end

        // $display("input_signal = %d",input_signal);
        // $display("time = %t rst = %d shift_reg = [%d%d%d%d%d]", $time ,shift_reg[0], shift_reg[1], shift_reg[2], shift_reg[3], shift_reg[4],rst);
        
        acc = 0;
        for(i = 0;i<N;i=i+1)
        begin
            // $display("time = %t shift_reg[%d] = %d ,acc = %d",$time,i,shift_reg[i],acc);
            mul_reg[i]  <= shift_reg[i] * filter_coefcients[i];
        end

        for(i = 0;i<N;i=i+1)
        begin
            // $display("time = %t shift_reg[%d] = %d ,acc = %d",$time,i,shift_reg[i],acc);
            acc  = acc + mul_reg[i];
        end

        output_signal <= acc;

        
        end



    end

        

       

endmodule  