####################################
# #
# Código de la actividad 7 #
# Pruebas con el PC #
# #
####################################
.text
eti1: addi $v0,$0,5
syscall #Lee un valor

eti2: addi $a0,$v0,15
addi $v0,$0,1
syscall #Escribe un valor

li $a0, '\n'
li $v0,11
syscall

j eti1 #Salta a eti1