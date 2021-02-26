`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2020 03:30:56 PM
// Design Name: 
// Module Name: control_path
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


module control_path(input [6:0] opcode,
                    input pipeline_stall,
                    output reg MemRead,MemtoReg,MemWrite,RegWrite,Branch,ALUSrc,
                    output reg [1:0] ALUop);

 always @* begin
 
        if(pipeline_stall) begin
            MemRead <= 0;
            MemtoReg <= 0;
            MemWrite <= 0;
            RegWrite <= 0;
            Branch <= 0;
            ALUSrc <= 0;
            ALUop <= 0;
        end
        else begin
            case(opcode)
            
            // Instructiuni de tip R
            7'b0110011: begin
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                RegWrite <= 1;
                Branch <= 0;
                ALUSrc <= 0;
                ALUop[1] <= 1;
                ALUop[0] <= 0;
            end
            
            // LD
            7'b0000011: begin
                MemRead <= 1;
                MemtoReg <= 1;
                MemWrite <= 0;
                RegWrite <= 1;
                Branch <= 0;
                ALUSrc <= 1;
                ALUop[1] <= 0;
                ALUop[0] <= 0;
            end
            
            // SD
            7'b0100011: begin
                MemRead <= 0;
                MemtoReg <= 1'bX;
                MemWrite <= 1;
                RegWrite <= 0;
                Branch <= 0;
                ALUSrc <= 1;
                ALUop[1] <= 0;
                ALUop[0] <= 0;
            end
            
             // BEQ
            7'b1100011: begin
                MemRead <= 0;
                MemtoReg <= 1'bX;
                MemWrite <= 0;
                RegWrite <= 0;
                Branch <= 1;
                ALUSrc <= 0;
                ALUop[1] <= 0;
                ALUop[0] <= 1;
            end
            
            // I-Type (ADDI, ANDI, ORI, XORI, SLTI, SLTIU, SW, SLTI, SLLI, SRLI, SRAI)
            // va fi la fel ca la R, doar ca ALUSrc va fi setat pe 1 (o valoare va fi luata direct din ALU)
            7'b0010011: begin
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                RegWrite <= 1;
                Branch <= 0;
                ALUSrc <= 1;
                ALUop[1] <= 1;
                ALUop[0] <= 0;
            end
               
            // nop de la Instruction Set Architecture
            7'b0000000: begin
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                RegWrite <= 0;
                Branch <= 0;
                ALUSrc <= 0;
                ALUop[1] <= 0;
                ALUop[0] <= 0;
            end
            
            // caz de baza (cand in este XXXXX) -> out va fi XXXXX
            default:
            begin
                MemRead <= 1'bX;
                MemtoReg <= 1'bX;
                MemWrite <= 1'bX;
                RegWrite <= 1'bX;
                Branch <= 1'bX;
                ALUSrc <= 1'bX;
                ALUop[1] <= 1'bX;
                ALUop[0] <= 1'bX;
            end
            endcase
        end
end
                    
endmodule
