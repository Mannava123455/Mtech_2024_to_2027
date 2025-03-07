/******************************************** Experiment 3 *******************************************************
EE24MTECH12008
Mannava Venkatasai


Fixed point division using numerical methods (Newton Raphson). Take a  fraction  like 15/23.  
Using Newton Raphson method, first compute  1/23 and then multiply with 15. 
You need to do this in fixed point.
Do your work both in Matlab and Verilog & then  verify  Verilog results with MATLAB. 
Please include mathematical derivations also as part of your report.
****************************************************************************************************************/


/* Look up table took from matlab code */
/* Look-up table module */
module lookup_table (
    input  logic [5:0] addr,
    output logic signed [63:0] data
);

    always @ (*)
    begin
        case (addr)
            6'd0:  data = 64'sd126366;
            6'd1:  data = 64'sd125342;
            6'd2:  data = 64'sd124318;
            6'd3:  data = 64'sd123294;
            6'd4:  data = 64'sd122270;
            6'd5:  data = 64'sd121246;
            6'd6:  data = 64'sd120222;
            6'd7:  data = 64'sd119198;
            6'd8:  data = 64'sd118174;
            6'd9:  data = 64'sd117150;
            6'd10: data = 64'sd116126;
            6'd11: data = 64'sd115102;
            6'd12: data = 64'sd114078;
            6'd13: data = 64'sd113054;
            6'd14: data = 64'sd112030;
            6'd15: data = 64'sd111006;
            6'd16: data = 64'sd109982;
            6'd17: data = 64'sd108958;
            6'd18: data = 64'sd107934;
            6'd19: data = 64'sd106910;
            6'd20: data = 64'sd105886;
            6'd21: data = 64'sd104862;
            6'd22: data = 64'sd103838;
            6'd23: data = 64'sd102814;
            6'd24: data = 64'sd101790;
            6'd25: data = 64'sd100766;
            6'd26: data = 64'sd99742;
            6'd27: data = 64'sd98718;
            6'd28: data = 64'sd97694;
            6'd29: data = 64'sd96670;
            6'd30: data = 64'sd95646;
            6'd31: data = 64'sd94622;
            6'd32: data = 64'sd93598;
            6'd33: data = 64'sd92574;
            6'd34: data = 64'sd91550;
            6'd35: data = 64'sd90526;
            6'd36: data = 64'sd89502;
            6'd37: data = 64'sd88478;
            6'd38: data = 64'sd87454;
            6'd39: data = 64'sd86430;
            6'd40: data = 64'sd85406;
            6'd41: data = 64'sd84382;
            6'd42: data = 64'sd83358;
            6'd43: data = 64'sd82334;
            6'd44: data = 64'sd81310;
            6'd45: data = 64'sd80286;
            6'd46: data = 64'sd79262;
            6'd47: data = 64'sd78238;
            6'd48: data = 64'sd77214;
            6'd49: data = 64'sd76190;
            6'd50: data = 64'sd75166;
            6'd51: data = 64'sd74142;
            6'd52: data = 64'sd73118;
            6'd53: data = 64'sd72094;
            6'd54: data = 64'sd71070;
            6'd55: data = 64'sd70046;
            6'd56: data = 64'sd69022;
            6'd57: data = 64'sd67998;
            6'd58: data = 64'sd66974;
            6'd59: data = 64'sd65950;
            6'd60: data = 64'sd64926;
            6'd61: data = 64'sd63902;
            6'd62: data = 64'sd62878;
            6'd63: data = 64'sd61854;
            default: data = 64'sd0;
        endcase
    end
endmodule


/* Module for normalizing the denominator between [0.5,1) */
module normalize_denominator(
    input  [63:0] in,
    output reg [63:0] out,
    output logic signed [15:0] no_of_shifts
);

    reg [63:0] temp; 

    always @(*) 
    begin
        temp = in;             
        no_of_shifts = 16'd0; 

      
        while (temp < 32'd32768) begin
            temp = temp << 1;
            no_of_shifts = no_of_shifts + 1;
        end

        while (temp >= 32'd65536) begin
            temp = temp >> 1;
            no_of_shifts = no_of_shifts - 1;
        end

        out = temp;  
    end

endmodule


/* Newton-Raphson Division Module */
module newton_raphson_division(
    input  logic signed [63:0] numerator,
    input  logic [63:0] denominator,
    output logic signed [63:0] out
);

    wire [63:0] norm_denominator;      
    wire logic signed [15:0] no_of_shifts;    
    wire [63:0] x0;       
    reg logic signed  [63:0]x_0;             
    wire [5:0] lookup_index;   
    reg [3:0]i; 

    /* Normalize the denominator between [0.5,1) */
    normalize_denominator f1(
        .in(denominator),
        .out(norm_denominator),
        .no_of_shifts(no_of_shifts)
    );

    /* Compute lookup table index */
    assign lookup_index = (norm_denominator - 64'd32768) >> 9;

    /* Fetch initial estimate from the lookup table */
    lookup_table f2(.addr(lookup_index), .data(x0));

    always @(*) 
    begin
        x_0 = x0;
        for (i = 0; i < 3; i = i + 1) 
        begin       
            x_0 = (x_0 * ((64'd131072 - ((norm_denominator * x_0) >> 16))) >> 16);        
        end

        x_0 = (x_0 * numerator) >> 16;
        if (no_of_shifts > 0)
            x_0 = x_0 << no_of_shifts;  
        else
            x_0 = x_0 >> -no_of_shifts; 
        out = x_0;
    end

endmodule

