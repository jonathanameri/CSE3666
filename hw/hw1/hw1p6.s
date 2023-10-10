#       CSE 3666 HW 1

        .globl  main

        .text
main:   


#problem 6
        li s1, 6		# s1 = a = 6	(a is a variable)
        li s2, 1 		# s2 = i = 1	(given in problem)
        			# S3 = j = 0
        li s4, 1		# s4 = r = 1	
        li s5, 0x55AABB33	# s5 = 0x55AABB33
        
	beq x0, x0, outtertest	# start the loop by first testing condition
oloop:	li s3, 0		# reset j to 0
	beq x0, x0, innertest	# start the inner loop by testing j < i
iloop:	add t0, s3, s5		# j + 0x55AABB3
	xor s4, s4, t0		# r ^= (j + 0x55AABB33)
	addi s3, s3, 1		# increment j by 1
innertest:	
	blt s3, s2, iloop	# if j < i, repeat inner loop
	addi s2, s2, 1		# increment i by 1
outtertest:
	blt s2, s1, oloop	# if i < a, repeat outter loop
	
	
	
        # exit
exit:   addi    a7, x0, 10      
        ecall
