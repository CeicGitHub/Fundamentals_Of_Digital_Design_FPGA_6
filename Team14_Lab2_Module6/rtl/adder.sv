// Course: Certificación en diseño de circuitos integrados digitales
// Module6
// Client: COCYTEN 2024
// Owner: Team14
// Laboratory 2: Risc-V Syngle Cycle

`timescale 1ns / 1ps

module adder #(parameter WIDTH=32)

    (
    input wire [WIDTH-1:0] a,
    input wire [WIDTH-1:0] b,

    output wire [WIDTH-1:0] sum
    );

    assign sum = a + b;
    
endmodule
