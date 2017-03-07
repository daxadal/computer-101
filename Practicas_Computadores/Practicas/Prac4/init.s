	.extern __gccmain
	.global start
	.equ STACK, 0x0c7ff000
	
	.text
start:
	ldr sp, =STACK
	mov fp, #0
	
	mov lr, pc
	ldr pc, =__gccmain
	
End:
	B End
.end
