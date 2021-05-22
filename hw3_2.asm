######################################################################################################################################
# Author:	Raphael Fidelis Lacet		Date: 02/15/2021
# Description:	program to write a function N_SUM to find the sum of the integers from 1 to N => n = [n*(n+1)/2] 
# Input:	User input integer example: N: 9, N: 32, N: 777
# Output:	For user input N: 9, n = 45, for N: 32, n = 528, and for N: 777, n = 302253
#################################################### Data segment ####################################################################
.data
msg1:	.asciiz		"Enter a value for N:\n"
msg2:	.asciiz		"n = "
loop:	.asciiz 	"\nRun Again? (y or n)? " 
answer:	.asciiz 	" "
#################################################### Data segment ####################################################################
.text
.globl main
main:					# main program entry
					# Get N from user
	li	$v0, 4			# print string code 4
	la	$a0, msg1
	syscall
	
	li	$v0, 5			# read integer - syscall code 5
	syscall
	move	$a0, $v0		# hold int N in $a0
	jal	N_SUM
	j	end
	
N_SUM:					# Compute (n*(n+1)/2) 	
	addu	$a1, $a0, 1		# $a1 = $a0 + 1 => (n+1)
	mulu	$a2, $a0, $a1		# $a2 = $a0 * $a1 => n*(n+1)
	divu	$v1, $a2, 2		# $v0 = $a2 / 2 => (n*(n+1)/2)
	
					# print result N_SUM 
	li	$v0, 4			# print string code 4
	la	$a0, msg2
	syscall
	
	move	$a0, $v1		# N_SUM = (n*(n+1)/2)
	li	$v0, 1			# print int code 1
	syscall

	li  	$v0, 4  		# loop to run myABS multiple times
    	la  	$a0, loop  
    	syscall  

    	la  	$s4, answer		# check user input to restart program or end it
    	jal 	get 

    	beq 	$v0, 'y', main		# if answer is yes, restart program
    	beq 	$v0, 'Y', main

    	li  	$v0, 10 		# else terminate program
    	syscall 
get:  
    	li  	$v0, 12  
    	li	$a1, 2  
    	syscall  
    	jr  $ra
end:
