.data 
num0: .word 1 # posic 0
num1: .word 2 # posic 4
num2: .word 4 # posic 8 
num3: .word 8 # posic 12 
num4: .word 16 # posic 16 
num5: .word 32 # posic 20
num6: .word 0 # posic 24
num7: .word 0 # posic 28
num8: .word 0 # posic 32
num9: .word 0 # posic 36
num10: .word 0 # posic 40
num11: .word 0 # posic 44
.text 
main:
  lw $t1, 1024($zero) 
  lw $t2, 1028($zero) 
  lw $t3, 1032($zero) 
  lw $t4, 1036($zero)
  lw $t5, 1040($zero)
  lw $t6, 1044($zero)
  sw $t1, 1048($zero)
  sw $t2, 1052($zero)
  sw $t3, 1056($zero)
  sw $t4, 1060($zero)
  sw $t5, 1064($zero)
  sw $t6, 1068($zero)
  lw $t1, 1048($zero) 
  lw $t2, 1052($zero) 
  lw $t3, 1056($zero) 
  lw $t4, 1060($zero) 
  lw $t5, 1064($zero) 
  lw $t6, 1068($zero) 
  add $t7, $t1, $t2
  add $s0, $t3, $t4
  sub $s1, $t5, $t1
  sub $s2, $t6, $t2
  and $s3, $t1, $t2
  and $s4, $t7, $t2
  or $s5, $t1, $t2 
  or $s6, $s0, $t2 
  slt $s7, $t1, $t2
  slt $t8, $s0, $t2
  

