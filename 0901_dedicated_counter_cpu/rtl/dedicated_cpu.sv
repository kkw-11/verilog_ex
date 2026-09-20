module dedicated_cpu(
	input clk,
	input rst_n,
	output logic [3:0] out
);

	logic lte10, asrcsel, load, out_control;


	datapath U_DATAPATH( 
		.*,
		.out(out)
	);


	 control_unit U_CONTROL_UNIT(
		.*
	 );


endmodule


module control_unit(
	input logic clk,
	input logic rst_n,
	input logic lte10,
	output logic asrcsel,
	output logic load,
	output logic out_control
);
	typedef enum logic [1:0]{
		S0 = 0,
		S1 = 1,
		S2 = 2,
		S3 = 3
	} state_t;

	state_t c_state, n_state;

	//CL output
	assign asrcsel = (c_state == S2) ? 1'b1:1'b0;
	assign load = (c_state == S0 || c_state == S2) ? 1'b1:1'b0;
	assign out_countrol = (c_state == S3) ? 1'b1:1'b0;

	always_ff @(posedge clk)begin
		if(!rst_n) begin
			c_state <= S0;
		end else begin
			c_state <= n_state;

		end
	end

	always_comb begin
		n_state		= c_state;
		asrcsel		= 1'b0;
		load		= 1'b0;
		out_control = 1'b0;

		case(c_state)
			S0: begin
				asrcsel		= 1'b0;
				load		= 1'b1;
				out_control = 1'b0;
				n_state		= S1;
			end
			S1: begin
				asrcsel		= 1'b1;
				load		= 1'b1;
				out_control = 1'b0;
				n_state		= S2;
			end
			S2: begin
				if(lte10)begin
					n_state = S1;
				end else begin
					n_state = S3;
				end
			end
			S3: begin
				asrcsel		= 1'b0;
				load		= 1'b0;
				out_control = 1'b1;
			end
		endcase
	end

endmodule



module datapath(
	input logic  clk,
	input logic rst_n,
	input logic asrcsel,
	input logic load,
	input logic out_control,
	output logic lte10,
	output logic [3:0] out
);

	logic [3:0] alu_result, reg_a_src_out, reg_a_out;
	assign out = (out_control) ? reg_a_out:4'hz;

	mux_2X1 U_REGA_SRC_MUX(
		.sel(asrcsel),
		.in0(4'h0),
		.in1(alu_result),
		.mux_out(reg_a_src_out)
	);

	
	reg_a U_REG_A(
		.clk(clk),
		.rst_n(rst_n),
		.load(load),
		.src_a(reg_a_src_out),
		.out_reg_a(reg_a)
	 );


	 alu U_ALU(
		.a(reg_a_out),
		.b(4'h1),
		.alu_result(alu_result)
	 );


	 ltq10 U_LTQ(
		.in(reg_a_out),
		.ltq10(lte10)
		);


endmodule


module reg_a(
	input				 clk,
	input				 rst_n,
	input				 load,
	input logic [3:0]	 src_a,
	output logic [3:0]   out_reg_a
);

	always_ff @(posedge clk) begin
		if(!rst_n) begin
			out_reg_a <= 0;
		end else begin
			if(load)begin
				out_reg_a <= src_a;
			end
		end
	end

endmodule


module mux_2X1(
	input logic sel,
	input logic [3:0] in0,
	input logic [3:0] in1,
	output logic [3:0] mux_out
);

	assign mux_out = (sel) ? in1:in0;

endmodule

module alu(
	input logic [3:0] a,
	input logic [3:0] b,
	output logic [3:0] alu_result
);

	assign alu_result = a + b;

endmodule

module ltq10(
	input logic [3:0] in,
	output logic ltq10
);

	assign ltq10 = (in < 10);

endmodule

