# Cuestión 11.
# Haz el código que lee de teclado dos valores positivos A y B en los que A < B.
# El programa tiene que escribir por consola los valores comprendidos entre ambos,
# 	incluyéndose a ellos mismos.
# Es decir, si A=3 y B=6, escribe en la consola: 3 4 5 6.
# 	(puedes escribir, por ejemplo, un salto de línea después de cada uno de los valores a mostrar). 

jal readInt		# Lee un entero
move $s0, $v0		# nos los guardamos en $s1, inicio.

jal readInt		# Lee el segundo entero
move $s1, $v0		# nos los guardamos en $s2, condicion final del bucle
move $s2, $s0		# Contador

inicio_for: move $a0, $s2		# Mostramos el contador
jal printInt

jal readSpace		# Imprimimos un espacio entre los numeros

seq $t1, $s2, $s1	# Si $s2 es menor que que $s1, $t1 = 1, en caso contrario, $t1 = 0

addi $s2, $s2, 1 	# incremento del contador

beqz $t1, inicio_for	# Si es igual a 0, reitera.

final_for:

j exit

############################
#        Funciones         #
############################

# Funcion que imprime un espacio
readSpace: li $a0, ' '
li $v0, 11
syscall

jr $ra

# Funcion, imprime un entenro
printInt: li $v0, 1     # Función imprimir
syscall                 # Escribe el valor de $a0

jr $ra                  # Vuelve al programa principal

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
