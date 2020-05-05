# SELECCIÓN:
lui $t0, 0xffff # Direc. del registro de control del teclado

r_espera:
  lw $t2, ($t0) # Lee registro control del teclado

  # SINCRONIZACIÓN:
  andi  $t2, $t2, 1 # Extrae el bit de ready
beqz $t2, r_espera # Si cero no hay carácter
# Continuamos esperando

# TRANSFERENCIA:
lw $v0, 4($t0) # Lee registro de datos del teclado
# Codigo de tecla guardado en $v0

move $a0, $v0

# SELECCIÓN:
lui $t0, 0xffff # ffff0000;

w_espera:
  lw $t1, 8($t0) # registro control

  # SINCRONITZACIÓN
  andi $t1, $t1, 0x0001 # bit de ready Sincroniza
beq $t1, $0, w_espera

# TRANSFERENCIA
sw $a0, 12($t0) # Escribe en la consola

j r_espera
