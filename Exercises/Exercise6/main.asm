			mov.w	#00005h, R4				; numero de lados
			mov.w	#00004h, R5				; longitud de lado
			mov.w	#00001h, R6				; apotema

			mov.w	#00000h, R7				; perimetro
			mov.w	#00000h, R8				; numero de diagonales
			mov.w	#00000h, R9				; area

			mov.b	#000h, R13
			mov.b	#000h, R14


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

INICIO		cmp.w	#00003h, R4
			jge		PERIMETRO
			jmp		ERROR


PERIMETRO	add.w	R4, R7
			dec.w	R5
			cmp.w	#00000h, R5
			jne		PERIMETRO
			jmp		DIAG

											; DIAG = (numero de lados * (numero de lados - 3)) / 2
DIAG		mov.w	R4, R10					; R4 = 10, para hacer numero de lados -3
			sub.w	#00003H, R10			; R10 - 3, hacer mult interna
mult		add.w	R4, R8
			dec.w	R10
			cmp.w	#00000h, R10
			jne		mult
			jmp		div2					; R8 = 10

div2		mov.w	#00002h, R11			; denominador = 2
maindiv		cmp.w	R11, R8
			jge		RES
			jmp		AREA
RES			sub.w	R11, R8
			inc		R14						; R14 es el numero de diagonales
			jmp		maindiv


AREA		add.w	R7, R9
			dec.w	R6
			cmp.w	#00000h, R6
			jne		AREA
			jmp		findiv2

findiv2		mov.b	#00002h, R11
finaldiv	cmp.w	R11, R9
			jge		RESTAFIN
			jmp		FIN
RESTAFIN	sub.w	R11, R9
			inc		R13						; R13 es el area
			jmp		finaldiv



FIN			mov.b	#001h, &P1OUT
			call	#DELAY
			mov.b	#000h, &P1OUT
			call	#DELAY
			jmp		FIN

ERROR		mov.b	#040h, &P1OUT
			call	#DELAY
			mov.b	#000h, &P1OUT
			call	#DELAY
			jmp		ERROR


DELAY		mov.w	#0FFFFh, R15
RESTA		dec		R15
			jne		RESTA
			ret