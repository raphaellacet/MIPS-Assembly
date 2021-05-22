######################################################################################################################################
# Author:	Raphael Fidelis Lacet		Date: 02/15/2021
# Description:	program to write a function myABS that accepts an integer and returns its absolute value 
# Input:	User input integer example: N: -129, N: 56
# Output:	For user input N: -129, |n| = 129, and for N: 56, |n| = 56
#################################################### Data segment ####################################################################
.data
msg1:	.asciiz		"\nEnter a value for N:\n"
msg2:	.asciiz		"|n| = "
loop:	.asciiz 	"\nRun Again? (y or n)? " 
answer:	.asciiz 	" "
#################################################### Data segment ####################################################################
.text
.globl main
main:					# main program entry
myABS:					# Get N from user
	li	$v0, 4			# print string code 4
	la	$a0, msg1
	syscall
	
	li	$v0, 5			# read integer - syscall code 5
	syscall
	move	$a0, $v0		# hold int N in $a0
		
	abs	$v1, $a0 		# Compute |n|
		
					# print result myABS 
	li	$v0, 4			# print string code 4
	la	$a0, msg2
	syscall
	
	move	$a0, $v1		# myABS = |n|
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
