		.global start
		.text
		.equ	N, 7
	
V:		.space	4*N 

start:	ldr	r0, =V			@ r0=dir(V)
		mov	r1, #0			@ i
		mov	r2, #0			@ V(0)	
		mov	r3, #1			@ V(1)
		
		str r2,[r0,r1,lsl #2] 		@ store V(0)
		add r1,r1,#1				@ i=i+1
		str r3,[r0,r1,lsl #2] 		@ store V(1)
		add r1,r1,#1				@ i=i+1

/* BUCLE: Para i=2..N-1 
r2 contiene el valor de V(i-2)
r3     "         "      V(i-1)
r4     "         "      V(i)    */
		
for:	cmp r1,#N				
		beq fin
		add r4,r2,r3			@ V(i)=V(i-2)+V(i-1)
		str r4,[r0,r1,lsl #2]	@ store V(i)
		mov r2,r3				@ V(i-2)=V(i-1)
		mov r3,r4				@ V(i-1)=V(i)
		add r1,r1,#1			@ i=i+1
		b   for
		
fin:	b .

		.end
