module memory #(
    parameter DATA_WIDTH    = 16,
    parameter POINTER_WIDTH = 4,
    parameter DATA_NUM      = 16
)(
    input  wire clk,
    input  wire lifo_we,
    input  wire [POINTER_WIDTH:0] pointer,      
    input  wire [POINTER_WIDTH:0] next_pointer, 
    input  wire [DATA_WIDTH-1:0]  data_in,
    
    output reg  [DATA_WIDTH-1:0]  data_out
);
    reg [DATA_WIDTH-1:0] mem_array [DATA_NUM-1:0];
    
    always @(posedge clk) begin
        if (lifo_we)
            mem_array[pointer[POINTER_WIDTH-1:0]] <= data_in;
    end
    always @(posedge clk) begin
        data_out <= mem_array[next_pointer[POINTER_WIDTH-1:0]];
    end

endmodule
