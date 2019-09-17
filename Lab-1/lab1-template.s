.data
size: .word 10
target: .word 3998
result: .word 0
array: .word 1, 64, 189, 674, 1005, 2763, 3730, 3998, 5476 ,10003

.text
########################################
# Your code starts here
# Your name: 
########################################
main:	
########################################
# Your code ends here
# Store your answer to 0x10010008(result)
########################################
	ori $2, $0, 10
	syscall
