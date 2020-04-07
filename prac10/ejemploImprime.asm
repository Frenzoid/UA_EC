####################################
#                                  #
# Código ejemplo de la actividad 2 #
# Escribir en la consola           #
# Carácter de salida en $a0        #  
#                                  #
####################################
# SELECCIÓN:
lui $t0, 0xffff # ffff0000;

b_espera:
  lw $t1, 8($t0) # registro control

  # SINCRONITZACIÓN
  andi $t1, $t1, 0x0001 # bit de ready Sincroniza
beq $t1, $0, b_espera

# TRANSFERENCIA
sw $a0, 12($t0) # Escribe en la consola