.text

# -----------------BINARY----------------    ----HEX---
# 1111 1001 1000 0100 0010 0001 0101 1010 => 0xF984215a
li $s1,  0xF984215a
move $a0, $s1

jal extractFirst8Bites
jal exit

# Queremos extraer los primeros 8 bits: 1111 1001 1000 0100 0010 0001 (0101 1010)
# La mascara que usaremos será 0x000000FF
extractFirst8Bites:
andi $a0, $a0, 0x000000FF

la $v0, 35
syscall
jr $ra


# Sale del programa
exit:
li $v0, 10
syscall
