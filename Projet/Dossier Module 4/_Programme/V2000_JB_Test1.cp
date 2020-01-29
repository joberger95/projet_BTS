#line 1 "C:/Users/Jordan/Documents/Projet_BTS_2018/Dossier Module 4/_Programme/V2000_JB_Test1.c"
#line 27 "C:/Users/Jordan/Documents/Projet_BTS_2018/Dossier Module 4/_Programme/V2000_JB_Test1.c"
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




void config(void);
void Recept_GSM(void);


void main()
{
 config();

while(1)
{
 UART1_Write('a');
 delay_ms(1000);

 PORTA.F2=1;
 delay_ms(500);

}
 }


void config()
{
 OSCCON=0x60;
 TRISA=0xFF;
 TRISB=0xC1;
 TRISC=0x19;


 UART1_Init(9600);
 UART2_Init(9600);
 I2C1_Init(400000);



}


void config_GSM()
{
UART2.write("AT");
UART2.write("AT+CPIN=0000");

UART2.write("AT+CSMP=17,167,0,4");

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
