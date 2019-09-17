.data
start: .word 1	#0x10010000
end: .word 9	#0x10010004
diff: .word 2	#0x10010008
result: .word 0	#0x1001000c
#################################
#Sum of a arithmetic sequence
#Given a start value, end value and 
#common difference, find the sum of
#arithmetic sequence from start term
#(included) to a term less than end. 
#
#For example,
#start: 1 end: 9 diff: 2
#result = 1 + 3 + 5 + 7 = 16
#
#start: 1 end: 11 diff: 3
#result = 1 + 4 + 7 + 10 = 22
#################################
.text
main:	lui $s4, 0x1001		#load the base address 0x10010000 to s4
	ori $s4, $s4, 0x0000
	lw $s0, 0($s4)		#load start(0x10010000 + 0'd) to s0
	lw $s1, 4($s4)		#load end(0x10010000 + 4'd) to s1
	lw $s2, 8($s4)		#load diff(0x10010000 + 8'd) to s2
	lui $s3, 0x0000
loop:	add $s3, $s3, $s0
	add $s0, $s0, $s2
	slt, $s5, $s0, $s1	#set s5 if s0<s1		
	bne, $s5, $zero, loop	#if s5!=0, go to loop
	sw $s3, 12($s4)		#save ans to result((0x10010000 + 12'd)=0x1001000c)
#################################
#system call
#################################
	ori $2, $0, 10
	syscall
