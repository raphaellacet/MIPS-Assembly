######################################################################################################################################
# Author:	Raphael Fidelis Lacet		Date: 02/11/2021
# Description:	program to calculate the following expressions: 
#               f = ((A^4) - 4(B^3) + 3(C^2) - 2D) and 
#               g = (A(B^2) + ((C^2)(D^3)))
#		and compute f and g, h = f / g, the quotient
#               and remainder of h, and i = (f+g) MOD h_quotient
# Input:	User input 4 integers for A, B, C, D respectively
# Output:	Decimal values for f_ten and g_ten, and quotient, 
#               remainder, and i_mod for h
#################################################### Data segment ####################################################################
.data
msg1:	.asciiz		"Enter 4 integers for A, B, C, D respectively: \n\n"
msg2:	.asciiz		"f_ten = "
msg3:	.asciiz		"\ng_ten = "
msg4:	.asciiz		"\nh_quot = "
msg5:	.asciiz		"\nh_remainder = "
msg6:	.asciiz		"\ni_mod = "
#################################################### Data segment ####################################################################
.text
.globl main
main:					# main program entry

	# Get operands A, B, C, D from user
	
	li	$v0, 4			# print string code 4
	la	$a0, msg1
	syscall
	
	li	$v0, 5			# read integer - syscall code 5
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

##### Compute 4B^3 ###################################################################################################################

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

	addu 	$t4, $s6, $s6		# $t4 = $s6(B^3) + $s6(B^3) = 2*B^3
	addu 	$t4, $t4, $s6		# $t4 = $t4(2*B^3) + $s6(B^3) = 3*B^3
	addu	$t5, $t4, $s6		# $t5 = $t4(3*B^3) + $t4(B^3) = 4*B^3
	
##### Compute 3C^2 ###################################################################################################################

	move	$t0, $s2		# copy C into $t0
	addiu	$t1, $t0, 0		# init loop counter to compute C^2, $t1 = C
	li	$t7, 0			# init C^2 result, $t2 = 0
	
loopC2:

	beqz	$t1, EndloopC2		# if branch = 0, end loop C^2	
	addu	$t7, $t7, $t0		# $t2 = C^2
	addi	$t1, $t1, -1			
	j 	loopC2

EndloopC2:				# End of loop C^2	

	addu 	$t6, $t7, $t7		# $t6 = $t2(C^2) + $t2(C^2) = 2*C^2
	addu 	$t6, $t6, $t7		# $t6 = $t6(2*C^2) + $t2(C^2) = 3*C^2		

##### Compute 2D #####################################################################################################################

	move	$t0, $s3		# copy D into $t0
	addu	$t9, $t0, $t0		# $t9 = $t0(D) + $t0(D) = 2*D
	
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

#	f = (A^4) - 4(B^3) + 3(C^2) - 2D

	subu	$t8, $t3, $t5		# $t8 = $t3(A^4) - $t5(4*B^3)
	addu	$s4, $t8, $t6		# $s4 = $t8[(A^4) - (4*B^3)] + $t6(3*C^2)
	subu	$s5, $s4, $t9		# $t5 = $s4{[(A^4) - (4*B^3)] + (3*C^2)} - $t9(2*D)

##### print result f decimal #########################################################################################################

	li	$v0, 4			# print string code 4
	la	$a0, msg2
	syscall
	
	move	$a0, $s5		# f = (A^4) - 4(B^3) + 3(C^2) - 2D ( decimal )
	li	$v0, 1			# print int code 1
	syscall

##### Compute (C^2)(D^3) #############################################################################################################	
	
	addiu	$t1, $t7, 0		# init loop counter to compute (C^2)(D^3), $t7 = C^2
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

#	g = A(B^2) + (C^2)(D^3)

	addu	$t8, $s0, $t7		# $t8 = $s0(A(B^2)) + $t7(C^2)(D^3)
		
##### print result g decimal #########################################################################################################

	li	$v0, 4			# print string code 4
	la	$a0, msg3
	syscall
	
	move	$a0, $t8		# g = A(B^2) + (C^2)(D^3) ( decimal )
	li	$v0, 1			# print int code 1
	syscall

##### Compute h ######################################################################################################################

#	h = f / g
	
	move	$s0, $s5		# place f into $s0
	move	$s1, $t8		# place g into $s1
	
	li	$t0, 0			# quotient
	li	$t1, 0			# remainder
	
loopHFG:

	ble 	$s0, 0, EndloopHFG	# if branch f <= g, end loop h=f/g	
	subu	$s0, $s0, $s1		# $s0(f) = $s0(f) - $s1(g)
	addi	$t0, $t0, 1		# quotient
	move	$t1, $s0		# remainder
	j 	loopHFG

EndloopHFG:				# End of loop h=f/g

	beq	$s0, 0, printHFG	# if f <= 0, update Q and R
	addi	$t0, $t0, -1
	addu	$t1, $s0, $s1		# R = f + g

printHFG:
	
##### print result h quotient ########################################################################################################

	li	$v0, 4			# print string code 4
	la	$a0, msg4
	syscall
	
	move	$a0, $t0		# h = f / g ( quotient )
	li	$v0, 1			# print int code 1
	syscall
	
##### print result h remainder ########################################################################################################

	li	$v0, 4			# print string code 4
	la	$a0, msg5
	syscall
	
	move	$a0, $t1		# h = (f / g) % h ( remainder )
	li	$v0, 1			# print int code 1
	syscall
	
##### Compute i_mod ###################################################################################################################	
	
	li	$t1, 0
i_mod:	
	ble	$s2, 0, endi_mod	# if branch i = 0, end loop i_mod
	subu	$s2, $s2, $t0		# $s2 = $s2 - Q
	move	$t1, $s2		# place $s2 in $t1
	j	i_mod

endi_mod:

	beq	$s2, 0, printI		# if branch equals 0 print i_mod
	addu	$t1, $t1, $s2		# R = R + $s2

printI:
	
##### print result i_mod ##############################################################################################################

	li	$v0, 4			# print string code 4
	la	$a0, msg6
	syscall
	
	move	$a0, $t1		# i = (f+g) MOD h_quotient
	li	$v0, 1			# print int code 1
	syscall
	
	li	$v0, 10			# end program
	syscall
