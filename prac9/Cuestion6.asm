######################################
#                                    #
# Código de partida de la cuestión 6 #
#                                    #
######################################

#########################
#         DATOS         #
#########################
.data
Xpide: .asciiz "X = "
Ypide: .asciiz "Y = "
MaxRes: .asciiz "El mayor es "

#########################
#     INSTRUCCIONES     #
#########################
.text
jal pidex

mov.s $f12, $f0

jal pidey

mov.s $f14, $f0

jal max

mov.s $f12, $f0

jal showResults

jal exit


############################
#        FUNCIONES         #
############################

# Funcion Max(float, float).
max:
# C O M P L E T A R

c.lt.s $f14, $f12
bc1t maxConditionalAssinament1    # Si $f12 es mayor, asignamos $f12 a $f0 (si el bit de comparacion es 1, salta automaticamente)
j maxConditionalAssinament2       # Si no, entonces significa que $f14 es mayor, asignamos $f14 a $f0

maxConditionalAssinament1:        # Asigna $f12 a $f0 
mov.s $f0, $f12
j maxConditionalExitNormal        #    y salta al final de la funcion

maxConditionalAssinament2:        # Asigna $f14 a $f0
mov.s $f0, $f14

maxConditionalExitNormal:         # final de la funcion.

jr $ra

# Pide X
pidex:
la $a0, Xpide
li $v0, 4
syscall

li $v0, 6
syscall

jr $ra

# Pide Y
pidey:

la $a0, Ypide
li $v0, 4
syscall

li $v0, 6
syscall

jr $ra

# Muestra el resultado.
showResults:
la $a0, MaxRes
li $v0, 4
syscall

li $v0, 2
syscall

jr $ra

exit:
li $v0, 10
syscall
