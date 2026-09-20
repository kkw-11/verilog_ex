module fifo_ctrl #(
    parameter int DEPTH       = 16,
    parameter int ADDR_WIDTH  = $clog2(DEPTH)
) (
    input  logic                      clk,
    input  logic                      rst_n,

    input  logic                      wr_en,
    input  logic                      rd_en,

    output logic [ADDR_WIDTH-1:0]     wr_addr,
    output logic [ADDR_WIDTH-1:0]     rd_addr,

    output logic                      wr_valid,   
    output logic                      rd_valid,  

    output logic                      full,
    output logic                      empty
);

    logic [ADDR_WIDTH:0] wr_ptr, rd_ptr;

    assign wr_valid = wr_en && !full;
    assign rd_valid = rd_en && !empty;

    // -----------------------------------------------------------
    // write pointer
    // -----------------------------------------------------------
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            wr_ptr <= '0;
        else if (wr_valid)
            wr_ptr <= wr_ptr + 1'b1;
    end

    // -----------------------------------------------------------
    // read pointer
    // -----------------------------------------------------------
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            rd_ptr <= '0;
        else if (rd_valid)
            rd_ptr <= rd_ptr + 1'b1;
    end

    assign wr_addr = wr_ptr[ADDR_WIDTH-1:0];
    assign rd_addr = rd_ptr[ADDR_WIDTH-1:0];

    assign empty = (wr_ptr == rd_ptr);
    assign full  = (wr_ptr[ADDR_WIDTH-1:0] == rd_ptr[ADDR_WIDTH-1:0]) &&
                   (wr_ptr[ADDR_WIDTH]     != rd_ptr[ADDR_WIDTH]);

endmodule