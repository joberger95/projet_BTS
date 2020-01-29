#line 1 "G:/Programme/Essai-Temp.c"
#line 31 "G:/Programme/Essai-Temp.c"
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
void Lecture_Temp_Hum(void);

int HumMSB, HumLSB, TempMSB, TempLSB, HumTotale, TempTotale;
float humcalcul, tempcalcul;
char valeurHum[15], valeurTemp[15];
char cent,diz,unit,rest;
int Reste;

void main()
{
 config();
 while(1)
 {
 Lecture_Temp_Hum();
 delay_ms(200);
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

 I2C1_Init(100000);


}
void Lecture_Temp_Hum()
{
I2C1_Start();
 I2C1_Wr(0x4E);
I2C1_Repeated_Start();
 I2C1_Wr(0x4F);
 HumMSB=I2C1_Rd(1);
 HumLSB=I2C1_Rd(1);
 TempMSB=I2C1_Rd(1);
 TempLSB=I2C1_Rd(0);
I2C1_Stop();
#line 97 "G:/Programme/Essai-Temp.c"
TempTotale=TempMSB*256;
TempTotale=TempTotale+TempLSB;
TempTotale=TempTotale >> 2;
#line 105 "G:/Programme/Essai-Temp.c"
tempcalcul= 6618;
tempcalcul=tempcalcul/16382;
tempcalcul=tempcalcul*165;
tempcalcul=tempcalcul-40;



 Reste = tempcalcul;
 cent=Reste/100;
 Reste= Reste -cent*100;
 diz= Reste /10;
 unit= Reste % 10;


 Lcd_chr(2,1,cent+0x30);
 Lcd_chr_Cp(diz+0x30);
 Lcd_chr_Cp(unit+0x30);
 delay_ms(150);
#line 130 "G:/Programme/Essai-Temp.c"
}
