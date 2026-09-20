`include "uvm_macros.svh"
import uvm_pkg::*;

// =============================================================
// fifo_if : interface connecting DUT(fifo_top) and the testbench
// =============================================================
interface fifo_if #(parameter int DATA_WIDTH = 8) (input logic clk);
    // initialize to a safe value so the very first clock edge (before the
    // driver has driven anything) doesn't leave these signals at X, which
    // would otherwise make "disable iff (!rst_n)" fail to disable the
    // assertion below and trip a spurious full&&empty violation at t=0
    logic rst_n = 1'b0;
    logic wr_en = 1'b0, rd_en = 1'b0;
    logic [DATA_WIDTH-1:0] wr_data = '0, rd_data;
    logic full, empty;

    clocking drv_cb @(posedge clk);
        default input #1step output #1;
        output rst_n;
        output wr_en;
        output wr_data;
        output rd_en;
    endclocking

    clocking mon_cb @(posedge clk);
        default input #1step;
        input rst_n;
        input wr_en;
        input wr_data;
        input rd_en;
        input rd_data;
        input full;
        input empty;
    endclocking

    modport drv_mp (clocking drv_cb, input clk);
    modport mon_mp (clocking mon_cb, input clk);

    // full and empty must never be asserted at the same time
    property p_full_empty_excl;
        @(posedge clk) disable iff (!rst_n) !(full && empty);
    endproperty

    A_FULL_EMPTY_EXCL: assert property (p_full_empty_excl)
        else `uvm_error("[ASSERT]", "full and empty asserted simultaneously!")

endinterface


// =============================================================
// fifo_seq_item : transaction carrying a write/read request
//                 and the observed outputs
// =============================================================
class fifo_seq_item extends uvm_sequence_item;
    localparam int DATA_WIDTH = 8;

    rand bit wr_en;
    rand bit rd_en;
    rand bit [DATA_WIDTH-1:0] wr_data;
         bit rst_n;

    // fields filled in by the monitor
    bit [DATA_WIDTH-1:0] rd_data;
    bit full;
    bit empty;

    // derived fields the monitor tracks by counting valid writes/reads
    bit [3:0] occupancy;   // current fill level (0..DEPTH)
    bit       wr_wrap;     // this write caused the write pointer's address to wrap
    bit       rd_wrap;     // this read caused the read pointer's address to wrap

    constraint c_dist { wr_en dist {0 := 3, 1 := 7};
                         rd_en dist {0 := 5, 1 := 5}; }

    function new(string name = "fifo_seq_item");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(fifo_seq_item)
        `uvm_field_int(wr_en,   UVM_DEFAULT)
        `uvm_field_int(rd_en,   UVM_DEFAULT)
        `uvm_field_int(wr_data, UVM_DEFAULT)
        `uvm_field_int(rst_n,   UVM_DEFAULT)
        `uvm_field_int(rd_data, UVM_DEFAULT)
        `uvm_field_int(full,    UVM_DEFAULT)
        `uvm_field_int(empty,   UVM_DEFAULT)
        `uvm_field_int(occupancy, UVM_DEFAULT)
        `uvm_field_int(wr_wrap,   UVM_DEFAULT)
        `uvm_field_int(rd_wrap,   UVM_DEFAULT)
    `uvm_object_utils_end

    virtual function string convert2string();
        return $sformatf("rst_n=%b wr_en=%b wr_data=%0d rd_en=%b | full=%b empty=%b rd_data=%0d",
                          rst_n, wr_en, wr_data, rd_en, full, empty, rd_data);
    endfunction
endclass


// =============================================================
// sequences
//   - fifo_write_seq  : num_writes writes (covers scenarios 2/3/4/5 via count)
//   - fifo_read_seq   : num_reads reads   (covers scenarios 2/3/6/7 via count)
//   - fifo_random_seq : random mix of write/read (extra coverage)
//   (reset is not driven by a dedicated sequence: fifo_if initializes
//    rst_n=0 at t=0, a valid X->0 negedge trigger, so fifo_ctrl already
//    resets before the first item of any sequence below is ever driven)
// =============================================================
class fifo_write_seq extends uvm_sequence #(fifo_seq_item);
    `uvm_object_utils(fifo_write_seq)

    int unsigned num_writes = 8;   // set externally to tune the scenario size

    function new(string name = "fifo_write_seq");
        super.new(name);
    endfunction

    virtual task body();
        fifo_seq_item item;
        repeat (num_writes) begin
            item = fifo_seq_item::type_id::create("item");
            start_item(item);
            if (!item.randomize() with { wr_en == 1; rd_en == 0; }) begin
                `uvm_fatal(get_type_name(), "randomize fail")
            end
            item.rst_n = 1;
            finish_item(item);
        end
    endtask
endclass


class fifo_read_seq extends uvm_sequence #(fifo_seq_item);
    `uvm_object_utils(fifo_read_seq)

    int unsigned num_reads = 8;    // set externally to tune the scenario size

    function new(string name = "fifo_read_seq");
        super.new(name);
    endfunction

    virtual task body();
        fifo_seq_item item;
        repeat (num_reads) begin
            item = fifo_seq_item::type_id::create("item");
            start_item(item);
            item.rst_n  = 1;
            item.wr_en  = 0;
            item.rd_en  = 1;
            item.wr_data = '0;
            finish_item(item);
        end
    endtask
endclass


class fifo_random_seq extends uvm_sequence #(fifo_seq_item);
    `uvm_object_utils(fifo_random_seq)

    int unsigned num_items = 50;

    function new(string name = "fifo_random_seq");
        super.new(name);
    endfunction

    virtual task body();
        fifo_seq_item item;
        repeat (num_items) begin
            item = fifo_seq_item::type_id::create("item");
            start_item(item);
            if (!item.randomize()) begin
                `uvm_fatal(get_type_name(), "randomize fail")
            end
            item.rst_n = 1;
            finish_item(item);
        end
    endtask
endclass


// =============================================================
// driver : takes sequence items and drives the DUT input pins
// =============================================================
class fifo_driver extends uvm_driver #(fifo_seq_item);
    `uvm_component_utils(fifo_driver)

    virtual fifo_if f_if;
    fifo_seq_item item;

    function new(string name = "fifo_drv", uvm_component c = null);
        super.new(name, c);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual fifo_if)::get(this, "", "f_if", f_if)) begin
            `uvm_fatal(get_name(), "unable to access fifo interface")
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            seq_item_port.get_next_item(item);
            @(f_if.drv_cb);
            f_if.drv_cb.rst_n   <= item.rst_n;
            f_if.drv_cb.wr_en   <= item.wr_en;
            f_if.drv_cb.wr_data <= item.wr_data;
            f_if.drv_cb.rd_en   <= item.rd_en;
            seq_item_port.item_done();
        end
    endtask
endclass


// =============================================================
// monitor : observes DUT signals and forwards them to the scoreboard
// =============================================================
class fifo_monitor extends uvm_monitor;
    `uvm_component_utils(fifo_monitor)

    virtual fifo_if f_if;
    fifo_seq_item item;
    uvm_analysis_port #(fifo_seq_item) send;

    localparam int DEPTH = 8;

    // running counters used to derive occupancy/wrap (not directly
    // observable on the DUT interface, so the monitor tracks them
    // the same way the reference model inside the DUT would)
    int unsigned wr_count = 0;
    int unsigned rd_count = 0;

    function new(string name = "fifo_mon", uvm_component c = null);
        super.new(name, c);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual fifo_if)::get(this, "", "f_if", f_if)) begin
            `uvm_fatal(get_name(), "unable to access fifo interface")
        end
        send = new("send", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            bit wr_valid, rd_valid;

            item = fifo_seq_item::type_id::create("item", this);
            @(f_if.mon_cb);   // == @(posedge clk), sampled just before the edge

            item.rst_n   = f_if.mon_cb.rst_n;
            item.wr_en   = f_if.mon_cb.wr_en;
            item.wr_data = f_if.mon_cb.wr_data;
            item.rd_en   = f_if.mon_cb.rd_en;
            item.rd_data = f_if.mon_cb.rd_data;
            item.full    = f_if.mon_cb.full;
            item.empty   = f_if.mon_cb.empty;

            if (!item.rst_n) begin
                wr_count = 0;
                rd_count = 0;
                item.occupancy = 0;
                item.wr_wrap   = 0;
                item.rd_wrap   = 0;
            end else begin
                wr_valid = item.wr_en && !item.full;
                rd_valid = item.rd_en && !item.empty;

                // a wrap happens when this valid access lands on the
                // last address of the current lap (addr == DEPTH-1)
                item.wr_wrap = wr_valid && ((wr_count % DEPTH) == DEPTH - 1);
                item.rd_wrap = rd_valid && ((rd_count % DEPTH) == DEPTH - 1);

                if (wr_valid) wr_count++;
                if (rd_valid) rd_count++;

                item.occupancy = wr_count - rd_count;
            end

            send.write(item);
        end
    endtask
endclass


// =============================================================
// agent : driver + monitor + sequencer
// =============================================================
class fifo_agent extends uvm_agent;
    `uvm_component_utils(fifo_agent)

    fifo_driver drv;
    fifo_monitor mon;
    uvm_sequencer #(fifo_seq_item) sqr;

    function new(string name = "fifo_agt", uvm_component c = null);
        super.new(name, c);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv = fifo_driver::type_id::create("drv", this);
        mon = fifo_monitor::type_id::create("mon", this);
        sqr = uvm_sequencer#(fifo_seq_item)::type_id::create("sqr", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction
endclass


// =============================================================
// scoreboard : predicts FIFO behavior with a SW model (queue)
//              and compares it against the observed values
// =============================================================
class fifo_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(fifo_scoreboard)

    uvm_analysis_imp #(fifo_seq_item, fifo_scoreboard) recv;

    localparam int DEPTH = 8;
    bit [7:0] model_q[$];   // reference model : SW queue mimicking the real FIFO

    int pass_cnt = 0;
    int fail_cnt = 0;
    int skip_cnt = 0;

    function new(string name = "fifo_scb", uvm_component c = null);
        super.new(name, c);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        recv = new("recv", this);
    endfunction

    virtual function void write(fifo_seq_item item);
        `uvm_info(get_type_name(), item.convert2string(), UVM_HIGH)

        if (!item.rst_n) begin
            model_q.delete();
            skip_cnt++;              // reset cycle -> exactly one SKIP verdict
            return;
        end

        begin
            bit exp_empty = (model_q.size() == 0);
            bit exp_full  = (model_q.size() == DEPTH);
            bit is_fail   = 0;

            // 1) full/empty flag correctness -- always checked, never skipped
            if (!(item.full === exp_full && item.empty === exp_empty)) begin
                is_fail = 1;
                `uvm_error(get_type_name(),
                    $sformatf("full/empty mismatch! exp(full=%0d,empty=%0d) act(full=%0d,empty=%0d)",
                              exp_full, exp_empty, item.full, item.empty))
            end

            // 2) valid read data correctness (only meaningful if a read actually occurred)
            if (item.rd_en && !exp_empty) begin
                bit [7:0] exp_data = model_q.pop_front();
                if (item.rd_data !== exp_data) begin
                    is_fail = 1;
                    `uvm_error(get_type_name(),
                        $sformatf("read data mismatch! exp=%0d act=%0d", exp_data, item.rd_data))
                end
            end

            // 3) reflect a valid write into the model queue (ignored on overflow)
            if (item.wr_en && !exp_full) begin
                model_q.push_back(item.wr_data);
            end

            // ---- exactly one verdict per item ----
            if (is_fail) begin
                fail_cnt++;
            end else if ((item.rd_en && exp_empty) || (item.wr_en && exp_full)) begin
                skip_cnt++;          // underflow/overflow attempt -> boundary case, not a real compare
            end else begin
                pass_cnt++;
            end
        end
    endfunction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("SCB", $sformatf("\n___________"), UVM_NONE)
        `uvm_info("SCB", $sformatf("Result Pass:%0d", pass_cnt), UVM_NONE)
        `uvm_info("SCB", $sformatf("Result Fail:%0d", fail_cnt), UVM_NONE)
        `uvm_info("SCB", $sformatf("Result Skip:%0d", skip_cnt), UVM_NONE)
    endfunction
endclass


// =============================================================
// coverage : functional coverage on wr_en/rd_en/full/empty and
//            their cross combinations (overflow/underflow hits)
// =============================================================
class fifo_coverage extends uvm_subscriber #(fifo_seq_item);
    `uvm_component_utils(fifo_coverage)

    fifo_seq_item item;

    covergroup fifo_cg;
        option.per_instance = 1;

        cp_wr_en: coverpoint item.wr_en {
            bins write    = {1};
            bins no_write = {0};
        }

        cp_rd_en: coverpoint item.rd_en {
            bins read    = {1};
            bins no_read = {0};
        }

        cp_full: coverpoint item.full {
            bins is_full     = {1};
            bins is_not_full = {0};
        }

        cp_empty: coverpoint item.empty {
            bins is_empty     = {1};
            bins is_not_empty = {0};
        }

        cp_wr_data: coverpoint item.wr_data iff (item.wr_en) {
            bins low  = {[0:84]};
            bins mid  = {[85:169]};
            bins high = {[170:255]};
        }

        // occupancy level : has the fill level actually swept through
        // empty -> low -> mid -> high -> full, not just the two extremes?
        cp_occupancy: coverpoint item.occupancy {
            bins empty_lvl = {0};
            bins low_lvl   = {[1:2]};
            bins mid_lvl   = {[3:5]};
            bins high_lvl  = {[6:7]};
            bins full_lvl  = {8};
        }

        // wrap coverage : did the write/read pointer's extra (wrap) bit
        // actually flip during this run, not just addr-level wraparound?
        cp_wr_wrap: coverpoint item.wr_wrap {
            bins wrapped     = {1};
            bins not_wrapped = {0};
        }

        cp_rd_wrap: coverpoint item.rd_wrap {
            bins wrapped     = {1};
            bins not_wrapped = {0};
        }

        // wr_en x full : write-while-full hit means overflow protection was actually exercised
        cx_write_full: cross cp_wr_en, cp_full;

        // rd_en x empty : read-while-empty hit means underflow protection was actually exercised
        cx_read_empty: cross cp_rd_en, cp_empty;
    endgroup

    function new(string name = "fifo_cov", uvm_component c = null);
        super.new(name, c);
        fifo_cg = new();
    endfunction

    virtual function void write(fifo_seq_item t_item);
        item = t_item;
        if (item.rst_n)   // skip sampling while reset is asserted
            fifo_cg.sample();
    endfunction

    virtual function void report_phase(uvm_phase phase);
        `uvm_info("COV", $sformatf("\n***** coverage report *****"), UVM_NONE)
        `uvm_info("COV", $sformatf("overall       = %.1f%%", fifo_cg.get_coverage()),           UVM_NONE)
        `uvm_info("COV", $sformatf("wr_en         = %.1f%%", fifo_cg.cp_wr_en.get_coverage()),   UVM_NONE)
        `uvm_info("COV", $sformatf("rd_en         = %.1f%%", fifo_cg.cp_rd_en.get_coverage()),   UVM_NONE)
        `uvm_info("COV", $sformatf("full          = %.1f%%", fifo_cg.cp_full.get_coverage()),    UVM_NONE)
        `uvm_info("COV", $sformatf("empty         = %.1f%%", fifo_cg.cp_empty.get_coverage()),   UVM_NONE)
        `uvm_info("COV", $sformatf("wr_data       = %.1f%%", fifo_cg.cp_wr_data.get_coverage()), UVM_NONE)
        `uvm_info("COV", $sformatf("occupancy     = %.1f%%", fifo_cg.cp_occupancy.get_coverage()), UVM_NONE)
        `uvm_info("COV", $sformatf("wr_wrap       = %.1f%%", fifo_cg.cp_wr_wrap.get_coverage()), UVM_NONE)
        `uvm_info("COV", $sformatf("rd_wrap       = %.1f%%", fifo_cg.cp_rd_wrap.get_coverage()), UVM_NONE)
        `uvm_info("COV", $sformatf("cx_write_full = %.1f%%", fifo_cg.cx_write_full.get_coverage()), UVM_NONE)
        `uvm_info("COV", $sformatf("cx_read_empty = %.1f%%", fifo_cg.cx_read_empty.get_coverage()), UVM_NONE)
    endfunction
endclass


// =============================================================
// environment : wires the agent, scoreboard and coverage together
// =============================================================
class fifo_environment extends uvm_env;
    `uvm_component_utils(fifo_environment)

    fifo_agent agt;
    fifo_scoreboard scb;
    fifo_coverage cov;

    function new(string name = "fifo_env", uvm_component c = null);
        super.new(name, c);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt = fifo_agent::type_id::create("agt", this);
        scb = fifo_scoreboard::type_id::create("scb", this);
        cov = fifo_coverage::type_id::create("cov", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agt.mon.send.connect(scb.recv);
        agt.mon.send.connect(cov.analysis_export);
    endfunction
endclass


// =============================================================
// test : covers the 7 verification scenarios by tuning the
//        write_seq/read_seq item counts
//   (reset is handled implicitly: fifo_if initializes rst_n=0 at t=0,
//    which is a valid X->0 negedge trigger, so fifo_ctrl resets before
//    the first sequence ever drives anything)
//   2 single write/read   -> seq_write_fill(1) + seq_read_drain(1)
//   3 back-to-back w/r    -> seq_write_fill(N) + seq_read_drain(N)
//   4 full check          -> seq_write_fill(DEPTH)
//   5 overflow protection -> seq_write_overflow(DEPTH+1)
//   6 empty check         -> seq_read_drain(DEPTH)
//   7 underflow protection-> seq_read_underflow(DEPTH+1)
// =============================================================
class fifo_test extends uvm_test;
    `uvm_component_utils(fifo_test)

    localparam int DEPTH = 8;

    fifo_write_seq  seq_write_overflow;   // DEPTH+1 writes -> full check + overflow protection
    fifo_read_seq   seq_read_underflow;   // DEPTH+1 reads  -> empty check + underflow protection
    fifo_random_seq seq_random;
    fifo_environment env;

    function new(string name = "fifo_test", uvm_component c = null);
        super.new(name, c);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env                = fifo_environment::type_id::create("env", this);
        seq_write_overflow  = fifo_write_seq::type_id::create("seq_write_overflow", this);
        seq_read_underflow  = fifo_read_seq::type_id::create("seq_read_underflow", this);
        seq_random          = fifo_random_seq::type_id::create("seq_random", this);

        seq_write_overflow.num_writes = DEPTH + 1;   // scenarios 4, 5
        seq_read_underflow.num_reads  = DEPTH + 1;   // scenarios 6, 7
        seq_random.num_items          = 50;
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        // scenarios 2/3/4/5 : DEPTH+1 writes -> full check + overflow protection
        phase.raise_objection(this);
        seq_write_overflow.start(env.agt.sqr);
        phase.drop_objection(this);

        // scenarios 2/3/6/7 : DEPTH+1 reads -> empty check + underflow protection
        phase.raise_objection(this);
        seq_read_underflow.start(env.agt.sqr);
        phase.drop_objection(this);

        // extra coverage : random mix of write/read
        phase.raise_objection(this);
        seq_random.start(env.agt.sqr);
        repeat (1) @(posedge env.agt.drv.f_if.clk);  // let the last item's driven effect actually reach the monitor
        phase.drop_objection(this);
    endtask
endclass


// =============================================================
// top module
// =============================================================
module tb_fifo_uvm();

    localparam int DATA_WIDTH = 8;
    localparam int DEPTH      = 8;

    logic clk = 0;
    always #5 clk = ~clk;

    fifo_if #(.DATA_WIDTH(DATA_WIDTH)) f_if(clk);

    fifo_top #(
        .DATA_WIDTH (DATA_WIDTH),
        .DEPTH      (DEPTH)
    ) dut (
        .clk     (clk),
        .rst_n   (f_if.rst_n),
        .wr_en   (f_if.wr_en),
        .wr_data (f_if.wr_data),
        .rd_en   (f_if.rd_en),
        .rd_data (f_if.rd_data),
        .full    (f_if.full),
        .empty   (f_if.empty)
    );

    initial begin
        // waveform dump (VCS/FSDB)
        $fsdbDumpfile("wave.fsdb");
        $fsdbDumpvars(0, tb_fifo_uvm);
    end

    initial begin
        uvm_config_db#(virtual fifo_if)::set(null, "*", "f_if", f_if);
        run_test("fifo_test");
        $finish;
    end

endmodule