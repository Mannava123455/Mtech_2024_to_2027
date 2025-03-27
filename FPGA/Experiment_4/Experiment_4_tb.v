module fir_filter_tb;

    reg clk;
    reg rst;
    reg signed [15:0] x;
    wire signed [15:0] y;
    reg signed [15:0] data_in[2400:0];
    integer i,file,file1,file2,file3;
    reg valid_in;
    wire valid_out;
    integer f1,read_status;

    fir_filter uut (
    .clk(clk),
	.rst(rst),
    .input_signal(x),
	.valid_in(valid_in),
	.output_signal(y),
	.valid_out(valid_out)
    );

    

    initial 
    begin
        clk = 0;
        forever #5 clk = ~clk; // Generate 10ns clock
    end

    initial 
    begin
    f1 = $fopen("input_signal_4.txt", "r");  
	// $readmemb("input_signal_1.txt", data_in);
	
    rst = 1;
    x = 16'd0; 
	valid_in=0;
	#15; rst = 0; 
	
    for (i = 0; i <= 1309; i = i + 1) 
    begin
    read_status = $fscanf(f1, "%d\n", data_in[i]);  
      #10; 
      x=data_in[i];
      valid_in=1;
	end
      valid_in=1;
        x = 16'd0; 
       #2000  $finish;
    end

    integer count=0;

    initial 
    begin
    file3=$fopen("verilog_output_4.txt","w");
    end
    always@(posedge clk) 
    begin
	if (valid_out==1 && count< 123 + 1309 -1) 
    begin
		$fwrite(file3, "%d\n", y); 
		count=count+1; 
	end
end


endmodule
