`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 02:24:16 PM
// Design Name: 
// Module Name: registers
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


module registers(
    input clk,
    input reg_write,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
    );
    
    reg [31:0] memory [31:0];
    reg [31:0] aux1, aux2;
    integer i;
    
    // initializare registrii
    initial
    begin
        for(i = 0; i < 32; i = i+1)
            memory[i] = i;
    end
    
    // citire (asincrona)
    always @*
    begin
        aux1 = memory[read_reg1];
        aux2 = memory[read_reg2];
    end
    
    assign read_data1 = aux1;
    assign read_data2 = aux2;
    
    // scriere (sincrona)
    always @(posedge clk)
    begin
        if(reg_write)
            memory[write_reg] = write_data;
    end
    
endmodule
