	.global start
		.EQU N, 8
	.data
A: 		.word 7,3,25,4,75,2,1,1
	.bss
max: 	.space 4
	.text
start: 	mov r9, #N
		mov r0, #0
		ldr r1,=max 		@ Leo la dir. de max
		str r0,[r1] 		@ Escribo 0 en max
		ldr r2, =A			@ Guardo en r2 la direccion del array
		mov r3, #0			@ Inicializo i=0

while:	cmp r3, r9
		beq fin				@ Salir si i=N
		ldr r4, [r2, r3, lsl #2] @ Cargo en r4 la componente i
		cmp r4, r0
		bls else			@ Saltar si array[i] <= max
		mov r0, r4			@ Actualiza max en el egistro
		str r0, [r1]		@ Actualiza max en la memoria
else: 	add r3, r3, #1		@ i++
		b   while

fin:	b   .
	.end
		
		
		