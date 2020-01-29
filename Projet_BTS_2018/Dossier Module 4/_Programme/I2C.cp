#line 1 "C:/Users/Jordan/Documents/Projet_BTS_2018/Dossier Module 4/_Programme/I2C.c"
#line 28 "C:/Users/Jordan/Documents/Projet_BTS_2018/Dossier Module 4/_Programme/I2C.c"
sbit LCD_RS at RC0_bit;
sbit LCD_EN at RC1_bit;
sbit LCD_D4 at RB2_bit;
sbit LCD_D5 at RB3_bit;
sbit LCD_D6 at RB4_bit;
sbit LCD_D7 at RB5_bit;

sbit LCD_RS_Direction at TRISC0_bit;
sbit LCD_EN_Direction at TRISC1_bit;
sbit LCD_D4_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB4_bit;
sbit LCD_D7_Direction at TRISB5_bit;

void config(void);
void comHTR(void);





void main()
{
 config();

 comHTR();

}
void config()
{
 ANSELA=0x00;
 ANSELB=0x00;
 ANSELC=0x00;
 TRISA=0xFF;
 TRISB=0x13;
 TRISC=0x90;
 TRISE=0xFF;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 delay_ms(200);

 UART1_Init(9600);
 UART2_Init(9600);

 I2C1_Init(100000);

 Lcd_Out(1,1,"Essai HTR");
 delay_ms(4000);
}
void comHTR
{
 char reponse;

 I2C1_Wr(0x00);
 I2C1_Wr(0x1F);
I2C1_Repeated_Start();
 I2C1_Wr(0x01);
 I2C1_Wr(0x0F);
I2C1_Repeated_Start();
 I2C1_Wr(0x02);
 I2C1_Wr(0x0F);
I2C1_Start();
 I2C1_Wr(0b1101110);
I2C1_Repeated_Start();
 I2C1_Wr(0x07);
 I2C1_Wr(0xF);
I2C1_Repeated_Start();
 I2C1_Wr(0x04);
 I2C1_Wr(0x05);
I2C1_Repeated_Start();
 I2C1_Wr(0x05);
 I2C1_Wr(0x0F);
I2C1_Repeated_Start();
 I2C1_Wr(0x06);
 I2C1_Wr(0x0F);
I2C1_Stop();



I2C1_Start();
 I2C1_Wr(0b11011110);
 I2C1_Wr(0x00);
I2C1_Repeated_Start();
 I2C1_Wr(0b1101111);
 reponse=I2C1_Rd(0);
I2C1_Stop();

 Lcd_Out(1,1,reponse);
}
