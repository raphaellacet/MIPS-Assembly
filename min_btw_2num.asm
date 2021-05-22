#####################################################################################################################################
# Author:	Raphael Fidelis Lacet		Date: 04/08/2021
# Description:	program that takes two numbers A and B, compare them, and print out the smaller one
# Input:	two user input integers
# Output:	compare A and B and display smallest either (A) < (B) or (B) < (A) depending on user input
# registers used:
# $a0:		hold integer value A
# $a1:		hold integer value B
# $s0:		hold argument value A
# $s1:		hold argument value B
# $v0:		load MIPS commands
#################################################### Data segment ###################################################################
.data
p1: 	.asciiz 	"Please enter the 1st integer (A) = "
p2: 	.asciiz 	"Please enter the 2nd integer (B) = "
outA:	.asciiz 	"(A) < (B)"
outB:	.asciiz 	"(B) < (A)"
#################################################### Data segment ###################################################################     
.text
.globl main
main:
################################################### Get User Input ##################################################################     
	
	li 	$v0, 4 			# Load 4=print_string into $v0
	la 	$a0, p1 		# Load address of first prompt into $a0
	syscall 			# Output the prompt via syscall

	li 	$v0, 5 			# Load 5=read_int into $v0
	syscall 			# Read an integer via syscall
	
	add 	$s0, $v0, $zero 	# Copy from $v0 to $s0
	li 	$v0, 4 			# Load 4=print_string into $v0
	la 	$a0, p2 		# Load address of second prompt into $a0
	syscall 			# Output the prompt via syscall
	
	li $v0, 5 			# Load 5=read_int into $v0 
	syscall 			# Read an integer via syscall
	
	add $s1, $v0, $zero 		# Copy from $v0 to $s1

################################################### Compute Minimum #################################################################     

	add 	$a0, $s0, $0 		# Put argument ($s0) in $a0
	add 	$a1, $s1, $0 		# Put argument ($s1) in $a1
	jal 	minimum 		# Call minimum function, result in $v0

################################################### Output Results ##################################################################     

	add 	$a0, $v0, $zero 	# Load sum of inupt numbers into $a0
	li 	$v0, 1 			# Load 1=print_int into $v0
	syscall 			# Output the prompt via syscall
	
######################################################## Exit #######################################################################     

endProgram:
	li 	$v0, 10 		# exit
	syscall
	
##################################### minimum function to compute min($a0, $a1) #####################################################

minimum:
	blt 	$a0, $a1, smallerIsA	# if $a0(A) < $a1(B) => A < B
	blt 	$a1, $a0, smallerIsB	# if $a1(B) < $a0(A) => B < A
	jal 	endProgram

##################################################### if A < B ######################################################################

smallerIsA:	
	 
	li 	$v0, 4 			# Load 4=print_string into $v0
	la 	$a0, outA 		# Load address of output (A) < (B) prompt into $a0
	syscall
	jal 	endProgram


##################################################### if B < A ######################################################################	
			
smallerIsB:

	li 	$v0, 4 			# Load 4=print_string into $v0
	la 	$a0, outB		# Load address of output (B) < (A) prompt into $a0
	syscall	
	jal 	endProgram
	
return:
	jr 	$ra 			# Return to caller
	

	
