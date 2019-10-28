module PC(clk, rst, in, out);
    parameter SIZE = 32;

    input wire clk;
    input wire rst;
    input wire [SIZE - 1:0] in;

    output reg [SIZE - 1:0] out;

    always @(posedge clk) begin
        if(rst) begin
            out  <= 32'h0000_0000;
        end
        else begin
            out <= in;
        end
    end

endmodule
