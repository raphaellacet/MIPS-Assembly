##########################################################################################################################
# Author:	Raphael Fidelis Lacet
# Date:		02/04/2021
# Description:	Increments from 0 to 15 and display the results in Decimal on the Console specified by the user at runtime
# Input:	Integer ranging from 0 to 15
# Output:	Array of integers from 0 to 15 followed by its hexadecimal converted values next to it
# $t0 - used to hold firstValue = 0
# $t1 - used to hold lastValue = 15
# $a0 - syscall parameter. 
#################################################### Data segment ########################################################
.data
firstValue: 	.word 		0 			# array start at 0
result: 	.asciiz		"\nThe increment array is: \n"
format:		.asciiz 	"\t"	# formatting program to look nicer
skip:		.asciiz 	"\n"			# skip to the next line
lastValue: 	.word 		15 			# array ends in 15
#################################################### Data segment ########################################################
.text
.globl main
main:	
.text
	lw 	$t0, firstValue		# load .word 0 into $t0
	lw 	$t1, lastValue		# load .word 15 into $t1
  
loop:
	bgt 	$t0, $t1, else		# if 15 > 0 , else
	move 	$a0, $t0		# print decimal value in $t0
	li 	$v0, 1			# code 1 display decimal value
	syscall				# syscall parameter
  
	la 	$a0, format		# fomarting program to look nicer
	li 	$v0, 4			# print string code 4 format
	syscall				# syscall parameter
  
	move 	$a0, $t0		# print hexadecimal value in $t0
	li 	$v0, 34 		# convert to hexadecimal code 34
	syscall
  
	la 	$a0, skip		# fomarting program to look nicer
	li 	$v0, 4			# print string code 4
	syscall				# syscall parameter

	addi 	$t0, $t0, 1		# i = i + 1
	b 	loop			# branch loop
	
else:					# end loop
	li $v0, 10   			# syscall code 10 for exit. 
	syscall      			# syscall parameter
					# end of lab2.asm.
