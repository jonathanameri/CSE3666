# CSE 3666. Cache
	.data
	.align 2
# 256 words
warray:	.space 1024
warray_end:

	# .text starts code segments
	.text
	.globl	main	# declare main to be global. Note it is ".globl"

main:	
	# s2: the stride size, in number of words
	# Try different values, 1, 2, 4, 8, and so on
	li	s2, 1
	
	# s3: the number of accesses to data memory
	li	s3, 10240

	# s0: starting address of the word array
	# s1: number of elements in the array
	la	s0, warray
	la	s1, warray_end
	sub	s1, s1, s0
	srai	s1, s1, 2

	# call read_array
	add	a0, s0, x0
	add	a1, s1, x0
	add	a2, s2, x0
	add	a3, s3, x0
	jal	read_array
	
	# exit from the program
exit:	addi	a7, x0, 10	
	ecall

# read_array(int a[], unsigned int n_elements, unsigned int stride_size, unsigned int n_accesses)
read_array:

	beq	a1, x0, ra_exit	# array length cannot be 0
	
	slli	t2, a2, 2	# stride size in bytes
	
	# t0 is the pointer, starting from a0
	# t1 is the index, from 0 to n_elements - 1 (a1)
	add	t0, a0, x0
	add	t1, x0, x0
	
	beq	x0, x0,	ra_test
ra_loop:
	lw	x0, 0(t0)	# do not need data
	
	# Set a breakpoint after LW
	add	t0, t0, t2	# add the stride size
	add	t1, t1, a2	
	bltu	t1, a1, ra_skip	# out of the range?

	# reset the pointer and index
	add	t0, a0, x0
	add	t1, x0, x0
	
ra_skip:
	addi	a3, a3, -1
ra_test:
	bne	a3, x0, ra_loop
	
ra_exit:
	jr	ra

