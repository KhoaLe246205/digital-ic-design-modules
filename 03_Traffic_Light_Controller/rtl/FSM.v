module FSM (
	input wire clk, rst_n,
	input wire en,
	input wire light_cnt_finish,
	input wire second_cnt_pre_last,
	output wire green_light,
	output wire yellow_light,
	output wire red_light,
	output reg [4:0] light_cnt_init
);
localparam IDLE = 2'b00;
localparam GREEN = 2'b01;
localparam YELLOW = 2'b10;
localparam RED = 2'b11;

reg [1:0] current_state, next_state;

always @(*) begin
	case(current_state)
		IDLE: if(en) next_state = GREEN;
		      else next_state = current_state;
		GREEN: begin
			if(light_cnt_finish && second_cnt_pre_last) 
				next_state = YELLOW;
			else 
				next_state = current_state;
		end
		
		YELLOW: begin 
			if(light_cnt_finish && second_cnt_pre_last) 
				next_state = RED;
			else 
				next_state = current_state;
		end

		RED: begin
			if(light_cnt_finish && second_cnt_pre_last) 
				next_state = GREEN;
			else 
				next_state = current_state;
		end
		
		default: next_state = GREEN;

	endcase
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n)
		current_state <= IDLE;
	else
		current_state <= next_state;
end

assign light_cnt_init =  (current_state == GREEN)  ? 5'b10010 :
		(current_state == YELLOW) ? 5'b00011 :
		(current_state == RED)    ? 5'b01111 :
					    5'b0;
assign green_light = (current_state == GREEN) ? 1'b1 : 1'b0;
assign yellow_light = (current_state == YELLOW) ? 1'b1 : 1'b0;
assign red_light = (current_state == RED) ? 1'b1 : 1'b0;

endmodule
