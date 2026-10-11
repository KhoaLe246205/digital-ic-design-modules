module second_counter #(parameter freq = 99) (
	input wire clk, rst_n,
	input wire en,
	output wire second_cnt_pre_last,
	output wire second_cnt_finish
);

reg [6:0] second_count;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) 
		second_count <= freq;
	else if(second_cnt_finish)
		second_count <= freq;
	else if(en)
		second_count <= second_count - 1'b1;
	else 
		second_count <= second_count;
end

assign second_cnt_finish = (second_count == 7'b0) ? 1'b1 : 1'b0;
assign second_cnt_pre_last = (second_count == 7'b0000001) ? 1'b1 : 1'b0;

endmodule