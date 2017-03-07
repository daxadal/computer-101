	.global start

	
.equ PCONG, 0x01D20040
.equ PUPG, 0x01D20048
.equ PDATG,0x01D20044

.text

start: bl init_botones
	   bl detecta
FIN: B .

## inicializamos los botones
init_botones:  
		 mov r0,#0
		 ldr r1,=PUPG
		 str  r0,[r1]
		 ldr r1,=PCONG
		 mov  r0,#0x0000
		 str  r0,[r1]
		 bx lr
		 
		 

## Detecta pulsaciones en algun boton mediante espera activa (hace un bucle hasta que se pulsa un boton)
## Devuelve: 1 -> si boton sb2 pulsado
#			 2 -> si boton sb3 pulsado
#			 3 -> si ambos fueron pulsados (poco probable, pero posible...)
# CUIDADO: esta implementación es muy sensible a rebotes. Es muy probable que una sola pulsación se interprete como 2  o más
detecta: 
		 ldr r0,=PDATG
bucle:	 ldr r1,[r0]
		 mvn r1,r1
		 and r1,r1,#0x000000C0
		 cmp r1,#0
		 beq bucle 
		 mov r0, r1, lsr #6
		 bx lr

.end
		
	
