
_main:

;Test_Complet_4c.c,69 :: 		void main()
;Test_Complet_4c.c,71 :: 		H_Prog = 0x10; M_Prog= 0x19; S_Prog= 0x00;// Heures minutes secondes
	MOVLW       16
	MOVWF       _H_Prog+0 
	MOVLW       25
	MOVWF       _M_Prog+0 
	CLRF        _S_Prog+0 
;Test_Complet_4c.c,73 :: 		config();                                //Appel le sous-programme
	CALL        _config+0, 0
;Test_Complet_4c.c,74 :: 		delay_ms(1000);                          //Délai 1s
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
;Test_Complet_4c.c,75 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet_4c.c,76 :: 		while(1)                                 //Boucle infinie
L_main1:
;Test_Complet_4c.c,78 :: 		Test_Complet();                         // Transmissions (Série et GSM)
	CALL        _Test_Complet+0, 0
;Test_Complet_4c.c,79 :: 		Lecture_Heure();                        //Lecture de l'heure
	CALL        _Lecture_Heure+0, 0
;Test_Complet_4c.c,80 :: 		Aff_Heure();                            //Affichage de l'heure
	CALL        _Aff_Heure+0, 0
;Test_Complet_4c.c,81 :: 		delay_ms(100);                          //Délai 100ms
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
;Test_Complet_4c.c,82 :: 		Lecture_TempHum();                      //Lecture temp et hum
	CALL        _Lecture_TempHum+0, 0
;Test_Complet_4c.c,83 :: 		Aff_TempHum();                          //Affichage temp et hum
	CALL        _Aff_TempHum+0, 0
;Test_Complet_4c.c,84 :: 		delay_ms(100);                          //Délai 100ms
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
;Test_Complet_4c.c,85 :: 		Vpile();                                //Mesure et affichage tension de
	CALL        _Vpile+0, 0
;Test_Complet_4c.c,87 :: 		}
	GOTO        L_main1
;Test_Complet_4c.c,88 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;Test_Complet_4c.c,92 :: 		void config()
;Test_Complet_4c.c,94 :: 		ANSELA=0x00;                      //Passe toutes les broches en digital
	CLRF        ANSELA+0 
;Test_Complet_4c.c,95 :: 		ANSELB=0x00;
	CLRF        ANSELB+0 
;Test_Complet_4c.c,96 :: 		ANSELC=0x00;
	CLRF        ANSELC+0 
;Test_Complet_4c.c,98 :: 		TRISA=0xFF;                       //0b11111111
	MOVLW       255
	MOVWF       TRISA+0 
;Test_Complet_4c.c,99 :: 		TRISB=0x81;                       //0b10000001
	MOVLW       129
	MOVWF       TRISB+0 
;Test_Complet_4c.c,100 :: 		TRISC=0x99;                       //0b10011001      SCL et SDA en entrée
	MOVLW       153
	MOVWF       TRISC+0 
;Test_Complet_4c.c,102 :: 		Lcd_Init();                       //Initialisation LCD
	CALL        _Lcd_Init+0, 0
;Test_Complet_4c.c,103 :: 		Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet_4c.c,104 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet_4c.c,105 :: 		Lcd_Out(1,1,"Modif Heure=>BP1");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Test_Complet_4c+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Test_Complet_4c+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet_4c.c,106 :: 		UART1_Init(9600);                 //Initialisation GSM
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Test_Complet_4c.c,107 :: 		UART2_Init(9600);                 //Initialisation RS232
	BSF         BAUDCON2+0, 3, 0
	CLRF        SPBRGH2+0 
	MOVLW       207
	MOVWF       SPBRG2+0 
	BSF         TXSTA2+0, 2, 0
	CALL        _UART2_Init+0, 0
;Test_Complet_4c.c,109 :: 		I2C1_Init(100000);                //Initialisaition I2C
	MOVLW       20
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;Test_Complet_4c.c,110 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_config5:
	DECFSZ      R13, 1, 1
	BRA         L_config5
	DECFSZ      R12, 1, 1
	BRA         L_config5
	DECFSZ      R11, 1, 1
	BRA         L_config5
	NOP
;Test_Complet_4c.c,112 :: 		if(BP1==0)                        //Condition BP1 enfoncé
	BTFSC       PORTA+0, 1 
	GOTO        L_config6
;Test_Complet_4c.c,114 :: 		Param_Heure();                 //Appel sous-programme param horodatage
	CALL        _Param_Heure+0, 0
;Test_Complet_4c.c,115 :: 		}
L_config6:
;Test_Complet_4c.c,116 :: 		Sound_Init(&PORTC,5);             //Initialisation du Buzzer
	MOVLW       PORTC+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	MOVLW       5
	MOVWF       FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;Test_Complet_4c.c,117 :: 		}
L_end_config:
	RETURN      0
; end of _config

_Param_Heure:

;Test_Complet_4c.c,119 :: 		void Param_Heure()
;Test_Complet_4c.c,121 :: 		I2C1_Start();               //Condition de Start
	CALL        _I2C1_Start+0, 0
;Test_Complet_4c.c,122 :: 		I2C1_Wr(0xDE);              //Adresse HTR+W
	MOVLW       222
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_4c.c,123 :: 		I2C1_Wr(0);                 //Adresse mémoire 0
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_4c.c,124 :: 		I2C1_Wr(0x80 + S_Prog);     //Oscillateur activé + Seconde
	MOVF        _S_Prog+0, 0 
	ADDLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_4c.c,125 :: 		I2C1_Wr(M_Prog);            //minutes
	MOVF        _M_Prog+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_4c.c,126 :: 		I2C1_Wr(H_Prog);            //Mode 24h, + Heures
	MOVF        _H_Prog+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_4c.c,127 :: 		I2C1_Stop();                //Bit de stop
	CALL        _I2C1_Stop+0, 0
;Test_Complet_4c.c,128 :: 		}
L_end_Param_Heure:
	RETURN      0
; end of _Param_Heure

_retchar:

;Test_Complet_4c.c,130 :: 		void retchar()
;Test_Complet_4c.c,132 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_retchar7:
	DECFSZ      R13, 1, 1
	BRA         L_retchar7
	DECFSZ      R12, 1, 1
	BRA         L_retchar7
	DECFSZ      R11, 1, 1
	BRA         L_retchar7
	NOP
	NOP
;Test_Complet_4c.c,133 :: 		UART1_Write(13);                    //Retour Chariot
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Test_Complet_4c.c,134 :: 		UART1_Write(10);                    //Retour ligne
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Test_Complet_4c.c,135 :: 		delay_ms(200);                      //délai de 200ms
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_retchar8:
	DECFSZ      R13, 1, 1
	BRA         L_retchar8
	DECFSZ      R12, 1, 1
	BRA         L_retchar8
	DECFSZ      R11, 1, 1
	BRA         L_retchar8
;Test_Complet_4c.c,136 :: 		}
L_end_retchar:
	RETURN      0
; end of _retchar

_Test_Complet:

;Test_Complet_4c.c,139 :: 		void Test_Complet()
;Test_Complet_4c.c,141 :: 		if(BP1==0)                           //Condition BP1 enfoncé
	BTFSC       PORTA+0, 1 
	GOTO        L_Test_Complet9
;Test_Complet_4c.c,143 :: 		Lcd_Cmd(_LCD_CLEAR);                //Reset de l'afficheur
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet_4c.c,144 :: 		LedOrange=1;                        //Allume la LED
	BSF         PORTC+0, 2 
;Test_Complet_4c.c,145 :: 		UART2_Write_Text("Test Complet");   //Transmet le texte
	MOVLW       ?lstr2_Test_Complet_4c+0
	MOVWF       FARG_UART2_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_Test_Complet_4c+0)
	MOVWF       FARG_UART2_Write_Text_uart_text+1 
	CALL        _UART2_Write_Text+0, 0
;Test_Complet_4c.c,146 :: 		UART2_Write(13);                    //Retour chariot
	MOVLW       13
	MOVWF       FARG_UART2_Write_data_+0 
	CALL        _UART2_Write+0, 0
;Test_Complet_4c.c,147 :: 		UART2_Write(10);                    //Retour ligne
	MOVLW       10
	MOVWF       FARG_UART2_Write_data_+0 
	CALL        _UART2_Write+0, 0
;Test_Complet_4c.c,148 :: 		Lcd_Out(1,1,"Transm Serie");        //Transmet le texte
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Test_Complet_4c+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Test_Complet_4c+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet_4c.c,149 :: 		delay_ms(2500);                     //Délai de 5s
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_Test_Complet10:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet10
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet10
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet10
	NOP
;Test_Complet_4c.c,150 :: 		Lcd_Cmd(_LCD_CLEAR);                //Reset de l'afficheur
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet_4c.c,151 :: 		Sound_Play(LA,1000);                //Le buzzer sonne pendant 1s
	MOVLW       184
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       232
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;Test_Complet_4c.c,152 :: 		LedOrange=0;                        //Eteint la LED
	BCF         PORTC+0, 2 
;Test_Complet_4c.c,153 :: 		}
L_Test_Complet9:
;Test_Complet_4c.c,154 :: 		if(BP2==0)                           //Condition BP2 enfoncé
	BTFSC       PORTA+0, 2 
	GOTO        L_Test_Complet11
;Test_Complet_4c.c,156 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet_4c.c,157 :: 		Lcd_Out(1,1,"Init GSM");             //Affiche le text
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_Test_Complet_4c+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_Test_Complet_4c+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet_4c.c,158 :: 		UART1_Write_Text("AT");              //Transmet le texte au GSM(init)
	MOVLW       ?lstr5_Test_Complet_4c+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_Test_Complet_4c+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet_4c.c,159 :: 		retchar();                          //Retchar
	CALL        _retchar+0, 0
;Test_Complet_4c.c,160 :: 		delay_ms(2000);                     //Délai de 2s
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Test_Complet12:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet12
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet12
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet12
	NOP
;Test_Complet_4c.c,161 :: 		UART1_Write_Text("AT+CPIN=1234");    //Transmet le texte au GSM(Code PIN)
	MOVLW       ?lstr6_Test_Complet_4c+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_Test_Complet_4c+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet_4c.c,162 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet_4c.c,163 :: 		delay_ms(4000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_Test_Complet13:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet13
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet13
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet13
;Test_Complet_4c.c,164 :: 		Lcd_Out(1,1,"Transm GSM");        //Affiche le texte
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_Test_Complet_4c+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_Test_Complet_4c+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet_4c.c,165 :: 		UART1_Write_Text("AT+CMGD=4");       //Transmet le texte au GSM(Delete les SMS)
	MOVLW       ?lstr8_Test_Complet_4c+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_Test_Complet_4c+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet_4c.c,166 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet_4c.c,167 :: 		delay_ms(2000);
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
;Test_Complet_4c.c,168 :: 		UART1_Write_Text("AT+CMGF=1");       //Transmet le texte au GSM(Config du SMS)
	MOVLW       ?lstr9_Test_Complet_4c+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_Test_Complet_4c+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet_4c.c,169 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet_4c.c,170 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Test_Complet15:
	DECFSZ      R13, 1, 1
	BRA         L_Test_Complet15
	DECFSZ      R12, 1, 1
	BRA         L_Test_Complet15
	DECFSZ      R11, 1, 1
	BRA         L_Test_Complet15
	NOP
;Test_Complet_4c.c,171 :: 		UART1_Write_Text("AT+CMGS=0648200953");//Numéro de téléphone
	MOVLW       ?lstr10_Test_Complet_4c+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr10_Test_Complet_4c+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet_4c.c,172 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet_4c.c,173 :: 		delay_ms(2000);
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
;Test_Complet_4c.c,174 :: 		UART1_Write_Text("Ca marche");       //Transmet le SMS
	MOVLW       ?lstr11_Test_Complet_4c+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr11_Test_Complet_4c+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Test_Complet_4c.c,175 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet_4c.c,176 :: 		UART1_Write(26);                     //CTRL+Z
	MOVLW       26
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Test_Complet_4c.c,177 :: 		retchar();
	CALL        _retchar+0, 0
;Test_Complet_4c.c,178 :: 		Lcd_Out(1,1,"SMS Transmis");      //Affiche le texte
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr12_Test_Complet_4c+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr12_Test_Complet_4c+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet_4c.c,179 :: 		delay_ms(2000);                     //Délai de 5s
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
;Test_Complet_4c.c,180 :: 		Lcd_Cmd(_LCD_CLEAR);              //Reset de l'afficheur
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Test_Complet_4c.c,181 :: 		}
L_Test_Complet11:
;Test_Complet_4c.c,182 :: 		}
L_end_Test_Complet:
	RETURN      0
; end of _Test_Complet

_Lecture_Heure:

;Test_Complet_4c.c,184 :: 		void Lecture_Heure()
;Test_Complet_4c.c,186 :: 		I2C1_Start();                         //Condition de start
	CALL        _I2C1_Start+0, 0
;Test_Complet_4c.c,187 :: 		I2C1_Wr(0xDE);                      //Adresse HTR+W
	MOVLW       222
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_4c.c,188 :: 		I2C1_Wr(0);                         //Adresse mémoire heures
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_4c.c,189 :: 		I2C1_Repeated_Start();                //Repeated start
	CALL        _I2C1_Repeated_Start+0, 0
;Test_Complet_4c.c,190 :: 		I2C1_Wr(0xDF);                      //Adresse HTR+R
	MOVLW       223
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_4c.c,191 :: 		reponseS=I2C1_Rd(1);                //Inscrit dans la variable la valeur lue
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _reponseS+0 
;Test_Complet_4c.c,192 :: 		reponseM=I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _reponseM+0 
;Test_Complet_4c.c,193 :: 		reponseH=I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _reponseH+0 
;Test_Complet_4c.c,194 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;Test_Complet_4c.c,195 :: 		reponseS=reponseS & 0x7F;           //Forcage à 0 du Bit 8
	MOVLW       127
	ANDWF       _reponseS+0, 1 
;Test_Complet_4c.c,196 :: 		}                                     //(Marche arrêt RTC = HTR)
L_end_Lecture_Heure:
	RETURN      0
; end of _Lecture_Heure

_Aff_Heure:

;Test_Complet_4c.c,197 :: 		void Aff_Heure()
;Test_Complet_4c.c,199 :: 		UnitSec=(reponseS&0x0F)+0x30;
	MOVLW       15
	ANDWF       _reponseS+0, 0 
	MOVWF       _UnitSec+0 
	MOVLW       48
	ADDWF       _UnitSec+0, 1 
;Test_Complet_4c.c,200 :: 		DizSec=(reponseS>>4);
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
;Test_Complet_4c.c,201 :: 		DizSec=(DizSec&0x07)+0x30;
	MOVLW       7
	ANDWF       _DizSec+0, 1 
	MOVLW       48
	ADDWF       _DizSec+0, 1 
;Test_Complet_4c.c,203 :: 		UnitMin=(reponseM&0x0F)+0x30;
	MOVLW       15
	ANDWF       _reponseM+0, 0 
	MOVWF       _UnitMin+0 
	MOVLW       48
	ADDWF       _UnitMin+0, 1 
;Test_Complet_4c.c,204 :: 		DizMin=(reponseM>>4);
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
;Test_Complet_4c.c,205 :: 		DizMin=(DizMin&0x07)+0x30;
	MOVLW       7
	ANDWF       _DizMin+0, 1 
	MOVLW       48
	ADDWF       _DizMin+0, 1 
;Test_Complet_4c.c,207 :: 		UnitHeure=(reponseH&0x0F)+0x30;
	MOVLW       15
	ANDWF       _reponseH+0, 0 
	MOVWF       _UnitHeure+0 
	MOVLW       48
	ADDWF       _UnitHeure+0, 1 
;Test_Complet_4c.c,208 :: 		DizHeure=(reponseH>>4);
	MOVF        _reponseH+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       _DizHeure+0 
;Test_Complet_4c.c,209 :: 		DizHeure=(DizHeure&0x03)+0x30;      // Mode 24 Heures
	MOVLW       3
	ANDWF       R0, 1 
	MOVLW       48
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _DizHeure+0 
;Test_Complet_4c.c,211 :: 		Lcd_Chr(1,1,DizHeure);              //Affichage de la
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Test_Complet_4c.c,212 :: 		Lcd_Chr_Cp(UnitHeure);
	MOVF        _UnitHeure+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_4c.c,213 :: 		Lcd_Out_Cp(":");
	MOVLW       ?lstr13_Test_Complet_4c+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr13_Test_Complet_4c+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Test_Complet_4c.c,214 :: 		Lcd_Chr_Cp(DizMin);
	MOVF        _DizMin+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_4c.c,215 :: 		Lcd_Chr_Cp(UnitMin);
	MOVF        _UnitMin+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_4c.c,216 :: 		Lcd_Out_Cp(":");
	MOVLW       ?lstr14_Test_Complet_4c+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr14_Test_Complet_4c+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Test_Complet_4c.c,217 :: 		Lcd_Chr_Cp(DizSec);
	MOVF        _DizSec+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_4c.c,218 :: 		Lcd_Chr_Cp(UnitSec);
	MOVF        _UnitSec+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_4c.c,220 :: 		}
L_end_Aff_Heure:
	RETURN      0
; end of _Aff_Heure

_Lecture_TempHum:

;Test_Complet_4c.c,222 :: 		void Lecture_TempHum()
;Test_Complet_4c.c,224 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;Test_Complet_4c.c,225 :: 		I2C1_Wr(0x4E);
	MOVLW       78
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_4c.c,226 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;Test_Complet_4c.c,227 :: 		I2C1_Wr(0x4F);
	MOVLW       79
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;Test_Complet_4c.c,228 :: 		HumMSB=I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _HumMSB+0 
	MOVLW       0
	MOVWF       _HumMSB+1 
;Test_Complet_4c.c,229 :: 		HumLSB=I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _HumLSB+0 
	MOVLW       0
	MOVWF       _HumLSB+1 
;Test_Complet_4c.c,230 :: 		TempMSB=I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _TempMSB+0 
	MOVLW       0
	MOVWF       _TempMSB+1 
;Test_Complet_4c.c,231 :: 		TempLSB=I2C1_Rd(0);                // et Nack Master
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _TempLSB+0 
	MOVLW       0
	MOVWF       _TempLSB+1 
;Test_Complet_4c.c,232 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;Test_Complet_4c.c,233 :: 		}
L_end_Lecture_TempHum:
	RETURN      0
; end of _Lecture_TempHum

_Aff_TempHum:

;Test_Complet_4c.c,235 :: 		void Aff_TempHum()
;Test_Complet_4c.c,237 :: 		HumTotale=HumMSB*256;                 //Mise en place de la formule
	MOVF        _HumMSB+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	MOVWF       _HumTotale+0 
	MOVF        R1, 0 
	MOVWF       _HumTotale+1 
;Test_Complet_4c.c,238 :: 		HumTotale=HumTotale+HumLSB;           //donnée par le constructeur
	MOVF        _HumLSB+0, 0 
	ADDWF       R0, 1 
	MOVF        _HumLSB+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _HumTotale+0 
	MOVF        R1, 0 
	MOVWF       _HumTotale+1 
;Test_Complet_4c.c,239 :: 		humcalcul=HumTotale;
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       _humcalcul+0 
	MOVF        R1, 0 
	MOVWF       _humcalcul+1 
	MOVF        R2, 0 
	MOVWF       _humcalcul+2 
	MOVF        R3, 0 
	MOVWF       _humcalcul+3 
;Test_Complet_4c.c,240 :: 		humcalcul=humcalcul/16382;
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
;Test_Complet_4c.c,241 :: 		humcalcul=humcalcul*100;
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
;Test_Complet_4c.c,243 :: 		Resteh = humcalcul;                  // Reste = Partie entière
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       _Resteh+0 
	MOVF        R1, 0 
	MOVWF       _Resteh+1 
;Test_Complet_4c.c,244 :: 		centh=Resteh/100;                    //Décodage pour l'affichage de la valeur
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _centh+0 
;Test_Complet_4c.c,245 :: 		Resteh= Resteh -cent*100;
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
;Test_Complet_4c.c,246 :: 		dizh= Resteh /10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _dizh+0 
;Test_Complet_4c.c,247 :: 		unith= Resteh % 10;
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
;Test_Complet_4c.c,249 :: 		if(cent==1) Lcd_chr(2,2,centh+0x30); //Affichage de la valeur
	MOVF        _cent+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Aff_TempHum18
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       _centh+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
L_Aff_TempHum18:
;Test_Complet_4c.c,250 :: 		if(cent==0) Lcd_Out(2,2," ");
	MOVF        _cent+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Aff_TempHum19
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr15_Test_Complet_4c+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr15_Test_Complet_4c+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_Aff_TempHum19:
;Test_Complet_4c.c,251 :: 		Lcd_chr(2,2,centh+0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       _centh+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Test_Complet_4c.c,253 :: 		Lcd_chr_Cp(unith+0x30);
	MOVLW       48
	ADDWF       _unith+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_4c.c,254 :: 		Lcd_Out_Cp("%");
	MOVLW       ?lstr16_Test_Complet_4c+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr16_Test_Complet_4c+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Test_Complet_4c.c,257 :: 		TempTotale=TempMSB*256;
	MOVF        _TempMSB+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	MOVWF       _TempTotale+0 
	MOVF        R1, 0 
	MOVWF       _TempTotale+1 
;Test_Complet_4c.c,258 :: 		TempTotale=TempTotale+TempLSB;
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
;Test_Complet_4c.c,259 :: 		TempTotale=TempTotale >> 2;
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
;Test_Complet_4c.c,261 :: 		tempcalcul= TempTotale;               //Mise en place de la formule
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       _tempcalcul+0 
	MOVF        R1, 0 
	MOVWF       _tempcalcul+1 
	MOVF        R2, 0 
	MOVWF       _tempcalcul+2 
	MOVF        R3, 0 
	MOVWF       _tempcalcul+3 
;Test_Complet_4c.c,262 :: 		tempcalcul=tempcalcul/16382;          //donnée par le constructeur
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
;Test_Complet_4c.c,263 :: 		tempcalcul=tempcalcul*165;
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
;Test_Complet_4c.c,264 :: 		tempcalcul=tempcalcul-40;
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
;Test_Complet_4c.c,266 :: 		Reste = tempcalcul;                  // Reste = Partie entière
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       _Reste+0 
	MOVF        R1, 0 
	MOVWF       _Reste+1 
;Test_Complet_4c.c,267 :: 		cent=Reste/100;                      //Décodage pour l'affichage de la valeur
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _cent+0 
;Test_Complet_4c.c,268 :: 		Reste= Reste -cent*100;
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
;Test_Complet_4c.c,269 :: 		diz= Reste /10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _diz+0 
;Test_Complet_4c.c,270 :: 		unit= Reste % 10;
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
;Test_Complet_4c.c,272 :: 		if(cent==1) Lcd_chr(2,12,cent+0x30); //Affichage de la valeur
	MOVF        _cent+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Aff_TempHum20
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       _cent+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
L_Aff_TempHum20:
;Test_Complet_4c.c,273 :: 		if(cent==0) Lcd_Out(2,12,"");
	MOVF        _cent+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Aff_TempHum21
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr17_Test_Complet_4c+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr17_Test_Complet_4c+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_Aff_TempHum21:
;Test_Complet_4c.c,274 :: 		Lcd_Chr_CP(diz+0x30);
	MOVLW       48
	ADDWF       _diz+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_4c.c,275 :: 		Lcd_Chr_Cp(unit+0x30);
	MOVLW       48
	ADDWF       _unit+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Test_Complet_4c.c,276 :: 		Lcd_Out_Cp("`");
	MOVLW       ?lstr18_Test_Complet_4c+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr18_Test_Complet_4c+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Test_Complet_4c.c,277 :: 		Lcd_Out_Cp("C");
	MOVLW       ?lstr19_Test_Complet_4c+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr19_Test_Complet_4c+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Test_Complet_4c.c,278 :: 		}
L_end_Aff_TempHum:
	RETURN      0
; end of _Aff_TempHum

_Vpile:

;Test_Complet_4c.c,280 :: 		void Vpile()
;Test_Complet_4c.c,284 :: 		Vbat=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;Test_Complet_4c.c,285 :: 		Vbat=Vbat*0.0048828125;
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
;Test_Complet_4c.c,286 :: 		IntToStr(Vbat,tension);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       Vpile_tension_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(Vpile_tension_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Test_Complet_4c.c,287 :: 		Lcd_Out(1,10,tension);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       Vpile_tension_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(Vpile_tension_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet_4c.c,288 :: 		Lcd_Out(1,16,"V");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr20_Test_Complet_4c+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr20_Test_Complet_4c+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Test_Complet_4c.c,289 :: 		}
L_end_Vpile:
	RETURN      0
; end of _Vpile
