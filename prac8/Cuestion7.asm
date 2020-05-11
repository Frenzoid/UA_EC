######################################
#                                    #
# Código de partida de la cuestión 7 #
# Cálculo longitud circunferencia    #
# y el área del círculo              #
#                                    #
######################################

#########################
#         DATOS         #
#########################
.data

demanaPi:  .asciiz "Dame el valor de pi: "
pideRadio: .asciiz "Dame el radio: "
long: 	.asciiz "Longitud de la circunferencia = "
super: 	.asciiz "Area del circulo = "

#########################
#     INSTRUCCIONES     #
#########################
.text

jal defConsts   # Definimos constantes.

jal pideP       # Pide pi y lo guarda en $f0

mov.s $f1, $f0  # Mueve $f0 (valor de Pi) a $f1.

jal pideR       # Pide el radio y lo guarda en $f0

mov.s $f2, $f0  # Mueve $f0 (valor del radio) a $f2.

jal muestraL    # Calcula y muestra la longitud.

jal muestraA    # Calcula y muestra el area.

jal exit        # Sale del programa.

############################
#        SECCIONES         #
############################
defConsts:
li $s0, 2      		  # Constante entero, valor del num 2
mtc1 $s0, $f20 		  # Movemos $s0 a $f20, Constante flotante simple, valor del num 2 
cvt.s.w $f20, $f20	# El valor sigue siendo entero, hay que pasarlo a flotante simple.
jr   $ra       		  # Vuelve al programa principal.

# Pedimos el numero Pi
pideP:
li $v0, 4
la $a0, demanaPi
syscall

li $v0, 6
syscall
jr   $ra          # Vuelve al programa principal.

# Pedimos el radio.
pideR:
li $v0, 4
la $a0, pideRadio
syscall

li $v0, 6 
syscall
jr   $ra           # Vuelve al programa principal.


# Calcula y Muestra la longitud
muestraL:
li $v0, 4
la $a0, long
syscall

# $f1   = pi en flotante simple.
# $f2   = radio en flotante simple.
# $f20  = valor del num 2 en flotante simple.

# Formula de la longitud: 2 * Pi * R.
# Procuramos siempre guardar el resultado final en $f12 para mostrar directamente el resultado.
mul.s $f12, $f1, $f2     # $f12 = pi * R
mul.s $f12, $f12, $f20   # $f12 = (pi * R) * 2

li $v0, 2
syscall

li $a0, '\n'		  # Imprimimos un salto de linea
li $v0, 11
syscall

jr   $ra         	# Vuelve al programa principal.

# Calcula y Muestra el Area
muestraA:
li $v0, 4
la $a0, super
syscall

# $f1 = pi en flotante simple.
# $f2 = radio en flotante simple.
# $f20 = valor del num 2 en flotante simple.

# Formula del area de un circulo: Pi * R^2.
# Procuramos siempre guardar el resultado final en $f12 para mostrar directamente el resultado.
mov.s $f3, $f2 		    # $f3 = $f2
mul.s $f3, $f3, $f3	  # $f2 = $f2^2
mul.s $f12, $f3, $f1	# $f12 = $f2^2 * $f1

li $v0, 2
syscall

jr   $ra         # Vuelve al programa principal.


############################
#        FUNCIONES         #
############################


# Sale del programa.
exit: 
li $v0, 10
syscall
