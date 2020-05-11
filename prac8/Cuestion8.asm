#######################################
#                                     #
# Código de partida de la cuestión 8  #
#                                     #
#######################################
# Haz el código que suma los elementos del vector y calcula el valor medio en coma
#  flotante. Muestra el resultado por la consola.

#########################
#         DATOS         #
#########################
.data

array: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

#########################
#     INSTRUCCIONES     #
#########################
.text

jal setInitialValues


# Bucle que trae de memoria, convierte a flotante y suma en flotante.
addAllAndConvert:

 jal moveAndConvert

 jal addAll

 jal inctrementRegAndCounter

blt $t2, $s0, addAllAndConvert


jal showMed

jal printF

jal exit


############################
#        SECCIONES         #
############################
# Define unos valores inciales.
setInitialValues:
la $t0, array   # Direccion de memoria del contador del array.
la $t2, 0       # Contador del bucle.

# Constante 10 en flotante para dividir despues.
li    $s0, 10      	# Longitud del array.
mtc1  $s0, $f10 	  # Movemos $s0 a $10, Constante flotante simple, valor del num 10.
cvt.s.w $f10, $f10	# El valor sigue siendo entero, hay que pasarlo a flotante simple.

# Inicializamos $f2 (registro que usaremos para sumar) a 0.
li    $s1, 0      	# 0.
mtc1  $s1, $f2 		  # Movemos $s1 a $2, Constante flotante simple, valor del num 0
cvt.s.w $f2, $f2	  # El valor sigue siendo entero, hay que pasarlo a flotante simple.

jr $ra          # Vuelve al programa principal.

# Incrementa la direccion y el contador.
inctrementRegAndCounter:
add $t2, $t2, 1  # Contador.
add $t0, $t0, 4  # Registro.
jr  $ra          # Vuelve al programa principal.


# Mueve el valor del array, despues lo muveve a un registro flotante, y despues lo convierte.
moveAndConvert:
lw $t3, 0($t0)      # Sacamos el valor de cada dir de memoria.
mtc1 $t3, $f1 		  # $t3 -> $f1.
cvt.s.w $f1, $f1	  # Convertimos el valor entero a simple precision Float
jr  $ra             # Vuelve al programa principal.

# Sumamos por cada iteración.
addAll:
add.s $f2, $f2, $f1
jr   $ra            # Vuelve al programa principal.

# Mostramos la media de la division por la suma.
showMed:
div.s $f12, $f2, $f10
jr   $ra            # Vuelve al programa principal.

############################
#        FUNCIONES         #
############################

# Imprime el valor flotante en $f12.
printF:
li $v0, 2
syscall
jr   $ra         # Vuelve al programa principal.


# Sale del programa
exit:
li $v0, 10
syscall
