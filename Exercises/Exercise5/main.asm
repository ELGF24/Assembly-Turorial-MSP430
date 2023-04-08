			mov.w	#00002h, R4				; radio
			mov.w	#00004h, R5				;3
			mov.w	#00003h, R6				;4
			mov.w	#0013Ah, R7				; pi * 100
			mov.w	#00064h, R9
			mov.w	#00000h, R8
			mov.w	#00000h, R10
			mov.w	#00000h, R15
			mov.w	#00000h, R14
			mov.w	#00000h, R13
			mov.w	#00004h, R12				; pot

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

DIV43		cmp		R6, R5					; 4/3
			jge		resta
			jmp		multpi
resta		sub		R6, R5
			inc		R8
			jmp		DIV43					;r8=1

multpi		add.w	R8, R15					; R8 * R7 = 314(r15)
			dec		R7
			cmp.w	#00000h, R7
			jeq		div100
			jmp		multpi

div100		cmp		R9, R15					; R15 / 100 = R10(3)
			jge		res
			jmp		sqr
res			sub		R9, R15
			inc		R10
			jmp		div100

sqr			add		R4, R14					; r^3
			dec		R12
			cmp		#000h, R12
			jeq		multfinal
			jmp		sqr

multfinal	add		R10, R13
			dec		R14
			cmp		#00000h, R14
			jeq		final
			jmp		multfinal


final 		jmp		final
