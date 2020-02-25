# Cuestión 9.
# Haz el código que lea dos enteros de la consola y escriba la suma y vuelva a
# comenzar si el resultado es distinto de 0. Es pseudocódigo sería:

# (bucle do-while)
#	seguir: Leer el primer valor (A)
#	Leer el segundo valor (B)
#	Imprimir A+B
#
# 	Si (A+B) == 0 
#		ir a acabar
#
# 	ir a seguir
# acabar

.text
BucleWhile: jal readInt		# Lee un entero
move $s0, $v0			# nos los guardamos en $s0

jal readInt			# Lee el segundo entero
move $s1, $v0			# nos los guardamos en $s1


move $a0, $s0			# Lo movemos para imprimir
jal printInt			# Imprimimos

jal printPlus			# Iprimimos un '+' par que quede: A+B

move $a0, $s1			# Lo movemos para imprimir
jal printInt			# Imprimimos

jal returncarriage		# Imprimimos un enter.

add $t0, $s0, $s1		# Sumamos ambos valores y guardamos el resultado en $t0

seq $t1, $t0, $zero		# Comprobamos si son iguales, deuvelve 1 en $1 si se cumple

bne $t1, 1, BucleWhile		# Si $1 es igual es 0, 

j exit



############################
#        Funciones         #
############################

# Funcion, imprime un entenro
printInt: li $v0, 1     # Función imprimir
syscall                 # Escribe el valor de $a0

jr $ra                  # Vuelve al programa principal

# Imprimimos un caracrer +
printPlus: li $a0, '+'
li $v0, 11
syscall

jr $ra

# Funcion imprime un caracter de retrono de carro
returncarriage: li $a0, '\n'
li $v0, 11
syscall
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
