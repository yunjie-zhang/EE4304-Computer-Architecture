.data
x: .word 4	#0x10010000
result: .word 0	#0x10010004 
#####################################################
#Logic NOT Operation
#NOR with zero
#####################################################
.text
main:	lui $s0, 0x1001		#load the base address 0x10010000 to s0
	ori $s0, $s0, 0x0000
	lw $s1, 0($s0)
	nor $s1, $s1, $zero
	sw, $s1, 4($s0)
#################################
#system call
#################################
	ori $2, $0, 10
	syscall
