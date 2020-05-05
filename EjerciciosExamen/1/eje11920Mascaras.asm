.data
	texto: .word 0

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
	li $t1, 0 # aqui lo guardaremos todo

	li $v0, 12  # leo un caracter
	syscall

	sll $t2, $v0, 24 # 12 bits y se lo suma al resultado
	or $t1, $t1, $t2
	li $v0, 12  # leo un caracter
	syscall

	sll $t2, $v0, 16 # 8 bits y se lo suma al resultado
	or $t1, $t1, $t2
	li $v0, 12  # leo un caracter
	syscall

	sll $t2, $v0, 8 # 8 bits y se lo suma al resultado
	or $t1, $t1, $t2
	li $v0, 12  # leo un caracter
	syscall

	or $t1, $t1, $v0
	sw $t1, ($a0)

jr $ra

# en $a0 recibe el numero a cifrar
# en $a1 recibe la clave
# en $v0 devuelve
cifrar_descifrar:

	lw $t1, ($a0)
	lw $t2, ($a1)
	xor $v0, $t1, $t2

jr $ra