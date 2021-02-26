`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2020 06:24:23 PM
// Design Name: 
// Module Name: RISC_V
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


module RISC_V(input clk,
              input reset,
              
              output [31:0] PC_EX,              // scos in ID_EX reg
              output [31:0] ALU_OUT_EX,         // scos in EX
              output [31:0] PC_MEM,             // scos in EX_MEM reg
              output PCSrc,                     // scos in IF
              output [31:0] DATA_MEMORY_MEM,    // scos in MEM
              output [31:0] ALU_DATA_WB,        // scos in WB
              output [1:0] forwardA,            // scos in forwarding
              output [1:0] forwardB,            // scos in forwarding
              output pipeline_stall             // scos in ID
             );
    
    
    // IF
    // in
    wire PC_write;                          // output din alta parte
    // out
    wire [31:0] PC_IF, INSTRUCTION_IF;
  
    IF IF_instance(clk, reset, PCSrc, PC_write, PC_MEM, PC_IF, INSTRUCTION_IF);
    
    
    
    // IF_ID_reg
    // in
    wire IF_ID_write;                   // output din alta parte
    // out
    wire [31:0] PC_ID, INSTRUCTION_ID;
    
    IF_ID_reg IF_ID_reg_instance(
        clk,
        reset,
        IF_ID_write,
        PC_IF,
        INSTRUCTION_IF,
            
        PC_ID,
        INSTRUCTION_ID
    );
    
    
    
    
    
    // ID
    // in
    wire RegWrite_WB;                   // output din alta parte
    wire [4:0] RD_WB;                   // output din alta parte
    // out
    wire [31:0] IMM_ID, REG_DATA1_ID, REG_DATA2_ID;
    wire [2:0] FUNCT3_ID;
    wire [6:0] FUNCT7_ID, OPCODE_ID;
    wire [4:0] RD_ID, RS1_ID, RS2_ID;
    wire RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID;
    wire [1:0] ALUop_ID;
    wire ALUSrc_ID, Branch_ID;
    
    ID ID_instance( clk,
                    PC_ID,
                    INSTRUCTION_ID,
                    RegWrite_WB,
                    ALU_DATA_WB,
                    RD_WB,
                    pipeline_stall,
                    
                    IMM_ID,
                    REG_DATA1_ID,
                    REG_DATA2_ID,
                    FUNCT3_ID,
                    FUNCT7_ID,
                    OPCODE_ID,
                    RD_ID,
                    RS1_ID,
                    RS2_ID,
                    RegWrite_ID,
                    MemtoReg_ID,
                    MemRead_ID,
                    MemWrite_ID,
                    ALUop_ID,
                    ALUSrc_ID,
                    Branch_ID);
    
    
    
    
    // hazard detection
    
    // in
    wire [4:0] RD_EX;   // output din alta parte
    
    hazard_detection hazard_detection_instance(
        // in
        RD_EX,
        RS1_ID,
        RS2_ID,
        MemRead_ID,
        // out
        PC_write,
        IF_ID_write,
        pipeline_stall
    );
    
    
    
    
    
    // ID_EX_module
    
    wire RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, ALUSrc_EX, Branch_EX;
    wire [1:0] ALUop_EX;
    wire [31:0] REG_DATA1_EX, REG_DATA2_EX, IMM_EX;
    wire [6:0] FUNCT7_EX;
    wire [2:0] FUNCT3_EX;
    wire [4:0] RS1_EX, RS2_EX;
    
    ID_EX_reg ID_EX_reg_module(
        // in
        clk,
        reset,
        1'b1,
        RegWrite_ID,
        MemtoReg_ID,
        MemRead_ID,
        MemWrite_ID,
        ALUSrc_ID,
        Branch_ID,
        ALUop_ID,
        PC_ID,
        REG_DATA1_ID,
        REG_DATA2_ID,
        IMM_ID,
        FUNCT7_ID,
        FUNCT3_ID,
        RS1_ID,
        RS2_ID,
        RD_ID,
        
        // out
        RegWrite_EX,
        MemtoReg_EX,
        MemRead_EX,
        MemWrite_EX,
        ALUSrc_EX,
        Branch_EX,
        ALUop_EX,
        PC_EX,
        REG_DATA1_EX,
        REG_DATA2_EX,
        IMM_EX,
        FUNCT7_EX,
        FUNCT3_EX,
        RS1_EX,
        RS2_EX,
        RD_EX
    );
    
    
    
    
    
    // EX MODULE
    // in
    wire [31:0] ALU_OUT_MEM;    // iesire din alta parte
    
    // out
    wire ZERO_EX;
    wire [31:0] PC_Branch_EX, REG_DATA2_EX_FINAL;
    wire [4:0] RD_EX_out, RS1_EX_out;
    wire RegWrite_out, MemtoReg_out, MemRead_out, MemWrite_out, Branch_out;
    wire [2:0] FUNCT3_out;
    
    EX EX_instance(
        // in
        IMM_EX,
        REG_DATA1_EX, 
        REG_DATA2_EX, 
        PC_EX, 
        FUNCT3_EX, 
        FUNCT7_EX, 
        RD_EX, 
        RS1_EX, 
        RS2_EX,
        RegWrite_EX, 
        MemtoReg_EX, 
        MemRead_EX, 
        MemWrite_EX, 
        ALUop_EX, 
        ALUSrc_EX, 
        Branch_EX, 
        forwardA, 
        forwardB,
        ALU_DATA_WB, 
        ALU_OUT_MEM,
        
        // out       
        ZERO_EX, 
        ALU_OUT_EX, 
        PC_Branch_EX, 
        REG_DATA2_EX_FINAL,
        
         RD_EX_out, 
         RS1_EX_out,
         RegWrite_out, 
         MemtoReg_out, 
         MemRead_out, 
         MemWrite_out, 
         Branch_out,
         FUNCT3_out
    );
    
    
    
    
    // registru EX-MEM
    
    // out
    wire RegWrite_MEM,MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM;
    wire [2:0] FUNCT3_MEM;
    wire ZERO_MEM;
    wire [31:0] REG_DATA2_MEM;
    wire [4:0] RD_MEM;
    
    EX_MEM_reg EX_MEM_reg_instance(
        // in
        clk, 
        reset, 
        1'b1, 
        RegWrite_out, 
        MemtoReg_out, 
        MemRead_out, 
        MemWrite_out, 
        Branch_out,
        PC_Branch_EX, 
        FUNCT3_out, 
        ALU_OUT_EX, 
        ZERO_EX, 
        REG_DATA2_EX_FINAL,
        RD_EX_out,
        
        // out
        RegWrite_MEM,
        MemtoReg_MEM, 
        MemRead_MEM, 
        MemWrite_MEM, 
        Branch_MEM,
        PC_MEM,
        FUNCT3_MEM,
        ALU_OUT_MEM,
        ZERO_MEM,
        REG_DATA2_MEM,
        RD_MEM
    );
    
    
    
    
    
    // forwarding unit
    forwarding forwarding_unit(
        // in
        RS1_EX, 
        RS2_EX, 
        RD_MEM, 
        RD_WB, 
        RegWrite_MEM, 
        RegWrite_WB, 
        // out
        forwardA,
        forwardB
    );
    
    
    
    
    // MEM
    
    // out
    wire RegWrite_MEM_out, MemtoReg_MEM_out;
    wire [31:0] ALU_OUT_MEM_WB;
    wire [4:0] RD_MEM_out;
        
    MEM MEM_instance(
        // in
        clk, 
        RegWrite_MEM, 
        MemtoReg_MEM, 
        MemRead_MEM, 
        MemWrite_MEM, 
        Branch_MEM, 
        ZERO_MEM,
        PC_MEM, 
        ALU_OUT_MEM, 
        REG_DATA2_MEM, 
        FUNCT3_MEM, 
        RD_MEM, 
        
        // out
        RegWrite_MEM_out, 
        MemtoReg_MEM_out,
        DATA_MEMORY_MEM, 
        ALU_OUT_MEM_WB, 
        RD_MEM_out, 
        PCSrc
    );
        
        
        
         
         
    // MEM-WB reg
    
    // out
    wire MemtoReg_WB;
    wire [31:0] DATA_MEMORY_WB, ALU_OUT_WB;
    
    MEM_WB_reg MEM_WB_reg_instance(
        // in
        clk, 
        reset, 
        1'b1, 
        RegWrite_MEM_out, 
        MemtoReg_MEM_out, 
        DATA_MEMORY_MEM, 
        ALU_OUT_MEM_WB,
        RD_MEM_out, 
        // out
        RegWrite_WB, 
        MemtoReg_WB, 
        DATA_MEMORY_WB, 
        ALU_OUT_WB, 
        RD_WB
    );
    
    
    
    // WB
    WB WB_instance(
        // in
        DATA_MEMORY_WB, 
        ALU_OUT_WB, 
        MemtoReg_WB,
        // out 
        ALU_DATA_WB
    );
    
endmodule
