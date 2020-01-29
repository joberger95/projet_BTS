#define LED1    PORTC.F0
void main()
{
    TRISC=0x00;
    while(1)
    {
    LATC=0x00;
    LED1=1;
    }
}