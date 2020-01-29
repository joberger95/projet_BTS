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
void retchar(void);
void Param_Heure(void);
void Test_Complet(void);
void Lecture_Heure(void);
/*******Defintion des Variables*******/
#define BP1 PORTA.F1                 //Associe à PORTA.F1 le nom BP1
#define BP2 PORTA.F2                 //Associe à PORTA.F2 le nom BP2
#define LedOrange PORTC.F2           //Associe à PORTC.F2 le nom LED
#define LA 440
char heure[8], minute[8], valeurHum[8];
int reponseH, reponseM, reponseHum;
/**************************PROGRAMME PRINCIPAL*********************************/
void main()
{
   config();                         //Appel le sous-programme
    while(1)                         //Boucle infinie
    {
     Test_Complet();
     Lecture_Heure();
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

   UART1_Init(9600);                 //Initialisation GSM
   UART2_Init(9600);                 //Initialisation RS232

   I2C1_Init(100000);                //Initialisaition I2C
   Param_Heure();                    //Appel sous-programme param horodatage
   
   Sound_Init(&PORTC,5);
   

}
/*******************************SOUS-PROGRAMMES********************************/
void Param_Heure()
{
 //Ecriture
         I2C1_Start();        //Condition de Start
         I2C1_Wr(0xDE);       //Adresse HTR+W
         I2C1_Wr(0);          //Adresse mémoire 0
         I2C1_Wr(0x80);       //0 sec
         I2C1_Stop();

         I2C1_Start();        //Condition de Start
         I2C1_Wr(0xDE);       //Adresse HTR+W
         I2C1_Wr(1);          //Adresse mémoire 1
         I2C1_Wr(0x21);       //0 min
         I2C1_Stop();
         
         I2C1_Start();        //Condition de Start
         I2C1_Wr(0xDE);       //Adresse HTR+W
         I2C1_Wr(0x02);       //Adresse mémoire 2
         I2C1_Wr(0x50);       //24h, 0h
         I2C1_Stop();

}
//Sous-programme de Retour Chariot et Retour Ligne
void retchar()
{
delay_ms(500);
 UART1_Write(13);
 UART1_Write(10);
 delay_ms(200);
}
/******************************************************************************/
//Sous-programme de Test
void Test_Complet()
{
 if(BP1==0)
 {
  LedOrange=1;
  UART2_Write_Text("Test Complet");
  UART2_Write(13);
  UART2_Write(10);
  Lcd_Out(1,1,"Transm Serie");
  delay_ms(5000);
  Lcd_Cmd(_LCD_CLEAR);
  Sound_Play(LA,250);
 }
 if(BP2==0)
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
//Lecture
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