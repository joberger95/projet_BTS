#line 1 "G:/Programme/Com_RS232.c"
#line 28 "G:/Programme/Com_RS232.c"
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
void communication(void);



void main()
{
 config();
 communication();
}
void config()
{
 TRISA=0xFF;
 TRISB=0x13;
 TRISC=0x90;
 TRISE=0xFF;

 UART1_Init(9600);
}
void communication()
{
 UART1_write('A');
 delay_ms(250);
}
