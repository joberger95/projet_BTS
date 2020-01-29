/*BERGER Jordan               VALAR2000
  Chef de Projet: M.COTTET Jean-Jacques
  Entreprise: Association Arret Demande
  Projet BTS 2017/2018 Lycee M.GENEVOIX
But: Programme de test fonctionnel de
     l'ensemble des fonctions

LATA RA5      RA4      RA3    RA2     RA1     RA0
     NC       NC       NC     BP2     BP1     Vbat
     E        E        E      E       E       E
     0b11111111        0xFF

LATB RB7      RB6      RB5    RB4     RB3     RB2     RB1     RB0
     RX2/PGD  Tx2/PGC  D7     D6      D5      D4      NC      INT
     E        S        S      S       S       S       E       E
     0b10000011       0x13

LATC RC7      RC6      RC5    RC4     RC3     RC2     RC1     RC0
     Rx1      Tx1      Buz    SDA     SCL     LED4    EN      RS
     E        S        S      E       S       S       S       S
     0b10010000        0x90

LATE RE3
     /MCLR
     E
     0b11111111       0xFF

Adresse HTR: 1101111 + r/w      0xDE(Ecriture) ou 0xDF(Lecture)

/*****Configuration de l'Afficheur****/
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
/*******Definiton des Programmes******/
void config(void);
void Lecture_Temp_Hum(void);
/*******Defintion des Variables*******/
int HumMSB, HumLSB, TempMSB, TempLSB, HumTotale, TempTotale;
float humcalcul, tempcalcul;
char cent, diz, unit, rest, centh, dizh, unith;
int Reste, Resteh;
/**************************PROGRAMME PRINCIPAL*********************************/
void main()
{
   config();                         //Appel le sous-programme
    while(1)                         //Boucle infinie
    {
     Lecture_Temp_Hum();
     delay_ms(200);
    }
}
//Sous-programme de configuration des communications, afficheur, registres
void config()
{
   ANSELA=0x00;                      //Passe toutes les broches en digital
   ANSELB=0x00;
   ANSELC=0x00;

   TRISA=0xFF;                       //0b11111111
   TRISB=0x81;                       //0b10000001
   TRISC=0x99;                       //0b10011001

   Lcd_Init();                       //Initialisation LCD
   Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
   Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur

   I2C1_Init(100000);                //Initialisation I2C

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
   TempLSB=I2C1_Rd(0);      // et Nack Master
I2C1_Stop();
/*************************************/
/*******Traitement de l'humidité******/
HumTotale=HumMSB*256;
HumTotale=HumTotale+HumLSB;
humcalcul=HumTotale;
humcalcul=humcalcul/16382;
humcalcul=humcalcul*100;
 
 Resteh = humcalcul;     // Reste = Partie entière
 centh=Resteh/100;
 Resteh= Resteh -cent*100;
 dizh= Resteh /10;
 unith= Resteh % 10;
 
 if(cent==1) Lcd_chr(2,10,centh+0x30);
 if(cent==0) Lcd_Out(2,10," ");
 Lcd_chr(2,3,centh+0x30);
 //Lcd_chr_Cp(dizh+0x30);
 Lcd_chr_Cp(unith+0x30);
 Lcd_Out_Cp("%");
 delay_ms(10);
 /*************************************/
 /****Traitement de la température*****/
TempTotale=TempMSB*256;
TempTotale=TempTotale+TempLSB;
TempTotale=TempTotale >> 2;

 //TempTotale= 0x19DA;    // Valeur en exemple pour 26.6°C
tempcalcul= TempTotale;
tempcalcul=tempcalcul/16382;
tempcalcul=tempcalcul*165;
tempcalcul=tempcalcul-40;

//tempcalcul=123.5;
 Reste = tempcalcul;     // Reste = Partie entière
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