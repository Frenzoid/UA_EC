####################################
#                                  #
# Código ejemplo de la actividad 1 #
# Leer del teclado                 #
# Carácter de entrada en $v0       #
#                                  #
####################################
# SELECCIÓN:
lui $t0, 0xffff # Direc. del registro de control del teclado

b_espera:
  lw $t2, ($t0) # Lee registro control del teclado

  # SINCRONIZACIÓN:
  andi  $t2, $t2, 1 # Extrae el bit de ready
beqz $t2, b_espera # Si cero no hay carácter
# Continuamos esperando

# TRANSFERENCIA:
lw $v0, 4($t0) # Lee registro de datos del teclado
# Codigo de tecla guardado en $v0