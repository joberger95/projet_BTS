#line 1 "G:/Programme/Test_Complet.c"
#line 31 "G:/Programme/Test_Complet.c"
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
void retchar(void);
void Param_Heure(void);
void Test_Complet(void);
void Lecture_Heure(void);





char heure[8], minute[8], valeurHum[8];
int reponseH, reponseM, reponseHum;

void main()
{
 config();
 while(1)
 {
 Test_Complet();
 Lecture_Heure();
 }
}

void config()
{
 ANSELA=0x00;
 ANSELB=0x00;
 ANSELC=0x00;

 TRISA=0xFF;
 TRISB=0x81;
 TRISC=0x99;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 UART1_Init(9600);
 UART2_Init(9600);

 I2C1_Init(100000);
 Param_Heure();

 Sound_Init(&PORTC,5);


}

void Param_Heure()
{

 I2C1_Start();
 I2C1_Wr(0xDE);
 I2C1_Wr(0);
 I2C1_Wr(0x80);
 I2C1_Stop();

 I2C1_Start();
 I2C1_Wr(0xDE);
 I2C1_Wr(1);
 I2C1_Wr(0x21);
 I2C1_Stop();

 I2C1_Start();
 I2C1_Wr(0xDE);
 I2C1_Wr(0x02);
 I2C1_Wr(0x50);
 I2C1_Stop();

}

void retchar()
{
delay_ms(500);
 UART1_Write(13);
 UART1_Write(10);
 delay_ms(200);
}


void Test_Complet()
{
 if( PORTA.F1 ==0)
 {
  PORTC.F2 =1;
 UART2_Write_Text("Test Complet");
 UART2_Write(13);
 UART2_Write(10);
 Lcd_Out(1,1,"Transm Serie");
 delay_ms(5000);
 Lcd_Cmd(_LCD_CLEAR);
 Sound_Play( 440 ,250);
 }
 if( PORTA.F2 ==0)
 {
 UART1_Write_Text("AT");
 retchar();
 delay_ms(2000);
 UART1_Write_Text("AT+CPIN=1234");
 retchar();
 delay_ms(2000);
 Lcd_Out(2,1,"Transm GSM");
 UART1_Write_Text("AT+CMGD=4");
 retchar();
 delay_ms(2000);
 UART1_Write_Text("AT+CMGF=1");
 retchar();
 delay_ms(2000);
 UART1_Write_Text("AT+CMGS=0648200953");
 retchar();
 delay_ms(2000);
 UART1_Write_Text("Ca marche");
 retchar();
 UART1_Write(26);
 retchar();
 Lcd_Out(2,1,"SMS Transmis");
 delay_ms(5000);
 Lcd_Cmd(_LCD_CLEAR);
 }
}
void Lecture_Heure()
{

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
 delay_ms(150);
}
