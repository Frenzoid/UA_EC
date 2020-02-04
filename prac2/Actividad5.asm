# Actividad 5.

# 	Observa el código de partida Aritmética de enteros de la actividad 4. ¿Cómo se codifica la primera instrucción? 
#		Hacedlo a mano (el código de operación de la instrucción addiu es 0x09)

# 	Confirmad con el programa ensamblado que el código máquina es el mismo.

.text 0x00400000


addiu $t0, $zero, 25

# Operacion (addiu):	0x09 (001001)
# Rs fuente ($zero):	00000
# Rt destino ($t0):	01000
# Inmediato (25):	0000000000011001

# Cod bin = 0010 0100 0000 1000 0000 0000 0001 1001
# Cod hex = 0x 24080019