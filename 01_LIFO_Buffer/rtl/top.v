module top #(
    parameter DATA_WIDTH    = 16,
    parameter POINTER_WIDTH = 4
)(
    input  wire clk,
    input  wire rst_n,
    input  wire wr,
    input  wire rd,
    input  wire [POINTER_WIDTH:0] low,
    input  wire [POINTER_WIDTH:0] high,
    input  wire [DATA_WIDTH-1:0]  data_in,
    output wire [DATA_WIDTH-1:0]  data_out,
    output wire lifo_empty,
    output wire lifo_full,
    output wire lifo_low_th,
    output wire lifo_high_th,
    output wire lifo_ov,
    output wire lifo_ud
);

    wire [POINTER_WIDTH:0] pointer_w;
    wire [POINTER_WIDTH:0] next_pointer_w;
    
    wire lifo_we_w;      
    wire lifo_re_w;      
    
    wire lifo_full_w;   
    wire lifo_empty_w; 

    assign lifo_full  = lifo_full_w;
    assign lifo_empty = lifo_empty_w;

    pointer #(
        .POINTER_WIDTH(POINTER_WIDTH)
    ) ctrl (
        .clk         (clk),
        .rst_n       (rst_n),
        .wr          (wr),
        .rd          (rd),
        .lifo_full   (lifo_full_w),  
        .lifo_empty  (lifo_empty_w),
        .pointer     (pointer_w),
        .next_pointer(next_pointer_w),
        .lifo_we     (lifo_we_w),  
        .lifo_re     (lifo_re_w)   
    );

    status #(
        .POINTER_WIDTH(POINTER_WIDTH)
    ) u_status (
        .pointer      (pointer_w),
        .low          (low),
        .high         (high),
        .lifo_empty   (lifo_empty_w), 
        .lifo_full    (lifo_full_w), 
        .lifo_low_th  (lifo_low_th),
        .lifo_high_th (lifo_high_th)
    );

    ov_uv error (
        .clk        (clk),
        .rst_n      (rst_n),
        .wr         (wr),           
        .rd         (rd),         
        .lifo_full  (lifo_full_w), 
        .lifo_empty (lifo_empty_w), 
        .lifo_we    (lifo_we_w),    
        .lifo_re    (lifo_re_w),    
        .lifo_ov    (lifo_ov),     
        .lifo_ud    (lifo_ud)      
    );

    memory #(
        .DATA_WIDTH   (DATA_WIDTH),
        .POINTER_WIDTH(POINTER_WIDTH),
        .DATA_NUM     (2**POINTER_WIDTH)
    ) u_mem (
        .clk          (clk),
        .lifo_we      (lifo_we_w),      
        .pointer      (pointer_w),      
        .next_pointer (next_pointer_w), 
        .data_in      (data_in),
        .data_out     (data_out)
    );

endmodule
