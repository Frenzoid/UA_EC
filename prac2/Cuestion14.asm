# Sup贸n que $t1=0x0000FACE, utilizando 煤nicamente las instrucciones l贸gicas
# 	de la tabla anterior, escribe el c贸digo que reordene los bits de $t1 de manera que
# 	en $t2 aparezca el valor 0x0000CAFE. Ensambla y escribe en la ventana de
# 	registros $t1=0x0000FACE. Ejecuta y comprueba que el c贸digo es correcto.

.text

# Bueno.. mejor que suponer, lo guardamos para cuando lo usemos.
addi $t1, $zero, 0x0000FACE


# Primero vamos a ver que valores tienen en bin.
# 0000FACE = 0000 0000 0000 0000 1111 1010 1100 1110
# 0000CAFE = 0000 0000 0000 0000 1100 1010 1111 1110

# Parece que la opci髇 m醩 directa ser韆 usando xor...

# 0000FACE xor 0000CAFE = 0000 0000 0000 0000 0011 0000 0011 0000 = 0003030
# Entoces 0000FACE xor 0003030 = 0000CAFE
xori $t2, $1, 0x0003030

# Salir del programa
addi $v0, $zero, 10 
syscall
