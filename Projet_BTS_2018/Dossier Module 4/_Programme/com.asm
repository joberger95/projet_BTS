
_main:

;com.c,47 :: 		void main()
;com.c,49 :: 		configuration();                  //Appel au sous-programme configuration
	CALL        _configuration+0, 0
;com.c,50 :: 		while(1)
L_main0:
;com.c,52 :: 		comrs();
	CALL        _comrs+0, 0
;com.c,53 :: 		}
	GOTO        L_main0
;com.c,54 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_configuration:

;com.c,56 :: 		void configuration()
;com.c,58 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;com.c,59 :: 		TRISA=0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;com.c,60 :: 		TRISB=0b11000001;
	MOVLW       193
	MOVWF       TRISB+0 
;com.c,61 :: 		TRISC=0x00;
	CLRF        TRISC+0 
;com.c,65 :: 		}
L_end_configuration:
	RETURN      0
; end of _configuration

_comrs:

;com.c,66 :: 		void comrs()
;com.c,68 :: 		UART1_write('A');
	MOVLW       65
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;com.c,69 :: 		delay_ms(250);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_comrs2:
	DECFSZ      R13, 1, 1
	BRA         L_comrs2
	DECFSZ      R12, 1, 1
	BRA         L_comrs2
	DECFSZ      R11, 1, 1
	BRA         L_comrs2
	NOP
	NOP
;com.c,70 :: 		}
L_end_comrs:
	RETURN      0
; end of _comrs
