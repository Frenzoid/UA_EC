# 1. Realiza  un  programa  que  solicite  la  lectura  de una  cadena  de  caracteres  por teclado  que  almacenará  a  partir  de  la  posición de  memoria  0x10010000.

# La cadena  deberá  de  tener  como  mínimo  4  caracteres  y  como  máximo  20 caracteres.

# En caso de que no se cumpla dicha especificación el programa deberá informar al usuario para que introduzca una cadena valida.

# A  continuación  el  programa  solicitará  al  usuario  que  escriba  un único caráctermediante el siguiente mensaje "Introduce  el caráctera  buscar  en  la  cadena: ".

# Una vez introducido el carácterse solicitará al usuario que verifique si es correcto o no.

# En caso de no ser correcto se volverá a solicitar y si es correcto el programa nos mostrará un mensaje indicando el númerode veces
#  que  se  repite  dicho carácter en la cadena introducida y finalizará.



.data 0x10010000
cadena: .space 20
mensajePideStr: .asciiz "Introduce la palabra (4 - 20 caracteres): "
mensajePideChr: .asciiz "Introduce el caráctera buscar en la cadena: "
mensajePregunta:.asciiz "\nEs el caracter introducido correcto? S/N: "
mensajeContado: .asciiz "\nEl numero de veces que se repite el caracter es de: "
mensajeError:   .asciiz "\nEl numero minimo de caracteres es 4."

.text
main:

beqz $s1, pideStr
jal printmensajeError

pideStr:
jal printmensajePideStr
jal readString
la $t9, cadena
lb $t1, 4($t9)
beqz $t1, main

jal printmensajePideChr
jal readChar
move $t2, $v0

jal printmensajePregunta
jal readChar
move $t3, $v0
li  $s2, 'N'
beq $s2, $t3, pideStr

li $t4, 20
li $t5, 0
countChars:
  lbu $t6, 0($t9)
  beq $t6, $t2, sum
  j continue
  sum:
    addiu $t5, $t5, 1 # Sumador (contador del caracter)
  continue:
  subiu $t4, $t4, 1 # Contador del bucle
  addi $t9, $t9, 1  # Registro
bnez $t4, countChars

jal printmensajeContado
move $a0, $t5
jal printInt
jal exit


################# Funciones ##################
printmensajeContado:
la $a0, mensajeContado
li $v0, 4
syscall
jr $ra


# Funcion imprime un mensaje, mensajePregunta
printmensajePregunta:
la $a0, mensajePregunta
li $v0, 4
syscall
jr $ra


# Funcion imprime un mensaje, mensajePideChr
printmensajePideChr:
la $a0, mensajePideChr
li $v0, 4
syscall
jr $ra

# Funcion imprime un mensaje, mensajeError
printmensajeError:
la $a0, mensajeError
li $v0, 4
syscall
jr $ra

# Funcion imprime un mensaje, mensajePideStr
printmensajePideStr:
la $a0, mensajePideStr
li $v0, 4
syscall
jr $ra

# Funcion, lee un string
readString:
li $v0, 8       # pide un string
la $a0, cadena  # carga la direccion desde donde se guardará el string en memoria
li $a1, 20      # especificamos el numero maximo de caracteres.
move $t0, $a0   # guarda el string a t0
syscall
jr $ra

# Funcion, lee un caracter
readChar:
li $v0, 12 # funcion leer caracter
syscall    # Lee un caracter a $v0
jr $ra     # Vuelve al programa principal

# Sale del programa
exit:
li $v0, 10
syscall

# Funcion, imprime un entenro
printInt:
li $v0, 1  # Función imprimir
syscall    # Escribe el valor de $a0
jr $ra     # Vuelve al programa principal
