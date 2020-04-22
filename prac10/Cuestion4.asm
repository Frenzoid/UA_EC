# Cuestion 4.
# Transforma el programa echo de la cuestión 3 en el programa caps que muestra
#  por la consola la mayúscula del carácter introducido por el teclado. Supón que
#  todos los caracteres introducidos están en minúscula.

#########################
#         DATOS         #
#########################
.data
.eqv ControlTeclado 0  # Constantes.
.eqv BufferTeclado 4
.eqv ControlDisplay 8
.eqv BufferDisplay 12

#########################
#     INSTRUCCIONES     #
#########################
.text
# SELECCIÓN:

jal setInitialValues
lui $t0, 0xffff # Direc. del registro de control del teclado

r_espera:
  lw $t2, ControlTeclado($s0) # Lee registro control del teclado
  andi  $t2, $t2, 1 # SINCRONIZACIÓN: Extrae el bit de ready
beqz $t2, r_espera  # Si cero no hay carácter, continuamos esperando

jal getc

beq $v0, $s1, exit

jal toUppercase

w_espera:
  lw $t1, ControlDisplay($s0) # registro control
  andi $t1, $t1, 1       # SINCRONITZACIÓN: bit de ready Sincroniza
beq $t1, $0, w_espera

jal putc

j r_espera


############################
#        SECCIONES         #
############################

setInitialValues:
la $s0, 0XFFFF0000	# Direcciones de inicio de E/S
li $s1, '\n'        # Codigo ascii de retorno de carro
jr $ra

getc:
lw $v0, BufferTeclado($s0) # Lee registro de datos del teclado, Codigo ascii de tecla guardado en $v0 
jr $ra

putc:
sw $a0, BufferDisplay($s0) # Escribe en la consola
jr $ra

############################
#        FUNCIONES         #
############################


# Pasa un valor entero representando un caracter ASCII a su valor entero mayuscular.
toUppercase:
subi $a0, $v0, 32    # Le restamos 32 para que se convierta en minuscula y lo dejamos en $a0.
jr $ra

# Cerramos el programa
exit:
li $v0, 10           # Función 10. Acaba programa
syscall
