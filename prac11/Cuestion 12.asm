# Cuestión 12

# Escribe una rutina general de tratamiento de excepciones que permita tratar
#  excepciones por desbordamiento aritmético, error por lectura al intentar el
#  acceso a una dirección no alineada e interrupciones de teclado. En los tres casos
#  se tiene que escribir un mensaje en la consola del MARS de la excepción
#  tratada. Escribe el programa de prueba apropiado para probar los tres casos.

.kdata
registros: .word 0, 0, 0, 0 # Espacio para guardar 4 registros
mis1:.asciiz "\nExcepción dirección erronea ocurrida en la dirección: "
mis2:.asciiz "\nExcepción desbordamiento ocurrida en la dirección: "
mis3:.asciiz "\nInterrupcion detectada, caracter: "

.ktext 0x80000180     # Dirección de comienzo de la rutina
# Salvar los registros a utilizar
la $k1, registros
sw $at, 0($k1)
sw $t0, 4($k1)
sw $v0, 8($k1)
sw $a0, 12($k1)

mfc0 $a0, $13         # $a0 <= registro Cause
andi $a0, $a0, 0x3C   # extraemos en $a0 el código de excepción

# Detectamos sólo dos excpcions
li $s0, 0x0030        # código Desbordamiento
li $s1, 0X0010        # código error de dirección load

beq $a0, $s0, Desbordo
beq $a0, $s1, Lectura
beq $a0, $zero, Interrupcion

# Excepcion Lectura.
Lectura:
la $a0, mis1
li $v0, 4
syscall

mfc0 $a0, $14         # $a0 <= EPC, donde ha ocurrido la excepción
li $v0, 34
syscall               # Escribimos EPC en hexadecimal

j FinExcepcion


# Excepcion Desbordo.
Desbordo:
la $a0, mis2
li $v0, 4
syscall

mfc0 $a0, $14         # $a0 <= EPC, donde ha ocurrido la excepción
li $v0, 34
syscall               # Escribimos EPC en hexadecimal

j FinExcepcion
 

# Interrupcion teclado.
Interrupcion:
la $a0, mis3
li $v0, 4
syscall

li $t0, 0xffff0000
lb $a0, 4($t0)        # Escribimos la tecla que se ha pulsado
li $v0, 11
syscall

j FinInterrupcion


# Iniciamos registro Vaddr del coprocesador 0
mtc0 $zero, $8

FinExcepcion:
# Restauramos los registros
la $k1, registros
lw $at, 0($k1)
lw $t0, 4($k1)
lw $v0, 8($k1)
lw $a0, 12($k1)

#Iniciamos registro Vaddr del coprocesador 0
mtc0 $zero, $8 

# Cómo se trata de excepciones se actualiza el registro EPC
mfc0 $k0, $14       # $k0 <= EPC
addiu $k0, $k0, 4   # Incremento de $k0 en 4
mtc0 $k0, $14       # Ahora EPC apunta a la siguiente instrucción

eret                # Vuelve al programa de usuario

FinInterrupcion:
# Restauramos los registros
la $k1, registros
lw $at, 0($k1)
lw $t0, 4($k1)
lw $v0, 8($k1)
lw $a0, 12($k1)

mtc0 $0, $13              # Iniciar registro Cause
mfc0 $k0, $12             # Leer registre Status
andi $k0, 0xfffd          # Iniciar bit de excepción
ori  $k0, 0x11            # Habilitar interrupciones
mtc0 $k0, $12             # reescribir registre Startus

eret                      # Vuelve al programa de usuario

.text

lui $t0, 0xffff 	# Dirige del registro de control
lw $t1, 0($t0) 		# Registre de control del receptor
ori $t1, $t1, 0x0002 	# Habilitar interrupciones del teclado
sw $t1, 0($t0) 		# Actualizamos registro de control

mfc0 $a0, $12 		# leer registre Status
ori $a0, 0xff11 	# Habilitar todas las interrupciones
mtc0 $a0, $12 		# reescribir el registro status

# Desbordo
li $t0, 0x7FFFFFFF
addi $t2, $t0, 1 #Detecta el desbordamiento

# Lecutra
li $t0, 0xFFFFFFFF
lw $t1, 0($t0)

# Iterrupcion teclado
bucle:

jal bucle

exit:
li $v0, 10
syscall # syscall 10 (exit)
