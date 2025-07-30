// Course: Certificación en diseño de circuitos integrados digitales
// Module6
// Client: COCYTEN 2024
// Owner: Team14
// Laboratory 2: Risc-V Syngle Cycle

`timescale 1ns / 1ps

module rom #(parameter WIDTH = 32, parameter SIZE = 1024) (
    // R-PORT
    input  wire [WIDTH-1:0] A,            
    output reg  [31:0]      RD           
);
 
    reg [7:0] mem [0:(SIZE * 4) - 1]; // SIZE * 4 because each 32-bit word = 4 bytes
 
    always @(*) begin
        RD = { mem[A + 3], mem[A + 2], mem[A + 1], mem[A] };
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
        void'(init_word(32'h1000, 32'hFFC4A303)); // LW
        void'(init_word(32'h1004, 32'h0064A423)); // SW
        void'(init_word(32'h1008, 32'h0062E233)); // OR
        void'(init_word(32'h100C, 32'hFE420AE3)); // BEQ
    end
 
endmodule
