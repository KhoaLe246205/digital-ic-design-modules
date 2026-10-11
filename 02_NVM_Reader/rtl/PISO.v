module PISO (
	input wire clk, rst_n,
	input wire shift,
	input wire load,
	input wire [7:0] data_in,
	output reg data_out
);

reg [7:0] data_reg;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		data_reg <= 8'b0;
		data_out <= 1'b0;
	end else if (load) 
		data_reg <= data_in;
	else if (shift) begin
		data_out <= data_reg[7];
		data_reg <= {data_reg[6:0], 1'b0};
	end
end

endmodule
		
		
