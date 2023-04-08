			mov.b	#0FFh, &P1DIR
			mov.b	#000h, &P1SEL
			mov.b	#000h, &P2DIR
			mov.b	#000h, &P2SEL

			mov.b	#000h, R4				; contador


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------


BOTON1		bit.b	#001h, &P2IN
			jne		INCREMENTA
			jmp		BOTON2

BOTON2		bit.b	#002h, &P2IN
			jne		REINICIO
			jmp		BOTON1

INCREMENTA	cmp.b	#00Ah, R4
			jge		REINICIO
            inc.b	R4
            mov.b	R4, R5
LEDS		mov.b	#0FFh, &P1OUT
			call 	#DELAY
			mov.b	#000h, &P1OUT
			call 	#DELAY
			dec.b	R5
			cmp     #000h, R5
			jeq		BOTON1
			jmp		LEDS

REINICIO	mov.b	#000h, R4
			mov.b	#000h, &P1OUT
			jmp		BOTON1

DELAY		mov.w	#0FFFFh, R6
RESTA		dec.w	R6
			jne		RESTA
			ret