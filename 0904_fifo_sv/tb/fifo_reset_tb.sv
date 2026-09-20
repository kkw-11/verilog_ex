`timescale 1ns/1ps

module fifo_reset_tb;

    localparam int DATA_WIDTH = 8;
    localparam int DEPTH      = 16;

    logic clk, rst_n;
    logic wr_en, rd_en;
    logic [DATA_WIDTH-1:0] wr_data, rd_data;
    logic full, empty;

    // DUT
    fifo_top #(
        .DATA_WIDTH (DATA_WIDTH),
        .DEPTH      (DEPTH)
    ) dut (
        .clk     (clk),
        .rst_n   (rst_n),
        .wr_en   (wr_en),
        .wr_data (wr_data),
        .rd_en   (rd_en),
        .rd_data (rd_data),
        .full    (full),
        .empty   (empty)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
      $fsdbDumpfile("wave.fsdb");
      $fsdbDumpvars(0, fifo_reset_tb);
    end

    initial begin
        rst_n   = 0;
        wr_en   = 0;
        rd_en   = 0;
        wr_data = '0;

        repeat (3) @(negedge clk);   
        rst_n = 1;                   
        @(negedge clk);              

        if (empty !== 1'b1)
            $display("[FAIL] empty=%0d (expected 1)", empty);
        else
            $display("[PASS] empty=1 check");

        if (full !== 1'b0)
            $display("[FAIL] full=%0d (expected 0)", full);
        else
            $display("[PASS] full=0 check");

        $finish;
    end

endmodule