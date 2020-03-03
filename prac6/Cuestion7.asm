# Cuestion 7.

# Escribe el código que lee cuatro enteros del teclado. Para ello deberás mostrar dos
# mensajes por la consola: uno que pida al usuario que introduzca el primer valor
# y tras haberlo leído que muestre otro solicitando el segundo valor. Los datos se
# almacenarán en posiciones consecutivas de la memoria, para lo cual debes haber
# reservado previamente espacio en el segmento de datos con la directiva .space.
# A continuación el programa leerá los valores guardados en la memoria y los
# mostrará en la pantalla.

#########################
#         DATOS         #
#########################

.data       # Especificamos que queremos empezar a manipular datos para empezar desde el segmeto de datos.
A: .space 4 # Numero 1.
B: .space 4 # Numero 2.
C: .space 4 # Numero 3.
D: .space 4 # Numero 4.

GREETER: .asciiz "Dime un numero\n" # String para pedir un numero

#########################
#     INSTRUCCIONES     #
#########################

.text       # Especificamos que queremos empezar a manipular instrucciones para empezar desde el segmeto de instrucciones.

# Pedimos los numeros y los guardamos en memoria.
jal setLoopStarters   # Setea el contador y el puntero a su valor original para vover a reutilizarlo.

BucleWhilePedir: jal readInt # Pedimos el entero
move $t2, $v0         # Movemos el entero a nuestro registro
sw $t2, 0($t1)        # Guardamose el valor del registro a la memoria

jal continueLoops     # Funcion que se encarga de continuar el bucle y la iteracion sobre el puntero.

bne $t7, 1, BucleWhilePedir		# Vuelve a iterar si $t7 != 1 



# Mostramos los numeros desde la memoria
jal setLoopStarters   # Setea el contador y el puntero a su valor original para vover a reutilizarlo.

BucleWhileMostrar: lw $a0, 0($t1)        # Cargamos el valor del byte a $a para mostrarlo.

jal printInt          # Imprimimos el numero
jal printSpace        # Imprimimos un espacio

jal continueLoops     # Funcion que se encarga de continuar el bucle y la iteracion sobre el puntero.

bne $t7, 1, BucleWhileMostrar		# Vuelve a iterar si $t7 != 1 


# Salimos el programa
jal exit



############################
#        Funciones         #
############################

# Esta función contiene las partes compartidas de ambos bulces, la logica para decrementar el contador,
#   avanzar a la siguiente posición de memoria (siguiente numero)
continueLoops: addi $t1, $t1, 4      # Cambiamos el valor del puntero para acceder al siguiente byte en la siguiente iteración

seq $t7, $t0, $zero   # Si el contador es 0, guarda 1 en $t7, 0 si no es igual a 0.

subi $t0, $t0, 1			# Decrementamos el contador

jr $ra			# Vuelve al programa principal



# Setteamos los contadores y la primera posición de memoria
setLoopStarters: li $t0, 3   # Cantidad de veces que queremos pedir/mostrar un número contado desde 0
la $t1, A   # $t0 = Dir Mem A

jr $ra			# Vuelve al programa principal


# Funcion lee un entero mostrando la petición.
readInt: la $a0, GREETER
li $v0, 4
syscall

li $v0, 5		# Pedimos un entero
syscall

jr $ra			# Vuelve al programa principal


# Funcion que imprime un espacio
printSpace: li $a0, ' '
li $v0, 11
syscall

jr $ra


# Funcion, imprime un entenro
printInt: li $v0, 1     # Función imprimir
syscall                 # Escribe el valor de $a0

jr $ra                  # Vuelve al programa principal


# Sale del programa
exit: li $v0, 10
syscall

