/*BERGER Jordan                                  VALAR2000
  Chef de Projet: M.COTTET Jean-Jacques
  Entreprise: Association Arrêt Demandé
  Projet BTS 2017/2018 Lycée M.GENEVOIX
 */
/*****Configuration de l'Afficheur****/
 
/*******Defintion des Variables*******/
 
 
/*******Definiton des Programmes******/
void config(void);
//void Recept_GSM(void);
/*********PROGRAMME PRINCIPAL*********/
void main()
{
        config();
}
while(1)
{
        UART1_Write('a');
        delay_ms(1000);
        //Recept_GSM();
}

/***********SOUS-PROGRAMMES***********/
//Configuration PIC et Communications
config()
{
        OSCCON=0x60;            //Mode 8Mhz
        TRISA=0xF9;                           //0b11111001
        TRISB=0x42;                    //0b01000010
        TRISC=0x9F;                    //0b10011111
        ADCONFIG=0x01;           //RA0 analogique        
        
        UART1_Init(9600);      //Init UART1
        UART2_Init(9600);      //Init UART2
        I2C_Init();              //Init i2c
        
        //UART2_Write("AT");       //Init GSM
        //UART2_Write("AT+CPIN=0000");  //Pin                        
}
/*
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