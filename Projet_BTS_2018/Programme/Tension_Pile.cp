#line 1 "G:/Projet_BTS_2018/Programme/Tension_Pile.c"
#line 31 "G:/Projet_BTS_2018/Programme/Tension_Pile.c"
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
void Vpile(void);

int Vbat;
char tension;

void main()
{
 config();
 while(1)
 {
 Vpile();
 delay_ms(150);
 }
}



void config()
{
 ANSELA=0x01;
 ANSELB=0x00;
 ANSELC=0x00;

 TRISA=0xFF;
 TRISB=0x81;
 TRISC=0x99;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1,1,"Tension Pile");
}
void Vpile()
{
 Vbat=ADC_Read(0);
 Vbat=Vbat*0.0048828125;
 IntToStr(Vbat,tension);
 Lcd_Out(2,1,tension);
 Lcd_Out_Cp("V");
}
