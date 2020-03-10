# Escribe el  código  que  calcula  la  suma  de  los  elementos  de  la  diagonal principal  
# de  una  matriz  4x4  de  valores  enteros  introducida  por  teclado. Muestra la suma por pantalla.

# Anyadidos. 
# Decir al usuario que fila / columna se esta introduciendo
# Mostrar la matriz una vez completada
# Preguntar si es correcta, si es asi, haz el calculo, si no, vuelve a pedir datos. (S/N)
# una vez mostrado el calculo, preguntamos al usuario si quiere hacer alguna otra operacion mas? (S/N).

#########################
#         DATOS         #
#########################

.data           # Especificamos que queremos empezar a manipular datos para empezar desde el segmeto de datos.
MAT: .space 16  # Reservamos la matriz.






#########################
#     INSTRUCCIONES     #
#########################

.text       # Especificamos que queremos empezar a manipular instrucciones para empezar desde el segmeto de instrucciones.







############################
#        Funciones         #
############################

# Funcion, imprime un entenro
printInt: li $v0, 1     # Función imprimir
syscall                 # Escribe el valor de $a0

jr $ra                  # Vuelve al programa principal


# Sale del programa
exit: li $v0, 10
syscall










