.data
size: .word 10 					#10010000
result: .word 0					#10010004
array: .word 0, 2, 4, 6, 8, 10, 12, 14, 16, 18	#10010008
#################################
#Find the sum of an array (given the size)
#################################
.text
main:	lui $s0, 0x1001		#load the base address 0x10010000 to s0
	ori $s0, $s0, 0x0000
	lw $s1, 0($s0)		#load the size into s1	
	addi $s4, $s0, 8	#load the base address of array to s4 (0x10010000 + 8'd)
	add $s3, $s3, $zero
loop:	lw $s2, 0($s4)
	add $s3, $s3, $s2
	addi $s1, $s1, -1
	addi $s4, $s4, 4	#increment s4 by 4 every loop
	bne, $s1, $zero, loop
	sw $s3, 4($s0)		#save ans to result((0x10010000 + 4'd)=0x10010004)
#################################
#system call
#################################
	ori $2, $0, 10
	syscall
