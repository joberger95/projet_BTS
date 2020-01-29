
_main:

;Essai_Temp_Hum_2.c,53 :: 		void main()
;Essai_Temp_Hum_2.c,55 :: 		config();                         //Appel le sous-programme
	CALL        _config+0, 0
;Essai_Temp_Hum_2.c,56 :: 		while(1)                         //Boucle infinie
L_main0:
;Essai_Temp_Hum_2.c,58 :: 		Lecture_Temp_Hum();
	CALL        _Lecture_Temp_Hum+0, 0
;Essai_Temp_Hum_2.c,59 :: 		delay_ms(200);
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
;Essai_Temp_Hum_2.c,60 :: 		}
	GOTO        L_main0
;Essai_Temp_Hum_2.c,61 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;Essai_Temp_Hum_2.c,63 :: 		void config()
;Essai_Temp_Hum_2.c,65 :: 		ANSELA=0x00;                      //Passe toutes les broches en digital
	CLRF        ANSELA+0 
;Essai_Temp_Hum_2.c,66 :: 		ANSELB=0x00;
	CLRF        ANSELB+0 
;Essai_Temp_Hum_2.c,67 :: 		ANSELC=0x00;
	CLRF        ANSELC+0 
;Essai_Temp_Hum_2.c,69 :: 		TRISA=0xFF;                       //0b11111111
	MOVLW       255
	MOVWF       TRISA+0 
;Essai_Temp_Hum_2.c,70 :: 		TRISB=0x81;                       //0b10000001
	MOVLW       129
	MOVWF       TRISB+0 
;Essai_Temp_Hum_2.c,71 :: 		TRISC=0x99;                       //0b10011001
	MOVLW       153
	MOVWF       TRISC+0 
;Essai_Temp_Hum_2.c,73 :: 		Lcd_Init();                       //Initialisation LCD
	CALL        _Lcd_Init+0, 0
;Essai_Temp_Hum_2.c,74 :: 		Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Essai_Temp_Hum_2.c,75 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Essai_Temp_Hum_2.c,77 :: 		I2C1_Init(100000);                //Initialisation I2C
	MOVLW       20
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;Essai_Temp_Hum_2.c,79 :: 		Lcd_Out(1,1,"Lecture Hum/Temp");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Essai_Temp_Hum_2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Essai_Temp_Hum_2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Essai_Temp_Hum_2.c,80 :: 		}
L_end_config:
	RETURN      0
; end of _config

_Lecture_Temp_Hum:

;Essai_Temp_Hum_2.c,81 :: 		void Lecture_Temp_Hum()
;Essai_Temp_Hum_2.c,83 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;Essai_Temp_Hum_2.c,84 :: 		I2C1_Wr(0x4E);
	MOVLW       78
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Essai_Temp_Hum_2.c,85 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;Essai_Temp_Hum_2.c,86 :: 		I2C1_Wr(0x4F);
	MOVLW       79
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Essai_Temp_Hum_2.c,87 :: 		HumMSB=I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _HumMSB+0 
	MOVLW       0
	MOVWF       _HumMSB+1 
;Essai_Temp_Hum_2.c,88 :: 		HumLSB=I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _HumLSB+0 
	MOVLW       0
	MOVWF       _HumLSB+1 
;Essai_Temp_Hum_2.c,89 :: 		TempMSB=I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _TempMSB+0 
	MOVLW       0
	MOVWF       _TempMSB+1 
;Essai_Temp_Hum_2.c,90 :: 		TempLSB=I2C1_Rd(0);      // et Nack Master
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _TempLSB+0 
	MOVLW       0
	MOVWF       _TempLSB+1 
;Essai_Temp_Hum_2.c,91 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;Essai_Temp_Hum_2.c,94 :: 		HumTotale=HumMSB*256;
	MOVF        _HumMSB+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	MOVWF       _HumTotale+0 
	MOVF        R1, 0 
	MOVWF       _HumTotale+1 
;Essai_Temp_Hum_2.c,95 :: 		HumTotale=HumTotale+HumLSB;
	MOVF        _HumLSB+0, 0 
	ADDWF       R0, 1 
	MOVF        _HumLSB+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _HumTotale+0 
	MOVF        R1, 0 
	MOVWF       _HumTotale+1 
;Essai_Temp_Hum_2.c,96 :: 		humcalcul=HumTotale;
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       _humcalcul+0 
	MOVF        R1, 0 
	MOVWF       _humcalcul+1 
	MOVF        R2, 0 
	MOVWF       _humcalcul+2 
	MOVF        R3, 0 
	MOVWF       _humcalcul+3 
;Essai_Temp_Hum_2.c,97 :: 		humcalcul=humcalcul/16382;
	MOVLW       0
	MOVWF       R4 
	MOVLW       248
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       140
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _humcalcul+0 
	MOVF        R1, 0 
	MOVWF       _humcalcul+1 
	MOVF        R2, 0 
	MOVWF       _humcalcul+2 
	MOVF        R3, 0 
	MOVWF       _humcalcul+3 
;Essai_Temp_Hum_2.c,98 :: 		humcalcul=humcalcul*100;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _humcalcul+0 
	MOVF        R1, 0 
	MOVWF       _humcalcul+1 
	MOVF        R2, 0 
	MOVWF       _humcalcul+2 
	MOVF        R3, 0 
	MOVWF       _humcalcul+3 
;Essai_Temp_Hum_2.c,100 :: 		Resteh = humcalcul;     // Reste = Partie entière
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       _Resteh+0 
	MOVF        R1, 0 
	MOVWF       _Resteh+1 
;Essai_Temp_Hum_2.c,101 :: 		centh=Resteh/100;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _centh+0 
;Essai_Temp_Hum_2.c,102 :: 		Resteh= Resteh -cent*100;
	MOVLW       100
	MULWF       _cent+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	SUBWF       _Resteh+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	SUBWFB      _Resteh+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Resteh+0 
	MOVF        R1, 0 
	MOVWF       _Resteh+1 
;Essai_Temp_Hum_2.c,103 :: 		dizh= Resteh /10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _dizh+0 
;Essai_Temp_Hum_2.c,104 :: 		unith= Resteh % 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _Resteh+0, 0 
	MOVWF       R0 
	MOVF        _Resteh+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _unith+0 
;Essai_Temp_Hum_2.c,106 :: 		if(cent==1) Lcd_chr(2,10,centh+0x30);
	MOVF        _cent+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Lecture_Temp_Hum3
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       _centh+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
L_Lecture_Temp_Hum3:
;Essai_Temp_Hum_2.c,107 :: 		if(cent==0) Lcd_Out(2,10," ");
	MOVF        _cent+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Lecture_Temp_Hum4
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Essai_Temp_Hum_2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Essai_Temp_Hum_2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_Lecture_Temp_Hum4:
;Essai_Temp_Hum_2.c,108 :: 		Lcd_chr(2,3,centh+0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       _centh+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Essai_Temp_Hum_2.c,110 :: 		Lcd_chr_Cp(unith+0x30);
	MOVLW       48
	ADDWF       _unith+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Essai_Temp_Hum_2.c,111 :: 		Lcd_Out_Cp("%");
	MOVLW       ?lstr3_Essai_Temp_Hum_2+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr3_Essai_Temp_Hum_2+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Essai_Temp_Hum_2.c,112 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_Lecture_Temp_Hum5:
	DECFSZ      R13, 1, 1
	BRA         L_Lecture_Temp_Hum5
	DECFSZ      R12, 1, 1
	BRA         L_Lecture_Temp_Hum5
	NOP
;Essai_Temp_Hum_2.c,115 :: 		TempTotale=TempMSB*256;
	MOVF        _TempMSB+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	MOVWF       _TempTotale+0 
	MOVF        R1, 0 
	MOVWF       _TempTotale+1 
;Essai_Temp_Hum_2.c,116 :: 		TempTotale=TempTotale+TempLSB;
	MOVF        _TempLSB+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVF        _TempLSB+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       _TempTotale+0 
	MOVF        R4, 0 
	MOVWF       _TempTotale+1 
;Essai_Temp_Hum_2.c,117 :: 		TempTotale=TempTotale >> 2;
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       _TempTotale+0 
	MOVF        R1, 0 
	MOVWF       _TempTotale+1 
;Essai_Temp_Hum_2.c,120 :: 		tempcalcul= TempTotale;
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       _tempcalcul+0 
	MOVF        R1, 0 
	MOVWF       _tempcalcul+1 
	MOVF        R2, 0 
	MOVWF       _tempcalcul+2 
	MOVF        R3, 0 
	MOVWF       _tempcalcul+3 
;Essai_Temp_Hum_2.c,121 :: 		tempcalcul=tempcalcul/16382;
	MOVLW       0
	MOVWF       R4 
	MOVLW       248
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       140
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _tempcalcul+0 
	MOVF        R1, 0 
	MOVWF       _tempcalcul+1 
	MOVF        R2, 0 
	MOVWF       _tempcalcul+2 
	MOVF        R3, 0 
	MOVWF       _tempcalcul+3 
;Essai_Temp_Hum_2.c,122 :: 		tempcalcul=tempcalcul*165;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       37
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _tempcalcul+0 
	MOVF        R1, 0 
	MOVWF       _tempcalcul+1 
	MOVF        R2, 0 
	MOVWF       _tempcalcul+2 
	MOVF        R3, 0 
	MOVWF       _tempcalcul+3 
;Essai_Temp_Hum_2.c,123 :: 		tempcalcul=tempcalcul-40;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _tempcalcul+0 
	MOVF        R1, 0 
	MOVWF       _tempcalcul+1 
	MOVF        R2, 0 
	MOVWF       _tempcalcul+2 
	MOVF        R3, 0 
	MOVWF       _tempcalcul+3 
;Essai_Temp_Hum_2.c,126 :: 		Reste = tempcalcul;     // Reste = Partie entière
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       _Reste+0 
	MOVF        R1, 0 
	MOVWF       _Reste+1 
;Essai_Temp_Hum_2.c,127 :: 		cent=Reste/100;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _cent+0 
;Essai_Temp_Hum_2.c,128 :: 		Reste= Reste -cent*100;
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
;Essai_Temp_Hum_2.c,129 :: 		diz= Reste /10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _diz+0 
;Essai_Temp_Hum_2.c,130 :: 		unit= Reste % 10;
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
;Essai_Temp_Hum_2.c,132 :: 		if(cent==1) Lcd_chr(2,10,cent+0x30);
	MOVF        _cent+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Lecture_Temp_Hum6
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       _cent+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
L_Lecture_Temp_Hum6:
;Essai_Temp_Hum_2.c,133 :: 		if(cent==0) Lcd_Out(2,10," ");
	MOVF        _cent+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Lecture_Temp_Hum7
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_Essai_Temp_Hum_2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_Essai_Temp_Hum_2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_Lecture_Temp_Hum7:
;Essai_Temp_Hum_2.c,134 :: 		Lcd_chr_Cp(diz+0x30);
	MOVLW       48
	ADDWF       _diz+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Essai_Temp_Hum_2.c,135 :: 		Lcd_chr_Cp(unit+0x30);
	MOVLW       48
	ADDWF       _unit+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Essai_Temp_Hum_2.c,136 :: 		Lcd_Out_Cp("`");
	MOVLW       ?lstr5_Essai_Temp_Hum_2+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr5_Essai_Temp_Hum_2+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Essai_Temp_Hum_2.c,137 :: 		Lcd_Out_Cp("C");
	MOVLW       ?lstr6_Essai_Temp_Hum_2+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr6_Essai_Temp_Hum_2+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Essai_Temp_Hum_2.c,138 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_Lecture_Temp_Hum8:
	DECFSZ      R13, 1, 1
	BRA         L_Lecture_Temp_Hum8
	DECFSZ      R12, 1, 1
	BRA         L_Lecture_Temp_Hum8
	NOP
;Essai_Temp_Hum_2.c,139 :: 		}
L_end_Lecture_Temp_Hum:
	RETURN      0
; end of _Lecture_Temp_Hum
