
_main:

;Test_Affichage.c,46 :: 		void main()
;Test_Affichage.c,48 :: 		config();
	CALL        _config+0, 0
;Test_Affichage.c,49 :: 		affichage();
	CALL        _affichage+0, 0
;Test_Affichage.c,50 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;Test_Affichage.c,52 :: 		void config()
;Test_Affichage.c,54 :: 		ANSELA=0x00;
	CLRF        ANSELA+0 
;Test_Affichage.c,55 :: 		ANSELB=0x00;
	CLRF        ANSELB+0 
;Test_Affichage.c,56 :: 		ANSELC=0x00;
	CLRF        ANSELC+0 
;Test_Affichage.c,57 :: 		OSCCON=0x60;
	MOVLW       96
	MOVWF       OSCCON+0 
;Test_Affichage.c,58 :: 		TRISA=0xFF;                       //0b11111111
	MOVLW       255
	MOVWF       TRISA+0 
;Test_Affichage.c,59 :: 		TRISB=0x13;                       //0b10000011
	MOVLW       19
	MOVWF       TRISB+0 
;Test_Affichage.c,60 :: 		TRISC=0x90;                       //0b10010000
	MOVLW       144
	MOVWF       TRISC+0 
;Test_Affichage.c,61 :: 		TRISE=0xFF;                       //0x11111111
	MOVLW       255
	MOVWF       TRISE+0 
;Test_Affichage.c,63 :: 		Lcd_Init();                       //Initialisation LCD
	CALL        _Lcd_Init+0, 0
;Test_Affichage.c,64 :: 		Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Affichage.c,65 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Affichage.c,66 :: 		}
L_end_config:
	RETURN      0
; end of _config

_affichage:

;Test_Affichage.c,67 :: 		void affichage()
;Test_Affichage.c,69 :: 		Lcd_Out(1,1,"Essai");               //Affiche Essai
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Test_Affichage+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Test_Affichage+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Affichage.c,70 :: 		}
L_end_affichage:
	RETURN      0
; end of _affichage
