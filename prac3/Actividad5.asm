####################################
# #
# Código de la actividad 5 #
# Pruebas de etiquetas #
# #
####################################
.text
eti1: addi $v0,$0,5
syscall

eti2: addi $a0,$v0,15
addi $v0,$0,1
syscall

li $a0, '\n'
li $v0,11
syscall

la $t1, eti1 #Carga en $t1 la dirección de eti1
la $t2, eti2 #Carga en $t2 la dirección de eti2
move $a0,$t1
li $v0,34
syscall

li $a0, '\n'
li $v0,11
syscall

move $a0,$t2
li $v0,34
syscall

li $v0,10 #Función 10 Exit
syscall