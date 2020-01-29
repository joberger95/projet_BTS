#line 1 "G:/Projet_BTS_2018/Programme/Test_Complet_3.c"
#line 31 "G:/Projet_BTS_2018/Programme/Test_Complet_3.c"
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
void Lecture_TempHum(void);
void Vpile(void);
void Aff_Heure(void);
void Aff_TempHum(void);







char reponseH, reponseM,reponseS,DizHeure, UnitHeure, DizMin, UnitMin, DizSec,
 UnitSec;
char H_Prog, M_Prog, S_Prog;
float humcalcul, tempcalcul;
int reponseHum, HumMSB, HumLSB, TempMSB, TempLSB, HumTotale, TempTotale, Reste,
 Resteh;
char cent, diz, unit, rest, centh, dizh, unith;

void main()
{
 H_Prog = 0x10; M_Prog= 0x19; S_Prog= 0x00;

 config();
 delay_ms(1000);
 Lcd_Cmd(_LCD_CLEAR);
 while(1)
 {
 Test_Complet();
 Lecture_Heure();
 Aff_Heure();
 delay_ms(100);
 Lecture_TempHum();
 Aff_TempHum();
 delay_ms(100);
 Vpile();

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
 Lcd_Out(1,1,"Modif Heure=>BP1");
 UART1_Init(9600);
 UART2_Init(9600);

 I2C1_Init(100000);
 Delay_ms(100);

 if( PORTA.F1 ==0)
 {
 Param_Heure();
 }
 Sound_Init(&PORTC,5);
}

void Param_Heure()
{
 I2C1_Start();
 I2C1_Wr(0xDE);
 I2C1_Wr(0);
 I2C1_Wr(0x80 + S_Prog);
 I2C1_Wr(M_Prog);
 I2C1_Wr(H_Prog);
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
 Lcd_Cmd(_LCD_CLEAR);
  PORTC.F2 =1;
 UART2_Write_Text("Test Complet");
 UART2_Write(13);
 UART2_Write(10);
 Lcd_Out(1,1,"Transm Serie");
 delay_ms(2500);
 Lcd_Cmd(_LCD_CLEAR);
 Sound_Play( 440 ,1000);
  PORTC.F2 =0;
 }
 if( PORTA.F2 ==0)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Init GSM");
 UART1_Write_Text("AT");
 retchar();
 delay_ms(2000);
 UART1_Write_Text("AT+CPIN=1234");
 retchar();
 delay_ms(4000);
 Lcd_Out(1,1,"Transm GSM");
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
 Lcd_Out(1,1,"SMS Transmis");
 delay_ms(2000);
 Lcd_Cmd(_LCD_CLEAR);
 }
}

void Lecture_Heure()
{
I2C1_Start();
 I2C1_Wr(0xDE);
 I2C1_Wr(0);
I2C1_Repeated_Start();
 I2C1_Wr(0xDF);
 reponseS=I2C1_Rd(1);
 reponseM=I2C1_Rd(1);
 reponseH=I2C1_Rd(0);
 I2C1_Stop();
 reponseS=reponseS & 0x7F;
}
void Aff_Heure()
{
 UnitSec=(reponseS&0x0F)+0x30;
 DizSec=(reponseS>>4);
 DizSec=(DizSec&0x07)+0x30;

 UnitMin=(reponseM&0x0F)+0x30;
 DizMin=(reponseM>>4);
 DizMin=(DizMin&0x07)+0x30;

 UnitHeure=(reponseH&0x0F)+0x30;
 DizHeure=(reponseH>>4);
 DizHeure=(DizHeure&0x03)+0x30;

 Lcd_Chr(1,1,DizHeure);
 Lcd_Chr_Cp(UnitHeure);
 Lcd_Out_Cp(":");
 Lcd_Chr_Cp(DizMin);
 Lcd_Chr_Cp(UnitMin);
 Lcd_Out_Cp(":");
 Lcd_Chr_Cp(DizSec);
 Lcd_Chr_Cp(UnitSec);

}

void Lecture_TempHum()
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
}

void Aff_TempHum()
{
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

 if(cent==1) Lcd_chr(2,2,centh+0x30);
 if(cent==0) Lcd_Out(2,2," ");
 Lcd_chr(2,2,centh+0x30);

 Lcd_chr_Cp(unith+0x30);
 Lcd_Out_Cp("%");


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

 if(cent==1) Lcd_chr(2,12,cent+0x30);
 if(cent==0) Lcd_Out(2,12,"");
 Lcd_Chr_CP(diz+0x30);
 Lcd_Chr_Cp(unit+0x30);
 Lcd_Out_Cp("`");
 Lcd_Out_Cp("C");
}

void Vpile()
{
int Vbat;
char tension;
 Vbat=ADC_Read(0);
 Vbat=Vbat*0.0048828125;
 IntToStr(Vbat,tension);
 Lcd_Out(1,10,tension);
 Lcd_Out_Cp("V");
}
