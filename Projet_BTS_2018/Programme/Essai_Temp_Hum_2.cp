#line 1 "G:/Programme/Essai_Temp_Hum_2.c"
#line 31 "G:/Programme/Essai_Temp_Hum_2.c"
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
char cent, diz, unit, rest, centh, dizh, unith;
int Reste, Resteh;

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

 Lcd_Out(1,1,"Lecture Hum/Temp");
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


HumTotale=HumMSB*256;
HumTotale=HumTotale+HumLSB;
humcalcul=HumTotale;
humcalcul=humcalcul/16382;
humcalcul=humcalcul*100;

 Resteh = humcalcul;
 centh=Resteh/100;
 Resteh= Resteh -cent*100;
 dizh= Resteh /10;
 unith= Resteh % 10;

 if(cent==1) Lcd_chr(2,10,centh+0x30);
 if(cent==0) Lcd_Out(2,10," ");
 Lcd_chr(2,3,centh+0x30);

 Lcd_chr_Cp(unith+0x30);
 Lcd_Out_Cp("%");
 delay_ms(10);


TempTotale=TempMSB*256;
TempTotale=TempTotale+TempLSB;
TempTotale=TempTotale >> 2;


tempcalcul= TempTotale;
tempcalcul=tempcalcul/16382;
tempcalcul=tempcalcul*165;
tempcalcul=tempcalcul-40;


 Reste = tempcalcul;
 cent=Reste/100;
 Reste= Reste -cent*100;
 diz= Reste /10;
 unit= Reste % 10;

 if(cent==1) Lcd_chr(2,10,cent+0x30);
 if(cent==0) Lcd_Out(2,10," ");
 Lcd_chr_Cp(diz+0x30);
 Lcd_chr_Cp(unit+0x30);
 Lcd_Out_Cp("`");
 Lcd_Out_Cp("C");
 delay_ms(10);
}
