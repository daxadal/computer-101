	.global start
	.data
Dividendo:	.word 39
Divisor:	.word 5
	.bss
Cociente:	.space 4
	.text
start:	ldr r3, =Cociente
		ldr r4, =Dividendo
		ldr r5, =Divisor
		mov r0, #0
		ldr r1, [r4]
		ldr r2, [r5]
while:	cmp r1, r2
		blo fin
		sub r1, r1, r2
		add r0, r0, #1
		b   while
fin: 	str r0, [r3]
		b   .
	.end
	