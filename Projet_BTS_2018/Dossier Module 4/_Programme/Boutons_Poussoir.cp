#line 1 "C:/Users/Jordan/Documents/Projet_BTS_2018/Dossier Module 4/_Programme/Boutons_Poussoir.c"
#line 28 "C:/Users/Jordan/Documents/Projet_BTS_2018/Dossier Module 4/_Programme/Boutons_Poussoir.c"
sbit LCD_RS at RC0_bit;
sbit LCD_EN at RC1_bit;
sbit LCD_D4 at RB2_bit;
sbit LCD_D5 at RB3_bit;
sbit LCD_D6 at RB4_bit;
sbit LCD_D7 at RB5_bit;

sbit LCD_RS_Direction at TRISC0_bit;
sbit LCD_EN_Direction at TRISC1_bit;
sbit LCD_D0_Direction at TRISB2_bit;
sbit LCD_D1_Direction at TRISB3_bit;
sbit LCD_D2_Direction at TRISB4_bit;
sbit LCD_D3_Direction at TRISB5_bit;

void config(void);
void Bouton_Poussoir(void);




void main()
{
 config();
 Bouton_Poussoir();
}

void config()
{
 OSCCON=0x60;
 TRISA=0xFF;
 TRISB=0x13;
 TRISC=0x90;
 TRISE=0xFF;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
}
void Bouton_Poussoir()
{
while(1)
{
 if( PORTA.F1 ==1)
 {
 LATC=0xFF;
 Lcd_Out(1,1,"LED4=Allumée");
 }
 else {LATC=0;}
 if( PORTA.F2 ==1)
 {
 Lcd_Out(1,1,"LED4=Clignote");
 LATC=0xFF;
 delay_ms(250);
 LATC=0;
 delay_ms(500);
 }
 else {LATC=0;}
 }
}
