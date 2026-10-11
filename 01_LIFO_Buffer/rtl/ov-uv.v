module ov_uv (
    input  wire clk,
    input  wire rst_n,
    input  wire wr,        
    input  wire rd,         
    input  wire lifo_full, 
    input  wire lifo_empty, 
    input  wire lifo_we,    
    input  wire lifo_re,    
    output reg  lifo_ov,  
    output reg  lifo_ud
);

    always @(posedge clk) begin
        if (~rst_n)          
            lifo_ov <= 1'b0;
        else if (lifo_re)    
            lifo_ov <= 1'b0;     
        else if (wr & lifo_full) 
            lifo_ov <= 1'b1;     
    end

    always @(posedge clk) begin
        if (~rst_n)          
            lifo_ud <= 1'b0;
        else if (lifo_we)    
            lifo_ud <= 1'b0;  
        else if (rd & lifo_empty) 
            lifo_ud <= 1'b1;    
    end

endmodule
