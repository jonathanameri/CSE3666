#       CSE 3666 uint2decstr

        .globl  main

	.data
	
str:	.space 100

        .text
main:   
	la	a0, str
        li	a1, 2004		# test with different numbers
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
	addi sp, sp, -12	# Reserve space to store data
	sw s0, 8(sp)		# save values of s0, s1, and ra
	sw s1, 4(sp)
	sw ra, 0(sp)
	add s0, x0, a0		# save the address of input string into s0
	add s1, x0, a1		# save the value of v into s1
	addi t0, x0, 10		# save the value 10 into t0
	blt s1, t0, skip	# If v >= 10, recursive call
	divu a1, s1, t0		# save new value of v for recursive call into a1
	jal ra, uint2decstr	# recursive call
	add s0, x0, a0		# s0 = return value from recursive call
skip:
	remu  t1, s1, t0	# finds remainder of v % 10 and saves into t1
	addi t1, t1, '0'	# add value of remainder to the value of '0'
	sb t1, 0(s0)		# save resulting int into s[0]
	sb x0, 1(s0)		# save 0 into s[1]
	
	addi a0, s0, 1		# return value = s[1]
	lw ra, 0(sp)		# load values of ra, s1, and s0
	lw s1, 4(sp)
	lw s0, 8(sp)
	addi sp, sp, 12		# move stack pointer back to original position
	jr	ra		# return