		.global	start
		.equ stack, 0x0C200000

.text
V:		.word 0,1,2,7,0,-8,4,0,0,5,-12,11,-2,0,0
N:		.word 15
N_ceros:	.space 4		

start:	
		mov  sp,#stack		@ Inicializamos sp
		ldr  r0,=V		@ Primer argumento -> dir(V)
		ldr  r1,N		@ Segundo argumento -> longitud de V

		bl   cuenta		@ Llamamos a la subrutina
		str  r0,N_ceros		@ Guardamos el resultado

FIN:		b .


cuenta:
		sub  sp, sp, #4 	@ Actualizar SP para apilar contexto
		str  r4, [sp,#0]

		mov  r2, #0		@ Ídice de iteración (i)
		mov  r3, #0		@ Número de 0's
		
C_LOOP: 	
		cmp  r2,r1
		bge  C_END		@ si se ha recorrido todo el vector, ir a C_END
		ldr  r4,[r0,r2,lsl #2]	@ r4=V(i)	
		cmp  r4,#0
		bne  sigue		@ Si V(i) no es cero, ir a sigue
		add  r3,r3,#1		@ Incrementa el contador de ceros
sigue:
		add  r2,r2,#1		@incrementar i
		b    C_LOOP
	
C_END:
		mov  r0,r3		@ Devolvemos el #0's en r0

		ldr  r4, [sp,#0]     	@ Restauro r4
		add  sp, sp, #4		@ Dejamos sp con su valor original
		mov  pc, lr		@ Return
		.end
