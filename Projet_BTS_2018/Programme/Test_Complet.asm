
_main:

;Test_Complet.c,58 :: 		void main()
;Test_Complet.c,60 :: 		config();                         //Appel le sous-programme
	CALL        _config+0, 0
;Test_Complet.c,61 :: 		while(1)                         //Boucle infinie
L_main0:
;Test_Complet.c,63 :: 		Test_Complet();
	CALL        _Test_Complet+0, 0
;Test_Complet.c,64 :: 		Lecture_Heure();
	CALL        _Lecture_Heure+0, 0
;Test_Complet.c,65 :: 		}
	GOTO        L_main0
;Test_Complet.c,66 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;Test_Complet.c,68 :: 		void config()
;Test_Complet.c,70 :: 		ANSELA=0x00;                      //Passe toutes les broches en digital
	CLRF        ANSELA+0 
;Test_Complet.c,71 :: 		ANSELB=0x00;
	CLRF        ANSELB+0 
;Test_Complet.c,72 :: 		ANSELC=0x00;
	CLRF        ANSELC+0 
;Test_Complet.c,74 :: 		TRISA=0xFF;                       //0b11111111
	MOVLW       255
	MOVWF       TRISA+0 
;Test_Complet.c,75 :: 		TRISB=0x81;                       //0b10000001
	MOVLW       129
	MOVWF       TRISB+0 
;Test_Complet.c,76 :: 		TRISC=0x99;                       //0b10011001
	MOVLW       153
	MOVWF       TRISC+0 
;Test_Complet.c,78 :: 		Lcd_Init();                       //Initialisation LCD
	CALL        _Lcd_Init+0, 0
;Test_Complet.c,79 :: 		Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet.c,80 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet.c,82 :: 		UART1_Init(9600);                 //Initialisation GSM
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Test_Complet.c,83 :: 		UART2_Init(9600);                 //Initialisation RS232
	BSF         BAUDCON2+0, 3, 0
	CLRF        SPBRGH2+0 
	MOVLW       207
	MOVWF       SPBRG2+0 
	BSF         TXSTA2+0, 2, 0
	CALL        _UART2_Init+0, 0
;Test_Complet.c,85 :: 		I2C1_Init(100000);                //Initialisaition I2C
	MOVLW       20
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;Test_Complet.c,86 :: 		Param_Heure();                    //Appel sous-programme param horodatage
	CALL        _Param_Heure+0, 0
;Test_Complet.c,88 :: 		Sound_Init(&PORTC,5);
	MOVLW       PORTC+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	MOVLW       5
	MOVWF       FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;Test_Complet.c,91 :: 		}
L_end_config:
	RETURN      0
; end of _config

_Param_Heure:

;Test_Complet.c,93 :: 		void Param_Heure()
;Test_Complet.c,96 :: 		I2C1_Start();        //Condition de Start
	CALL        _I2C1_Start+0, 0
;Test_Complet.c,97 :: 		I2C1_Wr(0xDE);       //Adresse HTR+W
	MOVLW       222
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet.c,98 :: 		I2C1_Wr(0);          //Adresse mémoire 0
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet.c,99 :: 		I2C1_Wr(0x80);       //0 sec
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet.c,100 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;Test_Complet.c,102 :: 		I2C1_Start();        //Condition de Start
	CALL        _I2C1_Start+0, 0
;Test_Complet.c,103 :: 		I2C1_Wr(0xDE);       //Adresse HTR+W
	MOVLW       222
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet.c,104 :: 		I2C1_Wr(1);          //Adresse mémoire 1
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet.c,105 :: 		I2C1_Wr(0x21);       //0 min
	MOVLW       33
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet.c,106 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;Test_Complet.c,108 :: 		I2C1_Start();        //Condition de Start
	CALL        _I2C1_Start+0, 0
;Test_Complet.c,109 :: 		I2C1_Wr(0xDE);       //Adresse HTR+W
	MOVLW       222
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet.c,110 :: 		I2C1_Wr(0x02);       //Adresse mémoire 2
	MOVLW       2
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet.c,111 :: 		I2C1_Wr(0x50);       //24h, 0h
	MOVLW       80
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet.c,112 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;Test_Complet.c,114 :: 		}
L_end_Param_Heure:
	RETURN      0
; end of _Param_Heure

_retchar:

;Test_Complet.c,116 :: 		void retchar()
;Test_Complet.c,118 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_retchar2:
	DECFSZ      R13, 1, 1
	BRA         L_retchar2
	DECFSZ      R12, 1, 1
	BRA         L_retchar2
	DECFSZ      R11, 1, 1
	BRA         L_retchar2
	NOP
	NOP
;Test_Complet.c,119 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Test_Complet.c,120 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Test_Complet.c,121 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_retchar3:
	DECFSZ      R13, 1, 1
	BRA         L_retchar3
	DECFSZ      R12, 1, 1
	BRA         L_retchar3
	DECFSZ      R11, 1, 1
	BRA         L_retchar3
;Test_Complet.c,122 :: 		}
L_end_retchar:
	RETURN      0
; end of _retchar

_Test_Complet:

;Test_Complet.c,125 :: 		void Test_Complet()
;Test_Complet.c,127 :: 		if(BP1==0)
	BTFSC       PORTA+0, 1 
	GOTO        L_Test_Complet4
;Test_Complet.c,129 :: 		LedOrange=1;
	BSF         PORTC+0, 2 
;Test_Complet.c,130 :: 		UART2_Write_Text("Test Complet");
	MOVLW       ?lstr1_Test_Complet+0
	MOVWF       FARG_UART2_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_Test_Complet+0)
	MOVWF       FARG_UART2_Write_Text_uart_text+1 
	CALL        _UART2_Write_Text+0, 0
;Test_Complet.c,131 :: 		UART2_Write(13);
	MOVLW       13
	MOVWF       FARG_UART2_Write_data_+0 
	CALL        _UART2_Write+0, 0
;Test_Complet.c,132 :: 		UART2_Write(10);
	MOVLW       10
	MOVWF       FARG_UART2_Write_data_+0 
	CALL        _UART2_Write+0, 0
;Test_Complet.c,133 :: 		Lcd_Out(1,1,"Transm Serie");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Test_Complet+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Test_Complet+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet.c,134 :: 		delay_ms(5000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_Test_Complet5:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet5
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet5
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet5
	NOP
	NOP
;Test_Complet.c,135 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet.c,136 :: 		Sound_Play(LA,250);
	MOVLW       184
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       250
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;Test_Complet.c,137 :: 		}
L_Test_Complet4:
;Test_Complet.c,138 :: 		if(BP2==0)
	BTFSC       PORTA+0, 2 
	GOTO        L_Test_Complet6
;Test_Complet.c,140 :: 		UART1_Write_Text("AT");
	MOVLW       ?lstr3_Test_Complet+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_Test_Complet+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet.c,141 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet.c,142 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Test_Complet7:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet7
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet7
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet7
	NOP
;Test_Complet.c,143 :: 		UART1_Write_Text("AT+CPIN=1234");
	MOVLW       ?lstr4_Test_Complet+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_Test_Complet+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet.c,144 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet.c,145 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Test_Complet8:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet8
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet8
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet8
	NOP
;Test_Complet.c,146 :: 		Lcd_Out(2,1,"Transm GSM");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_Test_Complet+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_Test_Complet+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet.c,147 :: 		UART1_Write_Text("AT+CMGD=4");
	MOVLW       ?lstr6_Test_Complet+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_Test_Complet+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet.c,148 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet.c,149 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Test_Complet9:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet9
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet9
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet9
	NOP
;Test_Complet.c,150 :: 		UART1_Write_Text("AT+CMGF=1");
	MOVLW       ?lstr7_Test_Complet+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_Test_Complet+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet.c,151 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet.c,152 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Test_Complet10:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet10
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet10
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet10
	NOP
;Test_Complet.c,153 :: 		UART1_Write_Text("AT+CMGS=0648200953");
	MOVLW       ?lstr8_Test_Complet+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_Test_Complet+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet.c,154 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet.c,155 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Test_Complet11:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet11
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet11
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet11
	NOP
;Test_Complet.c,156 :: 		UART1_Write_Text("Ca marche");
	MOVLW       ?lstr9_Test_Complet+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_Test_Complet+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet.c,157 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet.c,158 :: 		UART1_Write(26);
	MOVLW       26
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Test_Complet.c,159 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet.c,160 :: 		Lcd_Out(2,1,"SMS Transmis");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_Test_Complet+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_Test_Complet+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet.c,161 :: 		delay_ms(5000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_Test_Complet12:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet12
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet12
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet12
	NOP
	NOP
;Test_Complet.c,162 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet.c,163 :: 		}
L_Test_Complet6:
;Test_Complet.c,164 :: 		}
L_end_Test_Complet:
	RETURN      0
; end of _Test_Complet

_Lecture_Heure:

;Test_Complet.c,165 :: 		void Lecture_Heure()
;Test_Complet.c,168 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;Test_Complet.c,169 :: 		I2C1_Wr(0xDE);
	MOVLW       222
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet.c,170 :: 		I2C1_Wr(2);
	MOVLW       2
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet.c,171 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;Test_Complet.c,172 :: 		I2C1_Wr(0xDF);
	MOVLW       223
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet.c,173 :: 		reponseH=I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _reponseH+0 
	MOVLW       0
	MOVWF       _reponseH+1 
;Test_Complet.c,174 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;Test_Complet.c,176 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;Test_Complet.c,177 :: 		I2C1_Wr(0xDE);
	MOVLW       222
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet.c,178 :: 		I2C1_Wr(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet.c,179 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;Test_Complet.c,180 :: 		I2C1_Wr(0xDF);
	MOVLW       223
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet.c,181 :: 		reponseM=I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _reponseM+0 
	MOVLW       0
	MOVWF       _reponseM+1 
;Test_Complet.c,182 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;Test_Complet.c,184 :: 		IntToStr(reponseH,heure);
	MOVF        _reponseH+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _reponseH+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _heure+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_heure+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Test_Complet.c,185 :: 		IntToStr(reponseM,minute);
	MOVF        _reponseM+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _reponseM+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _minute+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_minute+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Test_Complet.c,187 :: 		Lcd_Out(1,4,minute);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _minute+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_minute+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet.c,188 :: 		Lcd_Out_Cp("m");
	MOVLW       ?lstr11_Test_Complet+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr11_Test_Complet+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Test_Complet.c,189 :: 		Lcd_Out(1,1,heure);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _heure+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_heure+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet.c,190 :: 		Lcd_Out_Cp("h");
	MOVLW       ?lstr12_Test_Complet+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr12_Test_Complet+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Test_Complet.c,191 :: 		delay_ms(150);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       134
	MOVWF       R12, 0
	MOVLW       153
	MOVWF       R13, 0
L_Lecture_Heure13:
	DECFSZ      R13, 1, 1
	BRA         L_Lecture_Heure13
	DECFSZ      R12, 1, 1
	BRA         L_Lecture_Heure13
	DECFSZ      R11, 1, 1
	BRA         L_Lecture_Heure13
;Test_Complet.c,192 :: 		}
L_end_Lecture_Heure:
	RETURN      0
; end of _Lecture_Heure
