		.global start

		.equ	N, 10
	
A:		.word	0,1,2,7,-8,4,5,-12,11,-2
B:		.word	0,1,2,7,-8,4,5,12,-11,-2
C:		.space	4*N 

start:	ldr	r0, =A			@ r0=dir(A)
		ldr	r1, =B			@ r1=dir(B)
		ldr	r2, =C			@ r2=dir(C)
		
		mov	r3, #0			@ r3=i
		mov	r4, #N
		sub	r4, r4, #1		@ r4=N-1		
	
LOOP: 	cmp	r3, #N				@ si i >= N, ir a FIN de programa
		bge	FN_LP
		ldr	r5, [r0,r3,lsl #2]	@ r5=A[i]
		sub	r7,r4,r3			@ r7 = N-1-i
		ldr	r6, [r1,r7,lsl #2]	@ r6=B[N-1-i]
		add	r5,r5,r6
		cmp	r5,#0				@ Si (A[i]+B[N-1-i]) >= 0, omitir cambio de signo
		bge	STORE
		
		mov	r6, #0
		sub	r5, r6, r5			@ cambiar el signo de (A[i]+B[N-1-i])
		
STORE:	str	r5, [r2,r3,lsl #2]	@ almacenar C[i]
		add	r3, r3, #1			@ incrementar i
		b	LOOP

FN_LP:	b 	FN_LP
	
		.end
