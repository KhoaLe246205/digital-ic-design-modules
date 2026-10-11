module counter (
	input wire clk, rst_n,
	input wire en,
	output wire finish
);

reg [3:0] count;  

always @(posedge clk or negedge rst_n) begin 
	if(!rst_n) 
		count <= 3'b0;
	else if (en) 
		count <= count + 1'b1;
	else 
		count <= 3'b0;
end

assign finish = (count == 3'b111) ? 1'b1: 1'b0;

endmodule
		