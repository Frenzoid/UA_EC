# Recopilación rapida de funciones mayormente usadas.

# Recordatorio
# [$a0], $a1  |  [$f0] , $f1 , $f2 , $f3    = entrada
# [$v0], $v1  |  [$f12], $f13, $f14, $f15   = salida
# $tXX        |  $f4  - $f11 & $f16 - $f19  = Registros temporales.
# $sXX        |  $f20 - $f30                = Registros de guardado.
##############

###############
# Datos clave #
###############

# Teclado
.data
.eqv ControlTeclado 0  # eqv = Constantes.
.eqv BufferTeclado 4
.eqv ControlDisplay 8
.eqv BufferDisplay 12

lui $t0, 0xffff   # Direc. del registro de control del teclado.
lw $v0, BufferTeclado($t0)   # Lee registro de datos del teclado (tecla pulasada).
sw $a0, BufferDisplay($t0)   # Escribe en la consola

#--------------------------------------------------------------Imprime lee
# SELECCIÓN:
lui $t0, 0xffff # Direc. del registro de control del teclado

r_espera:
  lw $t2, ControlTeclado($t0) # Lee registro control del teclado

  # SINCRONIZACIÓN:
  andi  $t2, $t2, 1 # Extrae el bit de ready
beqz $t2, r_espera # Si cero no hay carácter
# Continuamos esperando

# LEEMOS:
jal getc

move $a0, $v0

# SELECCIÓN:
lui $t0, 0xffff # ffff0000;

w_espera:
  lw $t1, ControlDisplay($t0) # registro control

  # SINCRONITZACIÓN
  andi $t1, $t1, 0x0001 # bit de ready Sincroniza
beq $t1, $0, w_espera

# ESCRIBIMOS
jal putc
j r_espera

# F
getc:
lw $v0, BufferTeclado($s0) # Lee registro de datos del teclado, Codigo ascii de tecla guardado en $v0 
jr $ra

putc:
sw $a0, BufferDisplay($s0) # Escribe en la consola
jr $ra
#-----------------------------------------------------------------


#Excepciones
mfc0 $a0, $13         # $a0 <= registro Cause
andi $a0, $a0, 0x3C   # extraemos en $a0 el código de excepción

# Detectamos sólo 3 excpciones
li $s0, 0x0030        # código Desbordamiento
li $s1, 0X0010        # código Error de dirección load
beq $a0, $zero, Interrupcion
beq $a0, $s0,   Desbordo
beq $a0, $s1,   Lectura


#############
# Funciones #
#############

# Funcion, lee un caracter
readChar:
li $a0, '>'	# Ponemos un caracter para que el usuario sepa que estamos esperando un caracter.
li $v0, 11
syscall			
li $v0, 12 # funcion leer caracter
syscall    # Lee un caracter a $v0
jr $ra     # Vuelve al programa principal


# Funcion, imprime un caracter
printCharTab:
li $a0, 'X'
li $v0, 11
syscall
jr $ra


# Funcion, imprime un espaciador (tabulador)
printCharTab:
li $a0, '\t'
li $v0, 11
syscall
jr $ra


# Funcion, imprime una nueva linea
printCharNewline:
li $a0, '\n'
li $v0, 11
syscall


# Funcion imprime un mensaje
printMsg:
la $a0, mensaje
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


# Funcion, imprime un entenro
printInt:
li $v0, 1  # Función imprimir
syscall    # Escribe el valor de $a0
jr $ra     # Vuelve al programa principal


# Funcion, lee un flotante. (valor resultante en $f12)
readFloat:
li $v0, 6
syscall
jr   $ra          # Vuelve al programa principal.


# Funcion, imprime un flotante. (valor a imprimir en $f0)
printFloat:
li $v0, 2
syscall
jr   $ra          # Vuelve al programa principal.

# Función pow(float, int)
pow:
  # Usamos el valor de la potencia recibida como contador, y multiplicamos por cada iteración.
  subi $a0, $a0, 1
  beqz $a0, powCondionalExitOne		# En caso de que la potencia sea 1, o haya llegado a 1, $a0 = 0,   entonces, devolvemos el valor.
  bltz $a0, powCondionalExitZero	# En caso de que la potencia sea 0, $a0 = -1 (por hacer la resta), entonces, devolvemos 1.
  mul.s $f14, $f14, $f12	      	# Hacemos la multiplicación de x*x 
bnez $a0, pow				              # Mientras que no sea 0, continua multiplicando.
powCondionalExitZero:
li $s0, 1				      # Cargamos un 1 en nuestro registro.
mtc1 $s0, $f14				# Movemos el valor a $f14
cvt.s.w $f14, $f14    # Transformamos de entero a flotante simple
powCondionalExitOne:	# Fin condicional, si la potencia a procesar era 1.
mov.s $f0, $f14				# Movemos el resultado a $f0.
jr $ra				


# Funcion Max(float, float).
max:
c.lt.s $f14, $f12
bc1t maxConditionalAssinament1    # Si $f12 es mayor, asignamos $f12 a $f0 (si el bit de comparacion es 1, salta automaticamente)
j maxConditionalAssinament2       # Si no, entonces significa que $f14 es mayor, asignamos $f14 a $f0
maxConditionalAssinament1:        # Asigna $f12 a $f0 
mov.s $f0, $f12
j maxConditionalExitNormal        #    y salta al final de la funcion
maxConditionalAssinament2:        # Asigna $f14 a $f0
mov.s $f0, $f14
maxConditionalExitNormal:         # final de la funcion.
jr $ra


read_string:
li $s1, '\n'                      # Codigo ascii de retorno de carro
la $t2, cadena                    # cadena: .space 32
r_sync:                           # Revisamos cuando tenemos un caracter leeido.
  lw   $t1, ControlTeclado($s0)
  andi $t1, $t1, 1                # Si se ha leeido, el bit estará a 1, comprobamos.
beqz $t1, r_sync
  lw   $t1, BufferTeclado($s0)    # Obtenemos el caracter.
  beq  $t1, $s1, r_final          # Comprobamos si es INTRO (\n)
  sb   $t1, 0($t2)                 # Guardamos en nuestra variable.
  addi $t2, $t2, 1                # Aumentamos el salto de registro para concatenar el siguiente caracter.
j r_sync
r_final:
jr $ra



print_string:
li $s1, '\n'                      # Codigo ascii de retorno de carro
la $t2, cadena                    # cadena: .space 32
w_sync: 
  lw   $t1, ControlDisplay($s0)
  andi $t1, $t1, 1
beqz $t1, w_sync
  lbu  $t1, 0($t2)
  beqz $t1, w_final
  sw   $t1, BufferDisplay($s0)
  addi $t2, $t2, 1
j w_sync
w_final:
jr $ra


# Funcion, invierte bits
invertBits:
xori $v0, $a0, 0xffffffff
jr $ra     # Vuelve al programa principal


# Sale del programa
exit:
li $v0, 10
syscall

