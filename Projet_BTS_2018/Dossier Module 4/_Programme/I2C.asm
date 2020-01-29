
_main:

;I2C.c,49 :: 		void main()
;I2C.c,51 :: 		config();                         //Appel le sous-programme
	CALL        _config+0, 0
;I2C.c,53 :: 		comHTR();
	CALL        _comHTR+0, 0
;I2C.c,55 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;I2C.c,56 :: 		void config()
;I2C.c,58 :: 		ANSELA=0x00;                      //Passe toutes les broches en digital
	CLRF        ANSELA+0 
;I2C.c,59 :: 		ANSELB=0x00;
	CLRF        ANSELB+0 
;I2C.c,60 :: 		ANSELC=0x00;
	CLRF        ANSELC+0 
;I2C.c,61 :: 		TRISA=0xFF;                       //0b11111111
	MOVLW       255
	MOVWF       TRISA+0 
;I2C.c,62 :: 		TRISB=0x13;                       //0b10000011
	MOVLW       19
	MOVWF       TRISB+0 
;I2C.c,63 :: 		TRISC=0x90;                       //0b10010000
	MOVLW       144
	MOVWF       TRISC+0 
;I2C.c,64 :: 		TRISE=0xFF;                       //0x11111111
	MOVLW       255
	MOVWF       TRISE+0 
;I2C.c,66 :: 		Lcd_Init();                       //Initialisation LCD
	CALL        _Lcd_Init+0, 0
;I2C.c,67 :: 		Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;I2C.c,68 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;I2C.c,70 :: 		UART1_Init(9600);                 //Initialisation GSM
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;I2C.c,71 :: 		UART2_Init(9600);                 //Initialisation RS232
	BSF         BAUDCON2+0, 3, 0
	CLRF        SPBRGH2+0 
	MOVLW       207
	MOVWF       SPBRG2+0 
	BSF         TXSTA2+0, 2, 0
	CALL        _UART2_Init+0, 0
;I2C.c,73 :: 		I2C1_Init(400000);
	MOVLW       5
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;I2C.c,74 :: 		}
L_end_config:
	RETURN      0
; end of _config

_comHTR:

;I2C.c,75 :: 		void comHTR()
;I2C.c,79 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;I2C.c,80 :: 		I2C1_Wr(0b1101110);
	MOVLW       110
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,81 :: 		I2C1_Wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,82 :: 		I2C1_Wr(0x1F);
	MOVLW       31
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,83 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;I2C.c,84 :: 		I2C1_Wr(0x01);
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,85 :: 		I2C1_Wr(0x0F);
	MOVLW       15
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,86 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;I2C.c,87 :: 		I2C1_Wr(0x02);
	MOVLW       2
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,88 :: 		I2C1_Wr(0x0F);
	MOVLW       15
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,89 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;I2C.c,90 :: 		I2C1_Wr(0x07);
	MOVLW       7
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,91 :: 		I2C1_Wr(0xF);
	MOVLW       15
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,92 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;I2C.c,93 :: 		I2C1_Wr(0x04);
	MOVLW       4
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,94 :: 		I2C1_Wr(0x05);
	MOVLW       5
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,95 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;I2C.c,96 :: 		I2C1_Wr(0x05);
	MOVLW       5
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,97 :: 		I2C1_Wr(0x0F);
	MOVLW       15
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,98 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;I2C.c,99 :: 		I2C1_Wr(0x06);
	MOVLW       6
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,100 :: 		I2C1_Wr(0x0F);
	MOVLW       15
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,101 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;I2C.c,105 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;I2C.c,106 :: 		I2C1_Wr(0b11011110);
	MOVLW       222
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,107 :: 		I2C1_Wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,108 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;I2C.c,109 :: 		I2C1_Wr(0b1101111);
	MOVLW       111
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2C.c,110 :: 		reponse=I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       comHTR_reponse_L0+0 
	MOVLW       0
	MOVWF       comHTR_reponse_L0+1 
;I2C.c,111 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;I2C.c,113 :: 		LCD_Out(1,1,reponse);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        comHTR_reponse_L0+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        comHTR_reponse_L0+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;I2C.c,114 :: 		}
L_end_comHTR:
	RETURN      0
; end of _comHTR
