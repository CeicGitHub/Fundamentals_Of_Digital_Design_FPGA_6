// Course: Certificación en diseño de circuitos integrados digitales
// Module6
// Client: COCYTEN 2024
// Owner: Team14
// Laboratory 2: Risc-V Syngle Cycle

`timescale 1ns / 1ps

module pc #(
    parameter WIDTH = 32,                 // Ancho del bus del contador de programa
    parameter RESET_ADDR = 32'h0000_0000 // Dirección de reinicio del PC
)(
    input  wire clk,                     // Señal de reloj
    input  wire arstn,                   // Reset asíncrono activo en bajo
    input  wire [WIDTH-1:0] PCNext,      // Valor siguiente del PC
    output reg  [WIDTH-1:0] PC           // Salida actual del PC
);

    always @(posedge clk or negedge arstn) begin
        if (!arstn) begin
    PC <= RESET_ADDR;
        end else begin
    PC <= PCNext;
        end 
    end

    
endmodule

