# 2. Realiza un programa que muestre la suma de los números impares que hay desde 0 hasta el numero n (n<256) que será introducido por teclado
# Almacena dichos númerosa partir memoria de la posiciónde memoria 0x10010020 de modo que ocupen la mínima cantidad de recursos de memoria.

.data 0x10010020
numeros: .byte 0


.text
# CODIGO #
la $t0, numeros   # Registros
li $t1, 0         # Contador (desde n pedido).
li $t3, 0         # Sumador
li $t4, 2         # divisor para saber si es par.

jal readInt
move $t1, $v0

# Bucle que pasa desde n hasta 254 (Inclusive)
suma:
    # Verificamos si es par.
    div		$t1, $t4    # $t1 / $t3
    mfhi	$t5         # si $t5 == 0, es par

    beqz $t5, espar
    bnez $t5, noespar
    
    espar:
      add  $t3, $t3, $t1	# $t3 += $t1
      sb   $t1, 0($t0)		# Guardamos el numero.
      addi $t0, $t0, 1		# Incrementamos el $t0 para guardar en la siguiente posicion.
      
    noespar:
    
    subi $t1, $t1, 1		# Decrementamos para el siguiente numero
bnez $t1, suma

move $a0, $t3

jal printInt

jal exit


# FUNCIONES #

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


# Funcion, imprime un entenro
printInt: 
li $v0, 1     # Función imprim
syscall                 # Escribe el valor de $a0

jr $ra                  # Vuelve al programa principal
