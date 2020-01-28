# Cuestion 6

# Especificamos desde que lugar en la memoria empezamos
.text 0x00400000

# $12=5
addi $t4, $zero, 5

# $10=8
addi $t2, $zero, 8

# $13=$12 + 10
addi $t5, $t4, 10

# $10=$10 - 4
addi $t2, $t2, -4

# $14=$13 – 30
addi $t6, $t5, -30

# $15=$10
addi $t7, $t2, 0


# Ensamblad y ejecutad el programa y comprobad que el resultado final es 
#  $t7 = $t2 = 4, $t6=-15, $t4=5,$t5=15.
