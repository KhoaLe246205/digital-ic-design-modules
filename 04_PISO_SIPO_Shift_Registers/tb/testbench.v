module testbench;
	reg clk, rst_n;
	reg start;
	reg mode_selected;
	reg serial_in;
	reg [7:0] parrallel_in;
	wire chip_finish;
	wire serial_out;
	wire [7:0] parrallel_out;

	top dut (
		.clk(clk),
		.rst_n(rst_n),
		.start(start),
		.mode_selected(mode_selected),
		.serial_in(serial_in),
		.parrallel_in(parrallel_in),
		.chip_finish(chip_finish),
		.serial_out(serial_out),
		.parrallel_out(parrallel_out)
	);

	initial begin
		clk = 1'b1;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0;
		start = 1'b0;
		mode_selected = 1'b0;
		parrallel_in = 8'b0;
		serial_in = 1'b0;
		#10;
		rst_n = 1'b1;
		start = 1'b1;
		parrallel_in = 8'b10101010;
		#15 start = 1'b0;
		repeat(12) @(posedge clk);
		start = 1'b1;
		mode_selected = 1'b1;
		parrallel_in = 8'b0;
		#15 start = 1'b0;
		repeat(8) begin
			@(posedge clk) serial_in = ~serial_in;
		end
		repeat(3) @(posedge clk);
		start = 1'b0;
		#100;
		$stop;
	end

endmodule
		
		
