			mov.b	#0FFh, &P1DIR
			mov.b	#000h, &P1SEL

			mov.w	#00001h, R4				; num1
			mov.w	#00001h, R5				; num2
			mov.w	#00000h, R6				; num1 + num2




;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

			mov.b	#001h, &P1OUT
			call 	#DELAY
			mov.b	#001h, &P1OUT
			call 	#DELAY
			mov.b	#002h, &P1OUT
			call	#DELAY
FIBONACCI	add.w	R4, R6
			add.w	R5, R6
			mov.b	R6, &P1OUT
			call	#DELAY
			mov.w	R5, R8
			add.w	R8, R5
			mov.w	R4, R9
			add.w	R9, R4
			jmp		FIBONACCI


DELAY		mov.w	#0FFFFh, R7
RESTA		dec.w	R7
			jne		RESTA
			ret