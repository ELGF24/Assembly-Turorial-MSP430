            mov.b	#0FFh, &P2DIR			; declaro todo el puerto dos como salidas
			mov.b	#000h, &P2SEL			; salidas digitales

			mov.b	#000h, R4


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

Loop		mov.b	R4, &P2OUT
			call 	#DELAY
			incd	R4
			cmp		#0AAh, R4
			jne		Loop
			jmp		FIN

FIN 		mov.b	#000h, &P2OUT
			call 	#DELAY
			mov.b	#0FFh, &P2OUT
			call 	#DELAY
			jmp		FIN


DELAY		mov.w	#0FFFFh, R5
RESTA		dec.w	R5
			jne		RESTA
			ret
