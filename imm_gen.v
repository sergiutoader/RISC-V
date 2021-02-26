`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 02:51:35 PM
// Design Name: 
// Module Name: imm_gen
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


module imm_gen(
    input [31:0] in,
    output reg[31:0] out
    );
    integer i;
    
    always @* begin
        case(in[6:0])
        
        // I-Type (LW)
        7'b0000011: begin
            for(i = 11; i < 32; i = i + 1)
                out[i]      = in[31]; 
                out[10:5]   = in[30:25];
                out[4:1]    = in[24:21];
                out[0]      = in[20];
        end
        
        // I-Type (ADDI, ANDI, ORI, XORI, SLTI, SLTIU, SW, SLTI, SLLI, SRLI, SRAI)
        7'b0010011: begin
            for(i = 11; i < 32; i = i + 1)
                out[i]      = in[31]; 
                out[10:5]   = in[30:25];
                out[4:1]    = in[24:21];
                out[0]      = in[20];
        end
        
        // S-Type (SW)
        7'b0100011: begin
            for(i = 11; i < 32; i = i + 1)
                out[i]      = in[31]; 
                out[10:5]   = in[30:25];
                out[4:1]    = in[11:8];
                out[0]      = in[7];
        end
        
        
        // B-Type (BEQ, BNE, BLT, BGE, BLTU, BGEU)
        7'b1100011: begin
            for(i = 12; i < 32; i = i + 1)
                out[i]      = in[31]; 
                out[11]     = in[7];
                out[10:5]   = in[30:25];
                out[4:1]    = in[11:8];
                out[0]      = 0;
        end
        
        // Instructiuni de tip R -> nu vor avea IMM
        7'b0110011: begin
            out = 0;
        end
        // caz de baza (cand in este XXXXX) -> out va fi XXXXX
        default:
            out = in;
        endcase
    end
    
endmodule
