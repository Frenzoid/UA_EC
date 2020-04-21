# Cuestion 11.

# Modifica la rutina de tratamiento de interrupciones para que escriba en el
#  display del transmisor el carácter leído en el receptor. Haz que guarde en el
#  registro $v0 el carácter leído. Escribe un programa principal apropiado para
#  hacer pruebas que finalice cuando en el receptor se pulse un salto de línea.


# Reserva de espacio para guardar registros en kdata
.kdata
contexto: .word 0,0,0,0    # espacio para alojar cuatro registros

.ktext 0x80000180          # Dirección de comienzo de la rutina

# Guardar registros a utilizar en la rutina.
la $k1, contexto
sw $at, 0($k1)             # Guardamos $at
sw $t0, 4($k1)
sw $v0, 8($k1)
sw $a0, 12($k1)

# Comprobación de si se trata de una interrupción, si no lo es acabamos.
mfc0 $k0, $13             # Registro Cause
srl $a0, $k0, 2           # Extraemos campo del c�digo
andi $a0, $a0, 0x1f
bne $a0, $zero, acabamos  # S�lo procesamos aqu� E/S

# Tratamiento de la interrupción 
li $t0, 0xffff0000        # Registro de control del teclado
lb $a0, 4($t0)            # Lee carácter del teclado
beq $a0, $s1, exit
sw $a0, 12($t0) 	        # Escribe en la consola

# Antes de acabar se podría dejar todo iniciado:
acabamos: mtc0 $0, $13    # Iniciar registro Cause
mfc0 $k0, $12             # Leer registre Status
andi $k0, 0xfffd          # Iniciar bit de excepción
ori  $k0, 0x11            # Habilitar interrupciones
mtc0 $k0, $12             # reescribir registre Startus

# Restaurar registros
lw $at, 0($k1)            # Recupero $at
lw $t0, 4($k1)
lw $v0, 8($k1)
lw $a0, 12($k1)

# Devolver en el programa de usuario
eret

.text
li $s1, '\n'      # Codigo ascii de retorno de carro

lui $t0, 0xffff 	# Dirige del registro de control
lw $t1, 0($t0) 		# Registre de control del receptor
ori $t1, $t1, 0x0002 	# Habilitar interrupciones del teclado
sw $t1, 0($t0) 		# Actualizamos registro de control

mfc0 $a0, $12 		# leer registre Status
ori $a0, 0xff11 	# Habilitar todas las interrupciones
mtc0 $a0, $12 		# reescribir el registro status

bucle:

jal bucle

exit:
li $v0, 10
syscall # syscall 10 (exit)

