#       CSE 3666 Lab 4: Remove spaces

        .data

        # allocating space for str
str:    .space  128

        .globl  main

        .text
main:   
        # read a string into str
        # use pseudoinstruction la to load address into register
        la      a0, str

main_loop:
        # read a string
        addi    a1, x0, 100
        addi    a7, x0, 8
        ecall

        # check if the line is empty (has only the newline) 
        lb      t0, 0(a0)
        addi    t1, x0, '\n'
        beq     t0, t1, exit

	# a0 is already set. does not change during ecall
	jal	ra, print_ns

        # the address of str should be in a0 
        beq     x0, x0, main_loop
 
exit:   addi    a7, x0, 10
        ecall

# DO NOT change code above this line

# function 
print_ns:
	addi sp, sp, -128	# move stack pointer down 128 bytes (step 2)
	add a1, x0, sp		# store address of sp in a1
	
	addi sp, sp, -4		# push address of a0 to stack (step 1)
	sw a0, 0(sp)
	
	addi sp, sp, -4		# push return address to stack (step 1)
	sw x1, 0(sp)
	
	jal ra, remove_spaces	# call to function (step 3)
	
	lw x1, 0(sp)		# pop return address from stack
	addi sp, sp, 4
	
	# load result into a0 and print result (step 4)
	li a7, 4
	add a0, x0, a1
	ecall
	
	lw a0, 0(sp)		# pop a0 address from stack (step 5)
	addi sp, sp, 4
	
	addi sp, sp, 128	# move stack pointer back to original position (step 5)
	
	jr      ra		# exit function
		
        # TODO
        # allocate a byte array of 128 bytes on stack to save result  
        # call remove_spaces
        # print the result string
        # identify the registers that need to be preserved, but changed
        # save/restore registers

# function remove_spaces
remove_spaces:
	addi t0, a0, 0		# t0 = i = a0	[t0 is temporary register for indexing]
	addi t1, a1, 0		# t1 = j = a1	[t1 is temporary register for indexing]
	addi a2, x0, 32 	# a2 = 32
loop:	lb t2, 0(t0)		# load byte into t2 [t2 is used to see if 'current' byte is a space
	beq t2, a2, skip	# if the current byte is a space, don't write to res
	sb t2, 0(t1)		# if the current byte is NOT a space, write that byte to res
	addi t1, t1, 1		# increment i
skip:	addi t0, t0, 1		# increment j
	bne t2, x0, loop	# if we reach null terminator, end the loop

	jr      ra
        # TODO
	# copy your code from lab 3 here
        # it should work if it uses only temporary and argument registers
	# make necessary changes if needed
