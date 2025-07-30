// Course: Certificación en diseño de circuitos integrados digitales
// Module6
// Client: COCYTEN 2024
// Owner: Team14
// Laboratory 2: Risc-V Syngle Cycle

`timescale 1ns / 1ps

module param_mux #(parameter int DATA_WIDTH = 32, parameter int NUM_INPUTS = 4) (
    input  wire signed [NUM_INPUTS-1:0][DATA_WIDTH-1:0] in, // Array of inputs
    input  wire [$clog2(NUM_INPUTS)-1:0] sel,         // Select signal
    output reg signed [DATA_WIDTH-1:0] out                  // Output
);

    always @(*) begin
        out = '0;
        for (int i = 0; i < NUM_INPUTS; i++) begin
            if (sel == i)
                out = in[i];
        end
    end

endmodule
