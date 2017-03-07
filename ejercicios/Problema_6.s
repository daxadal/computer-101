.global start

.text
X:	.word 10
Y:	.word 7

start:	ldr  r2,X		@ r2 <- X
		ldr  r3,Y		@ r3 <- Y

IF:		cmp  r2,r3		
		blt  ELSE		@ si X < Y, ir a Else
		add  r2,r2,#2	@ X <- X+2
		add  r3,r3,#2	@ Y <- Y+2
		b    END

ELSE:	sub  r2,r2,#2	@ X <- X-2
		sub  r3,r3,#2	@ Y <- Y-2

END:	str  r2,X		@ Almacenar X
		str  r3,Y		@ Almacenar Y
		b    .

.end

