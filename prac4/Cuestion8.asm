# Cuestión 8.
# Escribe una función que multiplique por 60. Escribe el programa principal que
#     lea una cantidad de minutos y devuelve por consola la cantidad en segundos.

# Recordatorio
# V = retorno
# A = entrada
##############

.text

jal readInt		# Llamamos a la funcion de leer un entero.

move $a0, $v0
jal x60			# Llamamos a la función x60 que multiplica por 60

move $a0, $v0
jal printInt		# Llamamos a la función imprimir un entero

jal exit		# Acaba el programa


############################
#        Funciones         #
############################

# Funcion, imprime un entenro
printInt: li $v0, 1     # Función imprim
syscall                 # Escribe el valor de $a0

jr $ra                  # Vuelve al programa principal


# Función multiplica por 60
x60: move $t0, $a0
sll $t1, $t0, 6		# Multiplicamos el valor por 64 y lo guardamos en $t1
sll $t2, $t0, 2		# Multiplicamos el valor por 4 y lo guardamos en $t2
sub $v0, $t1, $t2	# Restamos $t1 - $t2 y lo devolvemos a $v0
    
jr $ra


# Funcion lee un entero.
readInt: li $a0, '>'	# Ponemos un caracter para que el usuario sepa que estamos esperando un numero de entrada.
li $v0, 11
syscall			

li $v0, 5		# Pedimos un entero
syscall

jr $ra			# Vuelve al programa principal


# Sale del programa
exit: li $v0, 10
syscall