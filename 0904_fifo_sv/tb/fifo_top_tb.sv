`timescale 1ns/1ps

module fifo_top_tb;

    localparam int DATA_WIDTH = 8;
    localparam int DEPTH      = 8;   

    logic clk, rst_n;
    logic wr_en, rd_en;
    logic [DATA_WIDTH-1:0] wr_data, rd_data;
    logic full, empty;

    int   error_count = 0;

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

    task automatic do_write(input [DATA_WIDTH-1:0] ch);
        @(negedge clk);
        wr_en   = 1'b1;
        wr_data = ch;
        @(negedge clk);
        wr_en   = 1'b0;
    endtask

    task automatic do_read(output logic [DATA_WIDTH-1:0] data_out);
        @(negedge clk);
        data_out = rd_data;   
        rd_en = 1'b1;
        @(negedge clk);
        rd_en = 1'b0;
    endtask

    // -----------------------------------------------------------
    // 메인 시나리오
    // -----------------------------------------------------------
    string send_str = "HELLO";
    string recv_str = "";
    byte   ch;
    logic [DATA_WIDTH-1:0] captured_data;
    int    frame_len;   // 문자열 길이 + null terminator 1바이트

    initial begin
        // 초기화
        rst_n   = 0;
        wr_en   = 0;
        rd_en   = 0;
        wr_data = '0;

        repeat (3) @(negedge clk);
        rst_n = 1;
        @(negedge clk);

        // 리셋 직후 상태 확인
        if (!empty) begin
            $display("[FAIL] reset 직후 empty=1 이어야 하는데 empty=%0d", empty);
            error_count++;
        end
        if (full) begin
            $display("[FAIL] reset 직후 full=0 이어야 하는데 full=%0d", full);
            error_count++;
        end

        // -------------------------------------------------
        // 1) "HELLO" + null terminator write
        // -------------------------------------------------
        frame_len = send_str.len() + 1;   // +1 : null terminator
        $display("[INFO] Write phase: \"%s\" + null terminator", send_str);
        for (int i = 0; i < frame_len; i++) begin
            if (full) begin
                $display("[FAIL] write 도중 예상치 못한 full 상태 발생 (idx=%0d)", i);
                error_count++;
            end
            if (i < send_str.len())
                do_write(send_str[i]);
            else
                do_write(8'h00);   // null terminator
        end

        // -------------------------------------------------
        // 2) read 하여 문자열 재조립 (null terminator 만나면 종료)
        // -------------------------------------------------
        $display("[INFO] Read phase");
        for (int i = 0; i < frame_len; i++) begin
            if (empty) begin
                $display("[FAIL] read 도중 예상치 못한 empty 상태 발생 (idx=%0d)", i);
                error_count++;
            end
            do_read(captured_data);

            if (i < send_str.len()) begin
                ch = captured_data;
                recv_str = {recv_str, string'(ch)};
            end else begin
                if (captured_data != 8'h00) begin
                    $display("[FAIL] null terminator 위치에서 0x00이 아닌 값 나옴: %0h", captured_data);
                    error_count++;
                end
            end
        end

        if (recv_str != send_str) begin
            $display("[FAIL] 송신 문자열과 수신 문자열 불일치: sent=\"%s\" recv=\"%s\"",
                      send_str, recv_str);
            error_count++;
        end else begin
            $display("[PASS] 문자열 재조립 성공 (null terminator 확인): \"%s\"", recv_str);
        end

        // -------------------------------------------------
        // 3) empty 상태에서 read 시도 -> 무시되어야 함 (언더플로우 방지)
        // -------------------------------------------------
        if (!empty) begin
            $display("[FAIL] 모든 데이터를 읽은 후 empty=1 이어야 함");
            error_count++;
        end else begin
            $display("[PASS] 모든 데이터 read 후 empty=1 확인");
        end

        do_read(captured_data); // empty 상태에서 read 시도 (무시되어야 함)
        if (!empty) begin
            $display("[FAIL] empty 상태에서 read 시도 후에도 empty=1 이어야 하는데 아님");
            error_count++;
        end else begin
            $display("[PASS] empty 상태에서 read 시도가 무시됨 (언더플로우 방지 확인)");
        end

        // -------------------------------------------------
        // 4) full까지 채운 뒤 추가 write 시도 -> 무시되어야 함 (오버플로우 방지)
        // -------------------------------------------------
        $display("[INFO] Full 테스트: DEPTH=%0d 개 write", DEPTH);
        for (int i = 0; i < DEPTH; i++) begin
            do_write(8'h41 + i); // 'A', 'B', 'C', ...
        end

        if (!full) begin
            $display("[FAIL] DEPTH만큼 write 후 full=1 이어야 하는데 아님");
            error_count++;
        end else begin
            $display("[PASS] DEPTH만큼 write 후 full=1 확인");
        end

        do_write(8'hFF);
        if (!full) begin
            $display("[FAIL] full 상태에서 write 시도 후에도 full=1 이어야 하는데 아님");
            error_count++;
        end else begin
            $display("[PASS] full 상태에서 write 시도가 무시됨 (오버플로우 방지 확인)");
        end

        @(negedge clk);
        if (error_count == 0)
            $display("\n===== ALL TESTS PASSED =====");
        else
            $display("\n===== %0d TEST(S) FAILED =====", error_count);

        $finish;
    end

endmodule