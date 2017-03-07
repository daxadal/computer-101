.global start

.text
a:		.word 81
b:		.word 18

start:
		ldr  r2,a		@ r2 <- a
		ldr  r3,b		@ r3 <- b
do:		sub r2,r2,r3	@ a <- a-b
		cmp r2, #0
		bgt do
		b .
.end

