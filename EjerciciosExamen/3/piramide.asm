.data
	msg: .asciiz "Introduce le numero de filas: "

.text
	la $a0, msg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t3, $v0 # limite del bucle exterior
	
	li $t1, 1
bucle_exterior:
	bgt $t1, $t3, fin_bucle_exterior

	li $t2, 1
bucle_interior:
	bgt $t2, $t1, fin_bucle_interior
	li $v0, 11
	li $a0, '*'
	syscall
	addi $t2, $t2, 1
	j bucle_interior
fin_bucle_interior:
	addi $t1, $t1, 1
	li $a0, '\n'
	li $v0, 11
	syscall
	j bucle_exterior

fin_bucle_exterior:
	li $v0, 10
	syscall
