module PISO_SIPO_8bit (
	input wire clk, rst_n,
	input wire shift,
	input wire load,
	input wire read,
	input wire [7:0] parrallel_in,
	input wire serial_in,
	output wire serial_out,
	output wire [7:0] parrallel_out
);

reg [7:0] data_reg;
reg serial_out_reg;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		data_reg <= 8'b0;
		serial_out_reg <= 1'b0;
	end else if (load) 
		data_reg <= parrallel_in;
	else if (shift) begin
		serial_out_reg <= data_reg[7];
		data_reg <= {data_reg[6:0], serial_in};
	end else begin
		serial_out_reg <= 0;
		data_reg <= data_reg;
	end
end

assign serial_out = serial_out_reg;
assign parrallel_out = (read) ? data_reg : 8'b0;

endmodule
		
		

