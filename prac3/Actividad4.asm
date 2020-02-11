####################################
# #
# Código de la actividad 4 #
# Programa ECHO #
# #
####################################
li $v0,12 #Función 12. Read character
syscall #Carácter leído en $v0
move $a0,$v0 #Carácter a escribir en $a0
li $v0,11 #Función 11. Print character
syscall
li $v0, 10 #Función 10. Acaba programa
syscall