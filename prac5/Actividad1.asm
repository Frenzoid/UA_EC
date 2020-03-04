####################################
# 				#
# Código de la actividad 1 	#
# Cálculo del valor absoluto 	#
# de un entero			#
# 				#
####################################
.text
li $a0, '>'
li $v0, 11 		# Indicación de escribir un valor
syscall

li $v0, 5
syscall 		# Leer el entero A

bgez $v0, else 		# Si (A ≥ 0) salta a else

sub $a0, $zero, $v0 	# En $a0 el negativo de A

j exit 			# Acaba parte if-then

else: move $a0, $v0	# En $a0 el valor A

exit: li $v0, 1 	# Imprimir lo que hay en $a0

syscall

li $v0, 10 		# Acaba el programa
syscall
