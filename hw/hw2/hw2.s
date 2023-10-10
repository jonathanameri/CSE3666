#       CSE 3666 HW 2

        .globl  main

        .text
main:   


#1a)
	li s4, 100
	li s1, 0
loop:
	slli t0, s1, 2		# t0 = i * 4
	add t2, t0, s2		# compute addr of A[i]
	lw t1, 0(t2)
	addi t1, t1, 4
	add t3, t0, s3		# compute addr of B[i]
	sw t1, 0(t3)
	addi s1, s1, 1
test:	bne s1, s4, loop	# 8 instructions in the loop	
#the number of instructions per loop is 7/8 depending on how u count
#number of iterations is 100
#total instructions is 800 or 802

#1b)
	li s4, 100		
	li s1, 0		# initialize i = 0
loop:
	slli t0, s1, 2		# t0 = i * 4
	add t2, t0, s2		# compute addr of A[i]
	add t3, t0, s3		# compute addr of B[i]
	
	lw t1, 0(t2)		# load value in A[i]
	lw t4, 4(t2)		# load value in A[i+1]
	lw t5, 8(t2)		# load value in A[i+2]
	lw t6, 12(t2)		# load value in A[i+3]
	addi t1, t1, 4		# add 4 to the value in A[i]
	addi t4, t4, 4		# add 4 to the value in A[i+1]
	addi t5, t5, 4		# add 4 to the value in A[i+2]
	addi t6, t6, 4		# add 4 to the value in A[i+3]
	sw t1, 0(t3)		# save A[i] + 4 in B[i]
	sw t4, 4(t3)		# save A[i+1] + 4 in B[i+1]
	sw t5, 8(t3)		# save A[i+2] + 4 in B[i+2]
	sw t6, 12(t3)		# save A[i+3] + 4 in B[i+3]
	
	addi s1, s1, 4		# i = i + 4
test:	bne s1, s4, loop	# 17 instructions in the loop
				# 25 iterations
				# 2 + (17 * 25) = 427 instructions total



