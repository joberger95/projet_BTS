
_main:

;Boutons_Poussoir.c,48 :: 		void main()
;Boutons_Poussoir.c,50 :: 		config();
	CALL        _config+0, 0
;Boutons_Poussoir.c,51 :: 		Bouton_Poussoir();
	CALL        _Bouton_Poussoir+0, 0
;Boutons_Poussoir.c,52 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;Boutons_Poussoir.c,54 :: 		void config()
;Boutons_Poussoir.c,56 :: 		OSCCON=0x60;
	MOVLW       96
	MOVWF       OSCCON+0 
;Boutons_Poussoir.c,57 :: 		TRISA=0xFF;                       //0b11111111
	MOVLW       255
	MOVWF       TRISA+0 
;Boutons_Poussoir.c,58 :: 		TRISB=0x13;                       //0b10000011
	MOVLW       19
	MOVWF       TRISB+0 
;Boutons_Poussoir.c,59 :: 		TRISC=0x90;                       //0b10010000
	MOVLW       144
	MOVWF       TRISC+0 
;Boutons_Poussoir.c,60 :: 		TRISE=0xFF;                       //0x11111111
	MOVLW       255
	MOVWF       TRISE+0 
;Boutons_Poussoir.c,62 :: 		Lcd_Init();                       //Initialisation LCD
	CALL        _Lcd_Init+0, 0
;Boutons_Poussoir.c,63 :: 		Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Boutons_Poussoir.c,64 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Boutons_Poussoir.c,65 :: 		}
L_end_config:
	RETURN      0
; end of _config

_Bouton_Poussoir:

;Boutons_Poussoir.c,66 :: 		void Bouton_Poussoir()
;Boutons_Poussoir.c,68 :: 		while(1)                              //Boucle infinie
L_Bouton_Poussoir0:
;Boutons_Poussoir.c,70 :: 		if(BP1==1)                           //SI BP1 enfoncé
	BTFSS       PORTA+0, 1 
	GOTO        L_Bouton_Poussoir2
;Boutons_Poussoir.c,72 :: 		LATC=0xFF;                         //Allumé LED4
	MOVLW       255
	MOVWF       LATC+0 
;Boutons_Poussoir.c,73 :: 		Lcd_Out(1,1,"LED4=Allumée");       //Afficher LED4=Allumé
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Boutons_Poussoir+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Boutons_Poussoir+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Boutons_Poussoir.c,74 :: 		}
	GOTO        L_Bouton_Poussoir3
L_Bouton_Poussoir2:
;Boutons_Poussoir.c,75 :: 		else {LATC=0;}                        //Sinon LED4 éteinte
	CLRF        LATC+0 
L_Bouton_Poussoir3:
;Boutons_Poussoir.c,76 :: 		if(BP2==1)                           //Si BP2 enfoncé
	BTFSS       PORTA+0, 2 
	GOTO        L_Bouton_Poussoir4
;Boutons_Poussoir.c,78 :: 		Lcd_Out(1,1,"LED4=Clignote");     //Afficher LED4=Clignote
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Boutons_Poussoir+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Boutons_Poussoir+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Boutons_Poussoir.c,79 :: 		LATC=0xFF;                        //Fait clignoter LED4
	MOVLW       255
	MOVWF       LATC+0 
;Boutons_Poussoir.c,80 :: 		delay_ms(250);                    //Délai 250ms
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Bouton_Poussoir5:
	DECFSZ      R13, 1, 1
	BRA         L_Bouton_Poussoir5
	DECFSZ      R12, 1, 1
	BRA         L_Bouton_Poussoir5
	DECFSZ      R11, 1, 1
	BRA         L_Bouton_Poussoir5
	NOP
	NOP
;Boutons_Poussoir.c,81 :: 		LATC=0;
	CLRF        LATC+0 
;Boutons_Poussoir.c,82 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Bouton_Poussoir6:
	DECFSZ      R13, 1, 1
	BRA         L_Bouton_Poussoir6
	DECFSZ      R12, 1, 1
	BRA         L_Bouton_Poussoir6
	DECFSZ      R11, 1, 1
	BRA         L_Bouton_Poussoir6
	NOP
	NOP
;Boutons_Poussoir.c,83 :: 		}
	GOTO        L_Bouton_Poussoir7
L_Bouton_Poussoir4:
;Boutons_Poussoir.c,84 :: 		else {LATC=0;}                        //Sinon éteindre LED4
	CLRF        LATC+0 
L_Bouton_Poussoir7:
;Boutons_Poussoir.c,85 :: 		}
	GOTO        L_Bouton_Poussoir0
;Boutons_Poussoir.c,86 :: 		}
L_end_Bouton_Poussoir:
	RETURN      0
; end of _Bouton_Poussoir
