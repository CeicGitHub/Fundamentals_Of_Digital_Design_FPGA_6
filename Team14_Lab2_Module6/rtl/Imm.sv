// Course: Certificación en diseño de circuitos integrados digitales
// Module6
// Client: COCYTEN 2024
// Owner: Team14
// Laboratory 2: Risc-V Syngle Cycle

`timescale 1ns / 1ps

module Imm #(parameter WIDTH = 32) (
    input wire [31:0] Instr,
    input wire [2:0] ImmSrc,
    output reg signed [WIDTH-1:0] ImmExt
);
    always @(*) begin
        case (ImmSrc)
            3'b000: ImmExt = {{20{Instr[31]}}, Instr[31:20]}; // I
            3'b001: ImmExt = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]}; // S
            3'b010: ImmExt = {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0}; // B
            3'b011: ImmExt = {{20{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0}; // J
            3'b100: ImmExt = {Instr[31:12], 12'h000}; //U
            default: ImmExt = 0;
        endcase    
    end
endmodule
