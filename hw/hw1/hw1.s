#       CSE 3666 HW 1

        .globl  main

        .text
main:   
        li s0, 0x98AB3C6A
        li s1, 0x20503666
        
        add t0, s0, s1
        and t1, s0, s1
        or t2, s0, s1
        xor t3, s0, s1
        addi t4, s0, 0x210
        andi t5, s0, -16
        slli t6, s0, 12
        srai s2, s0, 8
        
        mv a0, t0
        li a7, 34
        ecall
        #   print newline
        li a0, '\n'	#loads the intermediate value of '\n' into a0
        li a7, 11	#load code 11 into a7, code 11 -> printChar
        ecall
        
        mv a0, t1
        li a7, 34
        ecall
        #   print newline
        li a0, '\n'	#loads the intermediate value of '\n' into a0
        li a7, 11	#load code 11 into a7, code 11 -> printChar
        ecall
        
        mv a0, t2
        li a7, 34
        ecall
        #   print newline
        li a0, '\n'	#loads the intermediate value of '\n' into a0
        li a7, 11	#load code 11 into a7, code 11 -> printChar
        ecall
        
        mv a0, t3
        li a7, 34
        ecall
        #   print newline
        li a0, '\n'	#loads the intermediate value of '\n' into a0
        li a7, 11	#load code 11 into a7, code 11 -> printChar
        ecall
        
        mv a0, t4
        li a7, 34
        ecall
        #   print newline
        li a0, '\n'	#loads the intermediate value of '\n' into a0
        li a7, 11	#load code 11 into a7, code 11 -> printChar
        ecall
        
        mv a0, t5
        li a7, 34
        ecall
        #   print newline
        li a0, '\n'	#loads the intermediate value of '\n' into a0
        li a7, 11	#load code 11 into a7, code 11 -> printChar
        ecall
        
        mv a0, t6
        li a7, 34
        ecall
        #   print newline
        li a0, '\n'	#loads the intermediate value of '\n' into a0
        li a7, 11	#load code 11 into a7, code 11 -> printChar
        ecall
       
        mv a0, s2
        li a7, 34
        ecall
        #   print newline
        li a0, '\n'	#loads the intermediate value of '\n' into a0
        li a7, 11	#load code 11 into a7, code 11 -> printChar
        ecall
        
        
        
        
        
        
        
        
        #problem 4
        #multiply s1 by 24
        li s1, 6	#start with some value
        add s2, s1, s1	#use add 2 times to triple the value in s1
        add s2, s2, s1

        slli s2, s2, 3	#shift s1 3 bits to the left, this is the equivalent of multiplying by 8
        		#since we multiplied by 3 at first and then 8, this is the same as multiplying by 24
        
        #print result
        mv a0, s2
        li a7, 1
        ecall
        
        #   print newline
        li a0, '\n'	#loads the intermediate value of '\n' into a0
        li a7, 11	#load code 11 into a7, code 11 -> printChar
        ecall
        
        
        
        li s0, 0xFF00FF00
        #problem 5a
        addi s1, x0, 0		# s1 = 0
        addi t0, x0 1		# Use t0 as mask to test each bit in s0
loop:	
	and t1, s0, t0		# extract a bit with the mask
	beq t1, x0, skip	# if the bit is 0, do not increment s1
	addi s1, s1, 1		# increment the counter
skip:
	slli t0, t0, 1		# shift mask to left by 1
	bne t0, x0, loop	# if the mask is not 0, continue
	
	#print result
        mv a0, s1
        li a7, 1
        ecall
	
	#   print newline
        li a0, '\n'	#loads the intermediate value of '\n' into a0
        li a7, 11	#load code 11 into a7, code 11 -> printChar
        ecall
	
	#problem 5b
        addi s1, x0, 0		# s1 = 0
        add t0, x0, s0		# Use t0 as mask to test each bit in s0
loop1:	
	bge t0, x0, skip1	#if t0 >= 0, the first bit is 0
	addi s1, s1, 1		# increment the counter
skip1:
	slli t0, t0, 1		# shift mask to left by 1
	bne t0, x0, loop1	# if the mask is not 0, continue
        
        #print result
        mv a0, s1
        li a7, 1
        ecall
        
        #   print newline
        li a0, '\n'	#loads the intermediate value of '\n' into a0
        li a7, 11	#load code 11 into a7, code 11 -> printChar
        ecall
        
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
	blt s3, s2, iloop	# if j < i, repeat loop
	addi s2, s2, 1		# increment i by 1
outtertest:
	blt s2, s1, oloop
	
	
	
	
	#problem 6 copy
        li s1, 6		# s1 = a = 6	(a is a variable)
        li s2, 1 		# s2 = i = 1	(given in problem)
        			# S3 = j = 0
        li s4, 1		# s4 = r = 1	
        li s5, 0x55AABB33	# s5 = 0x55AABB33
        
loop1:  bge s2, s1, skip1
        li s3, 0
loop2:  bge s3, s2, skip2
        add t0, s3, s5		# j + 0x55AABB3
	xor s4, s4, t0		# r ^= (j + 0x55AABB33)
	addi s3, s3, 1	
	beq x0, x0, loop2
	addi s2, s2, 1
	beq x0, x0, loop1
        
        
	beq x0, x0, outtertest	# start the loop by first testing condition
floop:	li s3, 0		# reset j to 0
	beq x0, x0, innertest	# start the inner loop by testing j < i
sloop:	add t0, s3, s5		# j + 0x55AABB3
	xor s4, s4, t0		# r ^= (j + 0x55AABB33)
	addi s3, s3, 1		# increment j by 1
innertest:	
	blt s3, s2, sloop	# if j < i, repeat loop
	addi s2, s2, 1		# increment i by 1
outtertest:
	blt s2, s1, floop
	
	
	
	#print result
        mv a0, s4
        li a7, 1
        ecall

        
        # exit
exit:   addi    a7, x0, 10      
        ecall
