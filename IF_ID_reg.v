`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 08:41:11 PM
// Design Name: 
// Module Name: IF_ID_reg
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


module IF_ID_reg(
    input clk,
    input reset,
    input write,
    input[31:0] PC_IF,
    input[31:0] INSTRUCTION_IF,
    output[31:0] PC_ID,
    output[31:0] INSTRUCTION_ID
    );
    
    reg[31:0] r1, r2;
    always@(posedge clk)
    begin
        if(reset)
        begin
            r1 <= 0;
            r2 <= 0;
        end
        else if(write)
        begin
            r1 <= PC_IF;
            r2 <= INSTRUCTION_IF;
        end
    end
    
    assign PC_ID = r1;
    assign INSTRUCTION_ID = r2;
endmodule
