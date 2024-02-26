# print_array.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
	array: .word 1 2 3 4 5 6 7 8 9 10
	cout: .asciiz "The contents of the array in reverse order are:\n"
	newline: .asciiz "\n"

.text
printA:
    # TODO: Write your function code here
	addi $t0, $a1, -1
	sll $t0, $t0, 2				# multiply by 4 so it lines up with array word size
	move $t2, $a0

loop:
	blt $t0, $zero, return
	add $t3, $t2, $t0
	
	# print array[i]
	lw $a0, 0($t3) 
	li $v0, 1
	syscall

	# print /n
	li $v0, 4
	la $a0, newline
	syscall

	addi $t0, -4		# move the array pointer back by 4 bytes
	j loop	

return:
	jr $ra

main:  # DO NOT MODIFY THE MAIN SECTION
	li $v0, 4
	la $a0, cout
	syscall

	la $a0, array
	li $a1, 10

	jal printA

exit:
	# TODO: Write code to properly exit a SPIM simulation
	li $v0, 10
	syscall

