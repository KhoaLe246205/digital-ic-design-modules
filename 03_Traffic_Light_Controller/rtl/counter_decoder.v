module counter_decoder (
	input wire [4:0] count,
	input wire clk, rst_n,
	input wire en,
	output wire [6:0] seg_tens,
	output wire [6:0] seg_units
);

wire [3:0] tens, units;
wire decode_en;

decimal_split count2hex (
	.clk(clk),
	.rst_n(rst_n),
	.en(en),
	.count(count),
	.decode_en(decode_en),
	.tens(tens),
	.units(units)
);

hex2seg led7seg_tens (
	.hex(tens),
	.en(decode_en),
	.seg(seg_tens)
);

hex2seg led7seg_units (
	.hex(units),
	.en(decode_en),
	.seg(seg_units)
);

endmodule

