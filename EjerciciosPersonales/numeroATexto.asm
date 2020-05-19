.data
	cien: .asciiz "cien "
	doscientos: .ascii "doscientos "
	trescientos: .ascii "trescientos "
	cuatrocientos: .ascii "cuatrocientos "
	quinientos: .ascii "quinientos "
	seiscientos: .ascii "seiscientos "
	setecientos: .ascii "setecientos "
	ochocientos: .ascii "ochocientos "
	novecientos: .ascii "novecientos "
	
	diez: .ascii "diez "
	veinte: .ascii "veinte "
	treinta: .ascii "treinta "
	cuarenta: .ascii "cuarenta "
	cincuenta: .ascii "cincuenta "
	sesenta: .ascii "sesenta "
	setenta: .ascii "setenta "
	ochenta: .ascii "ochenta "
	noventa: .ascii "noventa "
	
	uno: .asciiz "y uno"
	dos: .asciiz "y dos"
	tres: .asciiz "y tres"
	cuatro: .asciiz "y cuatro"
	cinco: .asciiz "y cinco"
	seis: .asciiz "y seis"
	siete: .asciiz "y siete"
	ocho: .asciiz "y ocho"
	nueve: .asciiz "y nueve"
	
	centenas: .word cien, doscientos, trescientos, cuatrocientos, quinientos, seiscientos, setecientos, ochocientos, novecientos
	decenas: .word diez, veinte, treinta, cuarenta, cincuenta, sesenta, setenta, ochenta, noventa
	unidades: .word uno, dos, tres, cuatro, cinco, seis, siete, ocho, nueve
	
.text

jal readInt
move $t1, $v0

la $s1, centenas
la $s2, decenas
la $s3, unidades

li $s4, 100
li $s5, 10

# Dividimos para sacar cada cifra del numero.
div $t1, $s4	# Numero / 100
mflo $t2	# Centenas
mfhi $t3	# Numero de decenas

div $t3, $s5	# Resto / 10
mflo $t4	# Decenas
mfhi $t5	# Unidades

# Preparamos el salto.
sll $t2, $t2, 2 # Centenas
sll $t4, $t4, 2 # Decenas
sll $t5, $t5, 2 # Unidades

# Cargamos la dir del array
la $t6, centenas # Centenas
la $t7, decenas  # Decenas
la $t8, unidades # Unidades

# Hacemos el salto
add $t6, $t6 $t2 # Centenas
add $t7, $t7 $t4 # Decenas
add $t8, $t8 $t5 # Unidades

move $a0, $t6
jal printMsg

move $a0, $t7
jal printMsg

move $a0, $t8
jal printMsg

jal exit

# Funcion imprime un mensaje
printMsg:
li $v0, 4
syscall
jr $ra

# Funcion lee un entero.
readInt: 
li $a0, '>'	# Ponemos un caracter para que el usuario sepa que estamos esperando un numero de entrada.
li $v0, 11
syscall
li $v0, 5		# Pedimos un entero
syscall
jr $ra			# Vuelve al programa principal


# Sale del programa
exit:
li $v0, 10
syscall
