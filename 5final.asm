.data
	Array20: .word 1, 2, 3, 4, 5, 60, 70, 8, 9, 12, 21, 22, 23, 24, 25, 30, 35, 40, 48, 50
	comma:	.asciiz	", "
	memory:	.space	80
	message: .asciiz	"Array divided by 5 is: \n"
.text
.globl main
main:
	li $v0, 4		# print string code 4
	la $a0, message		# load prompt
	syscall
	
	la, $t2, Array20	# read string code 5
	li $t0, 80		# load space for 20 array size
	syscall
	
	jal DivBy5		# go to function
	
	move $a0, $t0
	li $v0, 1		# print int code 1
	syscall
	
	li $v0, 10		# end program
	syscall

DivBy5:
#	addi $t0, $zero, 0	# index $t0 = 0 first position in the array
	sll $t1, $s0, 0
	sw $zero, Array20($t0)	# store $t3 in the first position of the array
	add $t0, $t0, 1	# go to the next position
	blt $t0, 20, DivBy5	
	lw $t6, Array20($t0)
	div $t0, $t0, 5

	li $v0, 1
	move $t6, $a0
	syscall
	
	li $v0, 4
	la $a0, comma
	syscall
	
	j DivBy5

endLoop:
	jr $ra
	
