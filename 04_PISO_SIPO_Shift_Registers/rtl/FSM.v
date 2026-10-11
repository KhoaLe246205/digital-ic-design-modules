module FSM (
	input wire clk, rst_n,
	input wire start,
	input wire mode_selected,
	input wire finish,
	output wire load,
	output wire shift,
	output wire read
);

reg [1:0] current_state, next_state;

localparam IDLE = 2'b00;
localparam LOAD = 2'b01;
localparam READ = 2'b10;
localparam SHIFT = 2'b11;

always @(*) begin
	case(current_state) 
		IDLE: begin
			if(start) begin
				if(!mode_selected)
					next_state = LOAD;
				else 
					next_state = SHIFT;
			end else
				next_state = IDLE;
		end

		LOAD: next_state = SHIFT;
	
		SHIFT: begin 
			if(finish) begin
				if(mode_selected) 
						next_state = READ;
				else 
						next_state = IDLE;
			end else
				next_state = SHIFT;
				
		end

		READ: next_state = IDLE;
		
		default: next_state = IDLE;
	endcase

end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) 
		current_state = IDLE;
	else
		current_state = next_state;
end

assign load = (current_state == LOAD) ? 1'b1 : 1'b0;
assign read = (current_state == READ) ? 1'b1 : 1'b0;
assign shift = (current_state == SHIFT) ? 1'b1 : 1'b0;

endmodule
			
