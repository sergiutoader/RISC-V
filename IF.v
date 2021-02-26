`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2020 05:06:32 PM
// Design Name: 
// Module Name: IF
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
 

module IF(input clk, input reset, input PCSrc, input PC_write,
    input [31:0] PC_Branch, output [31:0] PC_IF, output [31:0] INSTRUCTION_IF);
    
    wire [31:0] adder_out, mux_out;
    
    adder add_instance(PC_IF, 4, adder_out);
    mux2_1 mux_instance(PC_Branch, adder_out, PCSrc, mux_out);
    PC PC_instance(clk, reset, PC_write, mux_out, PC_IF);
    instruction_memory IM_instance(PC_IF[11:2], INSTRUCTION_IF);
    
endmodule
