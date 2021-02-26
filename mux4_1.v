`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2020 05:08:28 PM
// Design Name: 
// Module Name: mux4_1
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


module mux4_1(
    input [31:0] ina,
    input [31:0] inb,
    input [31:0] inc,
    input [31:0] ind,
    input [1:0] sel,
    output [31:0] out
    );
    
    reg [31:0] out_wire;
    
    always @* begin
        case(sel)
            
        2'b00:
            out_wire = ina;
        2'b01:
            out_wire = inb;
        2'b10:
            out_wire = inc;
        2'b11:
            out_wire = ind;
        endcase
    end

    assign out = out_wire;
endmodule
