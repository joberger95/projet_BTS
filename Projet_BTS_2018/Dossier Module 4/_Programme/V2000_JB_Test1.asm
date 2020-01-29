
_main:

;V2000_JB_Test1.c,15 :: 		void main()
;V2000_JB_Test1.c,17 :: 		config();
	CALL        _config+0, 0
;V2000_JB_Test1.c,19 :: 		while(1)
L_main0:
;V2000_JB_Test1.c,21 :: 		UART1_Write('a');
	MOVLW       97
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;V2000_JB_Test1.c,22 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;V2000_JB_Test1.c,24 :: 		PORTA.F2=1;
	BSF         PORTA+0, 2 
;V2000_JB_Test1.c,25 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;V2000_JB_Test1.c,26 :: 		led=1;
	BSF         PORTC+0, 0 
;V2000_JB_Test1.c,27 :: 		}
	GOTO        L_main0
;V2000_JB_Test1.c,28 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;V2000_JB_Test1.c,31 :: 		void config()
;V2000_JB_Test1.c,33 :: 		OSCCON=0x60;            //Mode 8Mhz
	MOVLW       96
	MOVWF       OSCCON+0 
;V2000_JB_Test1.c,34 :: 		TRISA=0x00;             //0b11111001
	CLRF        TRISA+0 
;V2000_JB_Test1.c,35 :: 		TRISB=0x42;                    //0b01000010
	MOVLW       66
	MOVWF       TRISB+0 
;V2000_JB_Test1.c,36 :: 		TRISC=0x9F;                    //0b10011111
	MOVLW       159
	MOVWF       TRISC+0 
;V2000_JB_Test1.c,39 :: 		UART1_Init(9600);      //Init UART1
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;V2000_JB_Test1.c,40 :: 		UART2_Init(9600);      //Init UART2
	BSF         BAUDCON2+0, 3, 0
	CLRF        SPBRGH2+0 
	MOVLW       207
	MOVWF       SPBRG2+0 
	BSF         TXSTA2+0, 2, 0
	CALL        _UART2_Init+0, 0
;V2000_JB_Test1.c,41 :: 		I2C1_Init(400000);              //Init i2c
	MOVLW       5
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;V2000_JB_Test1.c,45 :: 		}
L_end_config:
	RETURN      0
; end of _config
