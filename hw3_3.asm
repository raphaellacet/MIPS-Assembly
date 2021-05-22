######################################################################################################################################
# Author:	Raphael Fidelis Lacet		Date: 02/15/2021
# Description:	program to write a function Eval_Z to find Z = Z = X - 3 (Y / 8 + 125)
# Input:	User inputs (X1, Y1) = (100, 24) and (X1, Y1) = (100, 21)
# Output1:	For user input (X1, Y1) = (100, 24) => Z = 99.45864
# Output2:	For user input (X1, Y1) = (100, 21) => Z = 99.52631
#################################################### Data segment ####################################################################
.data
msg1:	.asciiz		"Enter a value for Y:\n"
msg2:	.asciiz		"Z = "
loop:	.asciiz 	"\nRun Again? (y or n)? " 
answer:	.asciiz 	" "
input: 	.double
const1:	.double 	 133
const2: .word 		-3
const3: .word 		-100	# constant value for X
#################################################### Data segment ####################################################################
.data
.text
.globl main
main:					# main program entry
					# Get Y from user
	li	$v0, 4			# print string code 4
	la	$a0, msg1
	syscall
					
	li 	$v0, 7			# read double user input
	syscall             		# store input in $f0 

##### Compute Z ###################################################################################################################
				
Eval_Z:	
					# divide by 133
	ldc1 	$f2, const1         	# load the value 133 into f2 and f3
	div.d 	$f12, $f0, $f2        
					# multiply by 3
	lw 	$t1, const2           	# load 3 into t1     
	mtc1.d 	$t1, $f4         	# move the value in t1 to f4
	cvt.d.w $f4, $f4        	#convert value to single precision for multiplication
        mul.d 	$f12, $f12, $f4   
					# subtract by 100    
	lw 	$t2, const3           	# load 100 into t2
	mtc1.d 	$t2, $f6         	# move the value in t2 to f6
	cvt.d.w $f6, $f6        	# convert value to single precision for subtraction
        sub.d 	$f12, $f12, $f6
					# print result Eval_Z
	li	$v0, 3			# print string code 4
	la	$a0, msg2
	syscall
	
	li  	$v0, 4  		# loop to run Eval_Z multiple times
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