.global start
		.EQU N, 8
		.EQU stack, 0x0c200000
	.data
A: 		.word 18,22,45,1,45,6,48,3
	.bss
ind: 	.space 4
	.text
start:	mov sp, #stack
		ldr r0, =A
		mov r1, #N
		bl  max
		ldr r2, =ind
		str r0, [r2]
		b   .

/*
Registros
	r0 - valor de ind
	r1 - valor de max
	r2 - indice i
	r3 - dir. de A[0]
	r4 - valor de longA
	r5 - valor de A[i]
*/
max:		sub sp, sp, #8			@ Crecer pila
			str r4, [sp, #4]
			str r5, [sp, #0]		@ Guardar r4-r5 en la pila
			
			mov r3, r0				@ La subrut. recibe dir.A en r0, pasa a r3
			mov r4, r1				@ La subrut. recibe longA en r1, pasa a r4

			mov r0, #0				@ Inicializo ind=0
			mov r1, #0				@ Inicializo max=0
			
			mov r2, #0				@ Inicializo i=0
forInt:		cmp r2, r4
			beq fin_forInt			@ Salir si i=N
			
			ldr r5, [r3, r2, lsl #2] 	@ Cargo A[i] en r5
			cmp r1, r5
			bhs fin_if				@ Saltar si max >= A[i]	
			mov r1, r5				@ max = A[i]
			mov r0, r2				@ ind = i
			
fin_if: 	add r2, r2, #1			@ i++
			b   forInt

			
fin_forInt: ldr r5, [sp, #0]
			ldr r4, [sp, #4]		@ Restaurar registros r4-r5
			add sp, sp, #8			@ Restaurar pila
			mov pc, lr
			
	.end
	