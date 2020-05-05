# Recopilación rapida de funciones mayormente usadas.
# Recordatorio
# A = entrada
# V = retorno
##############

# Funcion, lee un caracter
readInt: li $a0, '>'	# Ponemos un caracter para que el usuario sepa que estamos esperando un caracter.
li $v0, 11
syscall			

readChar:
li $v0, 12 # funcion leer caracter
syscall    # Lee un caracter a $v0

jr $ra     # Vuelve al programa principal


# Funcion, imprime un string
printStr:
li $v0, 4  # funcion imprime un string
syscall    # Lee un caracter a $v0

jr $ra     # Vuelve al programa principal


# Funcion, imprime un entenro
printInt:
li $v0, 1  # Función imprimir
syscall    # Escribe el valor de $a0

jr $ra     # Vuelve al programa principal


# Funcion, imprime un espaciador (tabulador)
printCharTab:
li $a0, '\t'
li $v0, 11
syscall

jr $ra


# Funcion, imprime una nueva linea
printCharNewline:
li $a0, '\n'
li $v0, 11
syscall


# Funcion lee un entero.
readInt: li $a0, '>'	# Ponemos un caracter para que el usuario sepa que estamos esperando un numero de entrada.
li $v0, 11
syscall			

li $v0, 5		# Pedimos un entero
syscall

jr $ra			# Vuelve al programa principal


# Sale del programa
exit:
li $v0, 10
syscall

