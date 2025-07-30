// Course: Certificación en diseño de circuitos integrados digitales
// Module6
// Client: COCYTEN 2024
// Owner: Team14
// Laboratory 2: Risc-V Syngle Cycle

`timescale 1ns / 1ps

module regfile #(parameter WIDTH = 32) (
    input wire clk,
    input wire [4:0] A1,
    input wire [4:0] A2,
    input wire WE3,
    input wire [4:0] A3,
    input wire [WIDTH-1:0] WD3,
    output reg signed [WIDTH-1:0] RD1,
    output reg signed [WIDTH-1:0] RD2
);

    reg [WIDTH-1:0] X [0:31]; //32 bits para cada registro es decir = 1024
    // RS1
    always @(*) begin
        if(A1 != 0) begin
            RD1 = X[A1];
        end else begin
            RD1 = {{WIDTH}{1'b0}};
        end
    end
    // RS1
    always @(*) begin
        if(A2 != 0) begin
            RD2 = X[A2];
        end else begin
            RD2 = {{WIDTH}{1'b0}};
        end
    end
    // RD
    always @(posedge clk) begin
        if(WE3 && A3 != 0) begin
            X[A3] <= WD3;
        end
    end

endmodule 
