module DataMemory(clk, rst, memWrite, memRead, addr, writeData, out);

    input wire clk;
    input wire rst;

    input wire memWrite;
    input wire memRead;
    input wire [31:0] addr;
    input wire [31:0] writeData;

    output reg [31:0] out;

    reg [31:0] mem [0:255];
    
    initial begin
		mem[0]   = 32'b000001_10000100010000000000010000;
		mem[1]   = 32'b000100_00000100100000000000000000;
		mem[5]   = 32'b000111_10000100110000000000000000;
    end

    integer i;
	 always @(negedge clk) begin
		if (memWrite) begin
        	mem[addr[7:0]] <= writeData;
      end
	 end
    always @(*) begin
        if(rst) begin
            for(i = 0; i < 256; i = i+1) begin
            	mem[i] <= 32'h0000_0000;
            end
        end
        else if (memRead) begin
        	out <= mem[addr[7:0]];
        end
        else begin
        	out <= 32'bzz;
        end
    end

//    assign out = mem[addr[7:0]];

endmodule
