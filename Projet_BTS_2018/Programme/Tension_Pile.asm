
_main:

;Tension_Pile.c,51 :: 		void main()
;Tension_Pile.c,53 :: 		config();                         //Appel le sous-programme
	CALL        _config+0, 0
;Tension_Pile.c,54 :: 		while(1)                         //Boucle infinie
L_main0:
;Tension_Pile.c,56 :: 		Vpile();
	CALL        _Vpile+0, 0
;Tension_Pile.c,57 :: 		delay_ms(150);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       134
	MOVWF       R12, 0
	MOVLW       153
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
;Tension_Pile.c,58 :: 		}
	GOTO        L_main0
;Tension_Pile.c,59 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;Tension_Pile.c,63 :: 		void config()
;Tension_Pile.c,65 :: 		ANSELA=0x01;                      //Passe toutes les broches en digital
	MOVLW       1
	MOVWF       ANSELA+0 
;Tension_Pile.c,66 :: 		ANSELB=0x00;
	CLRF        ANSELB+0 
;Tension_Pile.c,67 :: 		ANSELC=0x00;
	CLRF        ANSELC+0 
;Tension_Pile.c,69 :: 		TRISA=0xFF;                       //0b11111111
	MOVLW       255
	MOVWF       TRISA+0 
;Tension_Pile.c,70 :: 		TRISB=0x81;                       //0b10000001
	MOVLW       129
	MOVWF       TRISB+0 
;Tension_Pile.c,71 :: 		TRISC=0x99;                       //0b10011001
	MOVLW       153
	MOVWF       TRISC+0 
;Tension_Pile.c,73 :: 		Lcd_Init();                       //Initialisation LCD
	CALL        _Lcd_Init+0, 0
;Tension_Pile.c,74 :: 		Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Tension_Pile.c,75 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Tension_Pile.c,77 :: 		Lcd_Out(1,1,"Tension Pile");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Tension_Pile+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Tension_Pile+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Tension_Pile.c,78 :: 		}
L_end_config:
	RETURN      0
; end of _config

_Vpile:

;Tension_Pile.c,79 :: 		void Vpile()
;Tension_Pile.c,81 :: 		Vbat=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Vbat+0 
	MOVF        R1, 0 
	MOVWF       _Vbat+1 
;Tension_Pile.c,82 :: 		Vbat=Vbat*0.0048828125;
	CALL        _Int2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       119
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       _Vbat+0 
	MOVF        R1, 0 
	MOVWF       _Vbat+1 
;Tension_Pile.c,83 :: 		IntToStr(Vbat,tension);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVF        _tension+0, 0 
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Tension_Pile.c,84 :: 		Lcd_Out(2,1,tension);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _tension+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Tension_Pile.c,85 :: 		Lcd_Out_Cp("V");
	MOVLW       ?lstr2_Tension_Pile+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr2_Tension_Pile+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Tension_Pile.c,86 :: 		}
L_end_Vpile:
	RETURN      0
; end of _Vpile
