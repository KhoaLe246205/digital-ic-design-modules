module FSM (
	input wire clk, rst_n,
	input wire read_en,
	input wire finish,
	output reg load,
	output reg shift
);

reg [1:0] current_state, next_state;

localparam IDLE = 2'b01;
localparam LOAD = 2'b10;
localparam SHIFT = 2'b11;
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) 
		current_state <= IDLE;
	else 
		current_state <= next_state;
end

always @(*) begin
	case(current_state) 
		IDLE:
			if(read_en)
				next_state = LOAD;
			else 
				next_state = IDLE;
		LOAD:
			next_state = SHIFT;
		SHIFT:
			if(finish)
				next_state = IDLE;
			else 
				next_state = SHIFT;
		default: next_state = IDLE;
	endcase
end

assign load = (current_state == LOAD) ? 1'b1 : 1'b0;
assign shift = (current_state == SHIFT) ? 1'b1 : 1'b0;

endmodule
