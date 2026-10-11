module pointer #(parameter POINTER_WIDTH = 4)
(
    input  wire clk,
    input  wire rst_n,
    input  wire wr,                 
    input  wire rd,                 
    input  wire lifo_full,          
    input  wire lifo_empty,        
    output reg  [POINTER_WIDTH:0] pointer,     
    output wire [POINTER_WIDTH:0] next_pointer, 
    output wire lifo_we,           
    output wire lifo_re            
);

    wire lifo_en;
    wire [POINTER_WIDTH:0] add_value;

    assign lifo_we = wr & ~lifo_full;
    assign lifo_re = rd & ~lifo_empty;
    assign lifo_en = lifo_re ^ lifo_we;

    assign add_value = lifo_re ? {{POINTER_WIDTH{1'b1}}, 1'b0} : {(POINTER_WIDTH+1){1'b0}};

    assign next_pointer = pointer + add_value + 1'b1;

    always @(posedge clk) begin
        if (~rst_n)
            pointer <= {(POINTER_WIDTH+1){1'b0}};
        else if (lifo_en)
            pointer <= next_pointer;
    end

endmodule
