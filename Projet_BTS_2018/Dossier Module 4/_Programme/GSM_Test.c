/*BERGER Jordan               VALAR2000
  Chef de Projet: M.COTTET Jean-Jacques
  Entreprise: Association Arret Demande
  Projet BTS 2017/2018 Lycee M.GENEVOIX
But: Effectuer un programme utilisant
     les fonctions RS232, l'affichage,
     les LEDs et les boutons poussoirs

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
void GSM(void);
void retchar(void);
/*******Defintion des Variables*******/
#define BP1 PORTA.F1                 //Associe à PORTA.F1 le nom BP1
#define BP2 PORTA.F2                 //Associe à PORTA.F2 le nom BP2
#define LED PORTC.F2                 //Associe à PORTC.F2 le nom LED
/**************************PROGRAMME PRINCIPAL*********************************/
void main()
{
   config();                         //Appel le sous-programme
   while(1)
   {
    GSM();                  //Appel au sous-programme
   }
}
void config()
{
   ANSELA=0x00;                      //Passe toutes les broches en digital
   ANSELB=0x00;
   ANSELC=0x00;
   TRISA=0xFF;                       //0b11111111
   TRISB=0x13;                       //0b10000011
   TRISC=0x90;                       //0b10010000
   TRISE=0xFF;                       //0x11111111

   Lcd_Init();                       //Initialisation LCD
   Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
   Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur
   
   UART1_Init(9600);                 //Initialisation GSM
   UART2_Init(9600);                 //Initialisation RS232
}
void GSM()
{
if(BP2==0)
{
 UART2_Write('A');
 delay_ms(250);
}
if(BP1==0)
{
 UART1_Write_Text("AT");
 retchar();
 delay_ms(2000);
 UART1_Write_Text("AT+CPIN=1234");
 retchar();
 delay_ms(4000);
 UART1_Write_Text("AT+CMGD=1");
 
 UART1_Write_Text("AT+CMGF=1");
 retchar();
 delay_ms(2000);
 UART1_Write_Text("AT+CMGS=0648200953");
 retchar();
 delay_ms(2000);
 UART1_Write_Text("Essai Carte");
 retchar();
 delay_ms(2000);
 UART1_Write(26);
 retchar();
 delay_ms(2000);
}
}
void retchar()
{
 UART1_Write(13);
 UART1_Write(10);
}