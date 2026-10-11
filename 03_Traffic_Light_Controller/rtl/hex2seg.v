module hex2seg (
  	input wire [3:0] hex,
	input wire en,
   	output reg [6:0] seg
);

always @(*) begin
  	if(en) begin
		case (hex)
        		4'h0: seg = 7'b0111111;
        		4'h1: seg = 7'b0000110; 
        		4'h2: seg = 7'b1011011; 
        		4'h3: seg = 7'b1001111; 
        		4'h4: seg = 7'b1100110; 
        		4'h5: seg = 7'b1101101;
        		4'h6: seg = 7'b1111101;
        		4'h7: seg = 7'b0000111; 
        		4'h8: seg = 7'b1111111;
        		4'h9: seg = 7'b1101111;
        		default: seg = 7'b0000000; 
    		endcase
	end else 
		seg = 7'b0000000;
end

endmodule
