#line 1 "C:/Users/Jordan/Documents/Projet_BTS_2018/Programme/I2C_complet.c"
#line 31 "C:/Users/Jordan/Documents/Projet_BTS_2018/Programme/I2C_complet.c"
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
void Communication(void);




int reponseH, reponseM;
char heure[8], minute[8];
char vari;

void main()
{
 config();
 while(1)
 {
 communication();
 }
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
}
void communication()
{
vari=0;
if( PORTA.F1 ==0)
{
 vari=1;
 delay_ms(10);
}
if(vari==1)
 {

 I2C1_Start();
 I2C1_Wr(0xDE);
 I2C1_Wr(0);
 I2C1_Wr(0x80);

 I2C1_Wr(1);
 I2C1_Wr(0x00);

 I2C1_Wr(0x02);
 I2C1_Wr(0x40);

 I2C1_Wr(3);
 I2C1_Wr(0x21);

 I2C1_Wr(0x04);
 I2C1_Wr(0x01);

 I2C1_Wr(0x05);
 I2C1_Wr(0x06);

 I2C1_Wr(0x06);
 I2C1_Wr(0x18);
 I2C1_Stop();
 vari=0;

 delay_ms(100);
 }

I2C1_Start();
 I2C1_Wr(0xDE);
 I2C1_Wr(2);
I2C1_Repeated_Start();
 I2C1_Wr(0xDF);
 reponseH=I2C1_Rd(0);
I2C1_Stop();

I2C1_Start();
 I2C1_Wr(0xDE);
 I2C1_Wr(1);
I2C1_Repeated_Start();
 I2C1_Wr(0xDF);
 reponseM=I2C1_Rd(0);
I2C1_Stop();

 IntToStr(reponseH,heure);
 IntToStr(reponseM,minute);

 Lcd_Out(1,4,minute);
 Lcd_Out_Cp("m");
 Lcd_Out(1,1,heure);
 Lcd_Out_Cp("h");
 Lcd_Out(2,1,"Fin Sequence");
 delay_ms(150);
}
