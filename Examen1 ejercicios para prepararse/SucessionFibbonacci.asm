.data
PEDIR: .asciiz "Dime hasta que num quieres la sucession: "

.text
li $t0, 0 # Contador
li $t2, 0 # Sumador Anterior
li $t3, 1 # Sumador Posterior

jal pedirNum
move $t1, $v0	# Num de veces pedido

bucle: move $a0, $t2
li $v0, 1
syscall
jal espacio

add $t2, $t2, $t3
sub $t3, $t2, $t3 


add $t0, $t0, 1
bne $t0, $t1, bucle

jal exit


# FUNCIONES.

pedirNum: la $a0, PEDIR
li $v0, 4
syscall
li $v0, 5
syscall
jr $ra


exit: li $v0, 10
syscall


espacio: la $a0, ' '
la $v0, 11
syscall
jr $ra