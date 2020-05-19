.text

li $a0, 57	  # Numero a comprobar

jal isPrime
move $s0, $v0	# Si es 0 no es primo, si es el mismo numero a comprobar, es primo.
jal exit


isPrime:

move $t0, $a0 # $t0 = $a0
li   $t1, 2   # $t1 = 2, desde donde empezamos a dividir, cada vez se ir� sumando +1.

div  $t0, $t1 # $t0 / $t1
mflo $t2      # Mitad del numero a comprobar (hasta donde irá el bucle)

divide: 

  div  $t0, $t1 # $t0 / $t1
  mflo $t3      # $t2 = floor($t0 / $t1) 
  mfhi $t4	    # $t3 = $t0 mod $t1

  addi $t1, $t1, 1  # Siguiente numero por el que dividir.

  beqz $t4, itIsNotPrime  # Si el resto es 0, no es primo.
  beq $t1, $t2, itIsPrime # Si $t1 (contador) es == a la mitad del numero, hemos acabado correctamente.
  
  j divide

itIsPrime:
move $v0, $a0
jr $ra

itIsNotPrime:
li $v0, 0
jr $ra


# Sale del programa
exit:
li $v0, 10
syscall
