#####################################################################################################################################
# Author:	Raphael Fidelis Lacet		Date: 04/08/2021
# Description:	program that reads two lists of floating point numbers A and B, 
# 		and displays the measures given above on the simulator’s console
# Input:	sample vectors of size 10 A and B
# Output:	The Mean of A = 1.03
#		The Mean of B = 7.78
# registers used:
# $a0:		load address of: vector A/B && first/second string 
# $v0:		load MIPS commands
# $t0:		load index
# $s0:		calculate index
# $f2:		load input vector size 
# $f4:		load formatter
# $f5:		load float vector
# $f12:		hold float value
#################################################### Data segment ###################################################################
.data
A:	.float		0.11 0.34 1.23 5.34 0.76 0.65 0.34 0.12 0.87 0.56
B:	.float 		7.89 6.87 9.89 7.12 6.23 8.76 8.21 7.32 7.32 8.22
N:	.float		10
F:	.float		100.0
meanA: 	.asciiz 	"\nThe Mean of A = "
meanB: 	.asciiz 	"\nThe Mean of B = "
#################################################### Data segment ###################################################################     
.text
.globl main
main:
	la 	$a0, N 		# Load address of input vector size into $a0
	l.s 	$f2, 0($a0) 	# Load the input vector size into $f2
	la 	$a0, A 		# Load the address of vector A into $a0
	jal 	mean 		# Call mean function, result in $f1
	
	li 	$v0, 4 		# Load 4=print_string into $v0
	la 	$a0, meanA 	# Load address of first string into $a0
	syscall 		# Output the string via syscall

	li 	$v0, 2 		# Load 2 into $v0=print single precision float
	mov.s 	$f12, $f1 	# Copy from $f1 to $f12
	syscall 		# output meanA

	mov.s 	$f1, $f3 	# reset $f1
	la 	$a0, B 		# Load the address of vector B into $a0
	jal 	mean 		# Call mean function, result in $f1 

	li 	$v0, 4 		# Load 4=print_string into $v0
	la 	$a0, meanB 	# Load address of second string into $a0
	syscall 		# Output the string via syscall
	
	li 	$v0, 2 		# Load 2 into $v0=print single precision float
	mov.s 	$f12, $f1 	# Copy from $f1 to $f12
	syscall 		# output meanB
	
######################################################## Exit #######################################################################     
	
	li 	$v0, 10
	syscall
	
################################################### Mean Function ###################################################################     

mean: 
	li 	$t0, 0		# initialize index at 0
	l.s	$f4, F		# format result, load 100 into $f4

calcMean:
	mul 	$s0, $t0, 4 	# index value
	add 	$s0, $s0, $a0
	l.s 	$f5, ($s0) 	# load float vector
	
	add.s 	$f1, $f1, $f5 	# sum
	add 	$t0, $t0, 1 	# increment index
	
	blt 	$t0, 10, calcMean
	div.s 	$f1, $f1, $f2 	# get the mean from all values in vector
	
	mul.s	$f1, $f1, $f4	# multiply float by 100
	round.w.s $f1, $f1	# round to the nearest integer
	cvt.s.w	$f1, $f1	# convert to single
	div.s	$f1, $f1, $f4	# corrects decimal point (div by 100)

return:
	jr 	$ra
