module register_file #(
    parameter int DATA_WIDTH = 8,  
    parameter int DEPTH      = 16,
    parameter int ADDR_WIDTH = $clog2(DEPTH)
) (
    input  logic                      clk,
    input  logic                      rst_n,
 
    input  logic                      wr_valid,
    input  logic [ADDR_WIDTH-1:0]     wr_addr,
    input  logic [DATA_WIDTH-1:0]     wr_data,
 
    input  logic [ADDR_WIDTH-1:0]     rd_addr,
    output logic [DATA_WIDTH-1:0]     rd_data
);
 
    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];
 
    always_ff @(posedge clk) begin
        if (wr_valid)
            mem[wr_addr] <= wr_data;
    end
 
    assign rd_data = mem[rd_addr];
 
endmodule
 