# 1. Realiza  un  programa  que  solicite  la  lectura  de  dos  números  por  teclado,  los almacene  en  las  posiciones  de  memoria  0x10010004  y  0x1001000C.
# Dicho programa  determinara  cuál  de  los  números  es  menor,  lo  almacenara  en  la posición  0x10010014. 
# Posteriormente  multiplicará  el  primer  número por  30 (utilizando  instrucciones  de  desplazamiento)  y  lo  almacenará  en  la  posición 0x10010005.
# Para finalizar,sobre el segundo número cambiaremos ceros por unos y unos por ceros y lo guardaremos en la posición 0x1001000D.

# Recordatorio
# V = retorno
# A = entrada
##############

.text
# CODIGO #

# Numero 1
jal readInt
la  $t0, 0x10010004
move $t1, $v0 # $t1 num1
sw  $v0, 0($t0)


# Numero 2
jal readInt
la  $t0, 0x1001000C # $t0 direcciones en memoria.
move $t2, $v0 # $t2 num2
sw  $v0, 0($t0)

la $t0, 0x10010014 # $t0 = dir en memoria del que será el menor.


# Cual es menor.
ble $t1, $t2, menor	# if $t1 <= $t2 then menor
  sw $t2 0($t0)
menor:
  sw $t1 0($t0)


# Multiplica num1 x 30
move $a0, $t1
jal x30
la $t0, 0x10010005
sw $v0, 0($t0) # Y lo guardamos.

# Intercambio de num2 0 <-> 1.
la $t0, 0x1001000D
move $a0, $v0
jal num2InversFun
sw $v0, 0($t0)
jal exit
# FUNCIONES #

# Funcion de intercambio
num2InversFun:
xor $a0, $v0, $v0
jr $ra

# Función multiplica por 30
x30:
sll $t1, $a0, 5		# Multiplicamos el valor por 32 y lo guardamos en $t1
sll $t2, $a0, 1		# Multiplicamos el valor por 2 y lo guardamos en $t2

sub $v0, $t1, $t2	# Restamos $t1 - $t2 y lo devolvemos a $v0 = x30
    
jr $ra

# Funcion lee un entero.
readInt: li $a0, '>'	# Ponemos un caracter para que el usuario sepa que estamos esperando un numero de entrada.
li $v0, 11
syscall			

li $v0, 5		# Pedimos un entero
syscall

jr $ra			# Vuelve al programa principal

# Sale del programa
exit:
li $v0, 10
syscall

