
_main:

;RECEPTION.c,51 :: 		void main()
;RECEPTION.c,53 :: 		config();                                //Appel le sous-programme
	CALL        _config+0, 0
;RECEPTION.c,55 :: 		while(1)                                 //Boucle infinie
L_main0:
;RECEPTION.c,57 :: 		reception();
	CALL        _reception+0, 0
;RECEPTION.c,58 :: 		}
	GOTO        L_main0
;RECEPTION.c,59 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;RECEPTION.c,63 :: 		void config()
;RECEPTION.c,65 :: 		ANSELA=0x01;                      //Passe toutes les broches en digital
	MOVLW       1
	MOVWF       ANSELA+0 
;RECEPTION.c,66 :: 		ANSELB=0x00;
	CLRF        ANSELB+0 
;RECEPTION.c,67 :: 		ANSELC=0x00;
	CLRF        ANSELC+0 
;RECEPTION.c,69 :: 		TRISA=0xFF;                       //0b11111111
	MOVLW       255
	MOVWF       TRISA+0 
;RECEPTION.c,70 :: 		TRISB=0x81;                       //0b10000001
	MOVLW       129
	MOVWF       TRISB+0 
;RECEPTION.c,71 :: 		TRISC=0x99;                       //0b10011001      SCL et SDA en entrée
	MOVLW       153
	MOVWF       TRISC+0 
;RECEPTION.c,73 :: 		Lcd_Init();                       //Initialisation LCD
	CALL        _Lcd_Init+0, 0
;RECEPTION.c,74 :: 		Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RECEPTION.c,75 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RECEPTION.c,77 :: 		UART2_Init(9600);                 //Initialisation RS232
	BSF         BAUDCON2+0, 3, 0
	CLRF        SPBRGH2+0 
	MOVLW       207
	MOVWF       SPBRG2+0 
	BSF         TXSTA2+0, 2, 0
	CALL        _UART2_Init+0, 0
;RECEPTION.c,79 :: 		}
L_end_config:
	RETURN      0
; end of _config

_reception:

;RECEPTION.c,80 :: 		void reception()
;RECEPTION.c,82 :: 		if(BP1==0)
	BTFSC       PORTA+0, 1 
	GOTO        L_reception2
;RECEPTION.c,83 :: 		{UART2_Write_Text("A");
	MOVLW       ?lstr1_RECEPTION+0
	MOVWF       FARG_UART2_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_RECEPTION+0)
	MOVWF       FARG_UART2_Write_Text_uart_text+1 
	CALL        _UART2_Write_Text+0, 0
;RECEPTION.c,84 :: 		}
L_reception2:
;RECEPTION.c,86 :: 		if(UART2_Data_Ready()==1)
	CALL        _UART2_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_reception3
;RECEPTION.c,88 :: 		receive=UART2_Read();
	CALL        _UART2_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _receive+0 
;RECEPTION.c,89 :: 		Lcd_Chr_Cp(receive);
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RECEPTION.c,90 :: 		i++;
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;RECEPTION.c,91 :: 		}
L_reception3:
;RECEPTION.c,92 :: 		if(i==16)
	MOVLW       0
	XORWF       _i+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__reception8
	MOVLW       16
	XORWF       _i+0, 0 
L__reception8:
	BTFSS       STATUS+0, 2 
	GOTO        L_reception4
;RECEPTION.c,93 :: 		{i=0;
	CLRF        _i+0 
	CLRF        _i+1 
;RECEPTION.c,94 :: 		LCD_CMD(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RECEPTION.c,96 :: 		}
L_reception4:
;RECEPTION.c,98 :: 		}
L_end_reception:
	RETURN      0
; end of _reception
