`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2020 05:26:09 PM
// Design Name: 
// Module Name: EX_MEM_reg
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


module EX_MEM_reg(clk, reset, write, RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, Branch_EX,
    PC_Branch, FUNCT3_EX, ALU_OUT_EX, ZERO_EX, REG_DATA2_EX, RD_EX, RegWrite_MEM,MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM,
                             PC_MEM,FUNCT3_MEM,
                             ALU_OUT_MEM,ZERO_MEM,
                             REG_DATA2_MEM,
                             RD_MEM
    );

input clk, reset, write;
input RegWrite_EX,MemtoReg_EX,MemRead_EX,MemWrite_EX,Branch_EX;
input [31:0]PC_Branch;
input [2:0] FUNCT3_EX;
input [31:0] ALU_OUT_EX;
input ZERO_EX;
input [31:0] REG_DATA2_EX;
input [4:0] RD_EX;

output reg RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, 
       MemWrite_MEM, Branch_MEM, ZERO_MEM;
output reg [31:0] PC_MEM, ALU_OUT_MEM, REG_DATA2_MEM;
output reg [2:0] FUNCT3_MEM;
output reg [4:0] RD_MEM;

    always @(posedge clk) begin
        if(reset) begin
            RegWrite_MEM <= 1'b0;
            MemtoReg_MEM <= 1'b0;
            MemRead_MEM <= 1'b0;
            MemWrite_MEM <= 1'b0;
            Branch_MEM <= 1'b0;
            ZERO_MEM <= 1'b0;
            PC_MEM <= 32'b0;
            ALU_OUT_MEM <= 32'b0;
            REG_DATA2_MEM <= 32'b0;
            FUNCT3_MEM <= 3'b0;
            RD_MEM <= 5'b0;
        end
        else begin
            if(write) begin
                RegWrite_MEM <= RegWrite_EX;
                MemtoReg_MEM <= MemtoReg_EX;
                MemRead_MEM <= MemRead_EX;
                MemWrite_MEM <= MemWrite_EX;
                Branch_MEM <= Branch_EX;
                ZERO_MEM <= ZERO_EX;
                PC_MEM <= PC_Branch;
                ALU_OUT_MEM <= ALU_OUT_EX;
                REG_DATA2_MEM <= REG_DATA2_EX;
                FUNCT3_MEM <= FUNCT3_EX;
                RD_MEM <= RD_EX;
            end
        end
    end

endmodule
