# swap_case.asm program
# For CMPSC 64
#
# Data Area
.data
    buffer: .space 100
    input_prompt:   .asciiz "Enter string:\n"
    output_prompt:   .asciiz "Output:\n"
    convention: .asciiz "Convention Check\n"
    newline:    .asciiz "\n"

.text

# DO NOT MODIFY THE MAIN PROGRAM
main:
    la $a0, input_prompt    # prompt user for string input
    li $v0, 4
    syscall

    li $v0, 8       # take in input
    la $a0, buffer
    li $a1, 100
    syscall
    move $s0, $a0   # save string to s0

    ori $s1, $0, 0
    ori $s2, $0, 0
    ori $s3, $0, 0
    ori $s4, $0, 0
    ori $s5, $0, 0
    ori $s6, $0, 0
    ori $s7, $0, 0

    move $a0, $s0
    jal SwapCase

    add $s1, $s1, $s2
    add $s1, $s1, $s3
    add $s1, $s1, $s4
    add $s1, $s1, $s5
    add $s1, $s1, $s6
    add $s1, $s1, $s7
    add $s0, $s0, $s1

    la $a0, output_prompt    # give Output prompt
    li $v0, 4
    syscall

    move $a0, $s0
    jal DispString

    j Exit

DispString:
    addi $a0, $a0, 0
    li $v0, 4
    syscall
    jr $ra

ConventionCheck:
    addi    $t0, $0, -1
    addi    $t1, $0, -1
    addi    $t2, $0, -1
    addi    $t3, $0, -1
    addi    $t4, $0, -1
    addi    $t5, $0, -1
    addi    $t6, $0, -1
    addi    $t7, $0, -1
    ori     $v0, $0, 4
    la      $a0, convention
    syscall
    addi    $v0, $zero, -1
    addi    $v1, $zero, -1
    addi    $a0, $zero, -1
    addi    $a1, $zero, -1
    addi    $a2, $zero, -1
    addi    $a3, $zero, -1
    addi    $k0, $zero, -1
    addi    $k1, $zero, -1
    jr      $ra
    
Exit:
    ori     $v0, $0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

# YOU CAN ONLY MODIFY THIS FILE FROM THIS POINT ONWARDS:
SwapCase:
    #TODO: write your code here, $a0 stores the address of the string
    addi $sp, $sp, -8 
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    move $s0, $a0   #store incoming string address

loop:
    lb $t0, 0($s0)    # load the current character
    beq $t0, $zero, return

    

    # ASCII values of the characters
    li $t1, 'a'             
    li $t2, 'A'
    bge $t0, $t1, checkLower
    bge $t0, $t2, checkUpper
    j loop2

checkLower:
    li $t1, 'z'
    bgt $t0, $t1, loop2

    # print original char
    li $v0, 11
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    addi $t0, $t0, -32
checkUpper:
    li $t1, 'Z'
    bgt $t0, $t1, loop2

    # print original char
    li $v0, 11
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    addi $t0, $t0, 32
loop2:
    # print the new character

    li $v0, 11
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    sw $t0, 0($s0)
    addi $s0, $s0, 1
    jal ConventionCheck
    j loop
return:
    # Do not remove the "jr $ra" line below!!!
    # It should be the last line in your function code!
    jr $ra

