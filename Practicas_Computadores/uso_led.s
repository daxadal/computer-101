	.global start

	
.equ PDATB, 0x1d2000c
.equ PCONB, 0x1d20008

.data 
led_status: .word 0
	
.text

start: bl init_leds
	   
	   bl led1_off
	   
	   bl led2_off
	   bl led1_on
	   bl led2_on
FIN: B .
	.ltorg

## Configura bits 9 y 10 de PCONB como salida
init_leds:  
		 ldr r1,=0x1ff
		 ldr r0,=PCONB
		 str  r1,[r0]
		 ldr r0,=PDATB
		 str r1,[r0]  @ encender ambos led
		 bx lr

## poner a 0 el bit 9 del puerto B (PDATB)
led1_on: ldr r0,=led_status
		 ldr r1,[r0]
		 ldr  r2,=0x5ff
		 and r1,r1,r2
		 str r1,[r0]
		 ldr  r0,=PDATB
		 str r1,[r0]
		 bx lr

## switch el bit 9 del puerto B (PDATB)		
led1_off: ldr r0,=led_status
		  ldr r1,[r0]
		  ldr r2,=0x200
		  orr r1,r1,r2
		  str r1,[r0]
		  ldr  r0,=PDATB
		 str r1,[r0]
		  bx lr

## poner a 0 el bit 10 del puerto B (PDATB)
led2_on: ldr r0,=led_status
		 ldr r1,[r0]
		 ldr  r2,=0x3ff
		 and r1,r1,r2
		 str r1,[r0]
		 ldr  r0,=PDATB
		 str r1,[r0]
		 bx lr
		 
## poner a 1 el bit 10 del puerto B (PDATB)		
led2_off: ldr r0,=led_status
		  ldr r1,[r0]
		  ldr r2,=0x400
		  orr r1,r1,r2
		  str r1,[r0]
		  ldr  r0,=PDATB
		  str r1,[r0]
		  bx lr
	.end
		
	
