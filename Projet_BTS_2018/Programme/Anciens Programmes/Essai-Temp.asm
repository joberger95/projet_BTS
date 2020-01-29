
_main:

;Essai-Temp.c,54 :: 		void main()
;Essai-Temp.c,56 :: 		config();                         //Appel le sous-programme
	CALL        _config+0, 0
;Essai-Temp.c,57 :: 		while(1)                         //Boucle infinie
L_main0:
;Essai-Temp.c,59 :: 		Lecture_Temp_Hum();
	CALL        _Lecture_Temp_Hum+0, 0
;Essai-Temp.c,60 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
;Essai-Temp.c,61 :: 		}
	GOTO        L_main0
;Essai-Temp.c,62 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;Essai-Temp.c,64 :: 		void config()
;Essai-Temp.c,66 :: 		ANSELA=0x00;                      //Passe toutes les broches en digital
	CLRF        ANSELA+0 
;Essai-Temp.c,67 :: 		ANSELB=0x00;
	CLRF        ANSELB+0 
;Essai-Temp.c,68 :: 		ANSELC=0x00;
	CLRF        ANSELC+0 
;Essai-Temp.c,70 :: 		TRISA=0xFF;                       //0b11111111
	MOVLW       255
	MOVWF       TRISA+0 
;Essai-Temp.c,71 :: 		TRISB=0x81;                       //0b10000001
	MOVLW       129
	MOVWF       TRISB+0 
;Essai-Temp.c,72 :: 		TRISC=0x99;                       //0b10011001
	MOVLW       153
	MOVWF       TRISC+0 
;Essai-Temp.c,74 :: 		Lcd_Init();                       //Initialisation LCD
	CALL        _Lcd_Init+0, 0
;Essai-Temp.c,75 :: 		Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Essai-Temp.c,76 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Essai-Temp.c,78 :: 		I2C1_Init(100000);                //Initialisation I2C
	MOVLW       20
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;Essai-Temp.c,81 :: 		}
L_end_config:
	RETURN      0
; end of _config

_Lecture_Temp_Hum:

;Essai-Temp.c,82 :: 		void Lecture_Temp_Hum()
;Essai-Temp.c,84 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;Essai-Temp.c,85 :: 		I2C1_Wr(0x4E);
	MOVLW       78
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Essai-Temp.c,86 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;Essai-Temp.c,87 :: 		I2C1_Wr(0x4F);
	MOVLW       79
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Essai-Temp.c,88 :: 		HumMSB=I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _HumMSB+0 
	MOVLW       0
	MOVWF       _HumMSB+1 
;Essai-Temp.c,89 :: 		HumLSB=I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _HumLSB+0 
	MOVLW       0
	MOVWF       _HumLSB+1 
;Essai-Temp.c,90 :: 		TempMSB=I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _TempMSB+0 
	MOVLW       0
	MOVWF       _TempMSB+1 
;Essai-Temp.c,91 :: 		TempLSB=I2C1_Rd(0);      // et Nack Master
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _TempLSB+0 
	MOVLW       0
	MOVWF       _TempLSB+1 
;Essai-Temp.c,92 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;Essai-Temp.c,97 :: 		TempTotale=TempMSB*256;
	MOVF        _TempMSB+0, 0 
	MOVWF       _TempTotale+1 
	CLRF        _TempTotale+0 
;Essai-Temp.c,98 :: 		TempTotale=TempTotale+TempLSB;
	MOVF        _TempLSB+0, 0 
	ADDWF       _TempTotale+0, 1 
	MOVF        _TempLSB+1, 0 
	ADDWFC      _TempTotale+1, 1 
;Essai-Temp.c,99 :: 		TempTotale=TempTotale >> 2;
	RRCF        _TempTotale+1, 1 
	RRCF        _TempTotale+0, 1 
	BCF         _TempTotale+1, 7 
	BTFSC       _TempTotale+1, 6 
	BSF         _TempTotale+1, 7 
	RRCF        _TempTotale+1, 1 
	RRCF        _TempTotale+0, 1 
	BCF         _TempTotale+1, 7 
	BTFSC       _TempTotale+1, 6 
	BSF         _TempTotale+1, 7 
;Essai-Temp.c,105 :: 		tempcalcul= 6618; //TempTotale;
	MOVLW       0
	MOVWF       _tempcalcul+0 
	MOVLW       208
	MOVWF       _tempcalcul+1 
	MOVLW       78
	MOVWF       _tempcalcul+2 
	MOVLW       139
	MOVWF       _tempcalcul+3 
;Essai-Temp.c,106 :: 		tempcalcul=tempcalcul/16382;
	MOVLW       119
	MOVWF       _tempcalcul+0 
	MOVLW       214
	MOVWF       _tempcalcul+1 
	MOVLW       78
	MOVWF       _tempcalcul+2 
	MOVLW       125
	MOVWF       _tempcalcul+3 
;Essai-Temp.c,107 :: 		tempcalcul=tempcalcul*165;
	MOVLW       59
	MOVWF       _tempcalcul+0 
	MOVLW       80
	MOVWF       _tempcalcul+1 
	MOVLW       5
	MOVWF       _tempcalcul+2 
	MOVLW       133
	MOVWF       _tempcalcul+3 
;Essai-Temp.c,108 :: 		tempcalcul=tempcalcul-40;
	MOVLW       236
	MOVWF       _tempcalcul+0 
	MOVLW       64
	MOVWF       _tempcalcul+1 
	MOVLW       85
	MOVWF       _tempcalcul+2 
	MOVLW       131
	MOVWF       _tempcalcul+3 
;Essai-Temp.c,112 :: 		Reste = tempcalcul;     // Reste = Partie entière
	MOVLW       236
	MOVWF       R0 
	MOVLW       64
	MOVWF       R1 
	MOVLW       85
	MOVWF       R2 
	MOVLW       131
	MOVWF       R3 
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       _Reste+0 
	MOVF        R1, 0 
	MOVWF       _Reste+1 
;Essai-Temp.c,113 :: 		cent=Reste/100;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _cent+0 
;Essai-Temp.c,114 :: 		Reste= Reste -cent*100;
	MOVLW       100
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	SUBWF       _Reste+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	SUBWFB      _Reste+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Reste+0 
	MOVF        R1, 0 
	MOVWF       _Reste+1 
;Essai-Temp.c,115 :: 		diz= Reste /10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _diz+0 
;Essai-Temp.c,116 :: 		unit= Reste % 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _Reste+0, 0 
	MOVWF       R0 
	MOVF        _Reste+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _unit+0 
;Essai-Temp.c,119 :: 		Lcd_chr(2,1,cent+0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       _cent+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Essai-Temp.c,120 :: 		Lcd_chr_Cp(diz+0x30);
	MOVLW       48
	ADDWF       _diz+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Essai-Temp.c,121 :: 		Lcd_chr_Cp(unit+0x30);
	MOVLW       48
	ADDWF       _unit+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Essai-Temp.c,122 :: 		delay_ms(150);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       134
	MOVWF       R12, 0
	MOVLW       153
	MOVWF       R13, 0
L_Lecture_Temp_Hum3:
	DECFSZ      R13, 1, 1
	BRA         L_Lecture_Temp_Hum3
	DECFSZ      R12, 1, 1
	BRA         L_Lecture_Temp_Hum3
	DECFSZ      R11, 1, 1
	BRA         L_Lecture_Temp_Hum3
;Essai-Temp.c,130 :: 		}
L_end_Lecture_Temp_Hum:
	RETURN      0
; end of _Lecture_Temp_Hum
