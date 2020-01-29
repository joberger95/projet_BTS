
_main:

;V2000_18F2580.c,2 :: 		void main()
;V2000_18F2580.c,4 :: 		TRISC=0x00;
	CLRF        TRISC+0 
;V2000_18F2580.c,5 :: 		while(1)
L_main0:
;V2000_18F2580.c,7 :: 		LATC=0x00;
	CLRF        LATC+0 
;V2000_18F2580.c,8 :: 		LED1=1;
	BSF         PORTC+0, 0 
;V2000_18F2580.c,9 :: 		}
	GOTO        L_main0
;V2000_18F2580.c,10 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
