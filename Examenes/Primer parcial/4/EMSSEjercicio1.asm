# 1.1 Solicite mediante un mensaje la lectura de dos números por teclado, y los almacene    en    las    posiciones    de    memoria
#    (0x10010020    más    un desplazamiento).  El  desplazamiento (en  palabras) será    la  suma  de  los  dos dígitos  de  la  derecha  de  tu  DNI.
# Lo  números  estarán  en  posiciones  de memoria  contiguas de  modo  que  siempre  almacene  en  la  primera  posición válida el mayor de los números
#  y en la siguiente el menor. (2 puntos)

# 1.2 Mediante  el  uso  de  operaciones  lógicas  invertirá  los  16  bits  de  menor peso del primer número y dejará el bit de mayor peso a 
#    almacenando dicho resultado  la  posición  0x10010000.
# Para  finalizar  verificará  si  el  segundo número es múltiplo de 3 y mostrará un mensaje por pantalla indicando si es múltiplo o no. 


.data

strnum1: .asciiz "Dime el primer numero: "
strnum2: .asciiz "Dime el segundo numero: "
EsMultiplo: .asciiz "Es multiplo"
noEsMultiplo: .asciiz "No es multiplo"

.text

# 1.1.
jal askN1
jal readInt
move $t4, $v0 # Numero 1

jal askN2
jal readInt
move $t5, $v0 # Numero 2


la $t0, 0x10010020
li $t7, 4

# DNI: 512548 75 L
li $t1, 5
li $t2, 7


add  $t3, $t1, $t2 # Suma de los numeros del dni
mult $t7, $t3	   	 # $t0 * $t1 = Hi and Lo registers
mflo $t2				 	 # copy Lo to $t2


add  $t0, $t0, $t2 # 0x10010020 + ( desplazamiento de la suma * 4 )
addi $t6, $t0, 4   # 0x10010020 + ( desplazamiento de la suma * 4 ) + 4

ble $t5, $t4, n1Mayor
ble $t4, $t5, n1Menor

n1Mayor:
sw $t4, 0($t0)
sw $t5, 0($t6)

n1Menor:
sw $t4, 0($t6)
sw $t5, 0($t0)


# 1.2
li $t0, 0x10010000

# 32 - 16 = 16, desplazamos para quedarnos solo con los 16 bits de menor peso.
sll $t2, $t4, 16
srl $t2, $t2, 16

xor $t2, $t2, $t2 # Invertimos los 16 bits como pide el enunciado.

# Desplazamos para quedarnos solo con el bit de mayor peso.
srl $t3, $t4, 31
sll $t3, $t4, 31

# Guardamos el bit de mayor peso.
sb $t3, 0($t0)

# Divisor.
li $t1, 3 

# Dividimos, y si es 0, es multiplo.
div     $t5, $t1  	# $t5 / $t1
mfhi	  $t3	

beqz $t3, esMultiplo
la $a0, noEsMultiplo
li $v0, 4
syscall

jal exit

esMultiplo:
la $a0, EsMultiplo
li $v0, 4
syscall

jal exit


# F
askN1:
la $a0, strnum1
li $v0, 4
syscall
jr $ra

askN2:
la $a0, strnum2
li $v0, 4
syscall
jr $ra

readInt:
li $v0, 5
syscall
jr $ra

exit:
li $v0, 10
syscall

