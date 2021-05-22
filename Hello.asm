########################################################
# Author: Raphael Fidelis Lacet		Date: 01/21/2021
# Description: input Hello, World! into the Mips program
# Input:    String
# Output:   String
################### Data segment #######################
.data
out_string: .asciiz "\nHello, World!\n"
################### Code segment #######################
.text
.globl main
main:		# main program entry

li $v0, 4			# syscall code for print string. # li = Load Immeadiate 4 into $v0
la $a0, out_string		# la = Load Address (puts out_string address in register $a0)
syscall

li $v0, 10	# Exit program (a = 10 hexadecimal)
syscall