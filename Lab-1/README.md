# EE4304 Lab1 Instruction
Feel free to let me know if you have any suggestions or find any bug/typo/error. This tutorial will updated based on your feedback, so please keep tracking of this respository: https://github.com/yunjie-zhang/EE4304-Computer-Architecture.git 
## Installing SPIM
In your terminal, type:
```
sudo apt-get install spim
```
## Running Your Assembly Code

```
spim
(spim): load "$YOUR_CODE.s"
(spim): run
(spim): print ($REGISTER/$MEMORY ADDRESS)
```
You can find more spim command by typing ```help``` in the shell
## Data Memory
This is a snippet code of the template: 
```
.data
a: .word 0x1234ABCD     	
b: .word 9, 4, 6	                  
c: .word 0xABCD5678	                        
result: .word 0	#0x1001000c
```
In MIPS, the address of the first word ```0x123456ABCD``` is ```0x10010000```. Because this is a 32-bit MIPS machine and thus, each word is 32 bits, the address of next word is incremented by 32/8 = 4 which is ```0x10010004```. The address of ```0x123456ABCD``` is ```0x10010000 + 4 + 4 * 3 = 0x10010010```, as array b takes 3 * 4 bytes = 12 bytes. 

## Operators and Operands
You will design a simple MIPS CPU in lab2 and lab3, indicating that the instructions used in lab1 will be implemented on hardware with Verilog. Thus, in order to minimize your future worload, the operators and operands can be used in lab1 is lmited to the following:
```
Save and load operator:         lui, lw, sw
Arithmetic operator:            add, sub, addi
Logical operator:               srl, sll, and, or, andi, ori, xor, nor
Branch operator:                slt, beq, bne, j
Operands:                       t0-t7, s0-s7, zero(hardwared zero), imme(immediate value)
```
(No multiplication or division will be included)

Please read the usage of these operators carefully:
### LUI: Load upper immediate
```
The immediate value is stored in the higher 16 bits of register. The lower 16 bits are zeroes.
Syntax: lui $t, imm             Example: lui $s0, 0x6666             pc<-pc+4; s0<-0x66660000
Encoding: 0011 11-- ---t tttt iiii iiii iiii iiii
```

### LW: Load word
```
A word is loaded into a register from the specified address.
Syntax: lw $t, offset($s)       Example: lw $s0, 0($s1)             pc<-pc+4; s0<-MEM[$s1+0]           
Encoding: 1000 11ss ssst tttt iiii iiii iiii iiii
```

### SW: Store word
```
The contents of $t is stored at the specified address.
Syntax: sw $t, offset($s)       Example: sw $s0, 0($s1)             pc<-pc+4; MEM[$s1+0]<-s0
Encoding: 1010 11ss ssst tttt iiii iiii iiii iiii
```

### ADD
```
Adds two registers and stores the result in a register
Syntax: add $d, $s, $t          pc<-pc+4; $d<-$s+$t
Encoding: 0000 00ss ssst tttt dddd d000 0010 0000
```

### SUB
```
Subtracts two registers and stores the result in a register
Syntax: sub $d, $s, $t          pc<-pc+4; $d<-$s-$t
Encoding: 0000 00ss ssst tttt dddd d000 0010 0010
```

### ADDI
```
Adds a register and a sign-extended immediate value and stores the result in a register
Syntax: addi $t, $s, imm        pc<-pc+4; $t<-$s+imm
0010 00ss ssst tttt iiii iiii iiii iiii
```
### SRL
```
Shifts a register value right by the shift amount and places the value in the destination register. Zeroes are shifted in.
Syntax: srl $d, $t, h           pc<-pc+4; $d<-$t >> h
Encoding: 0000 00-- ---t tttt dddd dhhh hh00 0010
```
### SLL
```
Shifts a register value left by the shift amount and places the result in the destination register. Zeroes are shifted in.
Syntax: sll $d, $t, h           pc<-pc+4; $d<-$t << h
Encoding: 0000 00ss ssst tttt dddd dhhh hh00 0000
```
### AND 
```
Bitwise ands two registers and stores the result in a register
Syntax: and $d, $s, $t          pc<-pc+4; $d=$s&$t
Encoding: 0000 00ss ssst tttt dddd d000 0010 0100
```
### OR
```
Bitwise logical ors two registers and stores the result in a register
Syntax: or $d, $s, $t          pc<-pc+4; $d=$s|$t
Encoding: 0000 00ss ssst tttt dddd d000 0010 0101
```
### XOR
```
Bitwise logical xor two registers and stores the result in a register
Syntax: xor $d, $s, $t          pc<-pc+4; $d=$s^$t
Encoding: 0000 00ss ssst tttt dddd d--- --10 0110
```
### NOR
```
Bitwise logical nor two registers and stores the result in a register
Syntax: nor $d, $s, $t          pc<-pc+4; $d=$s nor $t
Encoding: 0000 00ss ssst tttt dddd d--- --10 0111
```

### ANDI
```
Bitwise ands a register and an immediate value and stores the result in a register
Syntax: andi $t, $s, imm       pc<-pc+4; $t=$s&imm
Encoding: 0011 00ss ssst tttt iiii iiii iiii iiii
```
### ORI
```
Bitwise ors a register and an immediate value and stores the result in a register
Syntax: ori $t, $s, imm       pc<-pc+4; $t=$s|imm
Encoding: 0011 01ss ssst tttt iiii iiii iiii iiii
```
### SLT
```
If $s is less than $t, $d is set to one. It gets zero otherwise.
Syntax: slt $d, $s, $t       pc<-pc+4; if $s < $t $d = 1 else $d = 0
Encoding: 0000 00ss ssst tttt dddd d000 0010 1010
```
### BEQ 
```
Branches if the two registers are equal
Syntax: beq $s, $t, offset   if $s==$t pc<-(offset << 2)); else pc<-pc+4;
Encoding: 0001 00ss ssst tttt iiii iiii iiii iiii
```
### BNE 
```
Branches if the two registers are not equal
Syntax: bne $s, $t, offset   if $s!=$t pc<-(offset << 2)); else pc<-pc+4;
Encoding: 0001 01ss ssst tttt iiii iiii iiii iiii
```
### J
```
Jumps to the calculated address
Syntax: j target             PC<-((PC & 0xf0000000) | (target << 2));
Encoding: 0000 10ii iiii iiii iiii iiii iiii iiii
```
(*Note: spim can take care of target address automatically when executing your code, so you don't need calculate target address by yourself. This type of instructions are okay:
```
loop: add $s0 , $s1, $s2
      j loop
```
pc will be directed back to loop automatically. It also works for beq and bne.
)
## MIPS Assembly/Pseudoinstructions
The instructions that mentioned above can be implemented in hardware. However, there are a lot of pseudo instructions that can be read and handled by spim, but cannot decoded by actual CPUs. For example, 

```
la $s0, 0x10010000
```

This instruction stores 0x10010000 into $s0. However, it is not possble for a 32-bit CPU to handle this 32-bit instruction, because the immediate value 0x10010000 takes all 32 bits and there is no space for op code or destination register nubmer. Thus, in real practice, it is handled by SPIM in this way:

```
lui $s0, 0x1001
ori $s0, $s0, 0x0000
```
Let's take a look on another instruction:

```
add $s0, $s1, 0x1234abcd
```
add is a real operator, but it cannot handle addition of a register and an immediate value. SPIM will expande it to:

```
lui $1, 0x1234
ori $1, $1, 0xabcd
add $s0, $s1, $1
```
where register $1 is preserved for pseudoinstructions. Since pseudoinstructions can be handled by SPIM, that might be a little bit difficult for you to check if pseudoinstructions have been used in your code. One simple to do the check is to use ```step "$STEP_NUM" ``` instead of ```run```. For example, 
``` 
[0x00400030]	0x3c011234  lui $1, 4660                    ; 8: add $s0, $s1, 0x1234abcd
[0x00400034]	0x3421abcd  ori $1, $1, -21555
[0x00400038]	0x02218020  add $16, $17, $1
```
Right side is the instruction in the file, left side is the actual execution flow. Original ADD instruction is expanded to three instructions. 

## Examples
I have put four examples in this repository. They can help you have a better understanding of conditional loop, data addressing and bitwise operation. 

