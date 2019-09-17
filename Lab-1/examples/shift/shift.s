.data
x: .word 4	#0x10010000
result: .word 0	#0x10010004 
#####################################################
#Find 2 to the power of x. x is stored in 0x10010000
#####################################################
.text
main:	lui $s0, 0x1001		#load the base address 0x10010000 to s0
	ori $s0, $s0, 0x0000
	lw $s1, 0($s0)		#load x(0x10010000 + 0'd) to s1. s1 is the counter
	lui $s2, 0x0000
	ori $s2, $s2, 0x0001	#initial value is 1
loop:	beq $s1, $zero, exit
	addi $s1, $s1, -1	#if counter has no reached 0, s2 is left shift one bit(x2)
	sll $s2, $s2, 1
	j loop
exit:	sw $s2, 4($s0)
#################################
#system call
#################################
	ori $2, $0, 10
	syscall
