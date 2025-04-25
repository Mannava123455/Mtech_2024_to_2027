module prn_code_generator(
    input wire clk,
    input wire rst,
    input wire start,
    input wire [2:0] prn_id,
    input wire pd,
    output reg [13:0] addr,
    output reg out_valid,
    output reg prn_bit
);

parameter N = 10223;
reg [13:0] i;
reg [13:0] weil_index;
reg [13:0] insertion_index;
reg [13:0] insert_end;
reg [6:0] expansion_bits;

reg legendre_rom [0:N-1];

initial 
begin
    expansion_bits[0] = 0;
    expansion_bits[1] = 1;
    expansion_bits[2] = 1;
    expansion_bits[3] = 0;
    expansion_bits[4] = 1;
    expansion_bits[5] = 0;
    expansion_bits[6] = 0;

    $readmemb("legendre.mem", legendre_rom);
    
end


always @(*) 
begin
    case ({pd, prn_id})
        
        /* Data prn code settings */
        4'b1001: begin weil_index = 5097; insertion_index = 181; end
        4'b1010: begin weil_index = 5110; insertion_index = 359; end
        4'b1011: begin weil_index = 5079; insertion_index = 72;  end
        4'b1100: begin weil_index = 4403; insertion_index = 1110; end
        4'b1101: begin weil_index = 4121; insertion_index = 1480; end

        /* pilot prncodes settings */
        4'b0001: begin weil_index = 5111; insertion_index = 412; end
        4'b0010: begin weil_index = 5109; insertion_index = 161; end
        4'b0011: begin weil_index = 5108; insertion_index = 1;   end
        4'b0100: begin weil_index = 5106; insertion_index = 303; end
        4'b0101: begin weil_index = 5103; insertion_index = 207; end
        default: begin weil_index = 0; insertion_index = 0; end
    endcase
        insert_end = insertion_index + 7;
        //$display("pd = %d prn_id = %d\n",pd,prn_id);
        //$display("weil_index = %d insertion_index = %d insert_end = %d\n",weil_index,insertion_index,insert_end);

end


assign legendre_i        = legendre_rom[i];
assign legendre_shifted  = legendre_rom[(i + weil_index) % N];


always @(posedge clk or posedge rst) 
begin
    if (rst) 
    begin
        i <= 0;
        addr <= 0;
        out_valid <= 0;
    end 
    else if (start) 
    begin
        if (i < N) 
        begin
            if (i >= insertion_index && i < insert_end) 
            begin
                prn_bit <= expansion_bits[i - insertion_index];
            end 
            else 
            begin
                prn_bit <= legendre_i ^ legendre_shifted;
            end
            addr <= i;
            i <= i + 1;
            out_valid <= 1;
        end 
        else 
        begin
            out_valid <= 0;
        end
    end
end

endmodule