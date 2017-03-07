	.global start
		.EQU N, 8
	.data
A: 		.word 7,3,25,4,75,2,1,1
	.bss
B: 		.space N*4
max: 	.space 4
ind: 	.space 4
	.text
/* Registros 
	r0 - dir. de max
	r1 - dir. de A[0]
	r2 - dir. de B[0]
	r3 - dir. de ind
	r4 - indice j
	r5 - indice i
	r6 - valor de max
	r7 - valor de A[i]
	r8 - valor de ind
	r9 - valor de N
*/
start: 		mov r9, #N				@ Cargo en r9 el valor de N
			ldr r0, =max			@ Cargo en r0 la direccion de max
			ldr r1, =A				@ Cargo en r1 la direccion del array A
			ldr r2, =B				@ Cargo en r2 la direccion del array B
			ldr r3, =ind			@ Cargo en r3 la direccion de ind
			
			
			mov r4, #0				@ Inicializo j=0
forExt:		cmp r4, r9
			beq fin					@ Salir si j=N
			
			mov r6, #0				@ Inicializo max=0
			str r6,[r0] 			@ Guardo max en memoria
			
			
			mov r5, #0				@ Inicializo i=0
forInt:		cmp r5, r9
			beq fin_forInt			@ Salir si i=N
			
			ldr r7, [r1, r5, lsl #2] 	@ Cargo A[i] en r7
			cmp r6, r7
			bhs fin_if				@ Saltar si max >= A[i]
			
			mov r6, r7				@ max = A[i]
			str r6, [r0]			@ Guardo max en la memoria
			mov r8, r5				@ ind = i
			str r8, [r3]			@ Guardo ind en la memoria
			
fin_if: 	add r5, r5, #1				@ i++
			b   forInt

			
fin_forInt:	ldr r7, [r1, r8, lsl #2]	@ Cargo A[ind] en r7
			str r7, [r2, r4, lsl #2]	@ Guardo r7 en B[j]
			mov r7, #0
			str r7, [r1, r8, lsl #2] 	@ Guardo en memoria A[ind] = 0
			add r4, r4, #1					@ j++
			b   forExt
			
fin:	b   .
	.end
		
		
		