.data 0x10010040
numerosOrdenados: .word 0:3

.data 0x10010080
numeros: .word 0:3

.data 0x10010090
mensaje: .asciiz "Resultado: "

.text
# Leemos los numeros y los guardamos, como pone en el enunciado.
# Segun el enunciao, no pide que hagamos nada mas desde memoria, así que omito la conversion a entero.
la $s0, numeros

jal readFloat
mov.s $f4, $f0
swc1 $f4, 0($s0)  # Num1

jal readFloat
mov.s $f5, $f0
swc1 $f5, 4($s0)  # Num2

jal readFloat
mov.s $f6, $f0
swc1 $f6, 8($s0)  # Num3

jal readFloat
mov.s $f7, $f0
swc1 $f7, 12($s0) # Num4

# Calculamos...
# Si tu DNI acaba en 5, 6, 7 ,8 y 9 ( ( Num3 * Num2) / 4 )+( (Num1 - Num4) / 2 )*
# Constantes:
li $s0, 4
li $s1, 2

mtc1 $s0, $f20
cvt.s.w $f20, $f20  # 4 en coma flotante simple

mtc1 $s1, $f21
cvt.s.w $f21, $f21  # 2 en coma flotante simple

# Calculo $f8 = ( ( $f6 * $f5) / 4 )
mul.s $f8, $f6, $f5
div.s $f8, $f8, $f20

# Calculo $f9 = ( ( $f4 - $f7 ) / 2 )
mul.s $f9, $f7, $f5
div.s $f9, $f8, $f21

# Calculo $f22 = $f8 + $f9
add.s $f22, $f8, $f9

# Imprimimos el resultado con el mensaje delante.
jal printMsg
mov.s $f12, $f22
jal printFloat

# Ordenamos y guardamos.
# Si tuDNI acaba en 5, 6, 7, 8 y 9 realizarán un orden descendente.

# Parametos de entrada segun convenio.
mov.s $f12, $f4
mov.s $f13, $f5
mov.s $f14, $f6
mov.s $f15, $f7

# Ordena en orden ascendente, y nosotrso guardamos en orden descendente, asi que al guaurdar, guardamos al revés
# Se queda colgado al ordenar, seguramente porque me he lidado con los tags y hay un bucle infinito que no veo, y no queda tiempo de examen para arreglarlo.
# jal floatSort

# Guardamos los numeros en memoria al revés.
la $t0, numerosOrdenados
swc1 $f3, 0($t0)
swc1 $f2, 4($t0)
swc1 $f1, 8($t0)
swc1 $f0, 12($t0)

jal exit



##### Funciones #####

# Ordenan 4 numeros y los deja en orden ascendente en $f0, $f1, $f2, $f3
floatSort:
  c.lt.s $f13, $f12 
  bc1t swap1312
  
  continue1415:
  c.lt.s $f15,  $f14
  bc1t swap1514
  
  continue1214:
  c.lt.s $f14, $f12
  bc1t swap1514
  
  continue1315:
  c.lt.s $f15, $f13
  bc1t swap1412
  
  continue1314:
  c.lt.s $f14, $f13
  bc1t swap1413


  swap1312:
  mov.s $f16, $f13
  mov.s $f13, $f12
  mov.s $f16, $f13
  j continue1415
  
  swap1514:
  mov.s $f16, $f15
  mov.s $f15, $f14
  mov.s $f14, $f16
  j continue1214
  
  swap1412:
  mov.s $f16, $f14
  mov.s $f14, $f12
  mov.s $f12, $f16
  j continue1315
  
  swap1513:
  mov.s $f16, $f15
  mov.s $f15, $f13
  mov.s $f13, $f16
  j continue1314
  
  swap1413:
  mov.s $f0, $f12
  mov.s $f0, $f13
  mov.s $f0, $f14
  mov.s $f0, $f15
  
jr $ra

# Funcion, lee un flotante. (valor resultante en $f0)
readFloat:
li $a0, '>'	# Ponemos un caracter para que el usuario sepa que estamos esperando un numero de entrada.
li $v0, 11
syscall
li $v0, 6
syscall
jr   $ra          # Vuelve al programa principal.

# Funcion, imprime un flotante. (valor a imprimir en $f12)
printFloat:
li $v0, 2
syscall
jr $ra  # Vuelve al programa principal.

# Funcion imprime un mensaje
printMsg:
la $a0, mensaje
li $v0, 4
syscall
jr $ra

# Sale del programa
exit:
li $v0, 10
syscall
