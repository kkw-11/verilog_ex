interface counter_if(input clk);
    logic rst_n,
    logic [2:0] counter;
    logic o_tick;
endinterface


   module tb_counter();

   logic clk = 0;

   always #5 clk = ~clk;

   counter_if c_if(clk);

    counter dut(
      .clk(clk),
      .rst_n(c_if.rst_n),
	  .enable(c_if.enable),
      .counter(c_if.counter),
      .o_tick(c_if.o_tick)
    );

	initial begin
		//vcs wave db
		$fsdbDumpfile("wave.fsdb");
		$fsdbDumpvars(0, tb_counter);
	end


	initial begin
		c_if.rst_n = 0;
		c_if.enable = 0;
		#10;
		c_if.rst_n = 1;
		#100;
		c_if.enable = 1;
		#100;
		$finish;
	end
 endmodule
