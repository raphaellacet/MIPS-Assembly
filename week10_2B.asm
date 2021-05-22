#####################################################################################################################################
# Author:	Raphael Fidelis Lacet		Date: 03/18/2021
# Description:	program to count how many times the words "KNIGHTS" and "UCF" appear in a sentence, 
#		non case sensitive, and then output the count result. 
# Input:	User input String
# Output:	KNIGHT: # number
#		UCF: # number
# registers used:
# $t0:		sample sentence
# $t1:		temporary place user input words
# $a1: 		allocate heap memory for user input words
# $s2:		load sample sentence memory address 	&&    hold the lowerCase sentence
# $s3:		load user input words memory address	&&    hold the lowerCase words
# $s4:		counter
# $s5:		load words
#################################################### Data segment ###################################################################
.data
sample: 	.asciiz 	"UCF, its athletic program, and the university's alumni and sports fans are sometimes jointly referred to as the UCF Nation, and are represented by the mascot Knightro. The Knight was chosen as the university mascot in 1970 by student election. The Knights of Pegasus was a submission put forth by students, staff, and faculty, who wished to replace UCF's original mascot, the Citronaut, which was a mix between an orange and an astronaut. The Knights were also chosen over Vincent the Vulture, which was a popular unofficial mascot among students at the time. In 1994, Knightro debuted as the Knights official athletic mascot."
word1: 		.asciiz 	"Please input first word: "
word2: 		.asciiz 	"Please input second word: "
newline: 	.asciiz 	"\n"
format: 	.asciiz 	": "
firstWord: 	.space 		32         
secondWord: 	.space 		32
#################################################### Data segment ###################################################################     
.text
.globl	main
main:					# main program entry
   	li 	$v0, 4			# print string code 4
   	la 	$a0, newline		# skip a line
   	syscall

################################################ Word String Counter ################################################################        	

   	la 	$a0, word1           	# get first word from user input
   	li 	$v0, 4			# print string code 4
   	syscall

   	li 	$v0, 8           	# read string code 8
   	la 	$a0, firstWord         	# temp hold first user input word
   	li 	$a1, 9         		# allocate heap memory for first user input word
   	syscall

   	la 	$a0, word2	        # get second word from user input  
   	li 	$v0, 4			# print string code 4
   	syscall

   	li 	$v0, 8           	# read string code 8
   	la 	$a0, secondWord         # temp hold second user input word
   	li 	$a1, 9         		# allocate heap memory for second user input word
   	syscall
   	
   	li 	$v0, 4			# print string code 4
   	la 	$a0, newline		# skip a line
   	syscall
 
################################################### User Word 1 #####################################################################        	
  
       	li 	$s4, 0            	# counter = 0
   	la 	$t0, sample           	# save sample sentence in $t0
        
stringWord1:   
	la 	$t1, firstWord          # place first user input in $t1

########################### search how many times the first word is repeated inside the sentence ####################################

stringLoop1:             		                 			                 
   	lb 	$s2, ($t0)           	# load sample sentence memory address in $s2
   	lb 	$s3, ($t1)           	# load user input word 1 memory address in $s3                
   	
   	beq 	$s3, '\n', addCounter1 	# if $s3(user input word 1) == newline, counter++
   	beqz 	$s3, addCounter1       	# if $s3(user input word 1) == 0 , terminate loop
   	beqz 	$s2, printCounter1      # if $s2(sample sentence) == 0 , terminate loop
  
################################################### to lower case ###################################################################                 
                               
   	move 	$a0, $s2           	# if $s2(sample sentence) == upperCase , lowerCase it
   	jal 	lowerCase
   	move 	$s2, $v0           	# hold the lowerCase sentence in $s2

   	move 	$a0, $s3           	# if $s3(user input word 1) == upperCase , lowerCase it
   	jal 	lowerCase
   	move 	$s3,$v0           	# hold the lowerCase word 1 in $s3

   	bne 	$s2, $s3, skipChar1    	# if noCharacterMatch, skip to next character
   	addiu 	$t0, $t0, 1          	# else charMatch, i++
   	addiu 	$t1, $t1, 1		# else charMatch, i++
   	j 	stringLoop1             # return to the loop
   	
################################################### character counter ###############################################################                 

skipChar1:
   	la 	$s5, firstWord		# load first word in $s5
   	bne 	$s5, $t1, stringWord1	# compare first word with new index, if not equal: 	
   	la 	$t1, firstWord          # place first user input word in $t1
   	addiu 	$t0, $t0, 1            	# i++, skipChar1
   	j 	stringLoop1             # return to the loop
   	
addCounter1:
   	addi 	$s4, $s4, 1           	# counter++
   	la 	$t1, firstWord          # place first user input word in $t1
   	j 	stringLoop1             # return to the loop
   	
printCounter1:
   	la 	$t0, firstWord		# print result counter

################################################### character counter ###############################################################                 

loop1:
   	lb 	$a0, ($t0)		# load i++ memory byte and extend the size of $a0
   	beq 	$a0, '\n', endLoop1	# if $a0(incremented index) == newline, end loop	
   	jal 	upperCase		# else convert user input word to upperCase
   	
   	move 	$a0, $v0		# hold returned value in $a0
   	li 	$v0, 11			# print character code 11
   	syscall
   	
   	addiu 	$t0, $t0, 1		# counter++
   	j 	loop1			# return to the loop

endLoop1:
   	la 	$a0, format		# print ': ' next to user input word
   	li 	$v0, 4			# print string code 4
   	syscall
   	     
   	move 	$a0, $s4		# place updated character counter in $a0
   	li 	$v0, 1			# print integer code 1
   	syscall               		
   	
   	la 	$a0, newline		# breakLine
   	li 	$v0, 4			# print string code 4
   	syscall
   	
################################################### User Word 2 #####################################################################        	
 
   	li 	$s4, 0            	# counter = 0
   	la 	$t0, sample           	# save sample sentence in $t0

stringWord2:   
	la 	$t1, secondWord         # place second user input in $t1

######################## search how many times the second word is repeated inside the sentence ######################################

stringLoop2:                   		            
   	lb 	$s2, ($t0)           	# load sample sentence memory address in $s2                  			
   	lb 	$s3, ($t1)           	# load user input word 2 memoru address in $s3
                   			               
   	beq 	$s3, '\n', addCounter2  # if $s3(user input word 2) == newline, counter++
   	beqz 	$s3, addCounter2        # if $s3(user input word 2) == 0 , terminate loop
   	beqz 	$s2, printCounter2      # if $s2(sample sentence) == 0 , terminate loop
       
################################################### to lower case ###################################################################                 
                                     
   	move 	$a0, $s2           	# if $s2(sample sentence) == upperCase , lowerCase it
   	jal 	lowerCase
   	move 	$s2, $v0           	# hold the lowerCase sentence in $s2

   	move 	$a0, $s3           	# if $s3(user word 2) == upperCase , lowerCase it
   	jal 	lowerCase
   	move 	$s3, $v0           	# hold the lowerCase word 2 in $s3

   	bne 	$s2, $s3, skipChar2     # if noCharacterMatch, skip to next character          			
   	addiu 	$t0, $t0, 1             # else charMatch, i++
   	addiu 	$t1, $t1, 1		# else charMatch, i++
   	j 	stringLoop2             # return to the loop

################################################### character counter ###############################################################                 

skipChar2:
   	la 	$s5, secondWord		# load second word in $s5
   	bne 	$s5, $t1, stringWord2   # compare first word with new index, if not equal:
   	la 	$t1, secondWord         # place second user input word in $t1
   	addiu 	$t0, $t0, 1            	# i++, skipChar2
   	j 	stringLoop2             # return to the loop
   	
addCounter2:
   	addi 	$s4, $s4, 1           	# counter++
   	la 	$t1, secondWord         # place second user input word in $t1
   	j 	stringLoop2             # return to the loop

printCounter2:
   	la 	$t0, secondWord		# print result counter

################################################### character counter ###############################################################                 

loop2:
   	lb 	$a0, ($t0)		# load i++ memory byte and extende the size of $a0
   	beq 	$a0, '\n', endLoop2	# if $a0(incremented index) == newline, end loop
   	jal 	upperCase		# else convert user input word to upperCase
   
   	move 	$a0, $v0		# hold returned value in $a0
   	li 	$v0, 11			# print character code 11
   	syscall
   	
   	addiu 	$t0, $t0, 1		# counter++
   	j 	loop2			# return to the loop

endLoop2:
   	la 	$a0, format		# print ': ' next to the user input word
   	li 	$v0, 4			# print string code 4
   	syscall
   	
   	move 	$a0, $s4		# place updated character counter in $a0
   	li 	$v0, 1			# print integer code 1
   	syscall
  
#################################################### end program ####################################################################                 
endProgram:

   	li      $v0, 10			# end program code 10
	syscall	

################################################### to lower case ###################################################################                 
lowerCase:                		
   	move 	$v0, $a0		# lowerCase the upperCase characters in $a0 and place the result in $v0 (sentence)
   	blt 	$a0, 'A', lCaseLoop	# if branch char is less than 'A' , lower case loop
   	bgt 	$a0, 'Z', lCaseLoop	# if branch char is greater than 'Z' , lower case loop
   	subi 	$v0, $a0, -32		# subtract immediate 32 bytes for lowerCase

lCaseLoop:   
	jr 	$ra               	# lowerCase result
	
################################################### to upper case ###################################################################                 
upperCase:                		
   	move 	$v0, $a0		# upperCase the lowerCase characters in $a0 and place the result in $v0 (output)
   	blt 	$a0, 'a', uCaseLoop	# if branch char is less than 'a' , upper case loop
   	bgt 	$a0, 'z', uCaseLoop	# if branch char is greater than 'z' , upper case loop
   	addiu 	$v0, $a0, -32		# subtract immediate 32 bytes for upperCase
   	
uCaseLoop:   
	jr 	$ra               	# lowerCase result              	
