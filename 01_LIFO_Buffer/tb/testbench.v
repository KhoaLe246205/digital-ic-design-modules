`timescale 1ns/1ns

module testbench;
    parameter DATA_WIDTH = 8;
    parameter POINTER_WIDTH = 3;

    reg clk;
    reg rst_n;
    reg wr;
    reg rd;
    reg [POINTER_WIDTH:0] low;
    reg [POINTER_WIDTH:0] high;
    reg [DATA_WIDTH-1:0] data_in;

    wire [DATA_WIDTH-1:0] data_out;
    wire lifo_empty;
    wire lifo_full;
    wire lifo_low_th;
    wire lifo_high_th;
    wire lifo_ov;
    wire lifo_ud;

    top #(
        .DATA_WIDTH(DATA_WIDTH),
        .POINTER_WIDTH(POINTER_WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .wr(wr),
        .rd(rd),
        .low(low),
        .high(high),
        .data_in(data_in),
        .data_out(data_out),
        .lifo_empty(lifo_empty),
        .lifo_full(lifo_full),
        .lifo_low_th(lifo_low_th),
        .lifo_high_th(lifo_high_th),
        .lifo_ov(lifo_ov),
        .lifo_ud(lifo_ud)
    );

    initial begin 
    	clk = 0;
 	forever #5 clk = ~clk;
    end
    
    integer i;

    initial begin
        clk = 0; rst_n = 0; wr = 0; rd = 0; data_in = 0;
        low = 2;   
        high = 6;
        
        #20 rst_n = 1;
     
        for (i = 1; i <= 8; i = i + 1) begin
            data_in = i;
            wr = 1;
            #10;
        end
        wr = 0;
        
        #1;
        if (lifo_full) $display("CHECK: LIFO FULL -> OK");
        else           $display("CHECK: LIFO FULL -> FAIL");

        if (lifo_high_th) $display("CHECK: HIGH THRESHOLD -> OK");

        data_in = 99;
        wr = 1;
        #10;
        wr = 0;
        if (lifo_ov) $display("CHECK: OVERFLOW FLAG -> DETECTED (OK)");
        else         $display("CHECK: OVERFLOW FLAG -> FAIL");
        for (i = 0; i < 8; i = i + 1) begin
            rd = 1;
            #10;
        end
        rd = 0;
        #1;
        if (lifo_empty) $display("CHECK: LIFO EMPTY -> OK");
        else            $display("CHECK: LIFO EMPTY -> FAIL");
        
        if (lifo_low_th)   $display("CHECK: LOW THRESHOLD -> OK");

      
        $display("--- Step 4: Testing Underflow ---");
        rd = 1;
        #10;
        rd = 0;
        if (lifo_ud) $display("CHECK: UNDERFLOW FLAG -> DETECTED (OK)");
        else         $display("CHECK: UNDERFLOW FLAG -> FAIL");

        $display("=== TEST FINISHED ===");
        #20 $stop;
    end

endmodule
