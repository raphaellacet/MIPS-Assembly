######################################################################################################################################
# Author:	Raphael Fidelis Lacet		Date: 04/22/2021
# Description:	program to calculate the following expressions: 
#               f = (0.1 * A^4) - (0.2 * B^3) + (0.3 * C^2) - (0.4 * D) and 
#               g = (0.1 * A(B^2)) + (0.2 * (C^2 * D^3)) 
#		and compute f and g
# Input:	User input 4 integers for A, B, C, D respectively
# Output:	Floating values for f and g
# registers used:
# $a0:		load prompt
# $a2:		hold D^3
# $f1:		hold A^4
# $f2:		hold B^3
# $f3:		hold C^2
# $f4:		load zero1 = 0.1
# $f5:		load zero2 = 0.2
# $f6:		load zero3 = 0.3
# $f7:		load zero4 = 0.4
# $f8:		hold D
# $f9:		hold f
# $f10:		hold A * (B^2)
# $f11:		hold g and (C^2 * D^3)
# $f12:		hold float value, display results f and g
# $f13:		load formatter
# $s0:		hold A
# $s1:		hold B
# $s2:		hold C
# $s3:		hold D
# $s6:		hold B^3
# $t0:		temporarily hold A, B, C, D values
# $t1:		initialize loop counters
# $t2:		hold B^2
# $t3:		hold A^4
# $t7:		hold C^2 and (C^2 * D^3)
# $v0:		load MIPS commands
#################################################### Data segment ####################################################################
.data
prompt:	.asciiz		"Enter 4 integers for A, B, C, D respectively: \n"
f:	.asciiz		"f = "
g:	.asciiz		"\ng = "
zero1:	.float		0.1
zero2:	.float		0.2
zero3:	.float		0.3
zero4:	.float		0.4
format:	.float		100.0
#################################################### Data segment ####################################################################
.text
.globl main
main:					# main program entry

	# Get operands A, B, C, D from user
	
	li	$v0, 4			# print string code 4
	la	$a0, prompt
	syscall
	
	li	$v0, 5			# read int - syscall code 5
	syscall
	move	$s0, $v0		# hold int A in $s0
	
	li	$v0, 5			
	syscall
	move	$s1, $v0		# hold int B in $s1
	
	li	$v0, 5			
	syscall
	move	$s2, $v0		# hold int C in $s2
	
	li	$v0, 5			
	syscall
	move	$s3, $v0		# hold int D in $s3
	
##### Compute A^4 ###################################################################################################################

	move	$t0, $s0		# copy A into $t0
	addiu	$t1, $t0, 0		# init loop counter to compute A^2, $t1 = A
	li	$t2, 0			# init A^2 result, $t2 = 0
	
loopA2:

	beqz	$t1, EndloopA2		# if branch = 0, end loop A^2	
	addu	$t2, $t2, $t0		# $t2 = A^2
	addi	$t1, $t1, -1		
	j 	loopA2

EndloopA2:				# End of loop A^2

	addiu	$t1, $t2, 0		# update loop counter to A^2
	li	$t3, 0			# init result to A^4, $t3 = 0
	
loopA4:

	beqz	$t1, EndloopA4		# if branch = 0, end loop A^4	
	addu	$t3, $t3, $t2		# $t3 = A^4
	addi	$t1, $t1, -1		
	j 	loopA4

EndloopA4:				# End of loop A^4, $t3 = A^4

##### Compute B^3 ###################################################################################################################

	move	$t0, $s1		# copy B into $t0
	addiu	$t1, $t0, 0		# init loop counter to compute B^2, $t1 = B
	li	$t2, 0			# init B^2 result, $t2 = 0
	
loopB2:

	beqz	$t1, EndloopB2		# if branch = 0, end loop B^2	
	addu	$t2, $t2, $t0		# $t2 = B^2
	addi	$t1, $t1, -1			
	j 	loopB2

EndloopB2:				# End of loop B^2

	addiu	$t1, $t2, 0		# update loop counter to B^3
	li	$s6, 0			# init result to B^3, $s6 = B
	
loopB3:

	beqz	$t1, EndloopB3		# if branch = 0, end loop B^3	
	addu	$s6, $s6, $t0		# $s6 = B^3 = B^2 ($s6) + B ($t0)
	addi	$t1, $t1, -1		
	j 	loopB3

EndloopB3:				# End of loop B^3, $s6 = B^3
	
##### Compute C^2 ###################################################################################################################

	move	$t0, $s2		# copy C into $t0
	addiu	$t1, $t0, 0		# init loop counter to compute C^2, $t1 = C
	li	$t7, 0			# init C^2 result, $t2 = 0
	
loopC2:

	beqz	$t1, EndloopC2		# if branch = 0, end loop C^2	
	addu	$t7, $t7, $t0		# $t7 = C^2
	addi	$t1, $t1, -1			
	j 	loopC2

EndloopC2:				# End of loop C^2		
	
##### Compute D^3 #####################################################################################################################	
	
	move	$t0, $s3		# copy D into $t0
	addiu	$t1, $t0, 0		# init loop counter to compute D^2, $t1 = D
	li	$a3, 0			# init D^2 result, $t2 = 0
	
loopD2:

	beqz	$t1, EndloopD2		# if branch = 0, end loop D^2	
	addu	$a3, $a3, $t0		# $a3 = D^2
	addi	$t1, $t1, -1			
	j 	loopD2

EndloopD2:				# End of loop D^2

	addiu	$t1, $a3, 0		# update loop counter to D^3
	li	$a2, 0			# init result to D^3, $a2 = D
	
loopD3:

	beqz	$t1, EndloopD3		# if branch = 0, end loop B^3	
	addu	$a2, $a2, $t0		# $a2 = D^3 = D^2 ($a2) + D ($t0)
	addi	$t1, $t1, -1		
	j 	loopD3

EndloopD3:				# End of loop D^3, $a2 = D^3

##### Compute f ######################################################################################################################

#	f = (0.1 * A^4) - (0.2 * B^3) + (0.3 * C^2) - (0.4 * D)

	lwc1	$f4, zero1		# load 0.1 into $f4
	lwc1	$f5, zero2		# load 0.2 into $f5
	lwc1	$f6, zero3		# load 0.3 into $f6
	lwc1	$f7, zero4		# load 0.4 into $f7

	mtc1	$t3, $f1		# move $t3(A^4) to $f1
	mtc1	$s6, $f2		# move $s6(B^3) to $f2
	mtc1	$t7, $f3		# move $t7(C^2) to $f3
	mtc1	$s3, $f8		# move $s3(D) to $f8
	
	cvt.s.w	$f1, $f1		# convert to floating point
	cvt.s.w	$f2, $f2
	cvt.s.w	$f3, $f3
	cvt.s.w	$f8, $f8

	mul.s	$f1, $f1, $f4		# $f1 = $f1(A^4) * $f4(0.1)
	mul.s	$f2, $f2, $f5		# $f2 = $f2(B^3) * $f5(0.2)
	mul.s	$f3, $f3, $f6		# $f3 = $f3(C^2) * $f6(0.3)
	mul.s	$f8, $f8, $f7		# $f8 = $f8(D) * $f7(0.4)
	
	sub.s	$f9, $f1, $f2		# $f9 = $f1(0.1 * A^4) - $f2(0.2 * B^3)
	add.s	$f9, $f9, $f3		# $f9 = $f9[(0.1 * A^4) - (0.2 * B^3)] + $f3(0.3 * C^2)
	sub.s	$f9, $f9, $f8		# $f9 = $f9[(0.1 * A^4) - (0.2 * B^3) + (0.3 * C^2)] - $f8(0.4 * D)

##### print result f ################################################################################################################

	li	$v0, 4			# print string code 4
	la	$a0, f
	syscall
	
	mov.s	$f12, $f9		# f = (0.1 * A^4) - (0.2 * B^3) + (0.3 * C^2) - (0.4 * D)
	li	$v0, 2			# print float code 2
	syscall

##### Compute (C^2)(D^3) #############################################################################################################	
	
	addiu	$t1, $t7, 0		# init loop counter to compute(C^2)(D^3), $t7=C^2
	li	$t7, 0			# init (C^2)(D^3) result, $t7 = 0
	
loopC2D3:

	beqz	$t1, EndloopC2D3	# if branch = 0, end loop (C^2)(D^3)	
	addu	$t7, $t7, $a2		# $t7 = $t7(C^2) * $a2(D^3)
	addi	$t1, $t1, -1			
	j 	loopC2D3

EndloopC2D3:				# End of loop (C^2)(D^3)

##### Compute A(B^2) #############################################################################################################	
	
	addiu	$t1, $s0, 0		# init loop counter to compute A(B^2), $s0 = A
	li	$s0, 0			# init A(B^2) result, $s0 = 0
	
loopAB2:

	beqz	$t1, EndloopAB2		# if branch = 0, end loop A(B^2)	
	addu	$s0, $s0, $t2		# $s0 = $s0(A) * $t2(B^2)
	addi	$t1, $t1, -1			
	j 	loopAB2

EndloopAB2:				# End of loop A(B^2)

##### Compute g ######################################################################################################################

#	g = (0.1 * A(B^2)) + (0.2 * (C^2 * D^3)) 

	mtc1	$s0, $f10		# move $s0(A(B^2)) to $f10
	mtc1	$t7, $f11
	
	cvt.s.w	$f10, $f10		# convert to floating point
	cvt.s.w	$f11, $f11
	
	mul.s	$f10, $f10, $f4		# $f10 = $f10(A(B^2)) * $f4(0.1)
	mul.s	$f11, $f11, $f5		# $f11 = $f11(C^2 * D^3) * $f5(0.2)
	
	add.s	$f11, $f11, $f10	# f11 = $f11[0.2 * (C^2 * D^3)] + $f10(0.1 * A(B^2))
	
	l.s	$f13, format		# format result, load 100 into $f13
	
	mul.s	$f11, $f11, $f13	# multiply float by 100
	round.w.s $f11, $f11		# round to the nearest integer
	cvt.s.w	$f11, $f11		# convert to single
	div.s	$f11, $f11, $f13	# corrects decimal point (div by 100)
		
##### print result g ################################################################################################################

	li	$v0, 4			# print string code 4
	la	$a0, g
	syscall
	
	mov.s	$f12, $f11		# g = (0.1 * A(B^2)) + (0.2 * (C^2 * D^3)) 
	li	$v0, 2			# print float code 2
	syscall