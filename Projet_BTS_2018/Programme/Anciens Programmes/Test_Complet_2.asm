
_main:

;Test_Complet_2.c,71 :: 		void main()
;Test_Complet_2.c,73 :: 		H_Prog = 0x14; M_Prog= 0x26; S_Prog= 0x0;  // Heures minutes seconde
	MOVLW       20
	MOVWF       _H_Prog+0 
	MOVLW       38
	MOVWF       _M_Prog+0 
	CLRF        _S_Prog+0 
;Test_Complet_2.c,75 :: 		config();                         //Appel le sous-programme
	CALL        _config+0, 0
;Test_Complet_2.c,76 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
	NOP
;Test_Complet_2.c,77 :: 		while(1)                         //Boucle infinie
L_main1:
;Test_Complet_2.c,79 :: 		Test_Complet();    // Transmissions (Série et GSM)
	CALL        _Test_Complet+0, 0
;Test_Complet_2.c,80 :: 		Lecture_Heure();
	CALL        _Lecture_Heure+0, 0
;Test_Complet_2.c,82 :: 		delay_ms(250);        //2500 pour confort 100 pour visu oscillo
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;Test_Complet_2.c,83 :: 		Lecture_TempHum();
	CALL        _Lecture_TempHum+0, 0
;Test_Complet_2.c,84 :: 		Aff_TempHum();
	CALL        _Aff_TempHum+0, 0
;Test_Complet_2.c,85 :: 		delay_ms(100);        //2500 pour confort 100 pour visu oscillo
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
;Test_Complet_2.c,87 :: 		}
	GOTO        L_main1
;Test_Complet_2.c,88 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;Test_Complet_2.c,92 :: 		void config()
;Test_Complet_2.c,94 :: 		ANSELA=0x00;                      //Passe toutes les broches en digital
	CLRF        ANSELA+0 
;Test_Complet_2.c,95 :: 		ANSELB=0x00;
	CLRF        ANSELB+0 
;Test_Complet_2.c,96 :: 		ANSELC=0x00;
	CLRF        ANSELC+0 
;Test_Complet_2.c,98 :: 		TRISA=0xFF;                       //0b11111111
	MOVLW       255
	MOVWF       TRISA+0 
;Test_Complet_2.c,99 :: 		TRISB=0x81;                       //0b10000001
	MOVLW       129
	MOVWF       TRISB+0 
;Test_Complet_2.c,102 :: 		SDA=0; SCL=0;
	BCF         LATC+0, 4 
	BCF         LATC+0, 3 
;Test_Complet_2.c,103 :: 		TRISC=0x81;                       //0b10000001      SCL et SDA en entrée
	MOVLW       129
	MOVWF       TRISC+0 
;Test_Complet_2.c,104 :: 		Delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_config5:
	DECFSZ      R13, 1, 1
	BRA         L_config5
	DECFSZ      R12, 1, 1
	BRA         L_config5
	NOP
;Test_Complet_2.c,105 :: 		SCL=1;
	BSF         LATC+0, 3 
;Test_Complet_2.c,106 :: 		Delay_us(40);
	MOVLW       26
	MOVWF       R13, 0
L_config6:
	DECFSZ      R13, 1, 1
	BRA         L_config6
	NOP
;Test_Complet_2.c,107 :: 		SDA=1;
	BSF         LATC+0, 4 
;Test_Complet_2.c,109 :: 		Lcd_Init();                       //Initialisation LCD
	CALL        _Lcd_Init+0, 0
;Test_Complet_2.c,110 :: 		Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet_2.c,111 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet_2.c,112 :: 		Lcd_Out(1,1,"Modif Heure=>BP1");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Test_Complet_2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Test_Complet_2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet_2.c,113 :: 		UART1_Init(9600);                 //Initialisation GSM
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Test_Complet_2.c,114 :: 		UART2_Init(9600);                 //Initialisation RS232
	BSF         BAUDCON2+0, 3, 0
	CLRF        SPBRGH2+0 
	MOVLW       207
	MOVWF       SPBRG2+0 
	BSF         TXSTA2+0, 2, 0
	CALL        _UART2_Init+0, 0
;Test_Complet_2.c,116 :: 		I2C1_Init(100000);                //Initialisaition I2C
	MOVLW       20
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;Test_Complet_2.c,118 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_config7:
	DECFSZ      R13, 1, 1
	BRA         L_config7
	DECFSZ      R12, 1, 1
	BRA         L_config7
	DECFSZ      R11, 1, 1
	BRA         L_config7
	NOP
;Test_Complet_2.c,119 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;Test_Complet_2.c,120 :: 		if(BP1==0)                        //Condition BP1 enfoncé
	BTFSC       PORTA+0, 1 
	GOTO        L_config8
;Test_Complet_2.c,122 :: 		Param_Heure();                    //Appel sous-programme param horodatage
	CALL        _Param_Heure+0, 0
;Test_Complet_2.c,123 :: 		}
L_config8:
;Test_Complet_2.c,124 :: 		Sound_Init(&PORTC,5);             //Initialisation du Buzzer
	MOVLW       PORTC+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	MOVLW       5
	MOVWF       FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;Test_Complet_2.c,125 :: 		}
L_end_config:
	RETURN      0
; end of _config

_Param_Heure:

;Test_Complet_2.c,127 :: 		void Param_Heure()
;Test_Complet_2.c,129 :: 		I2C1_Start();               //Condition de Start
	CALL        _I2C1_Start+0, 0
;Test_Complet_2.c,130 :: 		I2C1_Wr(0xDE);              //Adresse HTR+W
	MOVLW       222
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_2.c,131 :: 		I2C1_Wr(0);                 //Adresse mémoire 0
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_2.c,132 :: 		I2C1_Wr(0x80 + S_Prog);     //Oscillateur activé + Seconde
	MOVF        _S_Prog+0, 0 
	ADDLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_2.c,133 :: 		I2C1_Wr(M_Prog);            //minutes
	MOVF        _M_Prog+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_2.c,134 :: 		I2C1_Wr(H_Prog);            //Mode 24h, + Heures
	MOVF        _H_Prog+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_2.c,135 :: 		I2C1_Stop();                //Bit de stop
	CALL        _I2C1_Stop+0, 0
;Test_Complet_2.c,157 :: 		}
L_end_Param_Heure:
	RETURN      0
; end of _Param_Heure

_retchar:

;Test_Complet_2.c,159 :: 		void retchar()
;Test_Complet_2.c,161 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_retchar9:
	DECFSZ      R13, 1, 1
	BRA         L_retchar9
	DECFSZ      R12, 1, 1
	BRA         L_retchar9
	DECFSZ      R11, 1, 1
	BRA         L_retchar9
	NOP
	NOP
;Test_Complet_2.c,162 :: 		UART1_Write(13);                  //Retour Chariot
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Test_Complet_2.c,163 :: 		UART1_Write(10);                  //Retour ligne
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Test_Complet_2.c,164 :: 		delay_ms(200);                    //délai de 200ms
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_retchar10:
	DECFSZ      R13, 1, 1
	BRA         L_retchar10
	DECFSZ      R12, 1, 1
	BRA         L_retchar10
	DECFSZ      R11, 1, 1
	BRA         L_retchar10
;Test_Complet_2.c,165 :: 		}
L_end_retchar:
	RETURN      0
; end of _retchar

_Test_Complet:

;Test_Complet_2.c,168 :: 		void Test_Complet()
;Test_Complet_2.c,170 :: 		if(BP1==0)                        //Condition BP1 enfoncé
	BTFSC       PORTA+0, 1 
	GOTO        L_Test_Complet11
;Test_Complet_2.c,172 :: 		Lcd_Cmd(_LCD_CLEAR);             //Reset de l'afficheur
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet_2.c,173 :: 		LedOrange=1;                     //Allume la LED
	BSF         PORTC+0, 2 
;Test_Complet_2.c,174 :: 		UART2_Write('A');//Transmet le texte
	MOVLW       65
	MOVWF       FARG_UART2_Write_data_+0 
	CALL        _UART2_Write+0, 0
;Test_Complet_2.c,175 :: 		UART2_Write(13);                 //Retour chariot
	MOVLW       13
	MOVWF       FARG_UART2_Write_data_+0 
	CALL        _UART2_Write+0, 0
;Test_Complet_2.c,176 :: 		UART2_Write(10);                 //Retour ligne
	MOVLW       10
	MOVWF       FARG_UART2_Write_data_+0 
	CALL        _UART2_Write+0, 0
;Test_Complet_2.c,177 :: 		Lcd_Out(1,1,"Transm Serie");     //Transmet le texte
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Test_Complet_2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Test_Complet_2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet_2.c,178 :: 		delay_ms(5000);                  //Délai de 5s
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
;Test_Complet_2.c,179 :: 		Lcd_Cmd(_LCD_CLEAR);             //Reset de l'afficheur
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet_2.c,180 :: 		Sound_Play(LA,1000);             //Le buzzer sonne pendant 1s
	MOVLW       184
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       232
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;Test_Complet_2.c,181 :: 		LedOrange=0;                     //Eteint la LED
	BCF         PORTC+0, 2 
;Test_Complet_2.c,182 :: 		}
L_Test_Complet11:
;Test_Complet_2.c,183 :: 		if(BP2==0)                        //Condition BP2 enfoncé
	BTFSC       PORTA+0, 2 
	GOTO        L_Test_Complet13
;Test_Complet_2.c,185 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet_2.c,186 :: 		Lcd_Out(1,1,"Init GSM");          //Affiche le text
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Test_Complet_2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Test_Complet_2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet_2.c,187 :: 		UART1_Write_Text("AT");           //Transmet le texte au GSM(init)
	MOVLW       ?lstr4_Test_Complet_2+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_Test_Complet_2+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet_2.c,188 :: 		retchar();                       //Retchar
	CALL        _retchar+0, 0
;Test_Complet_2.c,189 :: 		delay_ms(2000);                  //Délai de 2s
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Test_Complet14:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet14
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet14
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet14
	NOP
;Test_Complet_2.c,190 :: 		UART1_Write_Text("AT+CPIN=1234"); //Transmet le texte au GSM(Code PIN)
	MOVLW       ?lstr5_Test_Complet_2+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_Test_Complet_2+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet_2.c,191 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet_2.c,192 :: 		delay_ms(4000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_Test_Complet15:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet15
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet15
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet15
;Test_Complet_2.c,193 :: 		Lcd_Out(1,1,"Transm GSM");     //Affiche le texte
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_Test_Complet_2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_Test_Complet_2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet_2.c,194 :: 		UART1_Write_Text("AT+CMGD=4");    //Transmet le texte au GSM(Delete les SMS)
	MOVLW       ?lstr7_Test_Complet_2+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_Test_Complet_2+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet_2.c,195 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet_2.c,196 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Test_Complet16:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet16
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet16
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet16
	NOP
;Test_Complet_2.c,197 :: 		UART1_Write_Text("AT+CMGF=1");    //Transmet le texte au GSM(Config du SMS)
	MOVLW       ?lstr8_Test_Complet_2+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_Test_Complet_2+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet_2.c,198 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet_2.c,199 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Test_Complet17:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet17
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet17
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet17
	NOP
;Test_Complet_2.c,200 :: 		UART1_Write_Text("AT+CMGS=0648200953");//Numéro de téléphone
	MOVLW       ?lstr9_Test_Complet_2+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_Test_Complet_2+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet_2.c,201 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet_2.c,202 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Test_Complet18:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet18
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet18
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet18
	NOP
;Test_Complet_2.c,203 :: 		UART1_Write_Text("Ca marche");    //Transmet le SMS
	MOVLW       ?lstr10_Test_Complet_2+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr10_Test_Complet_2+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet_2.c,204 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet_2.c,205 :: 		UART1_Write(26);                  //CTRL+Z
	MOVLW       26
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Test_Complet_2.c,206 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet_2.c,207 :: 		Lcd_Out(1,1,"SMS Transmis");   //Affiche le texte
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_Test_Complet_2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_Test_Complet_2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet_2.c,208 :: 		delay_ms(5000);                  //Délai de 5s
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_Test_Complet19:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet19
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet19
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet19
	NOP
	NOP
;Test_Complet_2.c,209 :: 		Lcd_Cmd(_LCD_CLEAR);           //Reset de l'afficheur
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet_2.c,210 :: 		}
L_Test_Complet13:
;Test_Complet_2.c,211 :: 		}
L_end_Test_Complet:
	RETURN      0
; end of _Test_Complet

_Lecture_Heure:

;Test_Complet_2.c,213 :: 		void Lecture_Heure()
;Test_Complet_2.c,215 :: 		I2C1_Start();                      //Condition de start
	CALL        _I2C1_Start+0, 0
;Test_Complet_2.c,216 :: 		I2C1_Wr(0xDE);                   //Adresse HTR+W
	MOVLW       222
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_2.c,217 :: 		I2C1_Wr(0);                      //Adresse mémoire heures
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_2.c,218 :: 		I2C1_Repeated_Start();             //Repeated start
	CALL        _I2C1_Repeated_Start+0, 0
;Test_Complet_2.c,219 :: 		I2C1_Wr(0xDF);                   //Adresse HTR+R
	MOVLW       223
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_2.c,220 :: 		reponseS=I2C1_Rd(1);             //Inscrit dans la variable la valeur lue
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _reponseS+0 
;Test_Complet_2.c,221 :: 		reponseM=I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _reponseM+0 
;Test_Complet_2.c,222 :: 		reponseH=I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _reponseH+0 
;Test_Complet_2.c,223 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;Test_Complet_2.c,224 :: 		reponseS=reponseS & 0b01111111;   // forcage à 0 du Bit 8 (Marche arrêt RTC = HTR)
	MOVLW       127
	ANDWF       _reponseS+0, 1 
;Test_Complet_2.c,225 :: 		}
L_end_Lecture_Heure:
	RETURN      0
; end of _Lecture_Heure

_Aff_Heure:

;Test_Complet_2.c,226 :: 		void Aff_Heure()
;Test_Complet_2.c,228 :: 		UnitSec=(reponseS&0x0F)+0x30;
	MOVLW       15
	ANDWF       _reponseS+0, 0 
	MOVWF       _UnitSec+0 
	MOVLW       48
	ADDWF       _UnitSec+0, 1 
;Test_Complet_2.c,229 :: 		DizSec=(reponseS>>4);
	MOVF        _reponseS+0, 0 
	MOVWF       _DizSec+0 
	RRCF        _DizSec+0, 1 
	BCF         _DizSec+0, 7 
	RRCF        _DizSec+0, 1 
	BCF         _DizSec+0, 7 
	RRCF        _DizSec+0, 1 
	BCF         _DizSec+0, 7 
	RRCF        _DizSec+0, 1 
	BCF         _DizSec+0, 7 
;Test_Complet_2.c,230 :: 		DizSec=(DizSec&0x07)+0x30;
	MOVLW       7
	ANDWF       _DizSec+0, 1 
	MOVLW       48
	ADDWF       _DizSec+0, 1 
;Test_Complet_2.c,232 :: 		UnitMin=(reponseM&0x0F)+0x30;
	MOVLW       15
	ANDWF       _reponseM+0, 0 
	MOVWF       _UnitMin+0 
	MOVLW       48
	ADDWF       _UnitMin+0, 1 
;Test_Complet_2.c,233 :: 		DizMin=(reponseM>>4);
	MOVF        _reponseM+0, 0 
	MOVWF       _DizMin+0 
	RRCF        _DizMin+0, 1 
	BCF         _DizMin+0, 7 
	RRCF        _DizMin+0, 1 
	BCF         _DizMin+0, 7 
	RRCF        _DizMin+0, 1 
	BCF         _DizMin+0, 7 
	RRCF        _DizMin+0, 1 
	BCF         _DizMin+0, 7 
;Test_Complet_2.c,234 :: 		DizMin=(DizMin&0x07)+0x30;
	MOVLW       7
	ANDWF       _DizMin+0, 1 
	MOVLW       48
	ADDWF       _DizMin+0, 1 
;Test_Complet_2.c,236 :: 		UnitHeure=(reponseH&0x0F)+0x30;
	MOVLW       15
	ANDWF       _reponseH+0, 0 
	MOVWF       _UnitHeure+0 
	MOVLW       48
	ADDWF       _UnitHeure+0, 1 
;Test_Complet_2.c,237 :: 		DizHeure=(reponseH>>4);
	MOVF        _reponseH+0, 0 
	MOVWF       _DizHeure+0 
	RRCF        _DizHeure+0, 1 
	BCF         _DizHeure+0, 7 
	RRCF        _DizHeure+0, 1 
	BCF         _DizHeure+0, 7 
	RRCF        _DizHeure+0, 1 
	BCF         _DizHeure+0, 7 
	RRCF        _DizHeure+0, 1 
	BCF         _DizHeure+0, 7 
;Test_Complet_2.c,238 :: 		DizHeure=(DizHeure&0x03)+0x30;     // Mode 24 Heures
	MOVLW       3
	ANDWF       _DizHeure+0, 1 
	MOVLW       48
	ADDWF       _DizHeure+0, 1 
;Test_Complet_2.c,240 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet_2.c,241 :: 		Lcd_Chr(1,5,DizHeure);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _DizHeure+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Test_Complet_2.c,242 :: 		Lcd_Chr_Cp(UnitHeure);
	MOVF        _UnitHeure+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_2.c,243 :: 		Lcd_Out_Cp(":");
	MOVLW       ?lstr12_Test_Complet_2+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr12_Test_Complet_2+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Test_Complet_2.c,244 :: 		Lcd_Chr_Cp(DizMin);
	MOVF        _DizMin+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_2.c,245 :: 		Lcd_Chr_Cp(UnitMin);
	MOVF        _UnitMin+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_2.c,246 :: 		Lcd_Out_Cp(":");
	MOVLW       ?lstr13_Test_Complet_2+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr13_Test_Complet_2+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Test_Complet_2.c,247 :: 		Lcd_Chr_Cp(DizSec);
	MOVF        _DizSec+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_2.c,248 :: 		Lcd_Chr_Cp(UnitSec);
	MOVF        _UnitSec+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_2.c,250 :: 		}
L_end_Aff_Heure:
	RETURN      0
; end of _Aff_Heure

_Lecture_TempHum:

;Test_Complet_2.c,252 :: 		void Lecture_TempHum()
;Test_Complet_2.c,254 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;Test_Complet_2.c,255 :: 		I2C1_Wr(0x4E);
	MOVLW       78
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_2.c,256 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;Test_Complet_2.c,257 :: 		I2C1_Wr(0x4F);
	MOVLW       79
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_2.c,258 :: 		HumMSB=I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _HumMSB+0 
	MOVLW       0
	MOVWF       _HumMSB+1 
;Test_Complet_2.c,259 :: 		HumLSB=I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _HumLSB+0 
	MOVLW       0
	MOVWF       _HumLSB+1 
;Test_Complet_2.c,260 :: 		TempMSB=I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _TempMSB+0 
	MOVLW       0
	MOVWF       _TempMSB+1 
;Test_Complet_2.c,261 :: 		TempLSB=I2C1_Rd(0);      // et Nack Master
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _TempLSB+0 
	MOVLW       0
	MOVWF       _TempLSB+1 
;Test_Complet_2.c,262 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;Test_Complet_2.c,263 :: 		}
L_end_Lecture_TempHum:
	RETURN      0
; end of _Lecture_TempHum

_Aff_TempHum:

;Test_Complet_2.c,265 :: 		void Aff_TempHum()
;Test_Complet_2.c,267 :: 		HumTotale=HumMSB*256;
	MOVF        _HumMSB+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	MOVWF       _HumTotale+0 
	MOVF        R1, 0 
	MOVWF       _HumTotale+1 
;Test_Complet_2.c,268 :: 		HumTotale=HumTotale+HumLSB;
	MOVF        _HumLSB+0, 0 
	ADDWF       R0, 1 
	MOVF        _HumLSB+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _HumTotale+0 
	MOVF        R1, 0 
	MOVWF       _HumTotale+1 
;Test_Complet_2.c,269 :: 		humcalcul=HumTotale;
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       _humcalcul+0 
	MOVF        R1, 0 
	MOVWF       _humcalcul+1 
	MOVF        R2, 0 
	MOVWF       _humcalcul+2 
	MOVF        R3, 0 
	MOVWF       _humcalcul+3 
;Test_Complet_2.c,270 :: 		humcalcul=humcalcul/16382;
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
;Test_Complet_2.c,271 :: 		humcalcul=humcalcul*100;
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
;Test_Complet_2.c,273 :: 		Resteh = humcalcul;     // Reste = Partie entière
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       _Resteh+0 
	MOVF        R1, 0 
	MOVWF       _Resteh+1 
;Test_Complet_2.c,274 :: 		centh=Resteh/100;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _centh+0 
;Test_Complet_2.c,275 :: 		Resteh= Resteh -cent*100;
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
;Test_Complet_2.c,276 :: 		dizh= Resteh /10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _dizh+0 
;Test_Complet_2.c,277 :: 		unith= Resteh % 10;
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
;Test_Complet_2.c,279 :: 		if(cent==1) Lcd_chr(2,10,centh+0x30);
	MOVF        _cent+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Aff_TempHum20
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       _centh+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
L_Aff_TempHum20:
;Test_Complet_2.c,280 :: 		if(cent==0) Lcd_Out(2,10," ");
	MOVF        _cent+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Aff_TempHum21
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr14_Test_Complet_2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_Test_Complet_2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_Aff_TempHum21:
;Test_Complet_2.c,281 :: 		Lcd_chr(2,3,centh+0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       _centh+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Test_Complet_2.c,283 :: 		Lcd_chr_Cp(unith+0x30);
	MOVLW       48
	ADDWF       _unith+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_2.c,284 :: 		Lcd_Out_Cp("%");
	MOVLW       ?lstr15_Test_Complet_2+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr15_Test_Complet_2+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Test_Complet_2.c,285 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_Aff_TempHum22:
	DECFSZ      R13, 1, 1
	BRA         L_Aff_TempHum22
	DECFSZ      R12, 1, 1
	BRA         L_Aff_TempHum22
	NOP
;Test_Complet_2.c,288 :: 		TempTotale=TempMSB*256;
	MOVF        _TempMSB+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	MOVWF       _TempTotale+0 
	MOVF        R1, 0 
	MOVWF       _TempTotale+1 
;Test_Complet_2.c,289 :: 		TempTotale=TempTotale+TempLSB;
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
;Test_Complet_2.c,290 :: 		TempTotale=TempTotale >> 2;
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
;Test_Complet_2.c,292 :: 		tempcalcul= TempTotale;
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       _tempcalcul+0 
	MOVF        R1, 0 
	MOVWF       _tempcalcul+1 
	MOVF        R2, 0 
	MOVWF       _tempcalcul+2 
	MOVF        R3, 0 
	MOVWF       _tempcalcul+3 
;Test_Complet_2.c,293 :: 		tempcalcul=tempcalcul/16382;
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
;Test_Complet_2.c,294 :: 		tempcalcul=tempcalcul*165;
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
;Test_Complet_2.c,295 :: 		tempcalcul=tempcalcul-40;
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
;Test_Complet_2.c,297 :: 		Reste = tempcalcul;     // Reste = Partie entière
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       _Reste+0 
	MOVF        R1, 0 
	MOVWF       _Reste+1 
;Test_Complet_2.c,298 :: 		cent=Reste/100;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _cent+0 
;Test_Complet_2.c,299 :: 		Reste= Reste -cent*100;
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
;Test_Complet_2.c,300 :: 		diz= Reste /10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _diz+0 
;Test_Complet_2.c,301 :: 		unit= Reste % 10;
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
;Test_Complet_2.c,303 :: 		if(cent==1) Lcd_chr(2,10,cent+0x30);
	MOVF        _cent+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Aff_TempHum23
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       _cent+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
L_Aff_TempHum23:
;Test_Complet_2.c,304 :: 		if(cent==0) Lcd_Out(2,10," ");
	MOVF        _cent+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Aff_TempHum24
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr16_Test_Complet_2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr16_Test_Complet_2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_Aff_TempHum24:
;Test_Complet_2.c,305 :: 		Lcd_Chr_Cp(diz+0x30);
	MOVLW       48
	ADDWF       _diz+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_2.c,306 :: 		Lcd_Chr_Cp(unit+0x30);
	MOVLW       48
	ADDWF       _unit+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_2.c,307 :: 		Lcd_Out_Cp("`");
	MOVLW       ?lstr17_Test_Complet_2+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr17_Test_Complet_2+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Test_Complet_2.c,308 :: 		Lcd_Out_Cp("C");
	MOVLW       ?lstr18_Test_Complet_2+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr18_Test_Complet_2+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Test_Complet_2.c,310 :: 		}
L_end_Aff_TempHum:
	RETURN      0
; end of _Aff_TempHum

_Vpile:

;Test_Complet_2.c,312 :: 		void Vpile()
;Test_Complet_2.c,316 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet_2.c,317 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_Vpile25:
	DECFSZ      R13, 1, 1
	BRA         L_Vpile25
	DECFSZ      R12, 1, 1
	BRA         L_Vpile25
	NOP
;Test_Complet_2.c,318 :: 		Lcd_Out(1,1,"Tension de Pile");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr19_Test_Complet_2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr19_Test_Complet_2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet_2.c,319 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_Vpile26:
	DECFSZ      R13, 1, 1
	BRA         L_Vpile26
	DECFSZ      R12, 1, 1
	BRA         L_Vpile26
	NOP
;Test_Complet_2.c,320 :: 		Vbat=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;Test_Complet_2.c,321 :: 		Vbat=Vbat*0.0048828125;
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
;Test_Complet_2.c,322 :: 		IntToStr(Vbat,tension);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVF        Vpile_tension_L0+0, 0 
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Test_Complet_2.c,323 :: 		Lcd_Out(2,3,tension);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        Vpile_tension_L0+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet_2.c,324 :: 		Lcd_Out_Cp("V");
	MOVLW       ?lstr20_Test_Complet_2+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr20_Test_Complet_2+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Test_Complet_2.c,325 :: 		delay_ms(2500);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_Vpile27:
	DECFSZ      R13, 1, 1
	BRA         L_Vpile27
	DECFSZ      R12, 1, 1
	BRA         L_Vpile27
	DECFSZ      R11, 1, 1
	BRA         L_Vpile27
	NOP
;Test_Complet_2.c,326 :: 		}
L_end_Vpile:
	RETURN      0
; end of _Vpile
