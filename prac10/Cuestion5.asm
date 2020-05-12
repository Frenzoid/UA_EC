#######################################
#                                     #
# Código de partida de la cuestión 5  #
#          print string               #
#                                     #
#######################################
# Complétalo escribiendo la función read_string. Esta función tiene que leer del
#  teclado la cadena de caracteres que introduzca el usuario y tiene que almacenarla
#  en un buffer denominado cadena. La cadena finaliza cuando el usuario teclee un
#  salto de línea. Posteriormente el programa muestra la cadena en la consola. Al
#  escribir la función read_string no olvidéis meter en el buffer el carácter de salto
#  de línea.

.data
cadena: .space 32
.eqv ControlTeclado 0
.eqv BufferTeclado 4
.eqv ControlDisplay 8
.eqv BufferDisplay 12

.text
jal setInitialValues
jal read_string
jal print_string

jal exit

###################################
#             SECCIONES           #
###################################
setInitialValues:
la $s0, 0xFFFF0000      # Direcciones de inicio de E/S
li $s1, '\n'            # Codigo ascii de retorno de carro
jr $ra

####################################
#             Funcions             #
####################################

# Funcion lee una cadena desde el teclado (en vivo) y lo imprime por el display.
read_string:
lui $s0, 0xffff                   # Direc. del registro de control del teclado.
li $s1, '\n'                      # Codigo ascii de retorno de carro
la $t2, cadena                    # cadena: .space 32
r_sync:                           # Revisamos cuando tenemos un caracter leeido.
  lw   $t1, ControlTeclado($s0)
  andi $t1, $t1, 1                # Si se ha leeido, el bit estará a 1, comprobamos, si no es así, volvemos a comprobar.
beqz $t1, r_sync
  lw   $t1, BufferTeclado($s0)    # Obtenemos el caracter.
  beq  $t1, $s1, r_final          # Comprobamos si es INTRO (\n), si lo es, salimos.
  sb   $t1, 0($t2)                # Guardamos en nuestra variable.
  addi $t2, $t2, 1                # Aumentamos el salto de registro para concatenar el siguiente caracter.
j r_sync
r_final:
jr $ra


# Funcion imprime una cadena desde desde memoria y lo imprime por el display.
print_string:
lui $s0, 0xffff                   # Direc. del registro de control del teclado.
li $s1, '\n'                      # Codigo ascii de retorno de carro
la $t2, cadena                    # cadena: .space 32
w_sync:                           # Revisamos cuando tenemos un caracter leeido.
  lw   $t1, ControlDisplay($s0)
  andi $t1, $t1, 1                # Si se ha leeido, el bit estará a 1, comprobamos, si no es así, volvemos a comprobar.
beqz $t1, w_sync
  lbu  $t1, 0($t2)                # Cargamos el bite desde memoria en $t1 (unsigned).
  beqz $t1, w_final               # Si lo leeido es de valor 0 (fin de la frase), salimos.
  sb   $t1, BufferDisplay($s0)    # Cargamos lo leeido en el display.
  addi $t2, $t2, 1                # Pasamos a la siguiente posición para lee el siguiente caracter en la siguiente iteracion.
j w_sync
w_final:
jr $ra


exit:
li  $v0, 10
syscall
