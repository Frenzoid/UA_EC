# Escribe el código que haga la operación lógica OR de $t1 y $t2 y lo guarde en $t3,
# 	la operación lógica AND de $t1 y $t2 y lo guarde en $t4,
#	y la operación lógica XOR de $t1 y $t2 y lo guarde en $t5. 
#	Escribe en la ventana de registros,tras ensamblarlo, los siguientes valores para los registros $t1=0x55555555 y
# 	$t2= 0xAAAAAAAA. Ejecuta el código y estudia los resultados.

.text

or $t3, $t2, $t1
and $t4, $t1, $t2
xor $t5, $t1, $t2


addi $v0, $zero, 10 #Salir del programa
syscall
