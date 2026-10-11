module decimal_split (
  	input wire clk, rst_n,
  	input wire en,
  	input wire [4:0] count,
  	output wire decode_en,
  	output wire [3:0] units,
  	output wire [3:0] tens
);

  reg [4:0] count_reg;
  wire en_count, count_change;
  reg [4:0] units_count, tens_count;
  
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) 
		count_reg <= 5'b0;
    else 
      	count_reg <= count;
  end
  
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) 
      units_count <= 4'b0;
    else if(count_change)
      units_count <= count;
    else if(en & en_count)
      units_count <= units_count - 4'b1010;
    else
      units_count <= units_count;
  end
  
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) 
      tens_count <= 4'b0;
    else if(count_change) 
      tens_count <= 4'b0;
    else if(en & en_count)
      tens_count <= tens_count + 1'b1;
    else 
      tens_count <= tens_count;
  end
  
  assign count_change = (count != count_reg) ? 1'b1 : 1'b0;
  assign en_count = (units_count > 5'b01010) ? 1'b1 : 1'b0;
  assign decode_en = (!en_count & en) ? 1'b1 : 1'b0;
  assign units = (!en_count) ? units_count : 4'b0;
  assign tens = tens_count;

endmodule

