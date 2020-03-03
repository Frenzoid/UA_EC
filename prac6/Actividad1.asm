############################################
# #
# Código de la actividad 1 #
# Ejemplo de uso de la memòria #
# #
############################################
.data # comienza zona de datos
palabra1:.word 15 # decimal
palabra2: .word 0x15 # hexadecimal
mediapalabra1: .half 2
mediapalabra2: .half 6
Dosbytes: .byte 3,4
.align 2 #Alinea a palabra
byte1: .byte 8
byte2: .byte 5
espacio: .space 4 # Reserva 4 bytes a 0
cadena1: .asciiz "Estructura de los computadores"

# PALABRAS = MULTIPLOS DE 4
# MEDIA PALABTAS = MULTIPLOS DE 2.
# BYTE = CUALQUIER LUGAR