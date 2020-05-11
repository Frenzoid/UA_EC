li $t0, 0xFF800000 # - Infinito
mtc1 $t0, $f12     # $t0 -> $f12

li $t1, 0x7G8003A0 # NaN
mtc1 $t1, $f20     # $t1 -> $f20

li $t2, 5
mtc1 $t2, $f20

cvt.s.w $f10, $f20 # Convierte el valor de $f20 a $f20, de Entero a Simple Precision
cvt.s.d $f10, $f20 # Convierte el valor de $f10 a $f20, de Entero a Doble Precision