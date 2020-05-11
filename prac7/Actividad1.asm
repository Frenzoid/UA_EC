####################################
# #
# Código ejemplo de la actividad 1 #
# Contar caracteres de una cadena #
# #
####################################
.data
str: .ascii "Estructuras de los"
.asciiz "Computadores"
 
.text
main:

la  $s0, str              #$s0 = string.
add $s1, $zero, $zero     # Iniciamos contador a 0

# Cuenta caracteres.
loop:
  add   $t0, $s0, $s1     # dirección del byte a examinar
  lb    $t1, 0($t0)       # $t1 = byte leeido.
  beq   $t1, $zero, exit  # salimos si carácter leído = '\0'
  addi  $s1, $s1, 1       # incrementamos el contador
j loop


exit:
li $v0, 10
syscall