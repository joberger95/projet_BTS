
_main:

;Cligno_LED.c,47 :: 		void main()
;Cligno_LED.c,49 :: 		configuration();                  //Appel au sous-programme configuration
	CALL        _configuration+0, 0
;Cligno_LED.c,50 :: 		while(1)
L_main0:
;Cligno_LED.c,52 :: 		Clign_LED();                      //Appel au sous-programme Clign_LED
	CALL        _Clign_LED+0, 0
;Cligno_LED.c,53 :: 		}
	GOTO        L_main0
;Cligno_LED.c,54 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_configuration:

;Cligno_LED.c,56 :: 		void configuration()
;Cligno_LED.c,58 :: 		TRISA=0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;Cligno_LED.c,59 :: 		TRISC=0x00;
	CLRF        TRISC+0 
;Cligno_LED.c,63 :: 		}
L_end_configuration:
	RETURN      0
; end of _configuration

_Clign_LED:

;Cligno_LED.c,64 :: 		void Clign_LED()
;Cligno_LED.c,67 :: 		if(PORTA.F1==1) LATC=0;
	BTFSS       PORTA+0, 1 
	GOTO        L_Clign_LED2
	CLRF        LATC+0 
L_Clign_LED2:
;Cligno_LED.c,68 :: 		if(PORTA.F1==0) LATC=0xFF;
	BTFSC       PORTA+0, 1 
	GOTO        L_Clign_LED3
	MOVLW       255
	MOVWF       LATC+0 
L_Clign_LED3:
;Cligno_LED.c,70 :: 		}
L_end_Clign_LED:
	RETURN      0
; end of _Clign_LED
