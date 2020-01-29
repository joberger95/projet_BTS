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
void Lecture_TempHum(void);
void Vpile(void);
void Aff_Heure(void);
void Aff_TempHum();

/*******Defintion des Variables*******/
#define BP1 PORTA.F1                 //Associe à PORTA.F1 le nom BP1
#define BP2 PORTA.F2                 //Associe à PORTA.F2 le nom BP2
#define LedOrange PORTC.F2           //Associe à PORTC.F2 le nom LED
#define LA 440
#define SCL  LATC.f3
#define SDA  LATC.f4
char reponseH, reponseM,reponseS,DizHeure, UnitHeure, DizMin, UnitMin, DizSec,
     UnitSec;
char H_Prog, M_Prog, S_Prog;
float humcalcul, tempcalcul;
int reponseHum, HumMSB, HumLSB, TempMSB, TempLSB, HumTotale, TempTotale, Reste,
    Resteh;
char cent, diz, unit, rest, centh, dizh, unith;
     
/**************************PROGRAMME PRINCIPAL*********************************/
void main()
{
    H_Prog = 0x14; M_Prog= 0x26; S_Prog= 0x0;  // Heures minutes seconde
                                         // d'initialisation de l'horloge
    config();                         //Appel le sous-programme
    delay_ms(1000);
    while(1)                         //Boucle infinie
    {
     Test_Complet();    // Transmissions (Série et GSM)
     Lecture_Heure();
     //Aff_Heure();
     delay_ms(100);        //2500 pour confort 100 pour visu oscillo
     Lecture_TempHum();
     Aff_TempHum();
     delay_ms(100);        //2500 pour confort 100 pour visu oscillo
    // Vpile();
    }
}
/*******************************SOUS-PROGRAMMES********************************/
/******************************************************************************/
//Sous-programme de configuration des communications, afficheur, registres,...
void config()
{
   ANSELA=0x00;                      //Passe toutes les broches en digital
   ANSELB=0x00;
   ANSELC=0x00;

   TRISA=0xFF;                       //0b11111111
   TRISB=0x81;                       //0b10000001
   TRISC=0x99;                       //0b10011001      SCL et SDA en entrée
  /*
   SDA=0; SCL=0;
   TRISC=0x81;                       //0b10000001      SCL et SDA en entrée
   Delay_ms(10);
   SCL=1;
   Delay_us(40);
   SDA=1;
  */
   Lcd_Init();                       //Initialisation LCD
   Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
   Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur
   Lcd_Out(1,1,"Modif Heure=>BP1");
   UART1_Init(9600);                 //Initialisation GSM
   UART2_Init(9600);                 //Initialisation RS232

   I2C1_Init(100000);                //Initialisaition I2C
   
   Delay_ms(100);
  // I2C1_Stop();
   if(BP1==0)                        //Condition BP1 enfoncé
   {  
      Param_Heure();                    //Appel sous-programme param horodatage
   }
   Sound_Init(&PORTC,5);             //Initialisation du Buzzer
}
//Sous-programme d'écriture de l'heure
void Param_Heure()
{
         I2C1_Start();               //Condition de Start
         I2C1_Wr(0xDE);              //Adresse HTR+W
         I2C1_Wr(0);                 //Adresse mémoire 0
         I2C1_Wr(0x80 + S_Prog);     //Oscillateur activé + Seconde
         I2C1_Wr(M_Prog);            //minutes
         I2C1_Wr(H_Prog);            //Mode 24h, + Heures
         I2C1_Stop();                //Bit de stop

     /*
         I2C1_Start();               //Condition de Start
         I2C1_Wr(0xDE);              //Adresse HTR+W
         I2C1_Wr(0);                 //Adresse mémoire 0
         I2C1_Wr(0x80 + S_Prog);     //Oscillateur activé + Seconde
         I2C1_Stop();                //Bit de stop

         I2C1_Start();               //Condition de Start
         I2C1_Wr(0xDE);              //Adresse HTR+W
         I2C1_Wr(1);                 //Adresse mémoire 1
         I2C1_Wr(M_Prog);            //minutes
         I2C1_Stop();                //Bit de stop
         
         I2C1_Start();               //Condition de Start
         I2C1_Wr(0xDE);              //Adresse HTR+W
         I2C1_Wr(2);                 //Adresse mémoire 2
         I2C1_Wr(H_Prog);            //Mode 24h, + Heures
         I2C1_Stop();                //Bit de stop
       */

}
//Sous-programme de Retour Chariot et Retour Ligne
void retchar()
{
delay_ms(500);
 UART1_Write(13);                  //Retour Chariot
 UART1_Write(10);                  //Retour ligne
 delay_ms(200);                    //délai de 200ms
}
/******************************************************************************/
//Sous-programme de Test de transmission série+buzzer et GSM
void Test_Complet()
{
 if(BP1==0)                        //Condition BP1 enfoncé
 {
  Lcd_Cmd(_LCD_CLEAR);             //Reset de l'afficheur
  LedOrange=1;                     //Allume la LED
  UART2_Write('A');//Transmet le texte
  UART2_Write(13);                 //Retour chariot
  UART2_Write(10);                 //Retour ligne
  Lcd_Out(1,1,"Transm Serie");     //Transmet le texte
  delay_ms(5000);                  //Délai de 5s
  Lcd_Cmd(_LCD_CLEAR);             //Reset de l'afficheur
  Sound_Play(LA,1000);             //Le buzzer sonne pendant 1s
  LedOrange=0;                     //Eteint la LED
 }
 if(BP2==0)                        //Condition BP2 enfoncé
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Init GSM");          //Affiche le text
 UART1_Write_Text("AT");           //Transmet le texte au GSM(init)
  retchar();                       //Retchar
  delay_ms(2000);                  //Délai de 2s
 UART1_Write_Text("AT+CPIN=1234"); //Transmet le texte au GSM(Code PIN)
  retchar();
  delay_ms(4000);
    Lcd_Out(1,1,"Transm GSM");     //Affiche le texte
 UART1_Write_Text("AT+CMGD=4");    //Transmet le texte au GSM(Delete les SMS)
  retchar();
  delay_ms(2000);
 UART1_Write_Text("AT+CMGF=1");    //Transmet le texte au GSM(Config du SMS)
  retchar();
  delay_ms(2000);
 UART1_Write_Text("AT+CMGS=0648200953");//Numéro de téléphone
  retchar();
  delay_ms(2000);
 UART1_Write_Text("Ca marche");    //Transmet le SMS
  retchar();
 UART1_Write(26);                  //CTRL+Z
  retchar();
    Lcd_Out(1,1,"SMS Transmis");   //Affiche le texte
  delay_ms(5000);                  //Délai de 5s
    Lcd_Cmd(_LCD_CLEAR);           //Reset de l'afficheur
 }
}
//Sous-programme de lecture de l'heure
void Lecture_Heure()
{
I2C1_Start();                      //Condition de start
  I2C1_Wr(0xDE);                   //Adresse HTR+W
  I2C1_Wr(0);                      //Adresse mémoire heures
I2C1_Repeated_Start();             //Repeated start
  I2C1_Wr(0xDF);                   //Adresse HTR+R
  reponseS=I2C1_Rd(1);             //Inscrit dans la variable la valeur lue
  reponseM=I2C1_Rd(1);
  reponseH=I2C1_Rd(0);
  I2C1_Stop();
  reponseS=reponseS & 0b01111111;   // forcage à 0 du Bit 8 (Marche arrêt RTC = HTR)
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
  DizHeure=(DizHeure&0x03)+0x30;     // Mode 24 Heures

  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Chr(1,5,DizHeure);
  Lcd_Chr_Cp(UnitHeure);
  Lcd_Out_Cp(":");
  Lcd_Chr_Cp(DizMin);
  Lcd_Chr_Cp(UnitMin);
  Lcd_Out_Cp(":");
  Lcd_Chr_Cp(DizSec);
  Lcd_Chr_Cp(UnitSec);

}
//Sous-programme de lecture de la température et de l'humidité
void Lecture_TempHum()
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
}
/**************************Traitement de l'humidité****************************/
void Aff_TempHum()
{
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

/***********************Traitement de la température***************************/
TempTotale=TempMSB*256;
TempTotale=TempTotale+TempLSB;
TempTotale=TempTotale >> 2;

tempcalcul= TempTotale;
tempcalcul=tempcalcul/16382;
tempcalcul=tempcalcul*165;
tempcalcul=tempcalcul-40;

 Reste = tempcalcul;     // Reste = Partie entière
 cent=Reste/100;
 Reste= Reste -cent*100;
 diz= Reste /10;
 unit= Reste % 10;

 if(cent==1) Lcd_chr(2,10,cent+0x30);
 if(cent==0) Lcd_Out(2,10," ");
 Lcd_Chr_Cp(diz+0x30);
 Lcd_Chr_Cp(unit+0x30);
 Lcd_Out_Cp("`");
 Lcd_Out_Cp("C");

}
/***********************Traitement de la tension de la pile *******************/
void Vpile()
{
int  Vbat;
char tension;
 Lcd_Cmd(_LCD_CLEAR);
 delay_ms(10);
 Lcd_Out(1,1,"Tension de Pile");
 delay_ms(10);
 Vbat=ADC_Read(0);
 Vbat=Vbat*0.0048828125;
 IntToStr(Vbat,tension);
 Lcd_Out(2,3,tension);
 Lcd_Out_Cp("V");
 delay_ms(2500);
}