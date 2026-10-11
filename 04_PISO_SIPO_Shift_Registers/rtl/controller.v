module controller (
	input wire clk, rst_n,
	input wire start,
	input wire mode_selected,
	output wire load,
	output wire shift,
	output wire read,
	output reg chip_finish
);

wire shift_wire;
wire en;
wire finish;
reg shift_reg;

assign shift = shift_wire;
assign en = shift_reg;

FSM Control (
	.clk(clk),
	.rst_n(rst_n),
	.start(start),
	.mode_selected(mode_selected),
	.finish(finish),
	.load(load),
	.shift(shift_wire),
	.read(read)
);

counter shift_clk (
	.clk(clk),
	.rst_n(rst_n),
	.en(en),
	.finish(finish)
);

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		shift_reg <= 1'b0;
		chip_finish <= 1'b0;
	end else begin
		shift_reg <= shift_wire;
		chip_finish <= finish;
	end
end

endmodule
