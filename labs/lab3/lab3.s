#       CSE 3666 Lab 3: remove spaces

        .data
        .align 2
        # allocating space for both strings
str:    .space  128
res:    .space  128

        .globl  main

        .text
main:   

        # read a string into str
        # use pseudoinstruction la to load address into register
        la      a0, str
        li      a1, 100	# a1 is the max number of characters to read
        		# the maximum number of characters for input is 100
        li      a7, 8
        ecall

        # a0 is the address of str
        la      a1, res



	addi t0, a0, 0		# t0 = i = a0	[t0 is temporary register for indexing]
	addi t1, a1, 0		# t1 = j = a1	[t1 is temporary register for indexing]
	addi a2, x0, 32 	# a2 = 32
loop:	lb t2, 0(t0)		# load byte into t2 [t2 is used to see if 'current' byte is a space
	beq t2, a2, skip	# if the current byte is a space, don't write to res
	sb t2, 0(t1)		# if the current byte is NOT a space, write that byte to res
	addi t1, t1, 1		# increment i
skip:	addi t0, t0, 1		# increment j
	bne t2, x0, loop	# if we reach null terminator, end the loop

	# load result into a0 and print result
	li a7, 4
	la a0, res
	ecall


        # TODO
	# remove spaces in str
	# print res
               
exit:   addi    a7, x0, 10
        ecall
