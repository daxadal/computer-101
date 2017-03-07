.global start

## Puerto G: conectado a los pulsadores	
.equ PCONG, 0x01D20040
.equ PUPG, 0x01D20048
.equ PDATG,0x01D20044

## Puerto B: conectado a los leds
.equ PDATB, 0x1d2000c
.equ PCONB, 0x1d20008

## Direcion inicial de la pila 
.equ SPINICIAL, 0x0C7ff000

.data 
## Variable que almacena el estado actual de los leds
led_status: .word 0


.text

## Programa principal: bucle infinito esperando pulsaciones y adaptando los leds
## DEBEN completarse las ramas "else1" y "else2" para que el LED2 cambie su estado cuando corresponda  
start: 
	   ldr sp,=SPINICIAL
		bl init_botones
	   bl init_leds
bucleMain:	   
	   bl detecta
	   cmp r0,#1
	   bne else1
	   bl switch_led1
	   b fin_if
else1: cmp r0,#2
	   bne else2
	   b fin_if	
else2: cmp r0,#3
	   bne fin_if
	   bl switch_led1
fin_if: b bucleMain
FIN: B .

## Configuara PUPG y PCONG como entrada
init_botones:  
		 mov r0,#0
		 ldr r1,=PUPG
		 str  r0,[r1]
		 ldr r1,=PCONG
		 mov  r0,#0x0000
		 str  r0,[r1]
		 bx lr
		 
## Configura bits 9 y 10 de PCONB como salida
## enciende ambos leds y actualiza la variable led_stats
init_leds:  
		 ldr r1,=0x1cf
		 ldr r0,=PCONB
		 str  r1,[r0]
		 mov r2,#0x0000
		 ldr  r0,=PDATB
		 str r2,[r0]
		 ldr r0,=led_status
		 str r2,[r0]
		 bx lr		 
		 

## Detecta pulsaciones en algun boton mediante espera activa (hace un bucle hasta que se pulsa un boton)
## Devuelve: 1 -> si boton SB1 pulsado
#			 2 -> si boton SB2 pulsado
#			 3 -> si ambos fueron pulsados (poco probable, pero posible...)
detecta: 
		  add		sp, sp, #-4
		  str		lr, [sp,#0]		@ direcciÛn de retor
		  ldr r0,=PDATG
bucleDet: ldr r1,[r0]
		  mvn r1,r1
		  and r1,r1,#0x000000C0
		  cmp r1,#0
		  beq bucleDet 
		  mov r0, r1, lsr #6
		  bl eliminaRebotes
		ldr		lr, [sp,#0]
		add		sp, sp, #4
		bx		lr
		  
## Eliminar rebotes: creo un retardo tras la deteccion haciendo iteraciones	
eliminaRebotes:
		  ldr r2,=200000
		  mov r3,#0
bReb: 	  cmp r3,r2
		  beq finR	 
		  mul r1,r0,r1
		  add r3,r3,#1
		  b bReb
finR:	  bx lr

## Rutina que cambia el estado del LED1 (encendido a apagado y  viceversa).
switch_led1:
		 ldr r0,=led_status
		 ldr r1,[r0]
		 ldr  r2,=0x200
		 eor r1,r1,r2
		 str r1,[r0]
		 ldr  r0,=PDATB
		 str r1,[r0]
		 bx lr


### DEBE completarse la rutina "switch_led2" para tener un comportamiento similar al 
### de "switch_led1" pero referido al LED 2.
switch_led2:
		 ldr r0,=led_status
		bx lr
	
.end

	
