//--------------------------------------------------------------------------
// Design Name: Booth Multiplication Algorithm 
// File Name: booth_parts.sv
// Description: Implementation of the Booth Multiplication Algorithm
// Version History
// * June 9, 2025 (sebastian ardelean): Finished the implementation 
// -------------------------------------------------------------------------
`timescale 1ns/1ps

module booth (
	      input logic	       clk,
	      input logic	       enable,
	      input logic	       rst_n,
	      input logic signed [7:0] inbus,
	      output logic	       done,
	      output logic [7:0]      outbus
	      
	      );
   //control signals
   logic [7:0] c;
   logic       stop;
   
   tri [7:0]  output_buffer;
   
   // Register Outputs
   logic signed [7:0] A_reg, M_reg, Q_reg;
   logic	      Qm;
   logic signed [7:0] M_input;
   logic signed [7:0] Q_input;
   // Count
   logic [2:0] counter_o;
   logic       count_and_o;

   // Other intermediate signals
   logic signed [7:0] adder_o;
   logic [7:0]	      xor_o;

   logic signed [7:0] A_outbus;
   logic signed [7:0] Q_outbus;
   
   
   cu_booth ctrl_unit (
		 .clk(clk),
		 .start(enable),
		 .rst_n(rst_n),
		 .count(count_and_o),
		 .q0(Q_reg[0]),
		 .qm(Qm),
		 .stop(stop),
		 .c(c)
		 );
   
   assign done = stop;
  
   counter_nbits #(.WIDTH(3)) counter (
			  .clk(clk),
			  .rst_n(rst_n),
			  .en(c[5]),
			  .count(counter_o)
			  );

   and3_gate and_counter (
		       .a(counter_o[0]),
		       .b(counter_o[1]),
		       .c(counter_o[2]),
		       .y(count_and_o)
		       );
   
      

   register #(.WIDTH(8)) reg_A (
				.clk(clk),
				.rst_n(rst_n),
				.load_en(c[2]),
				.shift_en(c[4]),
                                .sr(A_reg[7]),
                                .sl(1'b0),
                                .shift_dir(c[4]),
				.d(adder_o),
				.q(A_reg)
				);
   
   
   register #(.WIDTH(8)) q_Q (
			      .clk(clk),
			      .rst_n(rst_n),
			      .load_en(c[1]),
			      .shift_en(c[4]),
			      .sr(A_reg[0]),
                              .sl(1'b0),
                              .shift_dir(c[4]),
			      .d(Q_input),
			      .q(Q_reg)
			      );
   
   register #(.WIDTH(1)) reg_Qm (
				 .clk(clk),
				 .rst_n(rst_n),
				 .load_en(c[1]),
				 .shift_en(c[4]),
				 .sr(Q_reg[0]),
                                 .sl(1'b0),
                                 .shift_dir(c[4]),
				 .d(1'b0),
				 .q(Qm)
				 );
	      

   register #(.WIDTH(8)) reg_M (
				.clk(clk),
				.rst_n(rst_n),
				.load_en(c[0]),
				.shift_en(1'b0),
				.sr(1'b0),
                                .sl(1'b0),
                                .shift_dir(1'b0),
				.d(M_input),
				.q(M_reg)
				);
   xorn_gate #(8) xor_instance (
			   .a(M_reg),
			   .b(c[3]),
			   .y(xor_o)
			   );

   adder #(8) adder_instance (
			      .cin(c[3]),
			      .a(A_reg),
			      .b(xor_o),
			      .sum(adder_o)
			      );

   // Tri-state buffers

   tristate_buffer_bus #(8) M_in (
				   .data_in(inbus),
				   .enable(c[0]),
				   .data_out(M_input)
				   );

   tristate_buffer_bus #(8) Q_in (
				   .data_in(inbus),
				   .enable(c[1]),
				   .data_out(Q_input)
				   );
   tristate_buffer_bus #(8) A_out (
				   .data_in(A_reg),
				   .enable(c[6]),
				   .data_out(output_buffer)
				   );

   tristate_buffer_bus #(8) Q_out (
				   .data_in(Q_reg),
				   .enable(c[7]),
				   .data_out(output_buffer)
				   );

   assign outbus = output_buffer;
   
   

  
endmodule // booth
