####################################
# 		#
# Código ejemplo#
# Bucle while 	#
# 		#
####################################
BucleWhile: slt $t0, $s2, $s1	# Pone $t0 a 1 si $s2 < $s1, o a 0 si no se cumple.

bne $t0, $zero, SalirBucle 	# Salta a la etiqueta si no son iguales.

add $s1, $s1, $s5		# Suma

j BucleWhile 			# Volver al inicio del bucle

SalirBucle: 			# Salida del bucle 