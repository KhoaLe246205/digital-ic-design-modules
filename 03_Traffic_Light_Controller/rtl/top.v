module top #(
	parameter freq = 99
)(
	input wire clk, rst_n,
	input wire en, 
	output wire green_light,
	output wire yellow_light,
	output wire red_light,
	output wire [6:0] seg_tens,
	output wire [6:0] seg_units
);

wire light_cnt_finish, second_cnt_pre_last, second_cnt_finish;
wire [4:0] count, light_cnt_init;

FSM Control (
	.clk(clk),
	.rst_n(rst_n),
	.en(en),
	.light_cnt_finish(light_cnt_finish),
	.second_cnt_pre_last(second_cnt_pre_last),
	.green_light(green_light),
	.yellow_light(yellow_light),
	.red_light(red_light),
	.light_cnt_init(light_cnt_init)
);

second_counter #(
	.freq(freq)
) light (
	.clk(clk),
	.rst_n(rst_n),
	.en(en),
	.second_cnt_pre_last(second_cnt_pre_last),
	.second_cnt_finish(second_cnt_finish)
);

light_counter traffic_light (
	.clk(clk),
	.rst_n(rst_n),
	.en(second_cnt_finish),
	.light_cnt_init(light_cnt_init),
	.count(count),
	.light_cnt_finish(light_cnt_finish)
);

counter_decoder led7seg (
	.clk(clk),
	.rst_n(rst_n),
	.en(en),
	.count(count),
	.seg_tens(seg_tens),
	.seg_units(seg_units)
);

endmodule