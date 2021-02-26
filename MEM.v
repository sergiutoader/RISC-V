`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2020 03:56:30 PM
// Design Name: 
// Module Name: MEM
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


module MEM(
    input           clk,            // data_memory
                    RegWrite,       // propagat
                    MemtoReg,       // propagat
                    MemRead,        // data_memory
                    MemWrite,       // data_memory
                    Branch,         // MEM_Branch
                    zero_flag,      // MEM_Branch
    input [31:0]    PC,              
                    ALU_OUT,        // data_memory, MEM_Branch
                    REG_DATA2,      // data_memory
    input [2:0]     FUNCT3,         // MEM_Branch
    input [4:0]     RD,             // propagat
    output          RegWrite_OUT,   // propagat
                    MemtoReg_OUT,   // propagat
    output [31:0]   DATA_MEMORY_OUT,// data_memory 
                    ALU_OUT_WB,     // propagat pt mux
    output [4:0]    RD_OUT,         // propagat pt mux
    output          PC_Src          // MEM_Branch, trimis la IF
    );
    
    
    data_memory data_memory_instance(clk, MemRead, MemWrite, ALU_OUT, REG_DATA2, DATA_MEMORY_OUT);
    MEM_Branch MEM_Branch_instance(Branch, zero_flag, FUNCT3, ALU_OUT[31], PC_Src);
    
    assign RegWrite_OUT = RegWrite;
    assign MemtoReg_OUT = MemtoReg;
    assign ALU_OUT_WB = ALU_OUT;
    assign RD_OUT = RD;
    
endmodule
