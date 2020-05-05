.data
	texto: 	.word 0
.text
    la $a0, texto
    jal leerTexto
    
    lw $a0, texto
    li $v0, 34
    syscall
    
    li $v0, 10
    syscall

# en $a0 recibe el parametro
leerTexto:
    li $t1, 1
    pedir:
      li $v0, 12
      syscall
      sb $v0, ($a0)
      addi $a0, $a0, 1
    
      addi $t1, $t1, 1
      beq $t1, 5, fin
      j pedir
fin:
    jr $ra
    