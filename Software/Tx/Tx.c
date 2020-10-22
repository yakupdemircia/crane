/*RANGE Tx Ver2.0 codes
Processor :PIC16F46K20 @ 4 MHz
RF Module:DRF1212D10
WDT 1:256,HLVD 2,10 V down,BROWNOUT RESET enabled
*/
#define up PORTC.B3
#define down PORTB.B3
#define right PORTC.B1
#define left PORTB.B4
#define fwd PORTA.B6
#define back PORTE.B1
#define emergency PORTD.B2
#define up2 PORTC.B2
#define down2 PORTB.B2
#define right2 PORTC.B0
#define left2 PORTE.B0
#define fwd2 PORTA.B7
#define back2 PORTE.B2
#define led_emergency PORTD.B1
#define led_on PORTD.B0
#define led_low_battery PORTD.B3
#define setA PORTD.B5
#define setB PORTD.B4
#define aux PORTB.B0

unsigned char buff;
unsigned char TARGETID1=117;
unsigned char TARGETID2=45;
unsigned char TARGETID3=46;
unsigned char TARGETID4=45;
unsigned char RXBUFF[7] = {1,1,1,1,1,1,1};
unsigned char countPackage = 0;
unsigned char d0 = 0, d1 = 0;
unsigned char lowBatteryCounter=0;
unsigned char emergencyCounter=0;
unsigned char ledCounter=0;
unsigned int delayCounter=0;
unsigned int sleepCounter1=0;
unsigned int sleepCounter2=0;
unsigned int stopCounter=0;

void interrupt(void)
{
     while(PIR2.HLVDIF)
     {
      lowBatteryCounter++;
      led_low_battery=1;
      delay_ms(100);
      led_on=0;
      led_emergency=0;


                           if(lowBatteryCounter==2)
                           { setA=1;
                             setB=1;               //stop hlvd module,rf module etc for power saving
                             HLVDCON.HLVDEN=0;
                             PIR2.HLVDIF=0;
                             PIE2.HLVDIE=0;       //do not enter interrupt untill battery refreshes
                           while(1)
                           {
                            led_low_battery=1;
                                           for(delayCounter=0;delayCounter<500;delayCounter++)
                                           {
                                            Delay_ms(1);
                                           }
                                           asm CLRWDT;
                            led_low_battery=0;
                                           for(delayCounter=0;delayCounter<500;delayCounter++)
                                           {
                                            Delay_ms(1);                                //low battery led will blink every 0.5 seconds
                                           }
                                           asm CLRWDT;
                            }
                            }
     }

}
void Ayarlar()
{
        ANSEL=0;
        ANSELH=0;  //all pins digital
        TRISA.B6=1; TRISA.B7=1; TRISB.B0=1; TRISB.B2=1; TRISB.B3=1, TRISB.B4=1; TRISC.B0=1; TRISC.B1=1; TRISC.B2=1; TRISC.B3=1; TRISD.B0=0;
        TRISD.B1=0; TRISD.B2=1; TRISD.B3=0; TRISD.B4=0; TRISD.B5=0; TRISE.B0=1; TRISE.B1=1; TRISE.B2=1;
        PORTA=0;
        PORTB=0;
        PORTC=0;
        PORTD=0;
        PORTE=0;
        HLVDCON=0b00010010; // HLVD Module active 2.0V
        INTCON.PEIE=1;
        INTCON.GIE=1;  //Global interrupts enabled
        PIE2.HLVDIE=1; //HLVD Interrupt enabled
        ADCON0.ADON=0; //ADC module disabled
        CM1CON0.C1ON=0;
        CM2CON0.C2ON=0; //Comparators disabled
        //T2CON = 0b011111100;
        //TMR2 = 0;
        //PR2 = 0xFF; //tmr2 periyot
        UART1_INIT(9600);
        Delay_ms(100); //uart module stabilization time
      /*TXSTA.BRGH = 1;
        TXSTA.SYNC = 0; //async communication
        RCSTA.SPEN = 1; //tx rx enable
        RCSTA.CREN = 1;
        RCSTA.SREN = 0;
        PIE1.TXIE = 0; //tx interrupt disabled
        PIE1.RCIE = 0; //rx interrupt enabled
        TXSTA.TX9 = 0;  //8 bit send
        RCSTA.RX9 = 0;  //8 bit receive
        TXSTA.TXEN = 0; //reset transmitter
        TXSTA.TXEN = 1; //enable transmitter*/
        led_on=1;
}

void hataTemizle()
{

    if (RCSTA.OERR)     //overrun error
    {
            TXSTA.TXEN=0;
            TXSTA.TXEN=1;
            RCSTA.CREN=0;
            RCSTA.CREN=1;
    }
    if (RCSTA.FERR)     //frame error
    {
            buff=RCREG;
            TXSTA.TXEN=0;
            TXSTA.TXEN=1;
    }
}

void butonIsle()
{

      if(emergency){
      if(emergencyCounter<20)
      {
      setA=0;
      setB=0;
      led_emergency=1;
      led_on=0;
      d0=64;   //emergency command
      d1=0;
      RXBUFF[5]= d0;
      RXBUFF[6]= d1;
       for(countPackage = 0; countPackage <7; countPackage++)
                                {
                                       while(!PIR1.TXIF)
                                       {
                                       hataTemizle();
                                       }
                                 TXREG=(RXBUFF[countPackage]);
                                 }
                                 countPackage=0;
                                 Delay_ms(10);
                                 emergencyCounter++;
      }
      if(emergencyCounter==20)                   //if emergency command sent for 20 times
      {
      sleepCounter2=0;
      setA=1;
      setB=1;                             //sleep rf module
      led_emergency=0;
      led_on=0;                         //turn off leds
      }
      }
         else{
                if(up==1||down==1||right==1||left==1||fwd==1||back==1||up2==1||down2==1||right2==1||left2==1||fwd2==1||back2==1)
                {
                           if(!((up==1&&down==1) || (up==1&&down2==1) || (up2==1&&down==1) || (up2==1&&down2==1) || (right==1&&left==1) || (right==1&&left2==1) || (right2==1&&left==1) || (right2==1&&left2==1) || (fwd==1&&back==1) || (fwd==1&&back2==1) || (fwd2==1&&back==1) || (fwd2==1&&back2==1)))
                            {
                                           led_emergency=0;
                                           emergencyCounter=0;
                                           stopCounter=0;
                                           ledCounter++;
                                           setA=0;
                                           setB=0;              //awake rf module
                                           sleepCounter1=0;
                                           sleepCounter2=0;        //reset sleep timers
                                           d0 = emergency*64 + up*32 + down*16 + right*8 + left*4 + fwd*2 + back;
                                           d1 = up2*32 + down2*16 + right2*8 + left2*4 + fwd2*2 + back2;
                                           RXBUFF[5]= d0;
                                           RXBUFF[6]= d1;
                                for(countPackage = 0; countPackage <7; countPackage++)
                                {
                                       while(!PIR1.TXIF)
                                       {
                                       hataTemizle();
                                       }
                                 TXREG=(RXBUFF[countPackage]);
                                 }
                                 countPackage=0;
                                 if(ledCounter<10){led_on=1;}
                                 else {led_on=0;}
                                 if(ledCounter==20){ledCounter=0;}
                                 Delay_ms(10);
                            }
                }
                else
                {
                 if(d0!=64)
                 {
                 led_emergency=0;
                 led_on=0;
                 RXBUFF[5]=255;
                 RXBUFF[6]=0;
                 if(stopCounter<30)
                 {
                  for(countPackage = 0; countPackage <7; countPackage++)
                                {
                                       while(!PIR1.TXIF)
                                       {
                                       hataTemizle();
                                       }
                                       TXREG=(RXBUFF[countPackage]);
                                 }
                                 countPackage=0;
                                 Delay_ms(10);
                                 stopCounter++;
                 }
                }
                }
                }

}
void main()
{
        OSCCON=0b01010111;                //4Mhz internal oscillator
        OSCTUNE=0b10011111;
        Ayarlar();
        RXBUFF[0] = 0x55;
        RXBUFF[1] = TARGETID1;
        RXBUFF[2] = TARGETID2;
        RXBUFF[3] = TARGETID3;
        RXBUFF[4] = 0x11;
        RXBUFF[5] = 0;
        RXBUFF[6] = 0;
        RXBUFF[7] = 85;
                  for(delayCounter=0;delayCounter<100;delayCounter++)
                  {
                  delay_ms(1);
                  asm CLRWDT;
                  }
                  delayCounter=0;
                  while(1)
                    {
                     butonIsle();
                     asm CLRWDT;
                     sleepCounter1++;
                                 if(sleepCounter1>2000)
                                 {
                                 sleepCounter1=0;
                                 sleepCounter2++;
                                              if(sleepCounter2>480)  //system will sleep after 2000*480=960.000 cycles (58 seconds)
                                              {
                                              setA=1;
                                              setB=1;
                                              led_on=0;
                                              delayCounter++;
                                              if(delayCounter<3)led_emergency=1;
                                              else led_emergency=0;
                                              if(delayCounter>50)delayCounter=0;
                                              delay_ms(10);
                                              asm CLRWDT;
                                              if(sleepCounter2==1000)sleepCounter2=481;
                                              }
                                 }
                    }
}
