######################################################################################################################################
# Author:	Raphael Fidelis Lacet		Date: 03/04/2021
# Description:	strlength.asm-- A program that determine the length of a null terminated string
# Registers used:
# $t0 - used to hold the loop counter
# $a0 - used to hold the address of string
# $v0 - syscall parameter and return value
#################################################### Data segment ####################################################################
.data
str:	.asciiz		"abcde"
#################################################### Data segment ####################################################################
.text
.globl main
main:					# main program entry
	la	$a0, str		# Load address of string into a0			
strlen:
	li	$t0, 0			# initialize the count to zero 
loop:
	lb	$t1, 0($a0)		# load the next character into t1 
	beqz	$t1, exit		# check for the null character 
	addiu	$t0, $t0, 1		# letter count++ increment
	addiu	$a0, $a0, 1		# str pointer++	increment
	j	loop
exit:
	li	$v0, 1			# print count
	move	$a0, $t0		# place $t0 into $a0
	syscall
	
	li	$v0, 10			# terminate program
	syscall
	
# end of program