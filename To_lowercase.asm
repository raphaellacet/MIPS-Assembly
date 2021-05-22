######################################################################################################################################
# Author:	Raphael Fidelis Lacet		Date: 03/04/2021
# Description:	To_lowercase.asm-- A program that convert uppercase to lowercase
# Registers used:
# $t0 - used to hold the address of string
# $t2 - used to do the conversions
# $v0 - syscall parameter and return value
#################################################### Data segment ####################################################################
.data
string: .asciiz "HeLlo WoRld" # We want to lower this string
newline: .asciiz "\n"
#################################################### Data segment ####################################################################
.text
.globl main
main:					# main program entry
	la 	$t0, string 		# Load here the string
toLowerCase: 
	lb 	$t2, 0($t0) 		# We do as always, get the first byte pointed by the address
	beqz 	$t2, end 		# if is equal to zero, the string is terminated
#if (character >= 'A'
	bgt	$t2, 90, continue	# if character is greater than 'A'(0x41) => already lowercase letter or invalid
upperCaseTest2:
# && character <= 'Z')
	blt	$t2, 65, continue	# if character is less than 'Z'(0x5A) => already a lowercase letter or invalid
	addiu	$t2, $t2, 32		# convert to lowercase: add 32 from upperCase  
continue:
# Continue the iteration
	sb 	$t2, 0($t0) 		# store it in the string
	addu 	$t0, $t0, 1 		# Increment the address
	j toLowerCase
isUpperCase:
# add 32, so it goes lower case
	addiu	$t2, $t2, 32		# convert to lowercase: add 32 from upperCase  
	sb 	$t2, 0($t0) 		# store it in the string
	j continue 			# continue iteration as always
end:
	li 	$v0, 4 			# Print the string
	la 	$a0, string
	syscall
	
	li 	$v0, 4 			# A nice newline
	la 	$a0, newline
	syscall
# We have done, exit the program
	li 	$v0, 10
	syscall 