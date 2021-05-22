######################################################################################################################################
# Author:	Raphael Fidelis Lacet		
# Date: 02/25/2021
# Description:	convert user input hours to days and hours
# Input:	H = 71
# Output1:	D = 2
#		H = 23
#################################################### Data segment ####################################################################
.data
msg1:	.asciiz		"Enter the Number of Hours:\n"
msg2:	.asciiz		"hours = "
msg3:	.asciiz		" days and "
msg4:	.asciiz		" hours"
#################################################### Data segment ####################################################################
.data
.text
.globl main
main:					# Get H from user
	li	$v0, 4			# display msg1
	la	$a0, msg1
	syscall
					
	li 	$v0, 5			# read integer
	syscall             		
	jal	convert

##### Compute Days ###################################################################################################################
	
	move	$s0, $v0
convert:
	beqz	$s0, end		# if input = 0, terminate program		
	subi 	$v1, $s0, 24         	# subtract 24
	addi	$s0, $s0, -1
	blt	$s1, 24, plus
	j 	convert
plus:																					
	addu	$s1, $s1, $v1																																																						
	li	$v0, 4			# display result
	la	$a0, msg2
	syscall
	
	li	$v0, 1					
	syscall
	
	li	$v0, 4			# display result
	la	$a0, msg3
	syscall
	
	move	$a0, $s1
	li	$v0, 1					
	syscall   	 
	
	li	$v0, 4			# display result
	la	$a0, msg4
	syscall

  	li  	$v0, 10 		# end program
   	syscall 
end:
	jr	$ra