.data 0x10010000
cadena: .space 30
mensajePideStr: .asciiz "\nIntroduce la palabra (3 - 30 caracteres): "
mensajeContadoVocal: .asciiz "\nEl numero de VOCALES MAYUSCULAS es: "
mensajeContadoConso: .asciiz "\nEl numero de CONSONANTES MINUSCULAS es: "
mensajeLongitud: .asciiz "\nLa LONGITUD TOTAL de la cadena introducida es: "
mensajeError:   .asciiz "\nEl numero minimo de caracteres es 3.\n"
mensajeRepetir: .asciiz "\nQuieres volver a ejecutar el programa? Si o No (S/N): \n"

# .asciiz porque así podemos detectar cuando acabar la iteración sobre ellas al comprobar cada letra.
consonantes: .asciiz "bcdfghjklmn�pqrstvwxyz"
vocales: .asciiz "AEIOU"


# Si termina en 4 , 5 y 6 mostrará la cantidad de vocales (mayúsculas) que tiene la cadena, la cantidad de
#  consonantes (minúsculas) que tiene la cadena, así como su longitud.*

.text
main:

beqz $t8, pideStr # Comprobamos si est� a 0, si no esta, es que es la primera vez que se ejecuta el programa
jal printmensajeError

pideStr:
  li $t8, 1	# Steamos el valor de $t8 a 1 para que sale el error
  li $s0, '\n'  # Caracter de salida (para comprobar cuando se acaba de comprobar)
  jal printmensajePideStr
  jal readString

  la $t9, cadena
  lb $t1, 3($t9) # Comprobamos si la 3nda posición en bytes de memoria de nuestra zona reservada está en uso, si no lo est�, es que no ha introducido el minimo.
beqz $t1, main


li $t4, 30  # Contador de caracteres de la cadena
li $t5, 0   # Sumador (contador del consonantes)
li $t6, 0   # Sumador (contador del vocales)

# Bucle que ir� iterando sobre cada caracter introducido.
countChars:
  lbu $t0, 0($t9)
  beq $t0, $s0, finCountChars # Si hemos llegado al final (\n), salimos.

  # Bucles que iterar�n sobre una lista de consonantes y vocales para comprobar si es una vocar mayuscula o consonante.
  jal checkChar
  jal checkVoc

  subiu $t4, $t4, 1   # Contador del bucle
  addi $t9, $t9, 1    # Registro

bnez $t4, countChars    # Si es un caracter, seguimos.
addi $t4, $t4, 1    # quitamos la ultima comporbaci�n

finCountChars:

# Imprimimos la cantidad de consonantes.
jal printmensajeContadoConso
move $a0, $t5
jal printInt

# Imprimimos la cantidad de vocales.
jal printmensajeContadoVoc
move $a0, $t6
jal printInt

# Imprimimos la longitud total de la frase.
jal printmensajeLongitud
li $t0, 30
subu $a0, $t0, $t4
jal printInt

# Reseteamos identificadores para la siguiente ejecucion (en caso de que haya).
jal resetFlags

# Preguntamos al usuario si quiere volver a reejecutar el programa
li $s1, 'S' # Valor que usaremos para saber si el usuario quiere continuar.
jal printmensajeRepetir
jal readChar
beq $v0, $s1 main

jal exit


################# Secciones ##################
# Reseteamos los identificadores para monstrar el mensaje de error.
resetFlags:
li $t8, 0   # Reseteamos el valor de $t0 por si quiere volver a ejecutar el programa.
la $t9, cadena
lb $t8, 3($t9)  # Borramos la 3era posicion de memoria para que la siguiente vez compruebe la longitud correctamente.
jr $ra

# Cuenta las consonantes
checkChar:
  la $t1, consonantes

  checkCharInner:
    lbu $t2, 0($t1)

    beq	$t0, $t2, exitSumChar	
    beqz $t2, exitNotSumChar
    addi $t1, $t1, 1
  j checkCharInner

exitSumChar:
addi $t5, $t5, 1

exitNotSumChar:
jr $ra

# Cuenta las vocales
checkVoc:
  la $t1, vocales

  checkVocInner:
    lbu $t2, 0($t1)

    beq	$t0, $t2, exitSumVoc	
    beqz $t2, exitNotSumVoc
    addi $t1, $t1, 1
  j checkVocInner

exitSumVoc:
addi $t6, $t6, 1

exitNotSumVoc:
jr $ra

############## funciones #############

# Funcion, lee un caracter
readChar:
li $a0, '>'	# Ponemos un caracter para que el usuario sepa que estamos esperando un caracter.
li $v0, 11
syscall
li $v0, 12 # funcion leer caracter
syscall    # Lee un caracter a $v0
jr $ra     # Vuelve al programa principal

# Imprime un mensaje, mensajeRepetir
printmensajeRepetir:
la $a0, mensajeRepetir
li $v0, 4
syscall
jr $ra

# Imprime un mensaje, mensajeLongitud
printmensajeLongitud:
la $a0, mensajeLongitud
li $v0, 4
syscall
jr $ra

# Imprime un mensaje, mensajeContadoConso
printmensajeContadoConso:
la $a0, mensajeContadoConso
li $v0, 4
syscall
jr $ra

# Imprime un mensaje, mensajeContadoVocal
printmensajeContadoVoc:
la $a0, mensajeContadoVocal
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
li $a1, 30      # especificamos el numero maximo de caracteres.
move $t0, $a0   # guarda el string a t0
syscall
jr $ra

# Funcion, imprime un entenro
printInt:
li $v0, 1  # Función imprimir
syscall    # Escribe el valor de $a0
jr $ra     # Vuelve al programa principal

# Sale del programa
exit:
li $v0, 10
syscall
