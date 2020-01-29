/*BERGER Jordan               VALAR2000
  Chef de Projet: M.COTTET Jean-Jacques
  Entreprise: Association Arret Demande
  Projet BTS 2017/2018 Lycee M.GENEVOIX
But: Tester la communication RS232

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
sbit LCD_D0_Direction at TRISB2_bit;
sbit LCD_D1_Direction at TRISB3_bit;
sbit LCD_D2_Direction at TRISB4_bit;
sbit LCD_D3_Direction at TRISB5_bit;
/*******Definiton des Programmes******/
void config(void);
void communication(void);
/*******Defintion des Variables*******/
#define LED4 PORTC.F2
#define BP1 PORTA.F1
#define BP2 PORTA.F2
/**************************PROGRAMME PRINCIPAL*********************************/
void main()
{
   config();
   communication();
}
void config()
{
   OSCCON=0x60;
   TRISA=0xFF;                       //0b11111111
   TRISB=0x13;                       //0b10000011
   TRISC=0x90;                       //0b10010000
   TRISE=0xFF;                       //0x11111111

   Lcd_Init();                       //Initialisation LCD
   Lcd_Cmd(_LCD_CLEAR);              //Reset afficheur LCD
   Lcd_Cmd(_LCD_CURSOR_OFF);         //Désactive le curseur
   
   UART1_Init(9600);
}
void communication()
{
  UART1_write('A');
  delay_ms(250);
}