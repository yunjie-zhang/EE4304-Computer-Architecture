`include "Register.v"
`include "Decoder.v"

module RegFile(clk, rst, addrA, addrB, addrC, regWrite, outA, outB, writeData);

    parameter SIZE = 32;

    input wire clk;
    input wire rst;
    input wire regWrite;

    input wire [4:0] addrA;
    input wire [4:0] addrB;
    input wire [4:0] addrC;
    input wire [SIZE - 1:0] writeData;

    output wire [SIZE - 1:0] outA;
    output wire [SIZE - 1:0] outB;

    wire [SIZE - 1:0] dec;
    wire [SIZE - 1:0] out [0:SIZE - 1];

    Decoder decoderC(
        .in(addrC),
        .out(dec)
    );

    generate
        genvar i;
        for (i = 1; i < SIZE; i = i + 1) begin
            Register i_R(
                .clk(clk),
                .rst(rst),
                .write(regWrite),
                .addr(dec[i]),
                .in(writeData),
                .out(out[i])
            );
        end
    endgenerate

    assign outA = out[addrA];
    assign outB = out[addrB];

endmodule
