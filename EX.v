`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2020 04:17:34 PM
// Design Name: 
// Module Name: EX
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

module EX(input [31:0] IMM_EX,                  // adder, mux RS2   
          input [31:0] REG_DATA1_EX,            // muxA
          input [31:0] REG_DATA2_EX,            // muxB
          input [31:0] PC_EX,                   // adder
          input [2:0] FUNCT3_EX,                // alu control
          input [6:0] FUNCT7_EX,                // alu control
          input [4:0] RD_EX,                    // propagat
          input [4:0] RS1_EX,                   // propagat
          input [4:0] RS2_EX,                   // propagat
          input RegWrite_EX,                   
          input MemtoReg_EX,                    
          input MemRead_EX,                     
          input MemWrite_EX,                   
          input [1:0] ALUop_EX,                 // alu control
          input ALUSrc_EX,                      // mux RS2
          input Branch_EX,                      
          input [1:0] forwardA, forwardB,    // muxA, muxB
          
          input [31:0] ALU_DATA_WB,         // muxA, muxB
          input [31:0] ALU_OUT_MEM,         // muxA, muxB
          
          output ZERO_EX,                   // alu
          output [31:0] ALU_OUT_EX,         // alu
          output [31:0] PC_Branch_EX,           // adder
          output [31:0] REG_DATA2_EX_FINAL      // out de la muxB sau regdata2ex
          
          
          // outuri adaugate pentru propagare
          ,
          output [4:0] RD_out,
          output [4:0] RS1_out,
          output RegWrite_out,                    // propagat
          output MemtoReg_out,                    // propagat
          output MemRead_out,                     // propagat
          output MemWrite_out,                    // propagat
          output Branch_out,
          output [2:0] FUNCT3_out
          );
   
   wire [31:0] MUX_A_EX, MUX_B_EX, RS2_IMM_EX;
   wire [3:0] ALU_Control;
   // adder
   adder ADDER_MODULE(PC_EX, IMM_EX, PC_Branch_EX);
   
   // mux_a, mux_b
   mux4_1 MUX_A(REG_DATA1_EX, ALU_DATA_WB, ALU_OUT_MEM, 32'b0, forwardA, MUX_A_EX);
   mux4_1 MUX_B(REG_DATA2_EX, ALU_DATA_WB, ALU_OUT_MEM, 32'b0, forwardB, MUX_B_EX);
   
   // mux_c
   mux2_1 MUX_C(IMM_EX, MUX_B_EX, ALUSrc_EX, RS2_IMM_EX);
   
   // ALU_control
   ALUcontrol ALUcontrol_MODULE(ALUop_EX, FUNCT7_EX, FUNCT3_EX, ALU_Control);
   
   // ALU
   ALU ALU_MODULE(ALU_Control, MUX_A_EX, RS2_IMM_EX, ZERO_EX, ALU_OUT_EX);
   
   // valori propagate
   assign RD_out = RD_EX;
   assign RS1_out = RS1_EX;
   assign RegWrite_out = RegWrite_EX;
   assign MemtoReg_out = MemtoReg_EX;
   assign MemRead_out = MemRead_EX;
   assign MemWrite_out = MemWrite_EX;
   assign Branch_out = Branch_EX;
   assign REG_DATA2_EX_FINAL = MUX_B_EX;
   
   assign FUNCT3_out = FUNCT3_EX;
   
endmodule
