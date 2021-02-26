`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2020 02:43:03 PM
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input res,
    input write,
    input [31:0] in,
    output reg[31:0] out
    );
    
    always @(posedge clk)
    begin
        if(res)
            out = 0;
        else if(write)
            out = in;
    end
    
    
    
endmodule
