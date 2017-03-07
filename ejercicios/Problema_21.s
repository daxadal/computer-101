/*
-------------------------------------------
Código de alto nivel (comentado)

int fact();
int n=6, rFact;

void __main(){
	rFact = fact(n);
	while(1);
}

// la función fact devuelve el factorial del entero
// que se le pasa como argumento

int fact(int num){
	int i,resu;
	if (num > 1){
		resu = num;
		for (i=num-1;i>1;i--)
			resu = resu*i;
		}
	else 
		resu=1;
	return(resu);
}
---------------------------------------------
*/


	
/* Código ensamblador */


	.global	start

	.equ stack, 0x0c200000
	
.text
n:	.word 6		@ valor del que calcular el factorial
rFact:	.word 0		@ rFact=fact(n)

start:	
	mov  sp,#stack		@ Inicializamos sp
	ldr  r0,n		@ Preprar Parametro llamada (r0 = n)
	bl   fact
	str  r0, rFact		@ Almacenar valor de retorno
	b .	


/* Cálculo iterativo del factorial */

fact:	
	mov  r1, r0
	cmp  r1,#1
	ble  ELSE		@ si num <= 1; entonces resultado=1

						@ Cálculo iterativo
	sub  r1, r1, #1		@ r1 = num-1 (r1 representa el índice i)
F_NEXT:	cmp  r1, #1
	ble  RETURN
	mul  r0, r1, r0		@ ojo, no funciona 'mul r0, r0, r1'
				@ r0 representa a resu
	sub  r1, r1, #1		@ i--
	b    F_NEXT

ELSE:	mov  r0,#1

RETURN:
	mov  pc,lr		@ retorno
	.end
