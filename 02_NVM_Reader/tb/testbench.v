module top_tb;
	reg clk, rst_n;
	reg read_en;
	reg [7:0] data_in;
	reg [7:0] address_in;
	wire chip_finish;
	wire data_out;
	wire [7:0] address_out;

	top dut (
		.clk(clk),
		.rst_n(rst_n),
		.read_en(read_en),
		.data_in(data_in),
		.address_in(address_in),
		.chip_finish(chip_finish),
		.data_out(data_out),
		.address_out(address_out)
	);

	initial begin 
		clk = 1'b1;
		forever #5 clk = ~clk;
	end
	
	initial begin
		rst_n = 1'b0;
		read_en = 1'b0;
		data_in = 8'b0;
		address_in = 8'b0;
		#10 rst_n = 1'b1;
		#10;
		read_en = 1'b1;
		address_in = 8'b11001100;
		data_in = 8'b10101010;
		#15;
		read_en = 1'b0;
		repeat(8) @(posedge clk);
		#40;
		read_en = 1'b1;
		data_in = 8'b01010101;
		address_in = 8'b00110011;
		#15;
		read_en = 1'b0;
		repeat(8) @(posedge clk);
		#20;
		$finish;
	end

endmodule

