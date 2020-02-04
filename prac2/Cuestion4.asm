# Cuestión 4. Ensambla y ejecuta el código. ¿Cuál es el valor final del registro $t2?
#   $t2 = 20

.text 0x00400000

# Le asigna el valor 25 al registro $$t0, instruccion almacenada en 0x00400000
addiu $t0, $zero, 25

# le asigna el valor 5 al registro $t1, instruccion almacenada en 0x00400004
addiu $t1, $zero, 5

# Resta $t0 - $t1 y guarda el resultado en $t2, instruccion almacenada en 0x00400008
sub $t2, $t0, $t1


addi $v0, $zero, 10 #Salir del programa
syscall
