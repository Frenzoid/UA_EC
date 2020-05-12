# 2. Realiza un programa que solicite al usuario que introduzca un número y nos muestre por pantalla la siguiente información:

# Los datos del número en el estándar IEEE754 de simple precisión son:
# Signo:
# Mantisa:
# Exponente:


.data
mensajePrincipal: .asciiz "Los datos del número en el estándar IEEE754 de simple precisión son: \n"
mensajeSigno:     .asciiz "\nSigno: "
mensajeMantisa:   .asciiz "\nMantisa: "
mensajeExponente: .asciiz "\nExponente: "

mmask: .word 0x007FFFFF
emask: .word 0x7F800000
smask: .word 0x80000000

.text
jal printmensajePrincipal
jal readInt
move $t1, $v0
mtc1 $t1, $f4
cvt.s.w $f4, $f4
mfc1 $t1, $f4

lw $s1, mmask # mascara Matisa
lw $s2, emask # mascara Exponente
lw $s3, smask # mascara Signo

and $t2, $t1, $s1 # Matisa
and $t3, $t1, $s2 # Exponente
and $t4, $t1, $s3 # Signo

jal printmensajeSigno
move $a0, $t4 # Signo
jal printBin

jal printmensajeMantisa
move $a0, $t2 # Matisa
jal printBin

jal printmensajeExponente
move $a0, $t3 # Exponente
jal printBin

jal exit

#############
# Funciones #
#############
# Funcion imprime numero entero en binario
printBin:
la $v0, 35
syscall
jr $ra

# Funcion imprime un mensaje, mensajeSigno
printmensajeSigno:
la $a0, mensajeSigno
li $v0, 4
syscall
jr $ra

# Funcion imprime un mensaje, mensajeMantisa
printmensajeMantisa:
la $a0, mensajeMantisa
li $v0, 4
syscall
jr $ra

# Funcion imprime un mensaje, mensajeExponente
printmensajeExponente:
la $a0, mensajeExponente
li $v0, 4
syscall
jr $ra

# Funcion imprime un mensaje, mensajePrincipal
printmensajePrincipal:
la $a0, mensajePrincipal
li $v0, 4
syscall
jr $ra

# Funcion lee un entero.
readInt: 
li $a0, '>'	# Ponemos un caracter para que el usuario sepa que estamos esperando un numero de entrada.
li $v0, 11
syscall
li $v0, 5		# Pedimos un entero
syscall
jr $ra			# Vuelve al programa principal

# Sale del programa
exit:
li $v0, 10
syscall
