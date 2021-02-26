`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2020 03:28:42 PM
// Design Name: 
// Module Name: MEM_Branch
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


module MEM_Branch(
        input branch_flag,
        input zero_flag,
        input [2:0] funct3,
        input sign_bit,
        output reg PC_Src
        
    );
    
    always @* begin
        if(branch_flag) begin
            case(funct3)            
            3'b000:     PC_Src = zero_flag;     // beq -> Zero Flag = 1 -> PC_Src = 1
            3'b001:     PC_Src = ~zero_flag;    // bne -> Zero Flag = 0 -> PC_Src = 1
            3'b100:     PC_Src = sign_bit;      // blt -> Sign Bit = 1  -> PC_Src = 1
            3'b101:     PC_Src = ~sign_bit;     // bge -> Sign Bit = 0  -> PC_Src = 1
            endcase
        end
        else
            PC_Src = 0;
    end
endmodule
