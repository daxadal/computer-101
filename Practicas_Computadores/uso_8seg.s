	.global start

	
.equ LED8ADDR, 0x2140000

.equ segmento_A, 0x7F
.equ segmento_B, 0xBF
.equ segmento_C, 0xDF
.equ segmento_D, 0xF7
.equ segmento_E, 0xFB
.equ segmento_F, 0xFD
.equ segmento_G, 0xFE
.equ segmento_P, 0xEF


.data 
segmentos: .word segmento_A,segmento_B,segmento_C,segmento_D,segmento_E,segmento_F,segmento_G,segmento_P
	
.text

start: bl init_seg
	   bl escribeC
FIN: B .

## inicializamos los segmentos con todos iluminados
init_seg:  
		 mov r0,#0
		 ldr r1,=LED8ADDR
		 str  r0,[r1]
		 bx lr

## Escribe una C "componiendo" segmentos
escribeC: 
		 mov r0,#segmento_A
		 and r0,r0,#segmento_G
		 and r0,r0,#segmento_E
		 and r0,r0,#segmento_D
		 ldr r1,=LED8ADDR
		 strb  r0,[r1]
		 bx lr
.end
		
	
