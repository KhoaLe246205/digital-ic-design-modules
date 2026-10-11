module status #(
    parameter POINTER_WIDTH = 4
)(
    input  wire [POINTER_WIDTH:0] pointer,
    input  wire [POINTER_WIDTH:0] low,  
    input  wire [POINTER_WIDTH:0] high, 
    output wire lifo_empty,
    output wire lifo_full,
    output wire lifo_low_th,
    output wire lifo_high_th
);
    assign lifo_full  = pointer[POINTER_WIDTH];
    assign lifo_empty = ~|pointer;
    assign lifo_low_th  = (pointer < low);
    assign lifo_high_th = (pointer >= high);

endmodule
