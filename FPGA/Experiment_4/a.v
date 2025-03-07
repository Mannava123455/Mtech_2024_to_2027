module fir(input signed [15:0] din,
input signed [15:0] prev,
input signed [15:0] coeff,
output signed [15:0] dout);

wire signed [31:0] temp;
assign temp=din*coeff;
assign dout={temp[31],temp[28:14]}+prev;
endmodule 




module fir_filter (
    input clk,
    input rst,
    input signed [15:0] input_signal,
    input valid_in,
    output reg valid_out,
    output reg signed [15:0] output_signal
);

  parameter N = 123;

    reg signed [15:0] filter_coefcients [0:N-1];   
    reg signed [15:0] shift_reg[0:N-1]; 
    wire signed [15:0] buffer[0:N-1];  
    reg [15:0] index;
    reg valid_in_reg;
    integer k;

    // initialize coefcients
    initial 
    begin
        filter_coefcients[0] = -5;
        filter_coefcients[1] = -11;
        filter_coefcients[2] = -9;
        filter_coefcients[3] = 13;
        filter_coefcients[4] = 57;
        filter_coefcients[5] = 105;
        filter_coefcients[6] = 123;
        filter_coefcients[7] = 80;
        filter_coefcients[8] = -14;
        filter_coefcients[9] = -110;
        filter_coefcients[10] = -151;
        filter_coefcients[11] = -115;
        filter_coefcients[12] = -41;
        filter_coefcients[13] = 3;
        filter_coefcients[14] = -22;
        filter_coefcients[15] = -87;
        filter_coefcients[16] = -121;
        filter_coefcients[17] = -84;
        filter_coefcients[18] = -5;
        filter_coefcients[19] = 43;
        filter_coefcients[20] = 15;
        filter_coefcients[21] = -53;
        filter_coefcients[22] = -77;
        filter_coefcients[23] = -13;
        filter_coefcients[24] = 91;
        filter_coefcients[25] = 140;
        filter_coefcients[26] = 90;
        filter_coefcients[27] = 3;
        filter_coefcients[28] = -11;
        filter_coefcients[29] = 87;
        filter_coefcients[30] = 213;
        filter_coefcients[31] = 242;
        filter_coefcients[32] = 141;
        filter_coefcients[33] = 15;
        filter_coefcients[34] = 6;
        filter_coefcients[35] = 137;
        filter_coefcients[36] = 273;
        filter_coefcients[37] = 249;
        filter_coefcients[38] = 59;
        filter_coefcients[39] = -124;
        filter_coefcients[40] = -119;
        filter_coefcients[41] = 63;
        filter_coefcients[42] = 201;
        filter_coefcients[43] = 90;
        filter_coefcients[44] = -227;
        filter_coefcients[45] = -469;
        filter_coefcients[46] = -404;
        filter_coefcients[47] = -114;
        filter_coefcients[48] = 42;
        filter_coefcients[49] = -204;
        filter_coefcients[50] = -710;
        filter_coefcients[51] = -1002;
        filter_coefcients[52] = -751;
        filter_coefcients[53] = -180;
        filter_coefcients[54] = 58;
        filter_coefcients[55] = -493;
        filter_coefcients[56] = -1507;
        filter_coefcients[57] = -1972;
        filter_coefcients[58] = -991;
        filter_coefcients[59] = 1341;
        filter_coefcients[60] = 3799;
        filter_coefcients[61] = 4849;
        filter_coefcients[62] = 3799;
        filter_coefcients[63] = 1341;
        filter_coefcients[64] = -991;
        filter_coefcients[65] = -1972;
        filter_coefcients[66] = -1507;
        filter_coefcients[67] = -493;
        filter_coefcients[68] = 58;
        filter_coefcients[69] = -180;
        filter_coefcients[70] = -751;
        filter_coefcients[71] = -1002;
        filter_coefcients[72] = -710;
        filter_coefcients[73] = -204;
        filter_coefcients[74] = 42;
        filter_coefcients[75] = -114;
        filter_coefcients[76] = -404;
        filter_coefcients[77] = -469;
        filter_coefcients[78] = -227;
        filter_coefcients[79] = 90;
        filter_coefcients[80] = 201;
        filter_coefcients[81] = 63;
        filter_coefcients[82] = -119;
        filter_coefcients[83] = -124;
        filter_coefcients[84] = 59;
        filter_coefcients[85] = 249;
        filter_coefcients[86] = 273;
        filter_coefcients[87] = 137;
        filter_coefcients[88] = 6;
        filter_coefcients[89] = 15;
        filter_coefcients[90] = 141;
        filter_coefcients[91] = 242;
        filter_coefcients[92] = 213;
        filter_coefcients[93] = 87;
        filter_coefcients[94] = -11;
        filter_coefcients[95] = 3;
        filter_coefcients[96] = 90;
        filter_coefcients[97] = 140;
        filter_coefcients[98] = 91;
        filter_coefcients[99] = -13;
        filter_coefcients[100] = -77;
        filter_coefcients[101] = -53;
        filter_coefcients[102] = 15;
        filter_coefcients[103] = 43;
        filter_coefcients[104] = -5;
        filter_coefcients[105] = -84;
        filter_coefcients[106] = -121;
        filter_coefcients[107] = -87;
        filter_coefcients[108] = -22;
        filter_coefcients[109] = 3;
        filter_coefcients[110] = -41;
        filter_coefcients[111] = -115;
        filter_coefcients[112] = -151;
        filter_coefcients[113] = -110;
        filter_coefcients[114] = -14;
        filter_coefcients[115] = 80;
        filter_coefcients[116] = 123;
        filter_coefcients[117] = 105;
        filter_coefcients[118] = 57;
        filter_coefcients[119] = 13;
        filter_coefcients[120] = -9;
        filter_coefcients[121] = -11;
        filter_coefcients[122] = -5;
        
    end


    always @(posedge clk) 
    begin
    for (k =N-1; k > 0; k = k - 1) 
    begin
        shift_reg[k] <= shift_reg[k-1];
    end
    shift_reg[0] <= input_signal;
    end

     genvar i;
    generate
        for (i = 0; i < N; i = i + 1) 
        begin : fir_stages
            if (i == 0) 
            begin
                fir stage (
                    .din(shift_reg[i]),
                    .prev(16'd0),
                    .coeff(filter_coefcients[i]),
                    .dout(buffer[i])
                );
            end 

	        else  
            begin
                fir stage (
                    .din(shift_reg[i]),
                    .prev(buffer[i-1]),
                    .coeff(filter_coefcients[i]),
                    .dout(buffer[i])
                );
            end

        end
    endgenerate


	always@(posedge clk) 
    begin
		if (rst) 
        begin  
			valid_out<=0;
			valid_in_reg<=0;
		end
		else 
        begin
			valid_in_reg<=valid_in;
			valid_out<=valid_in_reg;
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
        end
    end


endmodule
