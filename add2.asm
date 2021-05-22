#################################################################################################################
# Author:	Raphael Fidelis Lacet
# Date:		01/28/2021
# Description:	Program that computes and print the sum of two numbers (A and B) specified by the user at runtime
# Input:	A, B
# Output:	A + B
# $t0 - used to hold the value of integer A (first user input)
# $t1 - used to hold the value of integer B (second user input)
# $t2 - used to hold the sum of integers A and B in registers $t1 and $t2. 
# $v0 - syscall parameter and return value. 
# $a0 - syscall parameter. 
############################################### Data segment ####################################################
.data
promptA: .asciiz		"\nPlease enter a positive integer for value A: \n"
promptB: .asciiz		"\nPlease enter a positive integer for value B: \n"
promptC: .asciiz		"\nThe result of A + B is: \n"
#promptD: .asciiz		"\nThe result in Hexadecimal is: \n"
############################################### Data segment ####################################################
.text
.globl main
main:				# main program entry
				# First integer A
	li	$v0, 4		# Print string code 4
	la	$a0, promptA	# String print address of promptA
	syscall			# Syscall parameter
	
				# get user input for integer A
	li	$v0, 5		# Syscall code 5 to read integer A
	syscall 		# Syscall parameter to get typed user input A
	move 	$t0, $v0	# hold the integer 'A' in $t0 as requested by the assigment
	
				# Second integer B
	li	$v0, 4		# Print string code 4
	la	$a0, promptB	# String print address of promptB
	syscall			# Syscall parameter

				# get user input for integer B
	li	$v0, 5		# Syscall code 5 to read integer B
	syscall 		# Syscall parameter to get typed user input B
	move 	$t1, $v0	# hold the integer 'B' in $t1 as requested by the assigment
		
				# compute sum of A + B
	add 	$t2, $t0, $t1	# add $t0 (A) + $t1 (B) = $t2 (sum A + B) 	
	
	li	$v0, 4		# Print string code 4 (print result in $v0)
	la	$a0, promptC	# String print address of promptC
	syscall      		# Syscall parameter. 
				
	move 	$a0,$t2		# Hexadecimal convertion of the result
	li	$v0, 1		# Print string code 34 (print hexadecimal result in $v0)
#	la	$a0, promptD	# String print address of promptD
	syscall      		# Syscall parameter. 
			
				# reuslt A + B 
	#li	$v0, 1		# Syscall code 1 to print the result of A + B
	#move	$a0, $t2	# hold the result A + B in $t2 as requested by the assigment
	#syscall		# Syscall parameter
				
	li $v0, 10   		# syscall code 10 for exit. 
	syscall      		# Syscall parameter
				# end of add2.asm. 
	

