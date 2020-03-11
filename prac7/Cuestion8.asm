# Escribe el  código  que  calcula  la  suma  de  los  elementos  de  la  diagonal principal  
# de  una  matriz  4x4  de  valores  enteros  introducida  por  teclado. Muestra la suma por pantalla.

# Anyadidos. 
# Decir al usuario que fila / columna se esta introduciendo
# Mostrar la matriz una vez completada
# Preguntar si es correcta, si es asi, haz el calculo, si no, vuelve a pedir datos. (S/N)
# una vez mostrado el calculo, preguntamos al usuario si quiere hacer alguna otra operacion mas? (S/N).
####################################

####################################
#
# Primero, vamos a ver de que maneras podemos hacer la logica de la matriz, ya que es lo unico más "groso" del ejercicio.
# Manera 1: 2 bucles, uno para iterar sobre las columnas y otro sobre filas.
# Manera 2: 1 bucle,  que itere sobre 16 posiciones, y separamos las columnas en multiplos de 4 empezando desde 1
#
# La manera 2 parece ser la más optima, pero tambien la más tediosa, de todos modos, parece interesante, lo hare
#    usando la manera 2.
#
#
# Ahora.. como lo implementamos? (20min más tarde) Pues de la siguiente manera.
#
#  0 / 4 = 0  <-  0 | [ 3][ 2][ 1][ 0]
#  4 / 4 = 1  <-  4 | [ 7][ 6][ 5][ 4]
#  8 / 4 = 2  <-  8 | [11][#Y][ 9][ 8]
# 12 / 4 = 3  <- 12 | [15][14][13][12]
# 
# X = Columna  (desde 0 - 3)
# Y = Iterador (desde 0 - 15)
# Divisor = 4
#
# Ejemplo:
#
#    Posicion de la matriz: 10
#
#    Y = 10, X = 10 / Divisor
#    Entonces, Columna = X + 1 = 3
#              Fila    = Y - (X * 4) + 1 = 3
#
#
# Contador de fila a mostrar al usuario    = X + 1
# Contador de columna a mostrar al usuario = Y - (X * 4) + 1
#
# Adicional, al hacer la matriz, si la hacemos de bytes, podemos usar el propio contador del bucle
# para realizar los saltos de registro a registro, y ahorrarnos más registros.
##################################

#########################
#         DATOS         #
#########################

.data           # Especificamos que queremos empezar a manipular datos para empezar desde el segmeto de datos.ç

#   Nums  #
MAT: .space 16     # Reservamos la matriz.
DIVISOR: .byte 4   # Numero bytes de salto (para dividir el contador).
MATSIZE: .byte 16  # Numero total de posiciones.

# Strings #
# Strings para pedir los datos
DEMANDNUM0: .asciiz "Inserte el numero de la fila ("
ROWMAT: .space 1
DEMANDNUM1: .asciiz ") columna ("
COLMAT: .space 1
DEMANDNUM2: .asciiz "): "

# String para pregunar si la matriz es la correcta
ISMATCORRECT: .asciiz "Es esta la matriz que esperabas?\n( [S]i o [Cualquier caracter] / [N]o ): "

# String para pregunar si quiere continuar o no.
CONTINUE: .asciiz "Quieres dar por finalizada esta tarea?\n( [S]i o [Cualquier caracter] / [N]o ): "

# Strings separadores (para separar los numeros a la hora de mostrar los numeros a sumar).
SEPARATORNUM: .asciiz " + "
SEPARATORRES: .asciiz " = "


#########################
#     INSTRUCCIONES     #
#########################

.text         # Especificamos que queremos empezar a manipular instrucciones para empezar desde el segmeto de instrucciones.

# $s0 = @ROWMAT, $s1 = @COLMAT, $s2 = @MATSIZE, $s3 = *MATSIZE ...... Valores iniciales.
jal setInitialValues

# Inicio del programa.
main:

# Seteamos los contadores a 0.
jal resetCountersAndMatAccess

# Iniciamos el bucle para pedir los datos y ir guardandolos en memoria.
readMatLoop:
  jal updateUserCounters        # Actualizamos el contador que mostramos por pantala.
  bne $t9, $s4, skipNewLineR    # Si el valor del contador de columna del usuario es 1, imprime una linea para separar.

  jal printCharNewline          # Imprime una linea
  skipNewLineR:                

  jal readInt                   # Pide el numero para una posicion de la matriz
  jal saveMatSlot               # Guarda el numero en la posicion de memoria.
  jal incrementMatCounterNormal # Incrementa el contador, y salta al siguiente registro.
blt $t0, $s3, readMatLoop       # Si el contador es menor que la cantidad de posicines de la matriz, continua.

jal resetCountersAndMatAccess

# Iniciamos el bucle para mostrar la matriz desde memoria.
printMatLoop:
  jal updateUserCounters

  bne $t9, $s4, skipNewLineP
  jal printCharNewline
  skipNewLineP:

  jal loadMatSlot             # Pedimos el valor de la posicion $t0 (registro $t1) de la matriz desde memoria.
  move $a0, $v0               # movemos el dato desde $v0 a $a0 para mostrarlo.
  jal printInt                # Imprimimos el dato.
  jal printCharTab            # Imprimimos un espaciado (tabulador).
  jal incrementMatCounterNormal
blt $t0, $s3, printMatLoop

jal resetCountersAndMatAccess

# Preguntamos si la matriz es la correcta
jal printCharNewline

la $a0, ISMATCORRECT          # Cargamos el mensaje
jal printStr                  # Mostramos el mensaje
jal readChar                  # Pedimos un caracter

beq $v0, $s5, main            # Si el caracter perdido es "N", entonces, vuleve a pedir la matriz, si es cualquier otra cosa, continua.

# Iniciamos el bucle para sumar y mostrar la diagonal
sumMatDiag:
  jal updateUserCounters
  jal loadMatSlot
  move $a0, $v0

  add $t3, $t3, $a0           # Hacemos la suma mediante vamos iterando por el bucle
  jal printInt                # Y a la vez vamos mostrando el valor de cada diagonal.
  beq $t8, $s7, skipFancy

  fancy:
  la $a0, SEPARATORNUM        # Ponemos un separador entre los numeros para que quede mas bonito
  jal printStr
  
  skipFancy:
  jal incrementMatCounterX4add1
blt $t0, $s3, sumMatDiag

la $a0, SEPARATORRES          # Ponemos un separador entre los  y el resultado para que quede mas bonito.
jal printStr

move $a0, $t3                 # Mostramos la suma.
jal printInt

jal printCharNewline

la $a0, CONTINUE              # Preguntamos al usuario si quiere continuar.
jal printStr
jal readChar
beq $v0, $s5, main            # Si el caracter perdido es "N", entonces, vuleve a pedir la matriz, si es cualquier otra cosa, continua.

jal exit                      # Salimos del programa

############################
#        SECCIONES         #
############################

# Las secciones serán funciones que tendrán influencia directa sobre la lógica principal del programa.

# Nos guardamos la direccion / valores de los registros que usaremos después etc etc.
setInitialValues:
la $s0, ROWMAT  # Direccion de memoria del contador de fila para mostrar al usuario.
la $s1, COLMAT  # Direccion de memoria del contador de columna para mostrar al usuario.
la $s2, MATSIZE # Direccion de memoria de inicio de la matriz.
lb $s3, 0($s2)  # Valor del tamaño de la matriz.
li $s4, 1       # Valor que usaremos para comparar si estamos en la columna 1. ($9 == $s1).
li $s5, 'N'     # Valor para comprar si ha escrito N.
la $s6, DIVISOR # Direccion de memoria del Divisor.
lb $s7, 0($s6)  # Valor del divisor (4).
li $t3, 0       # Regisitro que usaremos para hacer la suma de la diagonal.
jr $ra			    # Vuelve al programa principal.

# Funcion que resetea los contadores del bucle y el registro origen de la matriz.
resetCountersAndMatAccess:
li $t0, 0
la $t1, MAT
jr $ra			      # Vuelve al programa principal

# Incrementa el contador $t0 y registro $t1
incrementMatCounterNormal:
add $t0, $t0, 1
la  $t1, MAT      # $t1 = Posicion de registro.
add $t1, $t1, $t0 # $t1 = Posicion de registro + salto del contador.
jr  $ra			      # Vuelve al programa principal

# Incrementa el contador y el registro de 4 + 1 en 4 + 1 para acceder justo a la diagonal.
incrementMatCounterX4add1:
add $t0, $t0, $s7
add $t0, $t0, 1
la  $t1, MAT      # $t1 = Posicion de registro.
add $t1, $t1, $t0 # $t1 = Posicion de registro + salto del contador.
jr  $ra			      # Vuelve al programa principal

# Guarda en memoria el valor leeido en la posicion $t1.
saveMatSlot:
sb $v0, 0($t1)
jr $ra			      # Vuelve al programa principal

# Retorna un valor de la matriz desde memoria de la posicion $t1.
loadMatSlot:
lb $v0, 0($t1)
jr $ra			      # Vuelve al programa principal

# Actualiza el valor del contador para ROWMAT y COLMAT.
updateUserCounters:
div		$t0, $s7 # Y / 4 = X
mflo	$t8      # val de X

mult	$t8, $s7 # X * 4
mflo	$t9      # Val de Y sin procesar

sub		$t9, $t0, $t9 # Y = Y - (X * 4)

addi  $t8, $t8, 1 # X = X + 1 
addi  $t9, $t9, 1 # Y = Y + 1 

sb    $t8, 0($s0) # ROWMAT
sb    $t9, 0($s1) # COLMAT

jr $ra			# Vuelve al programa principal

############################
#        FUNCIONES         #
############################

# Funcion lee un entero mostrando la petición.
readInt:
la $a0, DEMANDNUM0  # Mostramos la primera parte del mensaje
li $v0, 4
syscall

lb $a0, 0($s0)      # Mostramos de la fila del contador de usuario 
li $v0, 1
syscall  

la $a0, DEMANDNUM1  # Mostramos la segunda parte del mensaje 
li $v0, 4
syscall

lb $a0, 0($s1)      # Mostramos de la columna del contador de usuario 
li $v0, 1
syscall  

la $a0, DEMANDNUM2  # Mostamos el final del mensaje
li $v0, 4
syscall

li $v0, 5	 # Pedimos un entero
syscall

jr $ra		 # Vuelve al programa principal

# Funcion, lee un caracter
readChar:
li $v0, 12 # funcion leer caracter
syscall    # Lee un caracter a $v0

jr $ra     # Vuelve al programa principal

# Funcion, imprime un string
printStr:
li $v0, 4  # funcion imprime un string
syscall    # Lee un caracter a $v0

jr $ra     # Vuelve al programa principal

# Funcion, imprime un entenro
printInt:
li $v0, 1  # Función imprimir
syscall    # Escribe el valor de $a0

jr $ra     # Vuelve al programa principal

# Funcion, imprime un espaciador (tabulador)
printCharTab:
li $a0, '\t'
li $v0, 11
syscall

jr $ra

# Funcion, imprime un entero
printCharNewline:
li $a0, '\n'
li $v0, 11
syscall

jr $ra

# Sale del programa
exit:
li $v0, 10
syscall
