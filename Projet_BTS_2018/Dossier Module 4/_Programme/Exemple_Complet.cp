#line 1 "C:/Users/Jordan/Documents/Projet_BTS_2018/Dossier Module 4/_Programme/Exemple_Complet.c"
#line 29 "C:/Users/Jordan/Documents/Projet_BTS_2018/Dossier Module 4/_Programme/Exemple_Complet.c"
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
void Test_Complet(void);





void main()
{
 config();
 while(1)
 {
 Test_Complet();
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

 UART2_Init(9600);
}
void Test_Complet()
{
  PORTC.F2 =0;

  PORTC.F2 =1;
 delay_ms(500);
 Lcd_Out(1,1,"Essai");
 UART2_Write('A');
 delay_ms(250);

}
