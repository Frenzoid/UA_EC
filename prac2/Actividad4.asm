######################################
# 
# Código de la actividad 4 #
# Aritmética de enteros #
# 
#####################################

# ¿Qué hace cada línea de código de partida?

.text 0x00400000

# Le asigna el valor 25 al registro $$t0, instruccion almacenada en 0x00400000
addiu $t0, $zero, 25

# le asigna el valor 5 al registro $t1, instruccion almacenada en 0x00400004
addiu $t1, $zero, 5

# Resta $t0 - $t1 y guarda el resultado en $t2, instruccion almacenada en 0x00400008
sub $t2, $t0, $t1


addi $v0, $zero, 10 #Salir del programa
syscall

# ¿En qué dirección de memoria se almacena la instrucción sub?
#    La instruccion sub se almacena en 0x00400008