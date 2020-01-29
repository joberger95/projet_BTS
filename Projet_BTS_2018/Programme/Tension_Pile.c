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
void Vpile(void);
/*******Defintion des Variables*******/
int Vbat;
char tension;
/**************************PROGRAMME PRINCIPAL*********************************/
void main()
{
   config();                         //Appel le sous-programme
    while(1)                         //Boucle infinie
    {
      Vpile();
      delay_ms(150);
    }
}
/*******************************SOUS-PROGRAMMES********************************/
/******************************************************************************/
//Sous-programme de configuration des communications, afficheur, registres
void config()
{
   ANSELA=0x01;                      //Passe toutes les broches en digital
   ANSELB=0x00;
   ANSELC=0x00;

   TRISA=0xFF;                       //0b11111111
   TRISB=0x81;                       //0b10000001
   TRISC=0x99;                       //0b10011001

   Lcd_Init();                       //Initialisation LCD
   Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
   Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur

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