`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2020 02:56:09 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(input clk,       
                   input mem_read, // asincrona
                   input mem_write, // sincrona
                   input [31:0] address,
                   input [31:0] write_data,
                   output reg [31:0] read_data
                   );
                   
reg [31:0] memory[1023:0];
integer i;
initial begin
    for(i = 0; i < 1024; i = i + 1) begin
        memory[i] = 0;
    end
end

wire [9:0] address_wire = address[11:2];

always @* begin
    if(mem_read) read_data = memory[address_wire];
end

always @(posedge clk) begin
    if(mem_write) memory[address_wire] = write_data;
end

endmodule
