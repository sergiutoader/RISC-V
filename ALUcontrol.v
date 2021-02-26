`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2020 04:25:21 PM
// Design Name: 
// Module Name: ALUcontrol
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


module ALUcontrol(input [1:0] ALUop,
                  input [6:0] funct7,
                  input [2:0] funct3,
                  output reg [3:0] ALUinput);
               
    always @*   
    case(ALUop)
        // LD si SD au AluOP = 0
        2'b00: begin
            ALUinput = 4'b0010;
        end
        // instructiuni de tip R (add, sub, and, or, xor, sltu, slt, srl, sll, sra
        // + instructiuni de tip I (srli, slli, srai)
        2'b10: begin
            // add
            if(funct7 == 7'b0000000 && funct3 == 3'b000)
                ALUinput = 4'b0010;
            // sub
            else if(funct7 == 7'b0100000 && funct3 == 3'b000)
                ALUinput = 4'b0110;
            // and
            else if(funct7 == 7'b0000000 && funct3 == 3'b111)
                ALUinput = 4'b0000;
            // or
            else if(funct7 == 7'b0000000 && funct3 == 3'b110)
                ALUinput = 4'b0001;
            // xor
            else if(funct7 == 7'b0000000 && funct3 == 3'b100)
                ALUinput = 4'b0011;
            // srl + srli
            else if(funct7 == 7'b0000000 && funct3 == 3'b101)
                ALUinput = 4'b0101;
            // sll + slli
            else if(funct7 == 7'b0000000 && funct3 == 3'b001)
                ALUinput = 4'b0100;
            // sra + srai
            else if(funct7 == 7'b0100000 && funct3 == 3'b101)
                ALUinput = 4'b1001;
            // sltu
            else if(funct7 == 7'b0000000 && funct3 == 3'b011)
                ALUinput = 4'b0111;
            // slt
            else if(funct7 == 7'b0000000 && funct3 == 3'b010)
                ALUinput = 4'b1000;
        end
        // instructiuni de tip branch
        2'b01: begin
            // BEQ, BNE
            if(funct3 == 3'b000 || funct3 ==3'b001)
                ALUinput = 4'b0110;
            // BLT, BGE
            else if(funct3 == 3'b100 || funct3 ==3'b101)
                ALUinput = 4'b1000;
            // BLTU, BGEU
            else if(funct3 == 3'b110 || funct3 ==3'b111)
                ALUinput = 4'b0111;
        end
    endcase           
                  
endmodule
