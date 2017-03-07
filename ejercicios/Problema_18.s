	.global	start
	.text
	
a:		.word	10
b:		.word	5

start:	ldr		r0, =a
		ldr		r1, =b
		
		bl		SWAP

FIN:	b .
		

/* Subrutina SWAP
   Como es hoja y no modifica más registros que
   r2 y r3, ni siquiera necesita usar la pila */

SWAP:	
		ldr		r2, [r0]
		ldr		r3, [r1]
		str		r3, [r0]
		str		r2, [r1]

		mov		pc, lr


		.end
