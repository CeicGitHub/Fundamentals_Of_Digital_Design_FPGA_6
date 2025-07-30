// Course: Certificación en diseño de circuitos integrados digitales
// Module6
// Client: COCYTEN 2024
// Owner: Team14
// Laboratory 2: Risc-V Syngle Cycle

`timescale 1ns / 1ps

module alu #(parameter WIDTH = 32) (
    input wire signed [WIDTH-1:0] SrcA,
    input wire signed [WIDTH-1:0] SrcB,
    input wire [2:0] ALUControl,
    input wire ALUfunct7_5,
    output reg signed [WIDTH-1:0] ALUResult
);

    always @(*) begin
        ALUResult = 0;
        case(ALUControl)   
            3'b000: ALUResult = (ALUfunct7_5) ? SrcA - SrcB : SrcA + SrcB;
            3'b001: ALUResult = SrcA << $unsigned(SrcB[4:0]);
            3'b010: ALUResult = SrcA < SrcB;
            3'b011: ALUResult = $unsigned(SrcA) < $unsigned(SrcB);
            3'b100: ALUResult = SrcA ^ SrcB;
            3'b101: ALUResult = (ALUfunct7_5) ? SrcA >>> $unsigned(SrcB[4:0]) : SrcA >> $unsigned(SrcB[4:0]);
            3'b110: ALUResult = SrcA | SrcB;
            3'b111: ALUResult = SrcA & SrcB;
        endcase 

    end
    
endmodule

