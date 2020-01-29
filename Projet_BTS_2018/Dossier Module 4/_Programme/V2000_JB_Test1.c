/*BERGER Jordan               VALAR2000
  Chef de Projet: M.COTTET Jean-Jacques
  Entreprise: Association Arret Demande
  Projet BTS 2017/2018 Lycee M.GENEVOIX

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

/*******Defintion des Variables*******/

/*******Definiton des Programmes******/
void config(void);
void config_GSM(void);
void envoi_SMS();
void Recept_GSM(void);
void Moteurs(void);
void Magn(void);
void Print(void);

/*********PROGRAMME PRINCIPAL*********/
void main()
{
        config();

while(1)
{
        UART1_Write('a');
        delay_ms(1000);
        //Recept_GSM();
        PORTA.F2=1;
        delay_ms(500);

}
 }
/***********SOUS-PROGRAMMES***********/
//Configuration PIC et Communications
void config()
{
        OSCCON=0x60;            //Mode 8Mhz
        TRISA=0xFF;             //0b11111111
        TRISB=0xC1;                    //0b11000001
        TRISC=0x19;                    //0b00011001
        //ADCONFIG=0x01;           //RA0 analogique
        
        UART1_Init(9600);      //Init UART1
        UART2_Init(9600);      //Init UART2
        I2C1_Init(400000);              //Init i2c
        
        //UART2_Write("AT");       //Init GSM
        //UART2_Write("AT+CPIN=0000");  //Pin                        
}

//Ebauche GSM
void config_GSM()
{
UART2.write("AT");
UART2.write("AT+CPIN=0000");
//config evoie sms
UART2.write("AT+CSMP=17,167,0,4");
//config recep sms        
}

void envoi_sms()
{
UART2.write("AT+CMGS=0648200953");
int receive=UART2.read();
    if(receive == >)UART2.write("contenu sms");
}

void Recept_GSM()
{
string receive;
       if(UART2_Data_Ready())
        {
         receive += UART2_Read("At+CMGR=1");
         LCD_Write(receive);
}

void Moteurs()
{


}

void Magn()
{

]

void Print()
{

}