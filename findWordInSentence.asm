.data
str:        .space      100         # space for sentence
input:      .space      30          # space for word to scan for

ins:        .asciiz     "Please enter a sentence: "
seek:       .asciiz     "Please enter a word: "
nomatch:    .asciiz     "No Match(es) Found"
found:      .asciiz     " Match(es) Found"
newline:    .asciiz     "\n"
quo1:       .asciiz     "'"
quo2:       .asciiz     "'\n"

    .text
    .globl  main
    
main:
    # read sentence
    la      $a0,ins                 # prompt
    la      $a1,100                 # length of buffer
    la      $a2,str                 # buffer address
    jal     rdstr

    # read scan word
    la      $a0,seek                # prompt
    la      $a1,30                  # length of buffer
    la      $a2,input               # buffer address
    jal     rdstr

    la      $t7,str                 # pointer to first char in string
    li      $t8,0                   # zero the match count

strloop:
    move    $t6,$t7                 # start scan where we left off in string
    la      $t5,input               # start of word to scan for
    li      $t4,0x20                # get ascii space

wordloop:
    lbu     $t0,0($t6)              # get char from string
    addiu   $t6,$t6,1               # advance pointer within string

    lbu     $t1,0($t5)              # get char from scan word
    addiu   $t5,$t5,1               # advance pointer within scan word

    bne     $t0,$t1,wordfail        # char mismatch? if yes, fly
    bne     $t1,$t4,wordloop        # at end of scan word? if no, loop

    addi    $t8,$t8,1               # increment match count

wordfail:
    addiu   $t7,$t7,1               # advance starting point within string
    lbu     $t0,0($t7)              # get next char in sentence
    bnez    $t0,strloop             # end of sentence? if no, loop

    beqz    $t8,exit                # any match? if no, fly
    li      $v0,1                   # syscall to print integer
    move    $a0,$t8                 # print match count
    syscall

    li      $v0,4                   # syscall to print string
    la      $a0,found               # move found into a0
    syscall
    j       endprogram

exit:
    li      $v0,4                   # syscall to print string
    la      $a0,nomatch             # move nomatch into a0
    syscall

endprogram:
    li      $v0,10
    syscall

rdstr:
    # prompt user
    li      $v0,4                   # syscall to print string
    syscall

    # get the string
    move    $a0,$a2                 # get buffer address
    li      $v0,8                   # read string input from user
    syscall                         # issue a system call

    li      $t1,0x0A                # get ascii newline
    li      $t2,0x2E                # get ascii dot
    li      $t3,0x20                # get ascii space

    # clean up the string so the matching will be easier/simpler
rdstr_loop:
    lbu     $t0,0($a0)              # get character

    beq     $t0,$t1,rdstr_nl        # fly if char is newline
    beq     $t0,$t2,rdstr_dot       # fly if char is '.'

rdstr_next:
    addiu   $a0,$a0,1               # advance to next character
    j       rdstr_loop

rdstr_dot:
    sb      $t0,0($a0)              # replace dot with space
    j       rdstr_loop

rdstr_nl:
    sb      $t3,0($a0)              # replace newline with space

    j       rdstr_done              # comment this out to get debug print

    # debug print the cleaned up string
    li      $v0,4                   # output string
    la      $a0,quo1                # output a quote
    syscall
    move    $a0,$a2                 # output the cleaned up string
    syscall
    la      $a0,quo2
    syscall

rdstr_done:
    jr      $ra                     # return
