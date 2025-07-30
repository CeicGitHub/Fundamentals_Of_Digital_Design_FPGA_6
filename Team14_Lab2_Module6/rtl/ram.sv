// Course: Certificación en diseño de circuitos integrados digitales
// Module6
// Client: COCYTEN 2024
// Owner: Team14
// Laboratory 2: Risc-V Syngle Cycle

`timescale 1ns / 1ps

module ram #(parameter WIDTH = 32, parameter SIZE = 1024) (
    input  wire               clk,
    // R-PORT
    input  wire [WIDTH-1:0]   A,          
    output reg  [31:0]        RD,
    // W-PORT         
    input  wire               WE,
    input  wire [31:0]        WD    
);
 
    reg [7:0] mem [0:(SIZE * 4) - 1];
 
    always @(*) begin
        RD = { mem[A + 3], mem[A + 2], mem[A + 1], mem[A] };
    end
 
    always @(posedge clk) begin
        if (WE) begin
            mem[A + 0] <= WD[7:0];
            mem[A + 1] <= WD[15:8];
            mem[A + 2] <= WD[23:16];
            mem[A + 3] <= WD[31:24];
        end
    end
 
    function void init_word(
        input reg [WIDTH-1:0] byte_address,
        input reg [31:0] word_data
    );
        begin
            mem[byte_address + 0] = word_data[7:0];
            mem[byte_address + 1] = word_data[15:8];
            mem[byte_address + 2] = word_data[23:16];
            mem[byte_address + 3] = word_data[31:24];
        end
    endfunction
 
    initial begin
        void'(init_word(32'h2000, 32'h00000010)); // Data
    end
 
endmodule
