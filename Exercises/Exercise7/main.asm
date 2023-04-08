			mov.b	#0FFh, &P1DIR
			mov.b	#000h, &P1SEL

			mov.b	#000h, &P1OUT

			mov.w	#00007h, R4				; teoria 1
			mov.w	#00007h, R5				; teoria 2
			mov.w	#00006h, R6				; practica 1
			mov.w	#00007h, R7				; practica 2
			mov.w	#00007h, R8				; practica 3
			mov.w	#00008h, R9				; practica 4

			mov.w	#00000h, R10			; promedio teoria
			mov.w	#00000h, R11			; promedio practicas

			mov.b	#002h, R12				; n1
			mov.b	#004h, R13				; n2
			mov.b	#000h, R14
			mov.b	#000h, R15


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

TEORIA		add.w	R4, R10
			add.w	R5, R10
			jmp		PROMTEORIA


; CALCULA EL PROMEDIO EN TEORIA
PROMTEORIA	cmp		R12, R10
			jge		RESTA1
			jmp		PASO
RESTA1		sub.w	R12, R10
			inc		R14
			jmp		PROMTEORIA

; REVISAN SI PASO LA MATERIA
PASO		cmp.w	#00006h, R14
			jge		PRACTICAS
			jmp		FIN

PASO2		cmp.w	#00006h, R15
			jge		PROMFINAL
			jmp		FIN

; CALCULA EL PROMEDIO EN PRACTICAS
PRACTICAS	add.w	R6, R11
			add.w	R7, R11
			add.w	R8, R11
			add.w	R9, R11
PROMP		cmp		R13, R11
			jge		RESTA2
			jmp		PASO2
RESTA2		sub.w	R13, R11
			inc		R15
			jmp		PROMP


; CALCULA EL PROMEDIO FINAL
PROMFINAL	mov.w	#00000h, R4
			add.w	R14, R4
			add.w	R15, R4
CALC		mov.b	#002h, R5
			mov.w	#00000h, R6
CALCFINAL	cmp		R5, R4
			jge		FRES
			jmp		RESULT
FRES		sub.w	R5, R4
			inc		R6
			jmp		CALCFINAL


; MUESTRA EL PROMEDIO FINAL SI PASO
RESULT		mov.b	#001, &P1OUT
			call	#DELAY
			mov.b	#000h, &P1OUT
			call	#DELAY
			dec		R6
			cmp.w	#00000h, R6
			jne		RESULT
			jmp		FIN



DELAY		mov.w	#0FFFFh, R7
re			dec		R7
			jne		re
			ret

SHOW		mov.b	#001h, &P1OUT
			jmp		SHOW


FIN 		mov.b	#040h, &P1OUT
			jmp		FIN
