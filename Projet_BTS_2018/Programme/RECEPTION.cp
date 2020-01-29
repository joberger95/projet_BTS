#line 1 "G:/Projet_BTS_2018/Programme/RECEPTION.c"
#line 30 "G:/Projet_BTS_2018/Programme/RECEPTION.c"
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
void reception(void);


char receive;
int i=0;

void main()
{
 config();

 while(1)
 {
 reception();
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

 UART2_Init(9600);

}
void reception()
{
if( PORTA.F1 ==0)
{UART2_Write_Text("A");
}

 if(UART2_Data_Ready()==1)
 {
 receive=UART2_Read();
 Lcd_Chr_Cp(receive);
 i++;
 }
 if(i==16)
 {i=0;
 LCD_CMD(_LCD_CLEAR);

 }

}
