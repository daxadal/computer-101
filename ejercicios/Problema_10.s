		.global start
		.text
a:		.word 6
b:		.word 15
mcd:	.space 4


start:	ldr		r0, a
		ldr		r1, b
		
WHILE:	cmp		r0, r1
		beq		FIN			@ si a = b, ir a FIN
		ble		ELSE		@ si  a <= b, ir a ELSE
		sub		r0, r0, r1	@ a <- (a-b)
		b 		WHILE
ELSE:	sub		r1, r1, r0	@ b <- (b-a)
		b 		WHILE
FIN:	str		r0, mcd		@ almacenar resultado

		b .
		.end
