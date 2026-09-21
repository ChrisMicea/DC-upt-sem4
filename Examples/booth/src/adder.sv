//--------------------------------------------------------------------------
// Design Name: n-bit adder
// File Name: adder.sv
// Description: Implementation of a n-bit  adder
// Version History
// * June 9, 2025 (sebastian ardelean): Finished the implementation 
// -------------------------------------------------------------------------
`timescale 1ns/1ps
module adder #(parameter WIDTH = 8) (
		    input logic cin,
		    input logic signed [WIDTH-1:0] a,
		    input logic signed [WIDTH-1:0] b,
		    output logic signed [WIDTH-1:0] sum
		    );
   always_comb begin
      sum = a + b + cin;
   end
endmodule //adder
      
