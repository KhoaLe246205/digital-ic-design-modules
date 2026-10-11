module light_counter (
	input wire clk, rst_n, 
	input wire en,
	input wire [4:0] light_cnt_init,
	output wire light_cnt_finish,
	output reg [4:0] count
);

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) 
		count <= 5'b10010;
	else if(light_cnt_finish && en) 
		count <= light_cnt_init;
	else begin
		if(en)
			count <= count - 1'b1;
		else 
			count <= count;
	end
end

assign light_cnt_finish = (count == 5'b0) ? 1'b1 : 1'b0;

endmodule
