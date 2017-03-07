	.global Intercambiar
	.global OrdenaPorPrioridad
	.extern PosMinPrioridad
	.extern Intercambiar
/*	
Intercambiar:
		mov ip,sp
		stmdb sp!,{fp,ip,lr,pc}
		sub fp,ip,#4
		
		add r1, r0, r1, lsl #3
		add r2, r0, r2, lsl #3
		ldr r3, [r1]
		ldr r0, [r2]
		str r3, [r2]
		str r0, [r1]
		ldr r3,[r1,#4]
		ldr r0,[r2,#4]
		str r3,[r2,#4]
		str r0,[r1,#4]
		
		ldmdb fp,{fp,sp,pc}
*/		
/*
Registros (tambien en pila)
	r0 - puntero A
	r1 - variable num
	r2 - índice i
	r3 - indice j
*/

OrdenaPorPrioridad:
		mov ip, sp
		stmdb sp!, {fp, ip, lr, pc}
		sub fp, ip, #4
		sub sp, sp, #16		@Espacio para variables
		
		mov r2, #0
		mov r3, #0			@Inicializo i,j
for:	cmp r2, r1
		beq fin_for
		
		str r0, [sp, #0]
		str r1, [sp, #4]
		str r2, [sp, #8]
		str r3, [sp, #12]	@Guardar r0-r3 en la pila
		
		mov r3, r2
		mov r2, r1
		mov r1, r3			@Colocar parámetros (A, i, num)
		mov lr, pc
		ldr pc, =PosMinPrioridad
		
		mov r3, r0			@Colocar retorno (j)
		ldr r0, [sp, #0]
		ldr r2, [sp, #8]	@Recuperar A, i
		
		mov r1, r2
		mov r2, r3			@Colocar parámetros (A, i, j)
		mov lr, pc
		ldr pc, =Intercambiar
		
		ldr r0, [sp, #0]
		ldr r1, [sp, #4]
		ldr r2, [sp, #8]
		ldr r3, [sp, #12]	@Recuperar r0-r3 de la pila
		
		add r2, r2, #1		@i++
		b   for
		
fin_for:
		ldmdb fp, {fp, sp, pc}

	.end
