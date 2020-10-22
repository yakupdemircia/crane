
_interrupt:

;Tx.c,43 :: 		void interrupt(void)
;Tx.c,45 :: 		while(PIR2.HLVDIF)
L_interrupt0:
	BTFSS       PIR2+0, 2 
	GOTO        L_interrupt1
;Tx.c,47 :: 		pilZayifSayac++;
	INCF        _pilZayifSayac+0, 1 
;Tx.c,48 :: 		pil_zayif_led=1;
	BSF         PORTD+0, 3 
;Tx.c,49 :: 		delay_ms(100);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_interrupt2:
	DECFSZ      R13, 1, 0
	BRA         L_interrupt2
	DECFSZ      R12, 1, 0
	BRA         L_interrupt2
	NOP
	NOP
;Tx.c,50 :: 		acik_led=0;
	BCF         PORTD+0, 0 
;Tx.c,51 :: 		acil_led=0;
	BCF         PORTD+0, 1 
;Tx.c,54 :: 		if(pilZayifSayac==2)
	MOVF        _pilZayifSayac+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;Tx.c,55 :: 		{ setA=1;
	BSF         PORTD+0, 5 
;Tx.c,56 :: 		setB=1;               //guc tuketimi icin hlvd modülü, rf modul vs kapat
	BSF         PORTD+0, 4 
;Tx.c,57 :: 		HLVDCON.HLVDEN=0;
	BCF         HLVDCON+0, 4 
;Tx.c,58 :: 		PIR2.HLVDIF=0;
	BCF         PIR2+0, 2 
;Tx.c,59 :: 		PIE2.HLVDIE=0;       //pil eski haline gelene kadar tekrar kesmeye girme
	BCF         PIE2+0, 2 
;Tx.c,60 :: 		while(1)
L_interrupt4:
;Tx.c,62 :: 		pil_zayif_led=1;
	BSF         PORTD+0, 3 
;Tx.c,63 :: 		for(dlysayac=0;dlySayac<500;dlySayac++)
	CLRF        _dlySayac+0 
	CLRF        _dlySayac+1 
L_interrupt6:
	MOVLW       1
	SUBWF       _dlySayac+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt102
	MOVLW       244
	SUBWF       _dlySayac+0, 0 
L__interrupt102:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt7
;Tx.c,65 :: 		Delay_ms(1);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       75
	MOVWF       R13, 0
L_interrupt9:
	DECFSZ      R13, 1, 0
	BRA         L_interrupt9
	DECFSZ      R12, 1, 0
	BRA         L_interrupt9
;Tx.c,63 :: 		for(dlysayac=0;dlySayac<500;dlySayac++)
	INFSNZ      _dlySayac+0, 1 
	INCF        _dlySayac+1, 1 
;Tx.c,66 :: 		}
	GOTO        L_interrupt6
L_interrupt7:
;Tx.c,67 :: 		asm CLRWDT;
	CLRWDT
;Tx.c,68 :: 		pil_zayif_led=0;
	BCF         PORTD+0, 3 
;Tx.c,69 :: 		for(dlysayac=0;dlySayac<500;dlySayac++)
	CLRF        _dlySayac+0 
	CLRF        _dlySayac+1 
L_interrupt10:
	MOVLW       1
	SUBWF       _dlySayac+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt103
	MOVLW       244
	SUBWF       _dlySayac+0, 0 
L__interrupt103:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt11
;Tx.c,71 :: 		Delay_ms(1);                                //0,5 sn aralýklarla pil zayýf ledi yanýp sönecek
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       75
	MOVWF       R13, 0
L_interrupt13:
	DECFSZ      R13, 1, 0
	BRA         L_interrupt13
	DECFSZ      R12, 1, 0
	BRA         L_interrupt13
;Tx.c,69 :: 		for(dlysayac=0;dlySayac<500;dlySayac++)
	INFSNZ      _dlySayac+0, 1 
	INCF        _dlySayac+1, 1 
;Tx.c,72 :: 		}
	GOTO        L_interrupt10
L_interrupt11:
;Tx.c,73 :: 		asm CLRWDT;
	CLRWDT
;Tx.c,74 :: 		}
	GOTO        L_interrupt4
;Tx.c,75 :: 		}
L_interrupt3:
;Tx.c,76 :: 		}
	GOTO        L_interrupt0
L_interrupt1:
;Tx.c,78 :: 		}
L__interrupt101:
	RETFIE      1
; end of _interrupt

_Ayarlar:

;Tx.c,79 :: 		void Ayarlar()
;Tx.c,81 :: 		ANSEL=0;
	CLRF        ANSEL+0 
;Tx.c,82 :: 		ANSELH=0;  //Tüm pinler dijital
	CLRF        ANSELH+0 
;Tx.c,83 :: 		TRISA.B6=1; TRISA.B7=1; TRISB.B0=1; TRISB.B2=1; TRISB.B3=1, TRISB.B4=1; TRISC.B0=1; TRISC.B1=1; TRISC.B2=1; TRISC.B3=1; TRISD.B0=0;
	BSF         TRISA+0, 6 
	BSF         TRISA+0, 7 
	BSF         TRISB+0, 0 
	BSF         TRISB+0, 2 
	BSF         TRISB+0, 3 
	BSF         TRISB+0, 4 
	BSF         TRISC+0, 0 
	BSF         TRISC+0, 1 
	BSF         TRISC+0, 2 
	BSF         TRISC+0, 3 
	BCF         TRISD+0, 0 
;Tx.c,84 :: 		TRISD.B1=0; TRISD.B2=1; TRISD.B3=0; TRISD.B4=0; TRISD.B5=0; TRISE.B0=1; TRISE.B1=1; TRISE.B2=1;
	BCF         TRISD+0, 1 
	BSF         TRISD+0, 2 
	BCF         TRISD+0, 3 
	BCF         TRISD+0, 4 
	BCF         TRISD+0, 5 
	BSF         TRISE+0, 0 
	BSF         TRISE+0, 1 
	BSF         TRISE+0, 2 
;Tx.c,85 :: 		PORTA=0;
	CLRF        PORTA+0 
;Tx.c,86 :: 		PORTB=0;
	CLRF        PORTB+0 
;Tx.c,87 :: 		PORTC=0;
	CLRF        PORTC+0 
;Tx.c,88 :: 		PORTD=0;
	CLRF        PORTD+0 
;Tx.c,89 :: 		PORTE=0;
	CLRF        PORTE+0 
;Tx.c,90 :: 		HLVDCON=0b00010010; // HLVD Modülü aktif 2.0
	MOVLW       18
	MOVWF       HLVDCON+0 
;Tx.c,91 :: 		INTCON.PEIE=1;
	BSF         INTCON+0, 6 
;Tx.c,92 :: 		INTCON.GIE=1;  //Global kesmeler açýk
	BSF         INTCON+0, 7 
;Tx.c,93 :: 		PIE2.HLVDIE=1; //HLVD Kesmesi açýldý
	BSF         PIE2+0, 2 
;Tx.c,94 :: 		ADCON0.ADON=0; //ADC modülü tamamen kapatýldý
	BCF         ADCON0+0, 0 
;Tx.c,95 :: 		CM1CON0.C1ON=0;
	BCF         CM1CON0+0, 7 
;Tx.c,96 :: 		CM2CON0.C2ON=0; //Comparatorler kapatýldý
	BCF         CM2CON0+0, 7 
;Tx.c,100 :: 		UART1_INIT(9600);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Tx.c,101 :: 		Delay_ms(100); //usart modülü stabilizasyon zamaný
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_Ayarlar14:
	DECFSZ      R13, 1, 0
	BRA         L_Ayarlar14
	DECFSZ      R12, 1, 0
	BRA         L_Ayarlar14
	NOP
	NOP
;Tx.c,113 :: 		acik_led=1;
	BSF         PORTD+0, 0 
;Tx.c,114 :: 		}
	RETURN      0
; end of _Ayarlar

_hataTemizle:

;Tx.c,116 :: 		void hataTemizle()
;Tx.c,119 :: 		if (RCSTA.OERR)     //overrun hatasý varsa
	BTFSS       RCSTA+0, 1 
	GOTO        L_hataTemizle15
;Tx.c,121 :: 		TXSTA.TXEN=0;
	BCF         TXSTA+0, 5 
;Tx.c,122 :: 		TXSTA.TXEN=1;
	BSF         TXSTA+0, 5 
;Tx.c,123 :: 		RCSTA.CREN=0;
	BCF         RCSTA+0, 4 
;Tx.c,124 :: 		RCSTA.CREN=1;
	BSF         RCSTA+0, 4 
;Tx.c,125 :: 		}
L_hataTemizle15:
;Tx.c,126 :: 		if (RCSTA.FERR)     //frame hatasý varsa
	BTFSS       RCSTA+0, 2 
	GOTO        L_hataTemizle16
;Tx.c,128 :: 		buff=RCREG;
	MOVF        RCREG+0, 0 
	MOVWF       _buff+0 
;Tx.c,129 :: 		TXSTA.TXEN=0;
	BCF         TXSTA+0, 5 
;Tx.c,130 :: 		TXSTA.TXEN=1;
	BSF         TXSTA+0, 5 
;Tx.c,131 :: 		}
L_hataTemizle16:
;Tx.c,132 :: 		}
	RETURN      0
; end of _hataTemizle

_butonIsle:

;Tx.c,134 :: 		void butonIsle()
;Tx.c,137 :: 		if(acil){
	BTFSS       PORTD+0, 2 
	GOTO        L_butonIsle17
;Tx.c,138 :: 		if(acilSayac<20)
	MOVLW       20
	SUBWF       _acilSayac+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_butonIsle18
;Tx.c,140 :: 		setA=0;
	BCF         PORTD+0, 5 
;Tx.c,141 :: 		setB=0;
	BCF         PORTD+0, 4 
;Tx.c,142 :: 		acil_led=1;
	BSF         PORTD+0, 1 
;Tx.c,143 :: 		acik_led=0;
	BCF         PORTD+0, 0 
;Tx.c,144 :: 		d0=64;   //acil komutu
	MOVLW       64
	MOVWF       _d0+0 
;Tx.c,145 :: 		d1=0;
	CLRF        _d1+0 
;Tx.c,146 :: 		RXBUFF[5]= d0;
	MOVLW       64
	MOVWF       _RXBUFF+5 
;Tx.c,147 :: 		RXBUFF[6]= d1;
	CLRF        _RXBUFF+6 
;Tx.c,148 :: 		for(paketSay = 0; paketSay <7; paketSay++)
	CLRF        _paketSay+0 
L_butonIsle19:
	MOVLW       7
	SUBWF       _paketSay+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_butonIsle20
;Tx.c,150 :: 		while(!PIR1.TXIF)
L_butonIsle22:
	BTFSC       PIR1+0, 4 
	GOTO        L_butonIsle23
;Tx.c,152 :: 		hataTemizle();
	CALL        _hataTemizle+0, 0
;Tx.c,153 :: 		}
	GOTO        L_butonIsle22
L_butonIsle23:
;Tx.c,154 :: 		TXREG=(RXBUFF[paketSay]);
	MOVLW       _RXBUFF+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_RXBUFF+0)
	MOVWF       FSR0H 
	MOVF        _paketSay+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       TXREG+0 
;Tx.c,148 :: 		for(paketSay = 0; paketSay <7; paketSay++)
	INCF        _paketSay+0, 1 
;Tx.c,155 :: 		}
	GOTO        L_butonIsle19
L_butonIsle20:
;Tx.c,156 :: 		paketSay=0;
	CLRF        _paketSay+0 
;Tx.c,157 :: 		Delay_ms(10);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_butonIsle24:
	DECFSZ      R13, 1, 0
	BRA         L_butonIsle24
	DECFSZ      R12, 1, 0
	BRA         L_butonIsle24
	NOP
	NOP
;Tx.c,158 :: 		acilSayac++;
	INCF        _acilSayac+0, 1 
;Tx.c,159 :: 		}
L_butonIsle18:
;Tx.c,160 :: 		if(acilSayac==20)                   //20 kere acil komutu yollandýysa
	MOVF        _acilSayac+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_butonIsle25
;Tx.c,162 :: 		uykuSayac2=0;
	CLRF        _uykuSayac2+0 
	CLRF        _uykuSayac2+1 
;Tx.c,163 :: 		setA=1;
	BSF         PORTD+0, 5 
;Tx.c,164 :: 		setB=1;                             //modülü uyut
	BSF         PORTD+0, 4 
;Tx.c,165 :: 		acil_led=0;
	BCF         PORTD+0, 1 
;Tx.c,166 :: 		acik_led=0;                         //ledleri kapat
	BCF         PORTD+0, 0 
;Tx.c,167 :: 		}
L_butonIsle25:
;Tx.c,168 :: 		}
	GOTO        L_butonIsle26
L_butonIsle17:
;Tx.c,170 :: 		if(yukari==1||asagi==1||sag==1||sol==1||ileri==1||geri==1||yukari2==1||asagi2==1||sag2==1||sol2==1||ileri2==1||geri2==1)
	BTFSC       PORTC+0, 3 
	GOTO        L__butonIsle100
	BTFSC       PORTB+0, 3 
	GOTO        L__butonIsle100
	BTFSC       PORTC+0, 1 
	GOTO        L__butonIsle100
	BTFSC       PORTB+0, 4 
	GOTO        L__butonIsle100
	BTFSC       PORTA+0, 6 
	GOTO        L__butonIsle100
	BTFSC       PORTE+0, 1 
	GOTO        L__butonIsle100
	BTFSC       PORTC+0, 2 
	GOTO        L__butonIsle100
	BTFSC       PORTB+0, 2 
	GOTO        L__butonIsle100
	BTFSC       PORTC+0, 0 
	GOTO        L__butonIsle100
	BTFSC       PORTE+0, 0 
	GOTO        L__butonIsle100
	BTFSC       PORTA+0, 7 
	GOTO        L__butonIsle100
	BTFSC       PORTE+0, 2 
	GOTO        L__butonIsle100
	GOTO        L_butonIsle29
L__butonIsle100:
;Tx.c,172 :: 		if(!((yukari==1&&asagi==1) || (yukari==1&&asagi2==1) || (yukari2==1&&asagi==1) || (yukari2==1&&asagi2==1) || (sag==1&&sol==1) || (sag==1&&sol2==1) || (sag2==1&&sol==1) || (sag2==1&&sol2==1) || (ileri==1&&geri==1) || (ileri==1&&geri2==1) || (ileri2==1&&geri==1) || (ileri2==1&&geri2==1)))
	BTFSS       PORTC+0, 3 
	GOTO        L__butonIsle99
	BTFSS       PORTB+0, 3 
	GOTO        L__butonIsle99
	GOTO        L_butonIsle35
L__butonIsle99:
	BTFSS       PORTC+0, 3 
	GOTO        L__butonIsle98
	BTFSS       PORTB+0, 2 
	GOTO        L__butonIsle98
	GOTO        L_butonIsle35
L__butonIsle98:
	BTFSS       PORTC+0, 2 
	GOTO        L__butonIsle97
	BTFSS       PORTB+0, 3 
	GOTO        L__butonIsle97
	GOTO        L_butonIsle35
L__butonIsle97:
	BTFSS       PORTC+0, 2 
	GOTO        L__butonIsle96
	BTFSS       PORTB+0, 2 
	GOTO        L__butonIsle96
	GOTO        L_butonIsle35
L__butonIsle96:
	BTFSS       PORTC+0, 1 
	GOTO        L__butonIsle95
	BTFSS       PORTB+0, 4 
	GOTO        L__butonIsle95
	GOTO        L_butonIsle35
L__butonIsle95:
	BTFSS       PORTC+0, 1 
	GOTO        L__butonIsle94
	BTFSS       PORTE+0, 0 
	GOTO        L__butonIsle94
	GOTO        L_butonIsle35
L__butonIsle94:
	BTFSS       PORTC+0, 0 
	GOTO        L__butonIsle93
	BTFSS       PORTB+0, 4 
	GOTO        L__butonIsle93
	GOTO        L_butonIsle35
L__butonIsle93:
	BTFSS       PORTC+0, 0 
	GOTO        L__butonIsle92
	BTFSS       PORTE+0, 0 
	GOTO        L__butonIsle92
	GOTO        L_butonIsle35
L__butonIsle92:
	BTFSS       PORTA+0, 6 
	GOTO        L__butonIsle91
	BTFSS       PORTE+0, 1 
	GOTO        L__butonIsle91
	GOTO        L_butonIsle35
L__butonIsle91:
	BTFSS       PORTA+0, 6 
	GOTO        L__butonIsle90
	BTFSS       PORTE+0, 2 
	GOTO        L__butonIsle90
	GOTO        L_butonIsle35
L__butonIsle90:
	BTFSS       PORTA+0, 7 
	GOTO        L__butonIsle89
	BTFSS       PORTE+0, 1 
	GOTO        L__butonIsle89
	GOTO        L_butonIsle35
L__butonIsle89:
	BTFSS       PORTA+0, 7 
	GOTO        L__butonIsle88
	BTFSS       PORTE+0, 2 
	GOTO        L__butonIsle88
	GOTO        L_butonIsle35
L__butonIsle88:
	CLRF        R0 
	GOTO        L_butonIsle34
L_butonIsle35:
	MOVLW       1
	MOVWF       R0 
L_butonIsle34:
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_butonIsle56
;Tx.c,174 :: 		acil_led=0;
	BCF         PORTD+0, 1 
;Tx.c,175 :: 		acilSayac=0;
	CLRF        _acilSayac+0 
;Tx.c,176 :: 		durSayac=0;
	CLRF        _durSayac+0 
	CLRF        _durSayac+1 
;Tx.c,177 :: 		ledSayac++;
	INCF        _ledSayac+0, 1 
;Tx.c,178 :: 		setA=0;
	BCF         PORTD+0, 5 
;Tx.c,179 :: 		setB=0;              //modülü uyandýr
	BCF         PORTD+0, 4 
;Tx.c,180 :: 		uykuSayac1=0;
	CLRF        _uykuSayac1+0 
	CLRF        _uykuSayac1+1 
;Tx.c,181 :: 		uykuSayac2=0;        //uyku modu sayaçlarýný sýfýrla
	CLRF        _uykuSayac2+0 
	CLRF        _uykuSayac2+1 
;Tx.c,182 :: 		d0 = acil*64 + yukari*32 + asagi*16 + sag*8 + sol*4 + ileri*2 + geri;
	CLRF        R1 
	BTFSC       PORTD+0, 2 
	INCF        R1, 1 
	MOVLW       6
	MOVWF       R0 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVF        R0, 0 
L__butonIsle104:
	BZ          L__butonIsle105
	RLCF        R3, 1 
	BCF         R3, 0 
	ADDLW       255
	GOTO        L__butonIsle104
L__butonIsle105:
	CLRF        R2 
	BTFSC       PORTC+0, 3 
	INCF        R2, 1 
	MOVLW       5
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__butonIsle106:
	BZ          L__butonIsle107
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__butonIsle106
L__butonIsle107:
	MOVF        R0, 0 
	ADDWF       R3, 1 
	CLRF        R2 
	BTFSC       PORTB+0, 3 
	INCF        R2, 1 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDWF       R3, 1 
	CLRF        R2 
	BTFSC       PORTC+0, 1 
	INCF        R2, 1 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDWF       R3, 1 
	CLRF        R2 
	BTFSC       PORTB+0, 4 
	INCF        R2, 1 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDWF       R3, 1 
	CLRF        R2 
	BTFSC       PORTA+0, 6 
	INCF        R2, 1 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       R1 
	CLRF        R0 
	BTFSC       PORTE+0, 1 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       _d0+0 
;Tx.c,183 :: 		d1 = yukari2*32 + asagi2*16 + sag2*8 + sol2*4 + ileri2*2 + geri2;
	CLRF        R1 
	BTFSC       PORTC+0, 2 
	INCF        R1, 1 
	MOVLW       5
	MOVWF       R0 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVF        R0, 0 
L__butonIsle108:
	BZ          L__butonIsle109
	RLCF        R3, 1 
	BCF         R3, 0 
	ADDLW       255
	GOTO        L__butonIsle108
L__butonIsle109:
	CLRF        R2 
	BTFSC       PORTB+0, 2 
	INCF        R2, 1 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDWF       R3, 1 
	CLRF        R2 
	BTFSC       PORTC+0, 0 
	INCF        R2, 1 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDWF       R3, 1 
	CLRF        R2 
	BTFSC       PORTE+0, 0 
	INCF        R2, 1 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDWF       R3, 1 
	CLRF        R2 
	BTFSC       PORTA+0, 7 
	INCF        R2, 1 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       R1 
	CLRF        R0 
	BTFSC       PORTE+0, 2 
	INCF        R0, 1 
	MOVF        R1, 0 
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _d1+0 
;Tx.c,184 :: 		RXBUFF[5]= d0;
	MOVF        R4, 0 
	MOVWF       _RXBUFF+5 
;Tx.c,185 :: 		RXBUFF[6]= d1;
	MOVF        R0, 0 
	MOVWF       _RXBUFF+6 
;Tx.c,186 :: 		for(paketSay = 0; paketSay <7; paketSay++)
	CLRF        _paketSay+0 
L_butonIsle57:
	MOVLW       7
	SUBWF       _paketSay+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_butonIsle58
;Tx.c,188 :: 		while(!PIR1.TXIF)
L_butonIsle60:
	BTFSC       PIR1+0, 4 
	GOTO        L_butonIsle61
;Tx.c,190 :: 		hataTemizle();
	CALL        _hataTemizle+0, 0
;Tx.c,191 :: 		}
	GOTO        L_butonIsle60
L_butonIsle61:
;Tx.c,192 :: 		TXREG=(RXBUFF[paketSay]);
	MOVLW       _RXBUFF+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_RXBUFF+0)
	MOVWF       FSR0H 
	MOVF        _paketSay+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       TXREG+0 
;Tx.c,186 :: 		for(paketSay = 0; paketSay <7; paketSay++)
	INCF        _paketSay+0, 1 
;Tx.c,193 :: 		}
	GOTO        L_butonIsle57
L_butonIsle58:
;Tx.c,194 :: 		paketSay=0;
	CLRF        _paketSay+0 
;Tx.c,195 :: 		if(ledSayac<10){acik_led=1;}
	MOVLW       10
	SUBWF       _ledSayac+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_butonIsle62
	BSF         PORTD+0, 0 
	GOTO        L_butonIsle63
L_butonIsle62:
;Tx.c,196 :: 		else {acik_led=0;}
	BCF         PORTD+0, 0 
L_butonIsle63:
;Tx.c,197 :: 		if(ledSayac==20){ledSayac=0;}
	MOVF        _ledSayac+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_butonIsle64
	CLRF        _ledSayac+0 
L_butonIsle64:
;Tx.c,198 :: 		Delay_ms(10);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_butonIsle65:
	DECFSZ      R13, 1, 0
	BRA         L_butonIsle65
	DECFSZ      R12, 1, 0
	BRA         L_butonIsle65
	NOP
	NOP
;Tx.c,199 :: 		}
L_butonIsle56:
;Tx.c,200 :: 		}
	GOTO        L_butonIsle66
L_butonIsle29:
;Tx.c,203 :: 		if(d0!=64)
	MOVF        _d0+0, 0 
	XORLW       64
	BTFSC       STATUS+0, 2 
	GOTO        L_butonIsle67
;Tx.c,205 :: 		acil_led=0;
	BCF         PORTD+0, 1 
;Tx.c,206 :: 		acik_led=0;
	BCF         PORTD+0, 0 
;Tx.c,207 :: 		RXBUFF[5]=255;
	MOVLW       255
	MOVWF       _RXBUFF+5 
;Tx.c,208 :: 		RXBUFF[6]=0;
	CLRF        _RXBUFF+6 
;Tx.c,209 :: 		if(durSayac<30)
	MOVLW       0
	SUBWF       _durSayac+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__butonIsle110
	MOVLW       30
	SUBWF       _durSayac+0, 0 
L__butonIsle110:
	BTFSC       STATUS+0, 0 
	GOTO        L_butonIsle68
;Tx.c,211 :: 		for(paketSay = 0; paketSay <7; paketSay++)
	CLRF        _paketSay+0 
L_butonIsle69:
	MOVLW       7
	SUBWF       _paketSay+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_butonIsle70
;Tx.c,213 :: 		while(!PIR1.TXIF)
L_butonIsle72:
	BTFSC       PIR1+0, 4 
	GOTO        L_butonIsle73
;Tx.c,215 :: 		hataTemizle();
	CALL        _hataTemizle+0, 0
;Tx.c,216 :: 		}
	GOTO        L_butonIsle72
L_butonIsle73:
;Tx.c,217 :: 		TXREG=(RXBUFF[paketSay]);
	MOVLW       _RXBUFF+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_RXBUFF+0)
	MOVWF       FSR0H 
	MOVF        _paketSay+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       TXREG+0 
;Tx.c,211 :: 		for(paketSay = 0; paketSay <7; paketSay++)
	INCF        _paketSay+0, 1 
;Tx.c,218 :: 		}
	GOTO        L_butonIsle69
L_butonIsle70:
;Tx.c,219 :: 		paketSay=0;
	CLRF        _paketSay+0 
;Tx.c,220 :: 		Delay_ms(10);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_butonIsle74:
	DECFSZ      R13, 1, 0
	BRA         L_butonIsle74
	DECFSZ      R12, 1, 0
	BRA         L_butonIsle74
	NOP
	NOP
;Tx.c,221 :: 		durSayac++;
	INFSNZ      _durSayac+0, 1 
	INCF        _durSayac+1, 1 
;Tx.c,222 :: 		}
L_butonIsle68:
;Tx.c,223 :: 		}
L_butonIsle67:
;Tx.c,224 :: 		}
L_butonIsle66:
;Tx.c,225 :: 		}
L_butonIsle26:
;Tx.c,227 :: 		}
	RETURN      0
; end of _butonIsle

_main:

;Tx.c,228 :: 		void main()
;Tx.c,230 :: 		OSCCON=0b01010111;                //4Mhz dahili osilatör
	MOVLW       87
	MOVWF       OSCCON+0 
;Tx.c,231 :: 		OSCTUNE=0b10011111;
	MOVLW       159
	MOVWF       OSCTUNE+0 
;Tx.c,232 :: 		Ayarlar();
	CALL        _Ayarlar+0, 0
;Tx.c,233 :: 		RXBUFF[0] = 0x55;
	MOVLW       85
	MOVWF       _RXBUFF+0 
;Tx.c,234 :: 		RXBUFF[1] = HEDEFID1;
	MOVF        _HEDEFID1+0, 0 
	MOVWF       _RXBUFF+1 
;Tx.c,235 :: 		RXBUFF[2] = HEDEFID2;
	MOVF        _HEDEFID2+0, 0 
	MOVWF       _RXBUFF+2 
;Tx.c,236 :: 		RXBUFF[3] = HEDEFID3;
	MOVF        _HEDEFID3+0, 0 
	MOVWF       _RXBUFF+3 
;Tx.c,237 :: 		RXBUFF[4] = 0x11;
	MOVLW       17
	MOVWF       _RXBUFF+4 
;Tx.c,238 :: 		RXBUFF[5] = 0;
	CLRF        _RXBUFF+5 
;Tx.c,239 :: 		RXBUFF[6] = 0;
	CLRF        _RXBUFF+6 
;Tx.c,240 :: 		RXBUFF[7] = 85;
	MOVLW       85
	MOVWF       _RXBUFF+7 
;Tx.c,241 :: 		for(dlySayac=0;dlySayac<100;dlySayac++)
	CLRF        _dlySayac+0 
	CLRF        _dlySayac+1 
L_main75:
	MOVLW       0
	SUBWF       _dlySayac+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main111
	MOVLW       100
	SUBWF       _dlySayac+0, 0 
L__main111:
	BTFSC       STATUS+0, 0 
	GOTO        L_main76
;Tx.c,243 :: 		delay_ms(1);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       75
	MOVWF       R13, 0
L_main78:
	DECFSZ      R13, 1, 0
	BRA         L_main78
	DECFSZ      R12, 1, 0
	BRA         L_main78
;Tx.c,244 :: 		asm CLRWDT;
	CLRWDT
;Tx.c,241 :: 		for(dlySayac=0;dlySayac<100;dlySayac++)
	INFSNZ      _dlySayac+0, 1 
	INCF        _dlySayac+1, 1 
;Tx.c,245 :: 		}
	GOTO        L_main75
L_main76:
;Tx.c,246 :: 		dlySayac=0;
	CLRF        _dlySayac+0 
	CLRF        _dlySayac+1 
;Tx.c,247 :: 		while(1)
L_main79:
;Tx.c,249 :: 		butonIsle();
	CALL        _butonIsle+0, 0
;Tx.c,250 :: 		asm CLRWDT;
	CLRWDT
;Tx.c,251 :: 		uykuSayac1++;
	INFSNZ      _uykuSayac1+0, 1 
	INCF        _uykuSayac1+1, 1 
;Tx.c,252 :: 		if(uykuSayac1>2000)   //testler için 2000 yerine 200 yaptým. 6 saniyede uykuya girecek
	MOVF        _uykuSayac1+1, 0 
	SUBLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L__main112
	MOVF        _uykuSayac1+0, 0 
	SUBLW       208
L__main112:
	BTFSC       STATUS+0, 0 
	GOTO        L_main81
;Tx.c,254 :: 		uykuSayac1=0;
	CLRF        _uykuSayac1+0 
	CLRF        _uykuSayac1+1 
;Tx.c,255 :: 		uykuSayac2++;
	INFSNZ      _uykuSayac2+0, 1 
	INCF        _uykuSayac2+1, 1 
;Tx.c,256 :: 		if(uykuSayac2>480)  //2000*480=960.000 döngüden sonra uykuya girecek yaklaþýk 58 sn
	MOVF        _uykuSayac2+1, 0 
	SUBLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__main113
	MOVF        _uykuSayac2+0, 0 
	SUBLW       224
L__main113:
	BTFSC       STATUS+0, 0 
	GOTO        L_main82
;Tx.c,258 :: 		setA=1;
	BSF         PORTD+0, 5 
;Tx.c,259 :: 		setB=1;
	BSF         PORTD+0, 4 
;Tx.c,260 :: 		acik_led=0;
	BCF         PORTD+0, 0 
;Tx.c,261 :: 		dlySayac++;
	INFSNZ      _dlySayac+0, 1 
	INCF        _dlySayac+1, 1 
;Tx.c,262 :: 		if(dlySayac<3)acil_led=1;
	MOVLW       0
	SUBWF       _dlySayac+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main114
	MOVLW       3
	SUBWF       _dlySayac+0, 0 
L__main114:
	BTFSC       STATUS+0, 0 
	GOTO        L_main83
	BSF         PORTD+0, 1 
	GOTO        L_main84
L_main83:
;Tx.c,263 :: 		else acil_led=0;
	BCF         PORTD+0, 1 
L_main84:
;Tx.c,264 :: 		if(dlySayac>50)dlySayac=0;
	MOVLW       0
	MOVWF       R0 
	MOVF        _dlySayac+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main115
	MOVF        _dlySayac+0, 0 
	SUBLW       50
L__main115:
	BTFSC       STATUS+0, 0 
	GOTO        L_main85
	CLRF        _dlySayac+0 
	CLRF        _dlySayac+1 
L_main85:
;Tx.c,265 :: 		delay_ms(10);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main86:
	DECFSZ      R13, 1, 0
	BRA         L_main86
	DECFSZ      R12, 1, 0
	BRA         L_main86
	NOP
	NOP
;Tx.c,266 :: 		asm CLRWDT;
	CLRWDT
;Tx.c,267 :: 		if(uykusayac2==1000)uykuSayac2=481;
	MOVF        _uykuSayac2+1, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__main116
	MOVLW       232
	XORWF       _uykuSayac2+0, 0 
L__main116:
	BTFSS       STATUS+0, 2 
	GOTO        L_main87
	MOVLW       225
	MOVWF       _uykuSayac2+0 
	MOVLW       1
	MOVWF       _uykuSayac2+1 
L_main87:
;Tx.c,268 :: 		}
L_main82:
;Tx.c,269 :: 		}
L_main81:
;Tx.c,270 :: 		}
	GOTO        L_main79
;Tx.c,271 :: 		}
	GOTO        $+0
; end of _main
