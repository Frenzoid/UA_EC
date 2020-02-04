# Cuestión 3. ¿Cómo se escribe la instrucción que hace $t2=$t1+$t0?
.text

add $t2, $t1, $t0 # suma el valor del registro $t1 y $t0 y devuelve el resultado a $t2

addi $v0, $zero, 10	#Función 10, exit
syscall		#Acaba el programa
