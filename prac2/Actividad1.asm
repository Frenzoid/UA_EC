####################################
# #
# Código de la actividad 1 #
# Imprimir en consola #
# #
####################################

.text 0x00400000
addi $a0,$0,25 	#Valor a escribir en $a0
addi $v0,$0,1	#Función 1, print integer
syscall		#Escribe en consola $a0