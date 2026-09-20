
module fifo_top #(
    parameter int DATA_WIDTH = 8,  
    parameter int DEPTH      = 16,
    parameter int ADDR_WIDTH = $clog2(DEPTH)
) (
    input  logic                      clk,
    input  logic                      rst_n,

    input  logic                      wr_en,
    input  logic [DATA_WIDTH-1:0]     wr_data,

    input  logic                      rd_en,
    output logic [DATA_WIDTH-1:0]     rd_data,

    output logic                      full,
    output logic                      empty
);

    logic [ADDR_WIDTH-1:0] wr_addr, rd_addr;
    logic                  wr_valid, rd_valid;

    fifo_ctrl #(
        .DEPTH      (DEPTH),
        .ADDR_WIDTH (ADDR_WIDTH)
    ) u_fifo_ctrl (
        .clk      (clk),
        .rst_n    (rst_n),
        .wr_en    (wr_en),
        .rd_en    (rd_en),
        .wr_addr  (wr_addr),
        .rd_addr  (rd_addr),
        .wr_valid (wr_valid),
        .rd_valid (rd_valid),
        .full     (full),
        .empty    (empty)
    );

    register_file #(
        .DATA_WIDTH (DATA_WIDTH),
        .DEPTH      (DEPTH),
        .ADDR_WIDTH (ADDR_WIDTH)
    ) u_register_file (
        .clk      (clk),
        .rst_n    (rst_n),
        .wr_valid (wr_valid),
        .rd_valid (rd_valid),
        .wr_addr  (wr_addr),
        .wr_data  (wr_data),
        .rd_addr  (rd_addr),
        .rd_data  (rd_data)
    );

endmodule