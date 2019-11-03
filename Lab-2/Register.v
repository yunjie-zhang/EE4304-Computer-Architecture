module Register(clk, rst, write, addr, in, out);
    
    parameter SIZE = 32;

    input wire clk;
    input wire rst;
    input wire write;
    input wire addr;
    input [SIZE - 1:0] in;

    output reg [SIZE - 1:0] out;

    wire enable;

    assign enable = addr&write;

    always @(negedge clk) begin
        if(rst) begin
            out <= 32'h0000_0000;
        end
        else if(enable) begin
            out <= in;
        end
        else begin
            out <= out;
        end
    end


endmodule
