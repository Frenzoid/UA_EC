# Ejercicio 11.
#   Escribe el código que lee el valor x y escribe por pantalla la solución de la
#      ecuación: 5x2 + 2x + 3.

# Recordatorio
# V = retorno
# A = entrada
##############

.text

# Llamamos a la funcion de leer un entero.
jal readInt

# Llamamos a la funcion que hace la ecuacion con el valor pasado por $a0
move $a0, $v0
jal ecuation

# Llamamos a la función imprimir un entero
move $a0, $v0
jal printInt		

# Acaba el programa
jal exit


############################
#        Funciones         #
############################

# Funcion, imprime un entenro
printInt: li $v0, 1     # Función imprim
syscall                 # Escribe el valor de $a0

jr $ra                  # Vuelve al programa principal


# Función multiplica por 60
ecuation: move $t0, $a0
# ecuación: 5 x ^ 2 + 2 x + 3.

mult $t0, $t0		# x ^ 2
mflo $t0		# $t0 = x ^ 2

li $t1, 5		# $t1 = 5
mult $t1, $t0		# 5 x ^ 2
mflo $t0		# $t0 = 5 x ^ 2


li $t1, 2		# $t1 = 2
mult $t1, $a0		# 2 x
mflo $t1		# $t1 = 2 x


addu $t0, $t0, $t1	# t0 = 5 x ^ 2 + 2 x
addiu $t0, $t0, 3	# t0 = 5 x ^ 2 + 2 x + 3

move $v0, $t0
    
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