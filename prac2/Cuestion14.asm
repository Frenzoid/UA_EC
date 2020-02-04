# Supón que $t1=0x0000FACE, utilizando únicamente las instrucciones lógicas
# 	de la tabla anterior, escribe el código que reordene los bits de $t1 de manera que
# 	en $t2 aparezca el valor 0x0000CAFE. Ensambla y escribe en la ventana de
# 	registros $t1=0x0000FACE. Ejecuta y comprueba que el código es correcto.

.text

# Bueno,, mejor que suponer, lo guardamos.
addi $t1, $zero, 0x0000FACE


# FACE = 0000 0000 0000 0000 1111 1010 1100 1110
# CAFE = 0000 0000 0000 0000 1100 1010 1111 1110

# FACE xor CAFE = 0000 0000 0000 0000 0011 0000 0011 0000

xori $t2, $1, 0x0003030


addi $v0, $zero, 10 #Salir del programa
syscall