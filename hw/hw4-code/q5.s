#       CSE 3666 uint2decstr

        .globl  main

	.data
	
str:	.space 100

        .text
main:   
	la	a0, str
        li	a1, -1		# test with different numbers
	jal	ra, uint2decstr

        la      a0, str
        addi    a7, x0, 4
        ecall

exit:   addi    a7, x0, 10      
        ecall

# char * uint2decstr(char *s, unsigned int v) 
# the function converts unsigned value to decimal string
# Here are some examples:
# 0:    "0"
# 2022: "2022"
# -1:   "4294967295"
uint2decstr:
	jr	ra
