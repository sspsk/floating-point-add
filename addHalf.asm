#author: sspsk Email:kdstsdk@gmail.com
#-------------------------------------
# temp is $t0
# temp1 is $t1
# temp2 is $t2
# s_a is $t3
# e_a is $t4
# s_b is $t5
# e_b is $t6
# s is $t7
# e is $t8
# $t9 for all purposes
addhalf:andi $t1,$a0,0x3ff              //look the c code for explantion
        srl  $t4,$a0,10
        andi $t4,$t4,0x1f
        srl  $t3,$a0,15

        andi $t2,$a1,0x3ff
        srl  $t6,$a1,10
        andi $t6,$t6,0x1f
        srl  $t5,$a1,15

        beq  $a0,$a1,check
start:
        ori $t1,$t1,0x400
        ori $t2,$t2,0x400

        blt  $t6,$t4,makeExp
        sub  $t9,$t6,$t4
        srl  $t1,$t1,$t9
        move $t4,$t6
cont:
        move $t8,$t4
        beq  $t3,$t5,sameSign
        beq  $t1,$t2,exit1
        blt  $t2,$t1,less
        move $t7,$t5
        sub  $t0,$t2,$t1

loop:   andi $t9,$t0,0x400
        bne  $t9,$zero,exit
        sll  $t0,$t0,1
        addi $t8,$t8,-1
        j loop

exit:
        sll  $t7,$t7,15
        sll  $t8,$t8,10
        andi $t0,$t0,0x3ff
        or   $t9,$t7,$t8
        or   $v0,$t9,$t0
        jr   $ra

makeExp:
        sub  $t9,$t4,$t6
        srl  $t2,$t2,$t9
        move $t6,$t4
        j cont

sameSign:
        move $t7,$t3
        add  $t0,$t1,$t2
        srl  $t9,$t0,10
        beq  $t9,1,exit
        srl  $t0,$t0,1
        addi $t8,$t8,1
        j exit

exit1:
        move $v0,$zero
        jr $ra

less:
       move $t7,$t3
       sub  $t0,$t1,$t2
       j loop
check:
       bne $a0,$zero,start
       j   exit1
