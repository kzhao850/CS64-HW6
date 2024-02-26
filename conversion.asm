# conversion.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text
conv:
    # TODO: Write your function code here
    li $v0, 0   # z = 0;
    li $t1, 0   # i = 0 -> for loop
    li $t2, 8
    li $t3, 2

loop:
    #Check condition, Calculate z,
    bge $t1, $t2, return    # Check if t1 >= 8
    # Compute z = z - 8x + y
    sll $t4, $a0, 3         # t3 = 8 * a0
    sub $v0, $v0, $t4
    add $v0, $v0, $a1
    bge $a0, $t3, if
    j loop2
if: 
    addi $a1, $a1, -1
loop2:
    addi $a0, $a0, 1
    addi $t1, $t1, 1
    j loop


return:
    jr $ra

main:  # DO NOT MODIFY THE MAIN SECTION
    li $a0, 5
    li $a1, 7

    jal conv

    move $a0, $v0
    li $v0, 1
    syscall

exit:
	# TODO: Write code to properly exit a SPIM simulation
    li $v0, 10
    syscall
