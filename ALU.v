`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2020 05:29:38 PM
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revisio
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(input [3:0] ALUop,
           input [31:0] ina,inb,
           output zero,
           output reg [31:0] out);
           
reg reg_zero;      

always @* begin
    case(ALUop)
        4'b0010:
            out = ina + inb;
        4'b0110:
            out = ina - inb;
        4'b0000:
            out = ina & inb;
        4'b0001:
            out = ina | inb;
        4'b0011:
            out = ina ^ inb;
        4'b0101:
            out = ina >> inb;
        4'b0100:
            out = ina << inb;
        4'b1001:
            out = ina >>> inb;
        4'b0111:
            out = ina < inb ? 1 : 0;
        4'b1000:
            out = ina < inb ? 1 : 0;
    endcase
    
    if (out == 0) reg_zero = 1;
    else reg_zero = 0;
end
    
    assign zero = reg_zero;
endmodule