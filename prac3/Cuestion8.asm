# Cuestión 8.
#   Escribe un programa que lea del teclado una letra en mayúscula y la escríba en minúscula en la consola.


# Vale.. vamos a ver que diferencia hay entre las letras
#   mayusculas y las minusculas, y a ver si dicha diferencia es equivalente entre otras letras.

# A = 0x41 | a = 0x61 => 0100 0001 = A > 0110 0001 = a | a - A = 0010 0000 = 0x20 = 32 en decimal
# Z = 0x5A | z = 0x7A => 0101 1010 = Z > 0111 1010 = z | z - A = 0010 0000 = 0x20 = 32 en decimal

# La diferencia entre las minusculas y las mayusculas es de 32 y se mantiene a pesar de la letra,
#     entonces, para pasar de mayuscula a minuscula solo
#     tenemos que sumarle 32 al valor del caracter.
 
li $v0, 12 #Función 12. Read character
syscall    #Carácter leído en $v0

move $t0, $v0        # Carácter a escribir en $t0

li $a0, '\n'	     # Preparamos un salto de linea para que quede mas guapo.
li $v0, 11           # Función 11. Print character
syscall		     # Hacemos un salto de linea.

addi $a0, $t0, 32    # Le sumamos 32 para que se convierta en minuscula y lo dejamos en $a0.

li $v0, 11           # Función 11. Print character
syscall              # Mostramos el caracter en minuscula.

li $v0, 10           # Función 10. Acaba programa
syscall

