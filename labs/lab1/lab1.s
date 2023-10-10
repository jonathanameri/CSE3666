#       CSE 3666 Lab 1

        .globl  main

        .text
main:   
        
        # read two positive integers from the console and 
        # save them in s1 and s2 
        # compute the GCD of the two numbers with Euclidean algorithm 
        #     while a != b:
        #         if a > b:
        #             a = a - b
        #         else:
        #             b = b - a
        # print the GCD

        # GCD examples:
        #     gcd(11, 121) = 11
        #     gcd(24, 60) = 12
        #     gcd(192, 270) = 6
        #     gcd(14, 97) = 1

        # use system call 5 to read integers
        addi    a7, x0, 5
        ecall
        addi    s1, a0, 0       # a in s1

        # using pseudoinstructions
        li      a7, 5
        ecall
        mv      s2, a0          # b in s2
        #mv s2, a0 -> s2 = a0
        
        # TODO
        # Add you code here
        # compute GCD(a, b) and print it
        
        beq x0, x0, test
loop:	blt s1, s2, case1	#if s1 < s2 goto case1
	sub s1, s1, s2		#else s1 = s1-s2
	beq x0, x0 test
case1:	sub s2, s2, s1		#s2 = s2-s1
test:	bne s1, s2, loop	#test if a != b

	li a7, 1
	add a0, s1, zero
	ecall

        # sys call to exit
exit:   addi    a7, x0, 10      
        ecall
