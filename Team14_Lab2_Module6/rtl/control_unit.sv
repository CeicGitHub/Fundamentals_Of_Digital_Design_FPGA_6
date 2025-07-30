// Course: Certificación en diseño de circuitos integrados digitales
// Module6
// Client: COCYTEN 2024
// Owner: Team14
// Laboratory 2: Risc-V Syngle Cycle

`timescale 1ns / 1ps

module control_unit (
    input wire [6:0] op,
    input wire [2:0] funct3,
    input wire funct7_5,
    input wire Zero,
    output wire PCSrc,
    output reg [1:0] ResultSrc,
    output reg MemWrite,
    output reg [2:0] ALUControl,
    output reg ALUSrc,
    output reg [1:0] ImmSrc,
    output reg RegWrite
);
 
    reg [1:0] ALUOp;
    reg Branch, Jump;
 
    always @(*) begin : MAIN_DECODER
        ResultSrc = 2'b00;
        MemWrite = 0;
        ALUSrc = 0;
        ImmSrc = 2'b00;
        RegWrite = 0;
        Branch = 0;
        Jump = 0;
        ALUOp = 2'b00;
        case (op)
            7'b0000011: begin // lw
                RegWrite = 1;
                ALUSrc = 1;
                ResultSrc = 2'b01;
            end
            7'b0100011: begin // sw
                ImmSrc = 2'b01;
                ALUSrc = 1;
                MemWrite = 1;
            end
            7'b0110011: begin // R-type
                RegWrite = 1;
                ALUOp = 2'b10;
            end
            7'b0010011: begin // I-type
                RegWrite = 1;
                ALUSrc = 1;
                ALUOp = 2'b10;
            end
            7'b1100011: begin // beq
                ImmSrc = 2'b10;
                Branch = 1;
                ALUOp = 2'b01;
            end
            7'b1101111: begin // jal
                RegWrite = 1;
                ALUSrc = 1;
                ImmSrc = 2'b11;
                ResultSrc = 2'b10;
                Jump = 1;
            end
        endcase
    end
    always @(*) begin : ALU_DECODER
        ALUControl = 0;
        casex({ALUOp, funct3, op[5], funct7_5}) 
            {2'b00, 3'bxxx, 2'bxx} : ALUControl = 3'b000; // add (lw, sw)
            {2'b01, 3'bxxx, 2'bxx} : ALUControl = 3'b001; // subtract (beq)
            {2'b10, 3'b000, 2'b00} : ALUControl = 3'b000; // add (add)
            {2'b10, 3'b000, 2'b01} : ALUControl = 3'b000; // add (add)
            {2'b10, 3'b000, 2'b10} : ALUControl = 3'b000; // add (add)
            {2'b10, 3'b000, 2'b11} : ALUControl = 3'b001; // subtract (sub)
            {2'b10, 3'b010, 2'bxx} : ALUControl = 3'b101; // set less than (slt)
            {2'b10, 3'b110, 2'bxx} : ALUControl = 3'b011; // or (or)
            {2'b10, 3'b111, 2'bxx} : ALUControl = 3'b010; // and (and)
        default: ALUControl = 0;
        endcase
    end
 
    assign PCSrc = (Zero & Branch) | Jump;
 
endmodule
