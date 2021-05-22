######################################################################################################################################
# Author:	Raphael Fidelis Lacet		Date: 04/22/2021
# Description:	program to perform a 3x3 matrix multiplication
# Input:	hard coded matrix A = [ 1, 3, 2 ]
#				      [ 1, 3, 2 ]
#				      [ 1, 3, 2 ]
#
#		hard coded matrix B = [ 0, 1, 2 ]
#				      [ 0, 1, 2 ]
#				      [ 0, 1, 2 ]
# Output:	
# 		Matrix Multiplication A x B (3 x 3)
#			      A x B = [ 0, 6, 12 ]
#				      [ 0, 6, 12 ]
#				      [ 0, 6, 12 ]
# registers used:
# $v0:		mips commands
# $a0:		load prompts
# $s0:		row[i], forLoop_i, matric C (mC)
# $s1:		forLoop_j, columns++, counter++
# $s2:		k
# $s3:		3(i) + k, 3(k) + j
# $s4:		A[i][k]
# $s5:		B[k][j]
# $s6:		temp, $s4(A[i][k] * B[k][j]) + temp, C[i][j]
#################################################### Data segment ####################################################################
.data
result: 	.asciiz 		"C = A x B\n"
format: 	.asciiz 		", "
mA: 		.word 	1 3 2 1 3 2 1 3 2
mB:		.word 	0 1 2 0 1 2 0 1 2
mC: 		.word 	0:9 		# matrix size (3)rows x (3)columns = 9 (0 to 8)
openBracket:	.asciiz			"[ "
closeBracket:	.asciiz			"]"
# for (int i=0;i<N;i++) {				// forLoop_i
#	for (int j=0;j<N;j++) {				// forLoop_j
#		temp = 0;
#		for (int k=0;k<N;k++) {			// forLoop_k
#			temp = temp + A[i][k]*B[k][j];
#		}
#		C[i][j] = temp;
#	}
# } 
#################################################### Data segment ####################################################################
.text
.globl main
main:
####### for (int i=0;i<N;i++) { #####################################################################################################
	li	$s0, 0 			# row[i]

forLoop_i:				# N = 3
	bge 	$s0, 3, endForLoop_i 	# if (i >= N; j = 0)
	li 	$s1, 0 			# col[j]
####### for (int j=0;j<N;j++) {	#####################################################################################################
forLoop_j:
	bge 	$s1, 3, endForLoop_j 	# if (j >= N; k = 0 && temp = 0)
	li 	$s2, 0 			# $s2 = k
	li 	$s6, 0 			# $s6 = temp
####### for (int k=0;k<N;k++) { #####################################################################################################
forLoop_k:
	bge 	$s2, 3, endForLoop_k

	mul 	$s3, $s0, 3		
	add 	$s3, $s3, $s2		# 3(i) + k
	mul 	$s3, $s3, 4 		# allocate 4 bytes of memory for each integer
	lw 	$s4, mA($s3)		# $s4 = A[i][k]

	mul 	$s3, $s2, 3
	add 	$s3, $s3, $s1		# 3(k) + j
	mul 	$s3, $s3, 4 		# allocate 4 bytes of memory for each integer
	lw 	$s5, mB($s3)		# $s5 = B[k][j]

####### temp = temp + A[i][k]*B[k][j]; ##############################################################################################
	mul 	$s4, $s4, $s5
	add 	$s6, $s6, $s4		# $s6 = $s4(A[i][k] * B[k][j]) + temp
	addi 	$s2, $s2, 1		# k++
	b forLoop_k

####### C[i][j] = temp; #############################################################################################################
endForLoop_k:
	mul 	$s3, $s0, 3
	add 	$s3, $s3, $s1
	mul 	$s3, $s3, 4 		# allocate 4 bytes of memory for each integer
	sw 	$s6, mC($s3) 		# $s6 = temp = C[i][j]

	addi 	$s1, $s1, 1		# columns++
	b forLoop_j

endForLoop_j:
	addi 	$s0, $s0, 1		# rows++
	b forLoop_i

endForLoop_i:
	la 	$s0, mC			# matrix C
	li 	$s1, 1 			# matrix counter

####### matrix C result #############################################################################################################
	
	li	$v0, 4			# print string code 4
	la	$a0, result
	syscall

	li	$v0, 4			# print string code 4
	la	$a0, openBracket
	syscall

cLoop:
	bgt 	$s1, 9, terminate	# matrix size (3)rows x (3)columns = 9 (0 to 8)
	li 	$v0, 1			# print int code 1
	lw 	$a0, 0($s0)		# get matrix C values (c11 to c33)
	syscall
	
	li 	$v0, 4			# print string code 4
	la 	$a0, format		# print ", "
	syscall

	addi 	$s1, $s1, 1		# counter++
	add 	$s0, $s0, 4		# allocate memory for displaying result values
	b cLoop

####### end program #################################################################################################################	
terminate:	
	li	$v0, 4			# print string code 4
	la	$a0, closeBracket
	syscall
	
	li 	$v0, 10			# end program
	syscall
