#########################
#         DATOS         #
#########################
.data 0x10010004
B: .byte 0:4    # Vector de bytes, capacidad máx = 2 ^ 8 = 256 -> ( 0 - 255 ), 4 numeros.

.data 0x10010020
W: .word 0:4    # Vector de palabras, 4 numeros.

#########################
#     INSTRUCCIONES     #
#########################
.text
jal setInitialValues  # Preparamos el terrenos, nos cremos nuestras variables iniciales, y les damos valor.
jal resetCouterAndRegIterators  # Seteamos los contadores y registros usados en los bucles a su valor inicial.

loopAskForNumber: # bucle que pide los 4 numeros y los guarda en bytes.
jal readInt     # Pedimos un numero.
sb  $v0, 0($t0) # Lo guardamos en el byte correspondiente.
jal incConter   # Incrementamos el contador.
jal jumpByte    # Hacemos el sato de byte, para acceder al siguiente byte en la siguiente iteración.
bne	$t3, $s2, loopAskForNumber	# if $t3 != $s2 -> loopAskForNumber.

jal resetCouterAndRegIterators  # Seteamos los contadores y registros usados en los bucles a su valor inicial.

loopPassToWord: # Bucle que pasa todos los bytes al vector de palabras
lbu $t4, 0($t0) # Cargamos el valor del byte correspondiente (ATENCIÓN, CARGAMOS UNSIGNED!, 10 minutos perdidos solo por no poner esa 'u' al final).
sw  $t4, 0($t1) # Guardamos el valor del byte en una palabra.
jal incConter   # Incrementamos el contador.
jal jumpByte    # Hacemos el sato de byte, para acceder al siguiente byte en la siguiente iteración.
jal jumpWord    # Hacemos el sato de palabra, para acceder al siguiente palabra en la siguiente iteración.
bne	$t3, $s2, loopPassToWord	# if $t3 != $s2 -> loopPassToWord.

jal resetCouterAndRegIterators  # Seteamos los contadores y registros usados en los bucles a su valor inicial.

loopAddAllWords:    # Bucle que suma todas las palabras.
lw $t4, 0($t1)      # Cargamos el calor de la palabra correspondiente.
addu	$t5, $t5, $t4	# $t5 = $51 + 4t2.
jal incConter       # Incrementamos el contador.
jal jumpWord        # Hacemos el sato de palabra, para acceder al siguiente palabra en la siguiente iteración.
bne	$t3, $s2, loopAddAllWords	# if $t3 != $s2 -> loopPassToWord.

srl $t5, $t5, 2     # Desplazamos a la derecha, dividimos entre 4, 2 ^ 2 = 4.

move $a0, $t5       # Movemos el resultado a $a0 para imprimir el resultado.
jal printInt        

jal exit            # salimos del programa.

############################
#        SECCIONES         #
############################
setInitialValues:
la $s0, B     # Primera posicion del vector de 4 bytes.
la $s1, W     # Primera posicion del vector de 4 palabras.
li $s2, 4     # Limite del contador.
jr $ra			  # Vuelve al programa principal.

resetCouterAndRegIterators:
li   $t3, 0     # Seteamos el contador a 0.
move $t1, $s1   # Iterador de registros las palabras.
move $t0, $s0   # Iterador de registros los bytes.
jr   $ra        # Vuelve al programa principal.

incConter:
addi $t3, $t3, 1 # Incrementamos el contador
jr   $ra         # Vuelve al programa principal.

jumpByte:
addi $t0, $t0, 1 # Incementamos el salto de bytes
jr   $ra         # Vuelve al programa principal.

jumpWord:
addi $t1, $t1, 4 # Incrementamos el salto de palabra
jr   $ra         # Vuelve al programa principal.


############################
#        FUNCIONES         #
############################
# Funcion lee un entero.
readInt: 
li $a0, '>'	  # Ponemos un caracter para que el usuario sepa que estamos esperando un numero de entrada.
li $v0, 11    # Instruccion para imprimir un caracter.
syscall

li $v0, 5	    # Pedimos un entero.
syscall

jr $ra			  # Vuelve al programa principal.

# Funcion, imprime un entenro.
printInt: 
li $v0, 1     # Función imprimir.
syscall       # Escribe el valor de $a0.

jr $ra        # Vuelve al programa principal.

# Sale del programa.
exit: 
li $v0, 10
syscall

