`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 08:51:26 PM
// Design Name: 
// Module Name: RISC_V_IF_ID
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


module RISC_V_IF_ID(input clk,	        //semnalul de ceas global
            input reset,                //semnalul de reset global
                                        //semnale provenite din stagii viitoare //sunt pre-setate pentru aceasta lucrare //vor fi discutate in oucrarile urmatoare
            input IF_IDwrite,	        //semnal de scriere pentru registrul de pipeline IF_ID
            input PCSrc, PC_write,	    //semnale de control pentru PC
            input [31:0] PC_Branch,     //PC-n( calcuiat in etapa EX pentru instructiunile de salt
            input RegWrite_WB,
            input [31:0] ALU_DATA_WB,   //reztatatca calculat de ALU
            input [4:0] RD_WB,	        //registrul rezultat in care se face scrierea
                                        //semnale de iesire din ID
                                        //vor fi vizualizate pe simulare
            output [31:0] PC_ID,	    //adresa PC a instructiunii din etapa ID
            output [31:0] INSTRUCTION_ID, //instructiunea curenta in etapa ID
            output [31:0] IMM_ID,	    //valoarea calculata
            output [31:0] REG_DATA1_ID,	//vaioarea primuiui registru sursa citit
            output [31:0] REG_DATA2_ID,	//valoarea celui de-al doilea registru sursa citit
            output [2:0] FUNCT3_ID,     //funct3 din codificarea instructiunii
            output [6:0] FUNCT7_ID,     //funct7 din codificarea instructiunii
            output [6:0] OPCODE_ID,     //opcode-ul instructiunii
            output [4:0] RD_ID,	        //registru destinatie
            output [4:0] RS1_ID,	    //registru sursa1
            output [4:0] RS2_ID);	    //registru sursa2
            
            
            // IF
            wire[31:0] PC_IF, INSTRUCTION_IF;
            IF IF_module(clk, reset, PCSrc, PC_write, PC_Branch, PC_IF, INSTRUCTION_IF);
            
            // IF_ID_reg
            wire[31:0] PC_IF_out, INSTRUCTION_IF_out;
            IF_ID_reg reg_module(clk, reset, IF_IDwrite, PC_IF, INSTRUCTION_IF, PC_IF_out, INSTRUCTION_IF_out);
            
            // ID
            ID ID_module(clk, PC_IF_out, INSTRUCTION_IF_out, RegWrite_WB, ALU_DATA_WB, RD_WB,
                IMM_ID, REG_DATA1_ID, REG_DATA2_ID, FUNCT3_ID, FUNCT7_ID, OPCODE_ID, RD_ID, RS1_ID, RS2_ID, PC_ID);
            
            assign INSTRUCTION_ID = INSTRUCTION_IF_out;
            
endmodule
