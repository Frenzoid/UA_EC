# Cuestión 16.
# 	Escribe el código que lee un valor entero por teclado y escribe el mismo valor en binario por la consola.

.text 0x00400000

# Pide un entero
add $v0, $zero, 5
syscall 

# Movemos el valor al registro de salido $a0
add $a0, $v0, $zero

# Muestra el numero guardado en $a0 en binario
add $v0, $zero, 35
syscall 

# Salir del programa
addi $v0, $zero, 10 
syscall
