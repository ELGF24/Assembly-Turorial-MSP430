			mov.b	#0FFh, &P1DIR
			mov.b	#000h, &P1SEL
			mov.b	#000h, &P2DIR
			mov.b	#000h, &P2SEL

			mov.w	#00001h, R4
			mov.w	#00002h, R5
			mov.w	#00003h, R6
			mov.w	#00004h, R7
			mov.w	#00005h, R8
			mov.w	#00006h, R9
			mov.w	#00007h, R10
			mov.w	#00008h, R11


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------


BOTON1		bit.b	#001h, &P2IN
			jne		SHOW
			jmp		BOTON2


BOTON2		bit.b	#002h, &P2IN
			jne		PARPADEA
			jmp		BOTON1

SHOW		call	#PROMEDIO
			mov.b	R13, &P1OUT
			call	#DELAY
			mov.b	#000h, &P1OUT
			jmp		BOTON1

PARPADEA	call	#PROMEDIO
Loop		mov.b	#001h, &P1OUT
			call 	#DELAY
			mov.b	#000h, &P1OUT
			call 	#DELAY
			dec		R13
			cmp		#000h, R13
			jeq		BOTON1
			jmp 	Loop


PROMEDIO	mov.b	#000h, R13
			mov.w	#00008h, 	 R14		; N
			mov.w	#00000h, R15
			add.w	R4, R15
			add.w	R5, R15
			add.w	R6, R15
			add.w	R7, R15
			add.w	R8, R15
			add.w	R9, R15
			add.w	R10, R15
			add.w	R11, R15
DIVISION	cmp.w	R14, R15
			jge		RESTA
			jmp		FIN
RESTA		sub		R14, R15
			inc		R13
			jmp		DIVISION

DELAY		mov.w	#0FFFFh, R12
RES			dec		R12
			jne		RES
			ret

FIN			ret