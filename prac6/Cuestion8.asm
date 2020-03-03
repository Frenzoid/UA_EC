# Cuestion 7.

# Modifica el programa de la cuestión 7 para que muestre en la pantalla los datos
# guardados en la memoria ordenados de menor a mayor valor

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


# Ordena los numeros de mayor a menor en memoria.
la $s1, A   # $s1 = Dir Mem A
la $s2, B   # $s2 = Dir Mem B
la $s3, C   # $s3 = Dir Mem C
la $s4, D   # $s4 = Dir Mem D

lw $t1, 0($s1)  # $t1 = Val Mem A
lw $t2, 0($s2)  # $t2 = Val Mem B
lw $t4, 0($s4)  # $t3 = Val Mem C
lw $t3, 0($s3)  # $t4 = Val Mem D

# Dios, dime que hay una manera mejor de hacer esto
# Comparamos A y B, si A > B, intercambiamos, si no, pasamos a la siguiente comprobación
cmpAB:
blt $t1, $t2, cmpCD
xor $t1, $t1, $t2 # ($t1) = xor  $t1   $t2 
xor $t2, $t1, $t2 #  $t2  = xor ($t1)  $t2 
xor $t1, $t1, $t2 # ($t1) = xor ($t1) ($t2)

# Comparamos C y D, si C > D, intercambiamos, si no, pasamos a la siguiente comprobación
cmpCD:
blt $t3, $t4, cmpAC
xor $t3, $t3, $t4 # ($t3) = xor  $t3   $t4 
xor $t4, $t3, $t4 #  $t4  = xor ($t3)  $t4 
xor $t3, $t3, $t4 # ($t3) = xor ($t3) ($t4)

# Comparamos A y C, si A > C, intercambiamos, si no, pasamos a la siguiente comprobación
cmpAC:
blt $t1, $t3, cmpBD
xor $t1, $t1, $t3 # ($t1) = xor  $t1   $t3 
xor $t3, $t1, $t3 #  $t3  = xor ($t1)  $t3 
xor $t1, $t1, $t3 # ($t1) = xor ($t1) ($t3)

# Comparamos B y D, si B > D, intercambiamos, si no, pasamos a la siguiente comprobación
cmpBD:
blt $t2, $t3, cmpBC
xor $t4, $t2, $t4 # ($t4) = xor  $t2   $t4 
xor $t2, $t2, $t4 #  $t2  = xor ($t2)  $t4 
xor $t4, $t2, $t4 # ($t4) = xor ($t2) ($t4)

# Comparamos B y C, si B > C, intercambiamos, si no, pasamos a la siguiente comprobación
cmpBC:
blt $t2, $t3, finishSorting
xor $t3, $t3, $t2 # ($t3) = xor  $t3   $t2 
xor $t2, $t3, $t2 #  $t2  = xor ($t3)  $t2 
xor $t3, $t3, $t2 # ($t3) = xor ($t3) ($t2)

# Acabamos guardando en memoria los valores ordenados.
finishSorting:
sw $t1, 0($s1)  # Val Mem A = $t1
sw $t2, 0($s2)  # Val Mem B = $t2
sw $t4, 0($s4)  # Val Mem C = $t3
sw $t3, 0($s3)  # Val Mem D = $t4



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

