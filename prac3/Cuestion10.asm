# Cuestión 10.
# Convierte caracteres numéricos. Escribe el código que lea del teclado un
#    carácter numérico (del ‘0’ al ‘9’) y lo convierta en un valor numérico (del 0 al 9)
#    y lo escriba por pantalla. Itera el código.


# Pues lo mismo que en la cuestion 8, pero cambiando la manera de recoger y mostrar datos y con un tag a primera vista...
#    vamos a ver que diferencia hay entre los caracter y los numeros y si dicha diferencia es consistente.

# 0 = 0x00 | '0' = 0x30 => '0' - 0 = 0011 0000 - 0000 0000 = 0011 0000 = 0x30 = 48.
# 9 = 0x09 | '9' = 0x39 => '9' - 9 = 0011 1001 - 0000 1001 = 0011 0000 = 0x30 = 48.

# La diferencia es de 48, y es consistente con todos los numeros.


empieza: li $v0, 12		# Creamos el tag.
syscall				# Lee un caracter

subi $a0, $v0, 48		# le restamos 48, y lo preparamos para que el valor sea mostrado como numero

li $v0, 1			# Muestra un entero
syscall 			

li $a0, '\n'			# Ponemos un salto de linea para que quede bien
li $v0, 11
syscall

j empieza 			# Salta al principio, y vuelta a empezar
