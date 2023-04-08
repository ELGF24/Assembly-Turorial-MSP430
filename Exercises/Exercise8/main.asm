			mov.b	#0FFh, &P1DIR
			mov.b	#000h, &P1SEL

			mov.w	#00004h, R4				; Valor teorico
			mov.w	#00002h, R5				; Valor medido
			mov.w	#00000h, R6				; cont teorico
			mov.w	#00000h, R7				; Error %
			mov.w	#00064h, R8
			mov.w	#00000h, R15
			mov.w	#00000h, R14

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------


INICIO		mov.w	R4, R6
			sub.w	R5, R6
			jmp		MULT100

MULT100		add.w	R6, R15
			dec.w	R8
			cmp.w	#00000h, R8
			jne		MULT100
			jmp		DIV

DIV			cmp.w	R4, R15
			jge		RESTA
			jmp		FIN
RESTA		sub.w	R4, R15
			inc		R14
			jmp		DIV

FIN			cmp		#00001h, R14
			jl		ROJO
			jmp		VERDE

ROJO		mov.b	#040h, &P1OUT
			call	#DELAY
			mov.b	#000h, &P1OUT
			call	#DELAY
			jmp		ROJO


VERDE		mov.b	#001h, &P1OUT
			jmp		VERDE

DELAY		mov.w	#0FFFFh, R10
res			dec		R10
			jne		res
			ret