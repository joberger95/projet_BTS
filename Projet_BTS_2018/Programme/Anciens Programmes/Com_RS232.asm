
_main:

;Com_RS232.c,47 :: 		void main()
;Com_RS232.c,49 :: 		config();
	CALL        _config+0, 0
;Com_RS232.c,50 :: 		communication();
	CALL        _communication+0, 0
;Com_RS232.c,51 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;Com_RS232.c,52 :: 		void config()
;Com_RS232.c,54 :: 		TRISA=0xFF;                       //0b11111111
	MOVLW       255
	MOVWF       TRISA+0 
;Com_RS232.c,55 :: 		TRISB=0x13;                       //0b10000011
	MOVLW       19
	MOVWF       TRISB+0 
;Com_RS232.c,56 :: 		TRISC=0x90;                       //0b10010000
	MOVLW       144
	MOVWF       TRISC+0 
;Com_RS232.c,57 :: 		TRISE=0xFF;                       //0x11111111
	MOVLW       255
	MOVWF       TRISE+0 
;Com_RS232.c,59 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Com_RS232.c,60 :: 		}
L_end_config:
	RETURN      0
; end of _config

_communication:

;Com_RS232.c,61 :: 		void communication()
;Com_RS232.c,63 :: 		UART1_write('A');
	MOVLW       65
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Com_RS232.c,64 :: 		delay_ms(250);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_communication0:
	DECFSZ      R13, 1, 1
	BRA         L_communication0
	DECFSZ      R12, 1, 1
	BRA         L_communication0
	DECFSZ      R11, 1, 1
	BRA         L_communication0
	NOP
	NOP
;Com_RS232.c,65 :: 		}
L_end_communication:
	RETURN      0
; end of _communication
