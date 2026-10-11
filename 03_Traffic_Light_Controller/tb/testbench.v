module test_bench;
	reg clk, rst_n;
	reg en;
	wire green_light;
	wire yellow_light;
	wire red_light;
	wire [6:0] seg_tens;
	wire [6:0] seg_units;

	top dut (
		.clk(clk),
		.rst_n(rst_n),
		.en(en),
		.green_light(green_light),
		.yellow_light(yellow_light),
		.red_light(red_light),
		.seg_tens(seg_tens),
		.seg_units(seg_units)
	);

	initial begin 
		clk = 1'b1;
		forever #5 clk = ~clk;
	end

	initial begin 
		rst_n = 1'b0;
		en = 1'b0;
		#15;
		rst_n = 1'b1;
		#10;
		en = 1'b1;
		repeat(100) @(posedge clk);
		#5 en = 1'b0;
		#100; 
		$stop;
	end

endmodule
