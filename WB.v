`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2020 09:20:01 PM
// Design Name: 
// Module Name: WB
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


module WB(
        input [31:0] ina,
        input [31:0] inb,
        input sel,
        output reg [31:0] out
    );
    
    always @* begin
        if(sel) out = ina;
        else out = inb;
    end
endmodule
