#######################################
#                                     #
# Código de partida de la cuestión 5  #
#                                     #
#######################################

#########################
#         DATOS         #
#########################
.data
Xpide: .asciiz "X = "
Npide: .asciiz "n = "
powRes: .asciiz "X^n = "

#########################
#     INSTRUCCIONES     #
#########################
.text
jal xpide
jal npide

mov.s $f12, $f0
mov.s $f14, $f0
move  $a0, $v0

jal pow

mov.s $f12, $f0

jal printResult

jal exit


############################
#        FUNCIONES         #
############################
# Funcion pow(num, exp)
pow:
  # C O M P L E T A R
  # Usamos el valor de la potencia recibida como contador, y multiplicamos por cada iteraci�n.
  subi $a0, $a0, 1
  beqz $a0, powCondionalExitOne		# En caso de que la potencia sea 1, o haya llegado a 1, salimos.
  bltz $a0, powCondionalExitZero	# En caso de que la potencia se 0, devolvemos 1.
   
  mul.s $f14, $f14, $f12		# Hacemos la multiplicación de x*x 
bnez $a0, pow				        # Mientras que no sea 0, continua multiplicando.

powCondionalExitZero:
li $s0, 1				      # Cargamos un 1 en nuestro registro.
mtc1 $s0, $f14				# Movemos el valor a $f14
cvt.s.w $f14, $f14

powCondionalExitOne:	# Fin condicional, si la potencia a procesar era 1.
mov.s $f0, $f14				# Movemos el resultado a $f0.

jr $ra				


# Pide el numero flotante.
xpide:
la $a0, Xpide
li $v0, 4
syscall
li $v0, 6
syscall

jr $ra

# Pide la potencia.
npide:
la $a0, Npide
li $v0, 4
syscall
li $v0, 5
syscall

jr $ra

# Imprime el resultado.
printResult:
la $a0, powRes
li $v0, 4
syscall

li $v0, 2
syscall

jr $ra

# Cierra el programa.
exit: li $v0, 10
syscall
