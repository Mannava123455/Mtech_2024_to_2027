module convolution(
    input signed [15:0] data_in,
    input signed [15:0] prev,
    input signed [15:0] coeff,
    output signed [15:0] dout
    );

    wire signed [31:0] temp;
    assign temp = data_in * coeff;
    assign dout = temp + prev;
endmodule





module fir_filter( 
    input wire clk, 
    input rst, 
    input signed [15:0] input_signal,  
    input valid_in,
    output reg valid_out,
    output reg signed[15:0] output_signal  
); 

parameter N = 5;   

reg signed [15:0]filter_coefcients[0:N-1]; 
reg signed [15:0]shift_reg[0:N-1]; 
wire signed [15:0]buffer[0:N-1];
integer i;  
reg valid_in_reg; 
integer k;
reg [15:0] index;
integer count;

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
        if(rst == 0)
     
        begin
        // shift the shift_register_to_right_by_1_unit
        for(i = N-1;i>0;i=i-1)
        begin
            shift_reg[i] <= shift_reg[i-1];
        end
        // take in incomming signal to first element of shift register
         if(count < N+2)
         begin
        shift_reg[0] <= input_signal;
        count <= count + 16'd1;
         end
         else
         begin
             shift_reg[0] <= 16'b0;
         end
         

        $display("input_signal = %d",input_signal);
        $display("rst = %d shift_reg = [%d%d%d%d%d]", shift_reg[0], shift_reg[1], shift_reg[2], shift_reg[3], shift_reg[4],rst);
        end
    end

        genvar iter;
        generate
            for(iter = 0;iter < N;iter = iter + 1)
            begin

                if(iter == 0)
                begin
                convolution stage_1(
                    .data_in(shift_reg[iter]),
                    .prev(16'd0),
                    .coeff(filter_coefcients[iter]),
                    .dout(buffer[iter])
                );
                end

                else
                begin

                    convolution stage_2(
                    .data_in(shift_reg[iter]),
                    .prev(buffer[iter-1]),
                    .coeff(filter_coefcients[iter]),
                    .dout(buffer[iter])
                    );
                end
            end
        endgenerate

        always @(posedge clk)
        begin
            if(rst)
            begin
                valid_out<=0;
			    valid_in_reg<=0;
            end
            else
            begin
                valid_in_reg<=valid_in;
			    valid_out<=valid_in_reg;
                $display("valid_in_reg = %d valid_out = %d",valid_in_reg,valid_out);
            end

        end

    always @(posedge clk) 
    begin
        if (rst) 
        begin
            output_signal <= 0;
             index <= 0;
	    
	    end
        else 
        begin
            output_signal <= buffer[index]; 
	        index <= valid_out?((index>=N-1)?index:index+1):0;   
            $display("buffer[%d] = %d",index,buffer[index]);
        end
    end

endmodule  