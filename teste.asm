######################################################################################################################################
# Author:	Raphael Fidelis Lacet		Date: 03/18/2021
# Description:	program to count how many times the words "KNIGHTS" and "UCF" appear in a sentence, 
#		non case sensitive, and then output the count result. 
# Input:	User input String
# Output:	KNIGHT: # number
#		UCF: # number
# registers used:
# $t0 - used to hold the loop counter
# $a0 - used to hold the address of string
# $v0 - syscall parameter and return value
#################################################### Data segment ####################################################################
.data
w1:      	.asciiz    	"KNIGHTS"
w2:      	.asciiz    	"UCF"
buffer:		.space		1024
sample:		.asciiz		"UCF, its athletic program, and the university's alumni and sports fans are sometimes jointly referred to as the UCF Nation, and are represented by the mascot Knightro. The Knight was chosen as the university mascot in 1970 by student election. The Knights of Pegasus was a submission put forth by students, staff, and faculty, who wished to replace UCF's original mascot, the Citronaut, which was a mix between an orange and an astronaut. The Knights were also chosen over Vincent the Vulture, which was a popular unofficial mascot among students at the time. In 1994, Knightro debuted as the Knights official athletic mascot."
word1:		.asciiz		"Please input first word: "
word2:		.asciiz		"Please input second word: "
w1_out:		.asciiz		"\nKNIGHT: "
w2_out:		.asciiz		"\nUCF: "
#################################################### Data segment ####################################################################
.text
.globl main
main:					# main program entry
	la	$a0, sample		# Load address of string into $a0	
# Get word 1 from user
        la 	$a0, word1		# load and print word1
        li 	$v0, 4			# print string code 4
        syscall
        
        li	$v0, 8			# read user input - syscall code 8
        la	$a0, buffer		# load byte space into address
        li 	$a1, 32			# allocate 1024 bytes of memory space for user input string
        syscall	
        
# Get word 2 from user
        la 	$a0, word2		# load and print word2
        li 	$v0, 4			# print string code 4
        syscall
        
        li	$v0, 8			# read user input - syscall code 8
        la	$a0, buffer		# load byte space into address
        li 	$a1, 32			# allocate 1024 bytes of memory space for user input string
        syscall	        		

# get string to scan word1        
	move	$s2, $v0		# hold int word1 in $s2
    	li      $s2, 0                  # initialize word1 count
    	la      $s0, buffer             # pointer to string
    	
# get string to scan word2   
	move	$s3, $v0		# hold int word2 in $s3
    	li      $s3, 0                  # initialize word2 count
    	la      $t3, buffer             # pointer to string

strlen:
	li	$t0, 0			# initialize the count to zero 
loop:
	lb	$t1, 0($a0)		# load the next character into $t1 
	beqz	$t1, exit		# check for the null character 
	addiu	$t0, $t0, 1		# letter count++ increment
	addiu	$a0, $a0, 1		# str pointer++	increment
	j	loop
exit:
	li	$v0, 1			# print count
	move	$a0, $t0		# place $t0 into $a0
	syscall
	
	li	$v0, 10			# terminate program
	syscall
	
# end of program