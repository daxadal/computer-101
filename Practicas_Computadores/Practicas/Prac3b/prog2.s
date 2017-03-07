	.global start
		.EQU N, 8
		.EQU stack, 0x0c200000
	.data
A: 		.word 18,22,45,1,45,16,18,3
	.bss
B: 		.space N*4
	.text
/* Registros 
	r0 
	r1 - dir. de A[0]
	r2 - dir. de B[0]
	r3 - dir. de ind
	r4 - indice j
	r5 
	r6 
	r7 - valor de A[i]
	r8 - valor de ind
	r9 - valor de N
*/
start: 		mov sp, #stack
			mov r9, #N				@ Cargo en r9 el valor de N
			ldr r1, =A				@ Cargo en r1 la direccion del array A
			ldr r2, =B				@ Cargo en r2 la direccion del array B
			ldr r3, =ind			@ Cargo en r3 la direccion de ind
			
			
			mov r4, #0				@ Inicializo j=0
forExt:		cmp r4, r9
			beq fin					@ Salir si j=N
			
			sub sp, sp, #12			@ Crecer pila
			str r1, [sp, #8]
			str r2, [sp, #4]
			str r3, [sp, #0]		@ Guardar r1-r3 en la pila
			
			mov r0, r1
			mov r1, r9				@ Colocar parámetros (dir.A, longA = N)
			bl  max					@ Llamar funcion max
			mov r8, r0				@ Colocar resultado (ind)
			
			ldr r3, [sp, #0]
			ldr r2, [sp, #4]
			ldr r1, [sp, #8]		@ Restaurar registros r1-r3
			add sp, sp, #12			@ Restaurar pila
			
			
			ldr r7, [r1, r8, lsl #2]	@ Cargo A[ind] en r7
			str r7, [r2, r4, lsl #2]	@ Guardo r7 en B[j]
			mov r7, #0
			str r7, [r1, r8, lsl #2] 	@ Guardo en memoria A[ind] = 0
			add r4, r4, #1				@ j++
			b   forExt
			
fin:	b   .


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
		
		
		