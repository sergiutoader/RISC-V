`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2020 02:19:16 PM
// Design Name: 
// Module Name: mux2_1
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

// sel = 0 -> ina, sel=1 -> inb
module mux2_1(
    input [31:0] ina,
    input [31:0] inb,
    input sel,
    output [31:0] out
    );
    
    assign out = sel ? ina : inb;
    
endmodule
