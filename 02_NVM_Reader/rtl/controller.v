module controller (
	input wire clk, rst_n,
	input wire read_en,
	output wire load,
	output wire shift,
	output reg chip_finish
);

wire shift_wire;
reg shift_reg;
wire en;
wire finish;

assign en = shift_reg;
assign shift = shift_wire;

FSM Control (
	.clk(clk),
	.rst_n(rst_n),
	.read_en(read_en),
	.load(load),
	.shift(shift_wire),
	.finish(finish)
);

always @(posedge clk) begin
	shift_reg <= shift_wire;
	chip_finish <= finish;
end

counter data (
	.clk(clk),
	.rst_n(rst_n),
	.en(en),
	.finish(finish)
);

endmodule

