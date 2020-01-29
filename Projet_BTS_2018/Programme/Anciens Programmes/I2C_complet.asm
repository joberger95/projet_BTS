
_main:

;I2C_complet.c,55 :: 		void main()
;I2C_complet.c,57 :: 		config();                         //Appel le sous-programme
	CALL        _config+0, 0
;I2C_complet.c,58 :: 		while(1)
L_main0:
;I2C_complet.c,60 :: 		communication();
	CALL        _Communication+0, 0
;I2C_complet.c,61 :: 		}
	GOTO        L_main0
;I2C_complet.c,62 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;I2C_complet.c,63 :: 		void config()
;I2C_complet.c,65 :: 		ANSELA=0x00;                      //Passe toutes les broches en digital
	CLRF        ANSELA+0 
;I2C_complet.c,66 :: 		ANSELB=0x00;
	CLRF        ANSELB+0 
;I2C_complet.c,67 :: 		ANSELC=0x00;
	CLRF        ANSELC+0 
;I2C_complet.c,68 :: 		TRISA=0xFF;                       //0b11111111
	MOVLW       255
	MOVWF       TRISA+0 
;I2C_complet.c,69 :: 		TRISB=0x13;                       //0b10000011
	MOVLW       19
	MOVWF       TRISB+0 
;I2C_complet.c,70 :: 		TRISC=0x90;                       //0b10010000
	MOVLW       144
	MOVWF       TRISC+0 
;I2C_complet.c,71 :: 		TRISE=0xFF;                       //0x11111111
	MOVLW       255
	MOVWF       TRISE+0 
;I2C_complet.c,73 :: 		Lcd_Init();                       //Initialisation LCD
	CALL        _Lcd_Init+0, 0
;I2C_complet.c,74 :: 		Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;I2C_complet.c,75 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;I2C_complet.c,76 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_config2:
	DECFSZ      R13, 1, 1
	BRA         L_config2
	DECFSZ      R12, 1, 1
	BRA         L_config2
	DECFSZ      R11, 1, 1
	BRA         L_config2
;I2C_complet.c,78 :: 		UART1_Init(9600);                 //Initialisation GSM
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;I2C_complet.c,79 :: 		UART2_Init(9600);                 //Initialisation RS232
	BSF         BAUDCON2+0, 3, 0
	CLRF        SPBRGH2+0 
	MOVLW       207
	MOVWF       SPBRG2+0 
	BSF         TXSTA2+0, 2, 0
	CALL        _UART2_Init+0, 0
;I2C_complet.c,81 :: 		I2C1_Init(100000);
	MOVLW       20
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;I2C_complet.c,82 :: 		}
L_end_config:
	RETURN      0
; end of _config

_communication:

;I2C_complet.c,83 :: 		void communication()
;I2C_complet.c,85 :: 		vari=0;
	CLRF        _vari+0 
;I2C_complet.c,86 :: 		if(BP1==0)
	BTFSC       PORTA+0, 1 
	GOTO        L_communication3
;I2C_complet.c,88 :: 		vari=1;
	MOVLW       1
	MOVWF       _vari+0 
;I2C_complet.c,89 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_communication4:
	DECFSZ      R13, 1, 1
	BRA         L_communication4
	DECFSZ      R12, 1, 1
	BRA         L_communication4
	NOP
;I2C_complet.c,90 :: 		}
L_communication3:
;I2C_complet.c,91 :: 		if(vari==1)
	MOVF        _vari+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_communication5
;I2C_complet.c,94 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;I2C_complet.c,95 :: 		I2C1_Wr(0xDE);
	MOVLW       222
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,96 :: 		I2C1_Wr(0);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,97 :: 		I2C1_Wr(0x80);       //0 sec
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,99 :: 		I2C1_Wr(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,100 :: 		I2C1_Wr(0x00);       //0 min
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,102 :: 		I2C1_Wr(0x02);
	MOVLW       2
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,103 :: 		I2C1_Wr(0x40);       //24h, 0h
	MOVLW       64
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,105 :: 		I2C1_Wr(3);
	MOVLW       3
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,106 :: 		I2C1_Wr(0x21);       //Lundi
	MOVLW       33
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,108 :: 		I2C1_Wr(0x04);
	MOVLW       4
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,109 :: 		I2C1_Wr(0x01);       //1
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,111 :: 		I2C1_Wr(0x05);
	MOVLW       5
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,112 :: 		I2C1_Wr(0x06);       //Juin
	MOVLW       6
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,114 :: 		I2C1_Wr(0x06);
	MOVLW       6
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,115 :: 		I2C1_Wr(0x18);       //18 (2018)
	MOVLW       24
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,116 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;I2C_complet.c,117 :: 		vari=0;
	CLRF        _vari+0 
;I2C_complet.c,119 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_communication6:
	DECFSZ      R13, 1, 1
	BRA         L_communication6
	DECFSZ      R12, 1, 1
	BRA         L_communication6
	DECFSZ      R11, 1, 1
	BRA         L_communication6
	NOP
;I2C_complet.c,120 :: 		}
L_communication5:
;I2C_complet.c,122 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;I2C_complet.c,123 :: 		I2C1_Wr(0xDE);
	MOVLW       222
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,124 :: 		I2C1_Wr(2);
	MOVLW       2
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,125 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;I2C_complet.c,126 :: 		I2C1_Wr(0xDF);
	MOVLW       223
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,127 :: 		reponseH=I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _reponseH+0 
	MOVLW       0
	MOVWF       _reponseH+1 
;I2C_complet.c,128 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;I2C_complet.c,130 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;I2C_complet.c,131 :: 		I2C1_Wr(0xDE);
	MOVLW       222
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,132 :: 		I2C1_Wr(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,133 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;I2C_complet.c,134 :: 		I2C1_Wr(0xDF);
	MOVLW       223
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C_complet.c,135 :: 		reponseM=I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _reponseM+0 
	MOVLW       0
	MOVWF       _reponseM+1 
;I2C_complet.c,136 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;I2C_complet.c,138 :: 		IntToStr(reponseH,heure);
	MOVF        _reponseH+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _reponseH+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _heure+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_heure+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;I2C_complet.c,139 :: 		IntToStr(reponseM,minute);
	MOVF        _reponseM+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _reponseM+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _minute+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_minute+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;I2C_complet.c,141 :: 		Lcd_Out(1,4,minute);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _minute+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_minute+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;I2C_complet.c,142 :: 		Lcd_Out_Cp("m");
	MOVLW       ?lstr1_I2C_complet+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr1_I2C_complet+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;I2C_complet.c,143 :: 		Lcd_Out(1,1,heure);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _heure+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_heure+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;I2C_complet.c,144 :: 		Lcd_Out_Cp("h");
	MOVLW       ?lstr2_I2C_complet+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr2_I2C_complet+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;I2C_complet.c,145 :: 		Lcd_Out(2,1,"Fin Sequence");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_I2C_complet+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_I2C_complet+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;I2C_complet.c,146 :: 		delay_ms(150);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       134
	MOVWF       R12, 0
	MOVLW       153
	MOVWF       R13, 0
L_communication7:
	DECFSZ      R13, 1, 1
	BRA         L_communication7
	DECFSZ      R12, 1, 1
	BRA         L_communication7
	DECFSZ      R11, 1, 1
	BRA         L_communication7
;I2C_complet.c,147 :: 		}
L_end_communication:
	RETURN      0
; end of _communication
