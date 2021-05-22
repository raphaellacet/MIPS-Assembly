######################################################################################################################################
# Author:	Raphael Fidelis Lacet		Date: 03/11/2021
# Description:	program to find the number of selected letters present in a string, 
#		specifically the number of the occurrences of the letters K, N, I, G, H, T, and S
#		within an input sentence, and then output the result 
# Input:	User input String
# Output:	K ------------- # number
#		N ------------- # number
#		I ------------- # number
#		G ------------- # number
#		H ------------- # number
#		T ------------- # number
#		S ------------- # number
# registers used:
# $a0:		hold the string of characters variable
# $v0:		hold the int counter variable
# $t0:		hold the temp string character and pointer to next string character
# $t1:		hold the address of the current character
# $s1:		pointer to desired character
# $s2:		character 'k' counter 	  |	# $s0:		'k' pointer
# $s3:		character 'n' counter 	  |	# $t3:		'n' pointer
# $s4:		character 'i' counter 	  |	# $t4:		'i' pointer
# $s5:		character 'g' counter 	  |	# $t5:		'g' pointer
# $s6:		character 'h' counter 	  |	# $t6:		'h' pointer
# $s7:		character 't' counter 	  |	# $a2:		't' pointer
# $t7:		character 's' counter 	  | 	# $a3:		's' pointer
#################################################### Data segment ####################################################################
.data
k:      	.asciiz    	"Kk"
n:      	.asciiz    	"Nn"
i:      	.asciiz    	"Ii"
g:      	.asciiz    	"Gg"
h:      	.asciiz    	"Hh"
t:      	.asciiz    	"Tt"
s:      	.asciiz     	"Ss"	
buffer:		.space		1024
prompt:		.asciiz		"Enter a phrase:\n"
K_out:		.asciiz		"K ------------- "
N_out:		.asciiz		"N ------------- "
I_out:		.asciiz		"I ------------- "
G_out:		.asciiz		"G ------------- "
H_out:		.asciiz		"H ------------- "
T_out:		.asciiz		"T ------------- "
S_out:		.asciiz		"S ------------- "
breakline:	.asciiz     	"\n"
#################################################### Data segment ####################################################################
.text
.globl  main
main:					# main program entry
# Get string from user

        la 	$a0, prompt		# load and print prompt
        li 	$v0, 4			# print string code 4
        syscall
        
        li	$v0, 8			# read user input - syscall code 8
        la	$a0, buffer		# load byte space into address
        li 	$a1, 1024		# allocate 1024 bytes of memory space for user input string
        syscall
# get string to scan k        
	move	$s2, $v0		# hold int k in $s2
    	li      $s2, 0                  # initialize k count
    	la      $s0, buffer             # pointer to string
    	
# get string to scan n   
	move	$s3, $v0		# hold int n in $s3
    	li      $s3, 0                  # initialize n count
    	la      $t3, buffer             # pointer to string
    	
# get string to scan i
	move	$s4, $v0		# hold int i in $s4
    	li      $s4, 0                  # initialize i count
    	la      $t4, buffer             # pointer to string
    	
# get string to scan g
	move	$s5, $v0		# hold int g in $s5
    	li      $s5, 0                  # initialize g count
    	la      $t5, buffer             # pointer to string
    	
# get string to scan h       
	move	$s6, $v0		# hold int h in $s6
    	li      $s6, 0                  # initialize h count
    	la      $t6, buffer             # pointer to string

# get string to scan t
	move	$s7, $v0		# hold int t in $s7
    	li      $s7, 0                  # initialize t count
    	la      $a2, buffer             # pointer to string
    	
# get string to scan s      
	move	$t7, $v0		# hold int s in $t7
    	li      $t7, 0                  # initialize s count
    	la      $a3, buffer             # pointer to string

##### count 'k' char function ########################################################################################################

k_loopString:
    	lb      $t0, 0($s0)		# get string of characters
	addiu   $s0, $s0, 1		# point to the next string of characters
    	beqz    $t0, k_endString	# end k_loopString if reach the end of the string
    	la      $s1, k			# pointer to k

k_loop:
    	lb      $t1, 0($s1)		# get k
    	beqz    $t1, k_loopString	# search for other k's in the string, if not find end loop
    	addiu   $s1, $s1, 1		# point to the next k
    	bne     $t0, $t1, k_loop	# if there are no k's in string, return to k_loop
    	addi    $s2, $s2, 1		# else increment counter, count++
    	j       k_loopString		# unconditional jump to return to the beginning of the loop
    	
k_endString:
	
##### print 'k' counter ###################################################################################################################

    	li      $v0, 4			# print string code 4
    	la      $a0, K_out		# load and print K
    	syscall
					# print k counter
    	li      $v0, 1			# print integer code 1
    	move    $a0, $s2
    	syscall
					# print line break
    	li      $v0, 4			# print string code 4
    	la      $a0, breakline
    	syscall

##### count 'n' char function ########################################################################################################

n_loopString:
    	lb      $t0, 0($t3)		# get string of characters
	addiu   $t3, $t3, 1		# point to the next string of characters
    	beqz    $t0, n_endString	# end n_loopString if reach the end of the string
    	la      $s1, n			# pointer to n

n_loop:
    	lb      $t1, 0($s1)		# get n
    	beqz    $t1, n_loopString	# search for other n's in the string, if not find end loop
    	addiu   $s1, $s1, 1		# point to the next n
    	bne     $t0, $t1, n_loop	# if there are no n's in string, return to n_loop
    	addi    $s3, $s3, 1		# else increment counter, count++
    	j       n_loopString		# unconditional jump to return to the beginning of the loop
    	
n_endString:

##### print 'n' counter #############################################################################################################

    	li      $v0, 4			# print string code 4
    	la      $a0, N_out		# load and print N
    	syscall
					# print n counter
    	li      $v0, 1			# print integer code 1
    	move    $a0, $s3
    	syscall
					# print line break
    	li      $v0, 4			# print string code 4
    	la      $a0, breakline
    	syscall

##### count 'i' char function ########################################################################################################

i_loopString:
    	lb      $t0, 0($t4)		# get string of characters
	addiu   $t4, $t4, 1		# point to the next string of characters
    	beqz    $t0, i_endString	# end i_loopString if reach the end of the string
    	la      $s1, i			# pointer to i

i_loop:
    	lb      $t1, 0($s1)		# get i
    	beqz    $t1, i_loopString	# search for other i's in the string, if not find end loop
    	addiu   $s1, $s1, 1		# point to the next i
    	bne     $t0, $t1, i_loop	# if there are no i's in string, return to i_loop
    	addi    $s4, $s4, 1		# else increment counter, count++
    	j       i_loopString		# unconditional jump to return to the beginning of the loop
    	
i_endString:

##### print 'i' counter ##############################################################################################################

    	li      $v0, 4			# print string code 4
    	la      $a0, I_out		# load and print I
    	syscall
					# print i counter
    	li      $v0, 1			# print integer code 1
    	move    $a0, $s4
    	syscall
					# print line break
    	li      $v0, 4			# print string code 4
    	la      $a0, breakline
    	syscall

##### count 'g' char function ########################################################################################################

g_loopString:
    	lb      $t0, 0($t5)		# get string of characters
	addiu   $t5, $t5, 1		# point to the next string of characters
    	beqz    $t0, g_endString	# end g_loopString if reach the end of the string
    	la      $s1, g			# pointer to g

g_loop:
    	lb      $t1, 0($s1)		# get g
    	beqz    $t1, g_loopString	# search for other g's in the string, if not find end loop
    	addiu   $s1, $s1, 1		# point to the next g
    	bne     $t0, $t1, g_loop	# if there are no g's in string, return to g_loop
    	addi    $s5, $s5, 1		# else increment counter, count++
    	j       g_loopString		# unconditional jump to return to the beginning of the loop
    	
g_endString:

##### print 'g' counter ##############################################################################################################

    	li      $v0, 4			# print string code 4
    	la      $a0, G_out		# load and print I
    	syscall
					# print g counter
    	li      $v0, 1			# print integer code 1
    	move    $a0, $s5
    	syscall
					# print line break
    	li      $v0, 4			# print string code 4
    	la      $a0, breakline
    	syscall

##### count 'h' char function ########################################################################################################

h_loopString:
    	lb      $t0, 0($t6)		# get string of characters
	addiu   $t6, $t6, 1		# point to the next string of characters
    	beqz    $t0, h_endString	# end h_loopString if reach the end of the string
    	la      $s1, h			# pointer to h

h_loop:
    	lb      $t1, 0($s1)		# get h
    	beqz    $t1, h_loopString	# search for other h's in the string, if not find end loop
    	addiu   $s1, $s1, 1		# point to the next h
    	bne     $t0, $t1, h_loop	# if there are no h's in string, return to h_loop
    	addi    $s6, $s6, 1		# else increment counter, count++
    	j       h_loopString		# unconditional jump to return to the beginning of the loop
    	
h_endString:

##### print 'h' counter ##############################################################################################################

    	li      $v0, 4			# print string code 4
    	la      $a0, H_out		# load and print H
    	syscall
					# print h counter
    	li      $v0, 1			# print integer code 1
    	move    $a0, $s6
    	syscall
					# print line break
    	li      $v0, 4			# print string code 4
    	la      $a0, breakline
    	syscall
    	
##### count 't' char function ########################################################################################################

t_loopString:
    	lb      $t0, 0($a2)		# get string of characters
	addiu   $a2, $a2, 1		# point to the next string of characters
    	beqz    $t0, t_endString	# end t_loopString if reach the end of the string
    	la      $s1, t			# pointer to t

t_loop:
    	lb      $t1, 0($s1)		# get t
    	beqz    $t1, t_loopString	# search for other t's in the string, if not find end loop
    	addiu   $s1, $s1, 1		# point to the next t
    	bne     $t0, $t1, t_loop	# if there are no t's in string, return to t_loop
    	addi    $s7, $s7, 1		# else increment counter, count++
    	j       t_loopString		# unconditional jump to return to the beginning of the loop
    	
t_endString:

##### print 't' counter ##############################################################################################################

    	li      $v0, 4			# print string code 4
    	la      $a0, T_out		# load and print T
    	syscall
					# print t counter
    	li      $v0, 1			# print integer code 1
    	move    $a0, $s7
    	syscall
					# print line break
    	li      $v0, 4			# print string code 4
    	la      $a0, breakline
    	syscall

##### count 's' char function ########################################################################################################

s_loopString:
    	lb      $t0, 0($a3)		# get string of characters
	addiu   $a3, $a3, 1		# point to the next string of characters
    	beqz    $t0, s_endString	# end s_loopString if reach the end of the string
    	la      $s1, s			# pointer to s

s_loop:
    	lb      $t1, 0($s1)		# get s
    	beqz    $t1, s_loopString	# search for other s's in the string, if not find end loop
    	addiu   $s1, $s1, 1		# point to the next s
    	bne     $t0, $t1, s_loop	# if there are no s's in string, return to s_loop
    	addi    $t7, $t7, 1		# else increment counter, count++
    	j       s_loopString		# unconditional jump to return to the beginning of the loop
    	
s_endString:

##### print 's' counter ##############################################################################################################

    	li      $v0, 4			# print string code 4
    	la      $a0, S_out		# load and print S
    	syscall
					# print s counter
    	li      $v0, 1			# print integer code 1
    	move    $a0, $t7
    	syscall

##### end program ###################################################################################################################			

   	li      $v0, 10			# end program code 10
	syscall				# exit program