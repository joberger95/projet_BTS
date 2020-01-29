
_main:

;Exemple_Complet.c,50 :: 		void main()
;Exemple_Complet.c,52 :: 		config();                         //Appel le sous-programme
	CALL        _config+0, 0
;Exemple_Complet.c,53 :: 		while(1)
L_main0:
;Exemple_Complet.c,55 :: 		Test_Complet();                  //Appel au sous-programme
	CALL        _Test_Complet+0, 0
;Exemple_Complet.c,56 :: 		}
	GOTO        L_main0
;Exemple_Complet.c,57 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;Exemple_Complet.c,58 :: 		void config()
;Exemple_Complet.c,60 :: 		ANSELA=0x00;                      //Passe toutes les broches en digital
	CLRF        ANSELA+0 
;Exemple_Complet.c,61 :: 		ANSELB=0x00;
	CLRF        ANSELB+0 
;Exemple_Complet.c,62 :: 		ANSELC=0x00;
	CLRF        ANSELC+0 
;Exemple_Complet.c,63 :: 		TRISA=0xFF;                       //0b11111111
	MOVLW       255
	MOVWF       TRISA+0 
;Exemple_Complet.c,64 :: 		TRISB=0x13;                       //0b10000011
	MOVLW       19
	MOVWF       TRISB+0 
;Exemple_Complet.c,65 :: 		TRISC=0x90;                       //0b10010000
	MOVLW       144
	MOVWF       TRISC+0 
;Exemple_Complet.c,66 :: 		TRISE=0xFF;                       //0x11111111
	MOVLW       255
	MOVWF       TRISE+0 
;Exemple_Complet.c,68 :: 		Lcd_Init();                       //Initialisation LCD
	CALL        _Lcd_Init+0, 0
;Exemple_Complet.c,69 :: 		Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Exemple_Complet.c,70 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Exemple_Complet.c,72 :: 		UART2_Init(9600);                  //Initialisation RS232
	BSF         BAUDCON2+0, 3, 0
	CLRF        SPBRGH2+0 
	MOVLW       207
	MOVWF       SPBRG2+0 
	BSF         TXSTA2+0, 2, 0
	CALL        _UART2_Init+0, 0
;Exemple_Complet.c,73 :: 		}
L_end_config:
	RETURN      0
; end of _config

_Test_Complet:

;Exemple_Complet.c,74 :: 		void Test_Complet()
;Exemple_Complet.c,76 :: 		LED=0;                              //La lED est éteinte
	BCF         PORTC+0, 2 
;Exemple_Complet.c,78 :: 		LED=1;                             //Allumer la LED
	BSF         PORTC+0, 2 
;Exemple_Complet.c,79 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Test_Complet2:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet2
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet2
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet2
	NOP
	NOP
;Exemple_Complet.c,80 :: 		Lcd_Out(1,1,"Essai");              //Afficher 'essai'
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Exemple_Complet+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Exemple_Complet+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Exemple_Complet.c,81 :: 		UART2_Write('A');                  //Transmettre la lettre A
	MOVLW       65
	MOVWF       FARG_UART2_Write_data_+0 
	CALL        _UART2_Write+0, 0
;Exemple_Complet.c,82 :: 		delay_ms(250);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Test_Complet3:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet3
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet3
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet3
	NOP
	NOP
;Exemple_Complet.c,84 :: 		}
L_end_Test_Complet:
	RETURN      0
; end of _Test_Complet
