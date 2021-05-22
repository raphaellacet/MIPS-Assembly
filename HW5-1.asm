######################################################################################################################################
# Author:	Raphael Fidelis Lacet		Date: 03/28/2021
# Description:	program to compute the Area of a Cylinder using the RADIUS and HEIGHT stored in memory
# Input:	R = 0.5m and H = 3.275m
# Output:	Side area of the cylinder
# registers used:
# $f0:		hold pi value
# $f2:		hold radius value
# $f4:		hold height value
# f12:		hold cylinder area result
#################################################### Data segment ####################################################################
.data
result: 	.asciiz		"Side area of the cylinder = "
RADIUS: 	.double 	0.50
HEIGHT: 	.double 	3.275
TwoPI: 		.double		6.2831853072
ROUND:		.double		0.00951226734
#################################################### Data segment ####################################################################
.text
main:					# main program entry
	ldc1 	$f0, TwoPI		# load PI in $f0
	ldc1 	$f2, RADIUS		# load RADIUS in $f2
	ldc1 	$f4, HEIGHT		# load HEIGHT in $f4
	ldc1	$f8, ROUND

################################################### Calculate Area ####################################################################

	mul.d	$f6, $f0, $f2		# $f6 = (2 * pi * r)
	add.d 	$f12, $f2, $f4		# $f12 = (r + h)
	mul.d	$f12, $f12, $f6 	# $f12 = (2 * pi * r) * (r + h) = (2 * pi * r^2) + (2 * pi * r * h)	
	sub.d	$f12, $f12, $f8		# round result

#################################################### Print Result ####################################################################

    	li      $v0, 4			# print string code 4
   	la      $a0, result		# load and print result
   	syscall

	li 	$v0, 3			# print double code 3
	syscall
	