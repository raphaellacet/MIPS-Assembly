.data
V4_3pi: .float 4.1887902048
R:	.float 2.5
H:	.float 100.00
prompt:	.asciiz "THE VOLUME OF THE SPHERE IS: "
m3:	.asciiz " m^3"
.text
.globl main
main:
	li $v0, 4	# print string code 4
	la $a0, prompt	# load prompt
	syscall
	
	jal volume
	
	mov.s 	$f0, $f12 
	li 	$v0, 2 		# print float code 2	
	syscall 
	
	li $v0, 4	# print string code 4
	la $a0, m3	# load prompt
	syscall
	
	li $v0, 10	# endprogram code 10
	syscall
	
volume:	
	l.s $f0, R	# $f0 = R = 2.5
	l.s $f2, H	# $2 = H = 100.0
	l.s $f4, V4_3pi	# $f4 = V 4/3pi = 4.1887902048
	
	mul.s	$f12, $f0, $f0	# $f12 = r^2
	mul.s	$f12, $f12, $f0 # $f12 = r^3 = 15.625
	mul.s	$f1, $f12, $f4 # $f12 = 4/3pi*r^3

	mul.s	$f12, $f1, $f2	# 4/3pi*r^3 x 100
	round.w.s $f12, $f12	# round from float to int
	cvt.s.w	$f12, $f12	# conver from int back to float
	div.s	$f12, $f12, $f2	# 4/3pi*r^3/100 = 65.45

	jr $ra
