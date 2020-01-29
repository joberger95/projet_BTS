#line 1 "C:/Users/Jordan/Documents/Projet_BTS_2018/Dossier Module 4/_Programme/Cligno_LED.c"
#line 28 "C:/Users/Jordan/Documents/Projet_BTS_2018/Dossier Module 4/_Programme/Cligno_LED.c"
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

void configuration(void);
void Clign_LED(void);



void main()
{
 configuration();
 while(1)
 {
 Clign_LED();
 }
}

void configuration()
{
 TRISA=0xFF;
 TRISC=0x00;
#line 63 "C:/Users/Jordan/Documents/Projet_BTS_2018/Dossier Module 4/_Programme/Cligno_LED.c"
}
void Clign_LED()
{

if(PORTA.F1==1) LATC=0;
if(PORTA.F1==0) LATC=0xFF;

}
