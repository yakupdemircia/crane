/* RANGE Rx V2.0
  PIC18F46K20, 16 MHz, WDT 1:64, BrownOut, int0, usart interrupt, optional lcd */

#define up  PORTC.B4=1
#define down   PORTD.B3=1
#define right     PORTD.B0=1
#define left     PORTC.B3=1
#define fwd   PORTC.B0=1
#define back    PORTA.B6=1
#define up2 PORTD.B2=1
#define down2  PORTD.B1=1
#define right2    PORTC.B2=1
#define left2    PORTC.B1=1
#define fwd2  PORTA.B7=1
#define back2   PORTE.B2=1
#define emergency    PORTC.B5=1
#define syren   PORTE.B1=1
#define setA    PORTD.B4
#define setB    PORTD.B5
#define aux     PORTB.B0

unsigned char data1;
unsigned char buff;
unsigned char RXBUFF[7] = {'0','0','0','0','0','0','0'};
unsigned char packageCounter = 0;
unsigned char ID1 = 117;
unsigned char ID2 = 45;
unsigned char ID3 = 46;
unsigned char ID4 = 45;
unsigned char dataOk = 0;
unsigned int tmrCounter = 0;
unsigned char dCount = 0;
unsigned char xdata=0;


void cleanErrors()
{

    if (RCSTA.OERR) //Overrun Error
    {
            TXSTA.TXEN=0;
            TXSTA.TXEN=1;
            RCSTA.CREN=0;
            RCSTA.CREN=1;
    }
    if (RCSTA.FERR) //Frame Error
    {
            buff=RCREG;
            TXSTA.TXEN=0;
            TXSTA.TXEN=1;
    }
}
void sendRs232Character()
{
    while(!PIR1.TXIF)
    {
        cleanErrors();
    }
    TXREG = data1;
}
  void processOutput(unsigned char sy, unsigned char p)
  {
          if(p == 0)
          {
                  switch(sy)
                  {
                          case 1:
                          {
                                  back;
                                  syren;
                                  break;
                          }
                          case 2:
                          {
                                  fwd;
                                  syren;
                                  break;
                          }
                          case 4:
                          {
                                  left;
                                  syren;
                                  break;
                          }
                          case 8:
                          {
                                  right;
                                  syren;
                                  break;
                          }
                          case 16:
                          {
                                  down;
                                  syren;
                                  break;
                          }
                          case 32:
                          {
                                  up;
                                  syren;
                                  break;
                          }
                          default:
                          {
                                  break;
                          }
                  }
          }
          else
          {
                  switch(sy)
                  {
                          case 1:
                          {
                                  back;
                                  back2;
                                  syren;
                                  break;
                          }
                          case 2:
                          {
                                  fwd;
                                  fwd2;
                                  syren;
                                  break;
                          }
                          case 4:
                          {
                                  left;
                                  left2;
                                  syren;
                                  break;
                          }
                          case 8:
                          {
                                  right;
                                  right2;
                                  syren;
                                  break;
                          }
                          case 16:
                          {
                                  down;
                                  down2;
                                  syren;
                                  break;
                          }
                          case 32:
                          {
                                  up;
                                  up2;
                                  syren;
                                  break;
                          }
                          default:
                          {
                                  break;
                          }
                  }
          }
  }
void cleanOutput()
{
        PORTA = 0;
        PORTB = 0;
        PORTC = 0;
        PORTD = 0;
        PORTE = 0;
}
void outputControl()
{
       cleanOutput();

        if(((RXBUFF[5]&64)>0)&&(RXBUFF[5]<255))
        {
                emergency;
                syren;
        }
        else if(RXBUFF[5]==255)
        {
        cleanOutput();
        }
        else
        {
                for(dCount = 1; dCount<128; dCount = dCount*2)
                {
                        if((RXBUFF[5]&dCount)>0)
                        {
                                xdata=0;
                                processOutput(dCount,xdata);
                        }
                }
                for(dCount = 1; dCount<64; dCount = dCount*2)
                {
                        if((RXBUFF[6]&dCount)>0)
                        {
                                xdata=1;
                                processOutput(dCount,xdata);
                        }
                }
        }
}
void interrupt()
{
       if(PIR1.RCIF)
        {
                RXBUFF[packageCounter] = RCREG;
                if(RXBUFF[packageCounter]==85)      //Sync
                {
                  if(packageCounter>0)
                  {
                  packageCounter=0;
                  RXBUFF[0]=85;
                  }
                }
                packageCounter++; 

                if(packageCounter == 7)
                {
                        packageCounter = 0;
                        if(RXBUFF[0] == 0x55 && RXBUFF[1] == ID1 && RXBUFF[2] == ID2 && RXBUFF[3] == ID3 && RXBUFF[4] == 0x11)
                        {
                                dataOk = 1;
                                tmrCounter=0;
                                outputControl();
                        }
                }
                PIR1.RCIF = 0;
        }

}

void Settings()
{ 
ANSEL=0;
ANSELH=0;
TRISC.B4=0; TRISD.B3=0; TRISD.B2=0; TRISD.B1=0; TRISD.B0=0; TRISC.B3=0; TRISC.B2=0; TRISC.B1=0; TRISC.B0=0; TRISA.B6=0;
TRISA.B7=0; TRISE.B2=0; TRISC.B5=0; TRISE.B1=0; TRISD.B4=0; TRISD.B5=0;
PORTA=0; PORTB=0; PORTC=0; PORTD=0; PORTE=0;

        INTCON.PEIE=1;  //Peripheral interrupt enabled
        PIE1.RCIE=1;   //Usart receive interrupt enabled     
        INTCON.GIE=1;  //Global interrupts enabled
        RCON.IPEN=1;  //Interrupt priorities enabled
        ADCON0.ADON=0; //ADC module disabled
        CM1CON0.C1ON=0;
        CM2CON0.C2ON=0; //Comparators disabled
        T2CON = 0b011111100;   
        TMR2 = 0;
        PR2 = 0xFF; //tmr2 period
        UART1_Init(9600);
        //Lcd_Init();
        Delay_ms(100);
        setA=0;
        setB=0;
}
void main() 
{
        Settings();
         OSCCON=0b01010111;
         OSCTUNE=0b10011111;

       while(1)
        {

                        tmrCounter++;
                        if(tmrCounter == 20000)
                        {
                                tmr2=0;
                                tmrCounter = 0;
                                if(dataOk == 0)
                                {       
                                   if(RXBUFF[5]!=64)
                                   {
                                        packageCounter = 0;
                                        cleanOutput();
                                   }
                                }
                                else
                                {dataOk = 0;}
                        }
                asm CLRWDT;
        }
}
