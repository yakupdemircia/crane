/* RANGE Rx V2.0
  PIC18F46K20, 16 MHz, WDT 1:64, BrownOut, int0, usart interrupt, opsiyonel lcd */

#define yukari  PORTC.B4=1
#define asagi   PORTD.B3=1
#define sag     PORTD.B0=1
#define sol     PORTC.B3=1
#define ileri   PORTC.B0=1
#define geri    PORTA.B6=1
#define yukari2 PORTD.B2=1
#define asagi2  PORTD.B1=1
#define sag2    PORTC.B2=1
#define sol2    PORTC.B1=1
#define ileri2  PORTA.B7=1
#define geri2   PORTE.B2=1
#define acil    PORTC.B5=1
#define siren   PORTE.B1=1
#define setA    PORTD.B4
#define setB    PORTD.B5
#define aux     PORTB.B0

unsigned char data1;
unsigned char buff;
unsigned char RXBUFF[7] = {'0','0','0','0','0','0','0'};
unsigned char paketSay = 0;
unsigned char ID1 = 117;
unsigned char ID2 = 45;
unsigned char ID3 = 46;
unsigned char ID4 = 45;
unsigned char veriOk = 0;
unsigned int tmrSay = 0;
unsigned char dSay = 0;
unsigned char xdata=0;


void hataTemizle()
{

    if (RCSTA.OERR) //Overrun Hatasý oluþtuysa
    {
            TXSTA.TXEN=0;
            TXSTA.TXEN=1;
            RCSTA.CREN=0;
            RCSTA.CREN=1;
    }
    if (RCSTA.FERR) //Frame hatasý oluþtuysa
    {
            buff=RCREG;
            TXSTA.TXEN=0;
            TXSTA.TXEN=1;
    }
}
void rs232KarakterGonder()
{
    while(!PIR1.TXIF)
    {
        hataTemizle();
    }
    TXREG = data1;
}
  void cikisIsle(unsigned char sy, unsigned char p)
  {
          if(p == 0)
          {
                  switch(sy)
                  {
                          case 1:
                          {
                                  geri;
                                  siren;
                                  break;
                          }
                          case 2:
                          {
                                  ileri;
                                  siren;
                                  break;
                          }
                          case 4:
                          {
                                  sol;
                                  siren;
                                  break;
                          }
                          case 8:
                          {
                                  sag;
                                  siren;
                                  break;
                          }
                          case 16:
                          {
                                  asagi;
                                  siren;
                                  break;
                          }
                          case 32:
                          {
                                  yukari;
                                  siren;
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
                                  geri;
                                  geri2;
                                  siren;
                                  break;
                          }
                          case 2:
                          {
                                  ileri;
                                  ileri2;
                                  siren;
                                  break;
                          }
                          case 4:
                          {
                                  sol;
                                  sol2;
                                  siren;
                                  break;
                          }
                          case 8:
                          {
                                  sag;
                                  sag2;
                                  siren;
                                  break;
                          }
                          case 16:
                          {
                                  asagi;
                                  asagi2;
                                  siren;
                                  break;
                          }
                          case 32:
                          {
                                  yukari;
                                  yukari2;
                                  siren;
                                  break;
                          }
                          default:
                          {
                                  break;
                          }
                  }
          }
  }
void cikisTemizle()
{
        PORTA = 0;
        PORTB = 0;
        PORTC = 0;
        PORTD = 0;
        PORTE = 0;
}
void cikisKontrol()
{
       cikisTemizle();

        if(((RXBUFF[5]&64)>0)&&(RXBUFF[5]<255))
        {
                acil;
                siren;
        }
        else if(RXBUFF[5]==255)
        {
        cikisTemizle();
        }
        else
        {
                for(dSay = 1; dSay<128; dSay = dSay*2)
                {
                        if((RXBUFF[5]&dSay)>0)
                        {
                                xdata=0;
                                cikisIsle(dSay,xdata);
                        }
                }
                for(dSay = 1; dSay<64; dSay = dSay*2)
                {
                        if((RXBUFF[6]&dSay)>0)
                        {
                                xdata=1;
                                cikisIsle(dSay,xdata);
                        }
                }
        }
}
void interrupt()
{
       if(PIR1.RCIF)
        {
                RXBUFF[paketSay] = RCREG;
                if(RXBUFF[paketSay]==85)      //Senkronizasyon
                {
                  if(paketSay>0)
                  {
                  paketSay=0;
                  RXBUFF[0]=85;
                  }
                }
                paketSay++; 

                if(paketSay == 7)
                {
                        paketSay = 0;
                        if(RXBUFF[0] == 0x55 && RXBUFF[1] == ID1 && RXBUFF[2] == ID2 && RXBUFF[3] == ID3 && RXBUFF[4] == 0x11)
                        {
                                veriOk = 1;
                                tmrSay=0;
                                cikisKontrol();
                        }
                }
                PIR1.RCIF = 0;
        }

}

void Ayarlar()
{ 
ANSEL=0;
ANSELH=0;
TRISC.B4=0; TRISD.B3=0; TRISD.B2=0; TRISD.B1=0; TRISD.B0=0; TRISC.B3=0; TRISC.B2=0; TRISC.B1=0; TRISC.B0=0; TRISA.B6=0;
TRISA.B7=0; TRISE.B2=0; TRISC.B5=0; TRISE.B1=0; TRISD.B4=0; TRISD.B5=0;
PORTA=0; PORTB=0; PORTC=0; PORTD=0; PORTE=0;

        INTCON.PEIE=1;  //Peripheral interrupt açýk
        PIE1.RCIE=1;   //Usart receive kesmesi açýk        
        INTCON.GIE=1;  //Global kesmeler açýk
        RCON.IPEN=1;  //Ýnterrupt öncelikleri açýk
        ADCON0.ADON=0; //ADC modülü tamamen kapatýldý
        CM1CON0.C1ON=0;
        CM2CON0.C2ON=0; //Comparatorler kapatýldý
        T2CON = 0b011111100;              //bu biraz sýkýntýlý
        TMR2 = 0;
        PR2 = 0xFF; //tmr2 periyot
        UART1_Init(9600);
        //Lcd_Init();
        Delay_ms(100);
        setA=0;
        setB=0;
}
void main() 
{
        Ayarlar();
         OSCCON=0b01010111;
         OSCTUNE=0b10011111;

       while(1)
        {

                        tmrSay++;
                        if(tmrSay == 20000)
                        {
                                tmr2=0;
                                tmrSay = 0;
                                if(veriOk == 0)
                                {       
                                   if(RXBUFF[5]!=64)
                                   {
                                        paketSay = 0; // dikkat sorun cikabilir
                                        cikisTemizle();
                                   }
                                }
                                else
                                {veriOk = 0;}
                        }
                asm CLRWDT;
        }
}