module InstructionMemory(clk, in, out);
    input clk;
    input [31:0] in;

    output reg [31:0] out;

    reg [31:0] memdata [127:0];

    initial begin
    	memdata[0] = 32'h21080002; // addi $t0 $t0 2
    	memdata[4] = 32'h214a0002; // addi $t2 $t2 2
    	memdata[8] = 32'h010a4020; // add  $t0 $t0 $t2
    	memdata[12] = 32'h21290001; // addi $t1 $t1 1
    	memdata[16] = 32'had280000; // sw   $t0 0($t1)
    	memdata[20] = 32'h8d2a0000; // lw   $t2 0($t1)
    	memdata[24] = 32'h01094022; // loop: sub $t0 $t0 $t1
    	memdata[28] = 32'h11090001; // beq  $t0 $t1 end
    	memdata[32] = 32'h08000006; // j loop
    	memdata[36] = 32'hffffffff;
    end

    always @(*) begin
    	out = memdata[in];
    end

endmodule
