# 2.1 Multiplicación de un número entero introducido por teclado por el valor suma de los cuatro dígitos de la derecha de tu DNI utilizando 
#  instrucciones de desplazamiento. El   número   se   almacenará   en   la   posición   0x10010008  (3 puntos)

# 2.2 Muestra su valor en octal por pantalla utilizando caracteres ASCII.
#  Para ello realiza una función que extraiga cada uno de los dígitos que forman parte del número y convierta dicho valor a su correspondiente 
#  carácter numérico para posteriormente ser mostrado por pantalla. (3 puntos)

.text

# 2.1.
jal readInt
move $t6, $v0
la $t0, 0x10010008

# DNI: 5125 4875 L
li $t1, 4
li $t2, 8
li $t3, 7
li $t4, 5

add $t5, $t1, $t2
add $t5, $t5, $t3
add $t5, $t5, $t4

# $t5 = 24
# $t6 = numero
# 2^4 = 16, 2^3 = 9, 16 + 4 = 24

sll $t7, $t6, 4 # Numero * 16
sll $t8, $t6, 3 # Numero * 9  = Numero * 24

add $t2, $t8, $t7
sb $t2, 0($t0)


# 2.2.
move $a0, $t2



jal exit

# F

# Extrae bits.
extractBits:
andi $a0, 0xff
jr $ra

# Funcion lee un entero.
readInt: li $a0, '>'	# Ponemos un caracter para que el usuario sepa que estamos esperando un numero de entrada.
li $v0, 11
syscall
li $v0, 5		# Pedimos un entero
syscall
jr $ra

# Salir
exit:
li $v0, 10
syscall

