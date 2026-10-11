module top (
	input wire clk, rst_n,
	input wire read_en,
	input wire [7:0] data_in,
	input wire [7:0] address_in,
	output wire chip_finish,
	output wire data_out,
	output wire [7:0] address_out
);


wire load, shift;

controller NVM_Controller (
	.clk(clk),
	.rst_n(rst_n),
	.read_en(read_en),
	.chip_finish(chip_finish),
	.load(load),
	.shift(shift)
);

PISO piso_shift_reg (
	.clk(clk),
	.rst_n(rst_n),
	.data_in(data_in),
	.load(load),
	.shift(shift),
	.data_out(data_out)
);

assign address_out = (load) ? address_in : 8'b0;

endmodule