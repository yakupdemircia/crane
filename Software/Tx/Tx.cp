#line 1 "D:/Dropbox/CizimlerTicari/Kodlar/Tx/Tx.c"
#line 27 "D:/Dropbox/CizimlerTicari/Kodlar/Tx/Tx.c"
unsigned char buff;
unsigned char HEDEFID1=117;
unsigned char HEDEFID2=45;
unsigned char HEDEFID3=46;
unsigned char HEDEFID4=45;
unsigned char RXBUFF[7] = {1,1,1,1,1,1,1};
unsigned char paketSay = 0;
unsigned char d0 = 0, d1 = 0;
unsigned char pilZayifSayac=0;
unsigned char acilSayac=0;
unsigned char ledSayac=0;
unsigned int dlySayac=0;
unsigned int uykuSayac1=0;
unsigned int uykuSayac2=0;
unsigned int durSayac=0;

void interrupt(void)
{
 while(PIR2.HLVDIF)
 {
 pilZayifSayac++;
  PORTD.B3 =1;
 delay_ms(100);
  PORTD.B0 =0;
  PORTD.B1 =0;


 if(pilZayifSayac==2)
 {  PORTD.B5 =1;
  PORTD.B4 =1;
 HLVDCON.HLVDEN=0;
 PIR2.HLVDIF=0;
 PIE2.HLVDIE=0;
 while(1)
 {
  PORTD.B3 =1;
 for(dlysayac=0;dlySayac<500;dlySayac++)
 {
 Delay_ms(1);
 }
 asm CLRWDT;
  PORTD.B3 =0;
 for(dlysayac=0;dlySayac<500;dlySayac++)
 {
 Delay_ms(1);
 }
 asm CLRWDT;
 }
 }
 }

}
void Ayarlar()
{
 ANSEL=0;
 ANSELH=0;
 TRISA.B6=1; TRISA.B7=1; TRISB.B0=1; TRISB.B2=1; TRISB.B3=1, TRISB.B4=1; TRISC.B0=1; TRISC.B1=1; TRISC.B2=1; TRISC.B3=1; TRISD.B0=0;
 TRISD.B1=0; TRISD.B2=1; TRISD.B3=0; TRISD.B4=0; TRISD.B5=0; TRISE.B0=1; TRISE.B1=1; TRISE.B2=1;
 PORTA=0;
 PORTB=0;
 PORTC=0;
 PORTD=0;
 PORTE=0;
 HLVDCON=0b00010010;
 INTCON.PEIE=1;
 INTCON.GIE=1;
 PIE2.HLVDIE=1;
 ADCON0.ADON=0;
 CM1CON0.C1ON=0;
 CM2CON0.C2ON=0;



 UART1_INIT(9600);
 Delay_ms(100);
#line 113 "D:/Dropbox/CizimlerTicari/Kodlar/Tx/Tx.c"
  PORTD.B0 =1;
}

void hataTemizle()
{

 if (RCSTA.OERR)
 {
 TXSTA.TXEN=0;
 TXSTA.TXEN=1;
 RCSTA.CREN=0;
 RCSTA.CREN=1;
 }
 if (RCSTA.FERR)
 {
 buff=RCREG;
 TXSTA.TXEN=0;
 TXSTA.TXEN=1;
 }
}

void butonIsle()
{

 if( PORTD.B2 ){
 if(acilSayac<20)
 {
  PORTD.B5 =0;
  PORTD.B4 =0;
  PORTD.B1 =1;
  PORTD.B0 =0;
 d0=64;
 d1=0;
 RXBUFF[5]= d0;
 RXBUFF[6]= d1;
 for(paketSay = 0; paketSay <7; paketSay++)
 {
 while(!PIR1.TXIF)
 {
 hataTemizle();
 }
 TXREG=(RXBUFF[paketSay]);
 }
 paketSay=0;
 Delay_ms(10);
 acilSayac++;
 }
 if(acilSayac==20)
 {
 uykuSayac2=0;
  PORTD.B5 =1;
  PORTD.B4 =1;
  PORTD.B1 =0;
  PORTD.B0 =0;
 }
 }
 else{
 if( PORTC.B3 ==1|| PORTB.B3 ==1|| PORTC.B1 ==1|| PORTB.B4 ==1|| PORTA.B6 ==1|| PORTE.B1 ==1|| PORTC.B2 ==1|| PORTB.B2 ==1|| PORTC.B0 ==1|| PORTE.B0 ==1|| PORTA.B7 ==1|| PORTE.B2 ==1)
 {
 if(!(( PORTC.B3 ==1&& PORTB.B3 ==1) || ( PORTC.B3 ==1&& PORTB.B2 ==1) || ( PORTC.B2 ==1&& PORTB.B3 ==1) || ( PORTC.B2 ==1&& PORTB.B2 ==1) || ( PORTC.B1 ==1&& PORTB.B4 ==1) || ( PORTC.B1 ==1&& PORTE.B0 ==1) || ( PORTC.B0 ==1&& PORTB.B4 ==1) || ( PORTC.B0 ==1&& PORTE.B0 ==1) || ( PORTA.B6 ==1&& PORTE.B1 ==1) || ( PORTA.B6 ==1&& PORTE.B2 ==1) || ( PORTA.B7 ==1&& PORTE.B1 ==1) || ( PORTA.B7 ==1&& PORTE.B2 ==1)))
 {
  PORTD.B1 =0;
 acilSayac=0;
 durSayac=0;
 ledSayac++;
  PORTD.B5 =0;
  PORTD.B4 =0;
 uykuSayac1=0;
 uykuSayac2=0;
 d0 =  PORTD.B2 *64 +  PORTC.B3 *32 +  PORTB.B3 *16 +  PORTC.B1 *8 +  PORTB.B4 *4 +  PORTA.B6 *2 +  PORTE.B1 ;
 d1 =  PORTC.B2 *32 +  PORTB.B2 *16 +  PORTC.B0 *8 +  PORTE.B0 *4 +  PORTA.B7 *2 +  PORTE.B2 ;
 RXBUFF[5]= d0;
 RXBUFF[6]= d1;
 for(paketSay = 0; paketSay <7; paketSay++)
 {
 while(!PIR1.TXIF)
 {
 hataTemizle();
 }
 TXREG=(RXBUFF[paketSay]);
 }
 paketSay=0;
 if(ledSayac<10){ PORTD.B0 =1;}
 else { PORTD.B0 =0;}
 if(ledSayac==20){ledSayac=0;}
 Delay_ms(10);
 }
 }
 else
 {
 if(d0!=64)
 {
  PORTD.B1 =0;
  PORTD.B0 =0;
 RXBUFF[5]=255;
 RXBUFF[6]=0;
 if(durSayac<30)
 {
 for(paketSay = 0; paketSay <7; paketSay++)
 {
 while(!PIR1.TXIF)
 {
 hataTemizle();
 }
 TXREG=(RXBUFF[paketSay]);
 }
 paketSay=0;
 Delay_ms(10);
 durSayac++;
 }
 }
 }
 }

}
void main()
{
 OSCCON=0b01010111;
 OSCTUNE=0b10011111;
 Ayarlar();
 RXBUFF[0] = 0x55;
 RXBUFF[1] = HEDEFID1;
 RXBUFF[2] = HEDEFID2;
 RXBUFF[3] = HEDEFID3;
 RXBUFF[4] = 0x11;
 RXBUFF[5] = 0;
 RXBUFF[6] = 0;
 RXBUFF[7] = 85;
 for(dlySayac=0;dlySayac<100;dlySayac++)
 {
 delay_ms(1);
 asm CLRWDT;
 }
 dlySayac=0;
 while(1)
 {
 butonIsle();
 asm CLRWDT;
 uykuSayac1++;
 if(uykuSayac1>2000)
 {
 uykuSayac1=0;
 uykuSayac2++;
 if(uykuSayac2>480)
 {
  PORTD.B5 =1;
  PORTD.B4 =1;
  PORTD.B0 =0;
 dlySayac++;
 if(dlySayac<3) PORTD.B1 =1;
 else  PORTD.B1 =0;
 if(dlySayac>50)dlySayac=0;
 delay_ms(10);
 asm CLRWDT;
 if(uykusayac2==1000)uykuSayac2=481;
 }
 }
 }
}
