module top (
	input wire clk, rst_n,
	input wire start,
	input wire mode_selected,
	input wire serial_in,
	input wire [7:0] parrallel_in,
	output wire [7:0] parrallel_out,
	output wire serial_out,
	output wire chip_finish
);

wire load, shift, read;

controller PISO_SIPO_Controller (
	.clk(clk),
	.rst_n(rst_n),
	.start(start),
	.mode_selected(mode_selected),
	.chip_finish(chip_finish),
	.load(load),
	.shift(shift),
	.read(read)
);

PISO_SIPO_8bit PISO_SIPO_shift_reg (
	.clk(clk),
	.rst_n(rst_n),
	.load(load),
	.shift(shift),
	.read(read),
	.serial_in(serial_in),
	.parrallel_in(parrallel_in),
	.serial_out(serial_out),
	.parrallel_out(parrallel_out)
);

endmodule
