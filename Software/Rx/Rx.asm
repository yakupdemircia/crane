
_hataTemizle:

;Rx.c,36 :: 		void hataTemizle()
;Rx.c,39 :: 		if (RCSTA.OERR) //Overrun Hatasý oluþtuysa
	BTFSS       RCSTA+0, 1 
	GOTO        L_hataTemizle0
;Rx.c,41 :: 		TXSTA.TXEN=0;
	BCF         TXSTA+0, 5 
;Rx.c,42 :: 		TXSTA.TXEN=1;
	BSF         TXSTA+0, 5 
;Rx.c,43 :: 		RCSTA.CREN=0;
	BCF         RCSTA+0, 4 
;Rx.c,44 :: 		RCSTA.CREN=1;
	BSF         RCSTA+0, 4 
;Rx.c,45 :: 		}
L_hataTemizle0:
;Rx.c,46 :: 		if (RCSTA.FERR) //Frame hatasý oluþtuysa
	BTFSS       RCSTA+0, 2 
	GOTO        L_hataTemizle1
;Rx.c,48 :: 		buff=RCREG;
	MOVF        RCREG+0, 0 
	MOVWF       _buff+0 
;Rx.c,49 :: 		TXSTA.TXEN=0;
	BCF         TXSTA+0, 5 
;Rx.c,50 :: 		TXSTA.TXEN=1;
	BSF         TXSTA+0, 5 
;Rx.c,51 :: 		}
L_hataTemizle1:
;Rx.c,52 :: 		}
	RETURN      0
; end of _hataTemizle

_rs232KarakterGonder:

;Rx.c,53 :: 		void rs232KarakterGonder()
;Rx.c,55 :: 		while(!PIR1.TXIF)
L_rs232KarakterGonder2:
	BTFSC       PIR1+0, 4 
	GOTO        L_rs232KarakterGonder3
;Rx.c,57 :: 		hataTemizle();
	CALL        _hataTemizle+0, 0
;Rx.c,58 :: 		}
	GOTO        L_rs232KarakterGonder2
L_rs232KarakterGonder3:
;Rx.c,59 :: 		TXREG = data1;
	MOVF        _data1+0, 0 
	MOVWF       TXREG+0 
;Rx.c,60 :: 		}
	RETURN      0
; end of _rs232KarakterGonder

_cikisIsle:

;Rx.c,61 :: 		void cikisIsle(unsigned char sy, unsigned char p)
;Rx.c,63 :: 		if(p == 0)
	MOVF        FARG_cikisIsle_p+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_cikisIsle4
;Rx.c,65 :: 		switch(sy)
	GOTO        L_cikisIsle5
;Rx.c,67 :: 		case 1:
L_cikisIsle7:
;Rx.c,69 :: 		geri;
	BSF         PORTA+0, 6 
;Rx.c,70 :: 		siren;
	BSF         PORTE+0, 1 
;Rx.c,71 :: 		break;
	GOTO        L_cikisIsle6
;Rx.c,73 :: 		case 2:
L_cikisIsle8:
;Rx.c,75 :: 		ileri;
	BSF         PORTC+0, 0 
;Rx.c,76 :: 		siren;
	BSF         PORTE+0, 1 
;Rx.c,77 :: 		break;
	GOTO        L_cikisIsle6
;Rx.c,79 :: 		case 4:
L_cikisIsle9:
;Rx.c,81 :: 		sol;
	BSF         PORTC+0, 3 
;Rx.c,82 :: 		siren;
	BSF         PORTE+0, 1 
;Rx.c,83 :: 		break;
	GOTO        L_cikisIsle6
;Rx.c,85 :: 		case 8:
L_cikisIsle10:
;Rx.c,87 :: 		sag;
	BSF         PORTD+0, 0 
;Rx.c,88 :: 		siren;
	BSF         PORTE+0, 1 
;Rx.c,89 :: 		break;
	GOTO        L_cikisIsle6
;Rx.c,91 :: 		case 16:
L_cikisIsle11:
;Rx.c,93 :: 		asagi;
	BSF         PORTD+0, 3 
;Rx.c,94 :: 		siren;
	BSF         PORTE+0, 1 
;Rx.c,95 :: 		break;
	GOTO        L_cikisIsle6
;Rx.c,97 :: 		case 32:
L_cikisIsle12:
;Rx.c,99 :: 		yukari;
	BSF         PORTC+0, 4 
;Rx.c,100 :: 		siren;
	BSF         PORTE+0, 1 
;Rx.c,101 :: 		break;
	GOTO        L_cikisIsle6
;Rx.c,103 :: 		default:
L_cikisIsle13:
;Rx.c,105 :: 		break;
	GOTO        L_cikisIsle6
;Rx.c,107 :: 		}
L_cikisIsle5:
	MOVF        FARG_cikisIsle_sy+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_cikisIsle7
	MOVF        FARG_cikisIsle_sy+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_cikisIsle8
	MOVF        FARG_cikisIsle_sy+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_cikisIsle9
	MOVF        FARG_cikisIsle_sy+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_cikisIsle10
	MOVF        FARG_cikisIsle_sy+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_cikisIsle11
	MOVF        FARG_cikisIsle_sy+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_cikisIsle12
	GOTO        L_cikisIsle13
L_cikisIsle6:
;Rx.c,108 :: 		}
	GOTO        L_cikisIsle14
L_cikisIsle4:
;Rx.c,111 :: 		switch(sy)
	GOTO        L_cikisIsle15
;Rx.c,113 :: 		case 1:
L_cikisIsle17:
;Rx.c,115 :: 		geri;
	BSF         PORTA+0, 6 
;Rx.c,116 :: 		geri2;
	BSF         PORTE+0, 2 
;Rx.c,117 :: 		siren;
	BSF         PORTE+0, 1 
;Rx.c,118 :: 		break;
	GOTO        L_cikisIsle16
;Rx.c,120 :: 		case 2:
L_cikisIsle18:
;Rx.c,122 :: 		ileri;
	BSF         PORTC+0, 0 
;Rx.c,123 :: 		ileri2;
	BSF         PORTA+0, 7 
;Rx.c,124 :: 		siren;
	BSF         PORTE+0, 1 
;Rx.c,125 :: 		break;
	GOTO        L_cikisIsle16
;Rx.c,127 :: 		case 4:
L_cikisIsle19:
;Rx.c,129 :: 		sol;
	BSF         PORTC+0, 3 
;Rx.c,130 :: 		sol2;
	BSF         PORTC+0, 1 
;Rx.c,131 :: 		siren;
	BSF         PORTE+0, 1 
;Rx.c,132 :: 		break;
	GOTO        L_cikisIsle16
;Rx.c,134 :: 		case 8:
L_cikisIsle20:
;Rx.c,136 :: 		sag;
	BSF         PORTD+0, 0 
;Rx.c,137 :: 		sag2;
	BSF         PORTC+0, 2 
;Rx.c,138 :: 		siren;
	BSF         PORTE+0, 1 
;Rx.c,139 :: 		break;
	GOTO        L_cikisIsle16
;Rx.c,141 :: 		case 16:
L_cikisIsle21:
;Rx.c,143 :: 		asagi;
	BSF         PORTD+0, 3 
;Rx.c,144 :: 		asagi2;
	BSF         PORTD+0, 1 
;Rx.c,145 :: 		siren;
	BSF         PORTE+0, 1 
;Rx.c,146 :: 		break;
	GOTO        L_cikisIsle16
;Rx.c,148 :: 		case 32:
L_cikisIsle22:
;Rx.c,150 :: 		yukari;
	BSF         PORTC+0, 4 
;Rx.c,151 :: 		yukari2;
	BSF         PORTD+0, 2 
;Rx.c,152 :: 		siren;
	BSF         PORTE+0, 1 
;Rx.c,153 :: 		break;
	GOTO        L_cikisIsle16
;Rx.c,155 :: 		default:
L_cikisIsle23:
;Rx.c,157 :: 		break;
	GOTO        L_cikisIsle16
;Rx.c,159 :: 		}
L_cikisIsle15:
	MOVF        FARG_cikisIsle_sy+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_cikisIsle17
	MOVF        FARG_cikisIsle_sy+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_cikisIsle18
	MOVF        FARG_cikisIsle_sy+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_cikisIsle19
	MOVF        FARG_cikisIsle_sy+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_cikisIsle20
	MOVF        FARG_cikisIsle_sy+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_cikisIsle21
	MOVF        FARG_cikisIsle_sy+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_cikisIsle22
	GOTO        L_cikisIsle23
L_cikisIsle16:
;Rx.c,160 :: 		}
L_cikisIsle14:
;Rx.c,161 :: 		}
	RETURN      0
; end of _cikisIsle

_cikisTemizle:

;Rx.c,162 :: 		void cikisTemizle()
;Rx.c,164 :: 		PORTA = 0;
	CLRF        PORTA+0 
;Rx.c,165 :: 		PORTB = 0;
	CLRF        PORTB+0 
;Rx.c,166 :: 		PORTC = 0;
	CLRF        PORTC+0 
;Rx.c,167 :: 		PORTD = 0;
	CLRF        PORTD+0 
;Rx.c,168 :: 		PORTE = 0;
	CLRF        PORTE+0 
;Rx.c,169 :: 		}
	RETURN      0
; end of _cikisTemizle

_cikisKontrol:

;Rx.c,170 :: 		void cikisKontrol()
;Rx.c,172 :: 		cikisTemizle();
	CALL        _cikisTemizle+0, 0
;Rx.c,174 :: 		if(((RXBUFF[5]&64)>0)&&(RXBUFF[5]<255))
	MOVLW       64
	ANDWF       _RXBUFF+5, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_cikisKontrol26
	MOVLW       255
	SUBWF       _RXBUFF+5, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_cikisKontrol26
L__cikisKontrol52:
;Rx.c,176 :: 		acil;
	BSF         PORTC+0, 5 
;Rx.c,177 :: 		siren;
	BSF         PORTE+0, 1 
;Rx.c,178 :: 		}
	GOTO        L_cikisKontrol27
L_cikisKontrol26:
;Rx.c,179 :: 		else if(RXBUFF[5]==255)
	MOVF        _RXBUFF+5, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_cikisKontrol28
;Rx.c,181 :: 		cikisTemizle();
	CALL        _cikisTemizle+0, 0
;Rx.c,182 :: 		}
	GOTO        L_cikisKontrol29
L_cikisKontrol28:
;Rx.c,185 :: 		for(dSay = 1; dSay<128; dSay = dSay*2)
	MOVLW       1
	MOVWF       _dSay+0 
L_cikisKontrol30:
	MOVLW       128
	SUBWF       _dSay+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_cikisKontrol31
;Rx.c,187 :: 		if((RXBUFF[5]&dSay)>0)
	MOVF        _dSay+0, 0 
	ANDWF       _RXBUFF+5, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_cikisKontrol33
;Rx.c,189 :: 		xdata=0;
	CLRF        _xdata+0 
;Rx.c,190 :: 		cikisIsle(dSay,xdata);
	MOVF        _dSay+0, 0 
	MOVWF       FARG_cikisIsle_sy+0 
	CLRF        FARG_cikisIsle_p+0 
	CALL        _cikisIsle+0, 0
;Rx.c,191 :: 		}
L_cikisKontrol33:
;Rx.c,185 :: 		for(dSay = 1; dSay<128; dSay = dSay*2)
	RLCF        _dSay+0, 1 
	BCF         _dSay+0, 0 
;Rx.c,192 :: 		}
	GOTO        L_cikisKontrol30
L_cikisKontrol31:
;Rx.c,193 :: 		for(dSay = 1; dSay<64; dSay = dSay*2)
	MOVLW       1
	MOVWF       _dSay+0 
L_cikisKontrol34:
	MOVLW       64
	SUBWF       _dSay+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_cikisKontrol35
;Rx.c,195 :: 		if((RXBUFF[6]&dSay)>0)
	MOVF        _dSay+0, 0 
	ANDWF       _RXBUFF+6, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_cikisKontrol37
;Rx.c,197 :: 		xdata=1;
	MOVLW       1
	MOVWF       _xdata+0 
;Rx.c,198 :: 		cikisIsle(dSay,xdata);
	MOVF        _dSay+0, 0 
	MOVWF       FARG_cikisIsle_sy+0 
	MOVLW       1
	MOVWF       FARG_cikisIsle_p+0 
	CALL        _cikisIsle+0, 0
;Rx.c,199 :: 		}
L_cikisKontrol37:
;Rx.c,193 :: 		for(dSay = 1; dSay<64; dSay = dSay*2)
	RLCF        _dSay+0, 1 
	BCF         _dSay+0, 0 
;Rx.c,200 :: 		}
	GOTO        L_cikisKontrol34
L_cikisKontrol35:
;Rx.c,201 :: 		}
L_cikisKontrol29:
L_cikisKontrol27:
;Rx.c,202 :: 		}
	RETURN      0
; end of _cikisKontrol

_interrupt:

;Rx.c,203 :: 		void interrupt()
;Rx.c,205 :: 		if(PIR1.RCIF)
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt38
;Rx.c,207 :: 		RXBUFF[paketSay] = RCREG;
	MOVLW       _RXBUFF+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_RXBUFF+0)
	MOVWF       FSR1H 
	MOVF        _paketSay+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        RCREG+0, 0 
	MOVWF       POSTINC1+0 
;Rx.c,208 :: 		if(RXBUFF[paketSay]==85)      //Senkronizasyon
	MOVLW       _RXBUFF+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_RXBUFF+0)
	MOVWF       FSR0H 
	MOVF        _paketSay+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       85
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt39
;Rx.c,210 :: 		if(paketSay>0)
	MOVF        _paketSay+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt40
;Rx.c,212 :: 		paketSay=0;
	CLRF        _paketSay+0 
;Rx.c,213 :: 		RXBUFF[0]=85;
	MOVLW       85
	MOVWF       _RXBUFF+0 
;Rx.c,214 :: 		}
L_interrupt40:
;Rx.c,215 :: 		}
L_interrupt39:
;Rx.c,216 :: 		paketSay++;
	INCF        _paketSay+0, 1 
;Rx.c,218 :: 		if(paketSay == 7)
	MOVF        _paketSay+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt41
;Rx.c,220 :: 		paketSay = 0;
	CLRF        _paketSay+0 
;Rx.c,221 :: 		if(RXBUFF[0] == 0x55 && RXBUFF[1] == ID1 && RXBUFF[2] == ID2 && RXBUFF[3] == ID3 && RXBUFF[4] == 0x11)
	MOVF        _RXBUFF+0, 0 
	XORLW       85
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt44
	MOVF        _RXBUFF+1, 0 
	XORWF       _ID1+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt44
	MOVF        _RXBUFF+2, 0 
	XORWF       _ID2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt44
	MOVF        _RXBUFF+3, 0 
	XORWF       _ID3+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt44
	MOVF        _RXBUFF+4, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt44
L__interrupt53:
;Rx.c,223 :: 		veriOk = 1;
	MOVLW       1
	MOVWF       _veriOk+0 
;Rx.c,224 :: 		tmrSay=0;
	CLRF        _tmrSay+0 
	CLRF        _tmrSay+1 
;Rx.c,225 :: 		cikisKontrol();
	CALL        _cikisKontrol+0, 0
;Rx.c,226 :: 		}
L_interrupt44:
;Rx.c,227 :: 		}
L_interrupt41:
;Rx.c,228 :: 		PIR1.RCIF = 0;
	BCF         PIR1+0, 5 
;Rx.c,229 :: 		}
L_interrupt38:
;Rx.c,231 :: 		}
L__interrupt54:
	RETFIE      1
; end of _interrupt

_Ayarlar:

;Rx.c,233 :: 		void Ayarlar()
;Rx.c,235 :: 		ANSEL=0;
	CLRF        ANSEL+0 
;Rx.c,236 :: 		ANSELH=0;
	CLRF        ANSELH+0 
;Rx.c,237 :: 		TRISC.B4=0; TRISD.B3=0; TRISD.B2=0; TRISD.B1=0; TRISD.B0=0; TRISC.B3=0; TRISC.B2=0; TRISC.B1=0; TRISC.B0=0; TRISA.B6=0;
	BCF         TRISC+0, 4 
	BCF         TRISD+0, 3 
	BCF         TRISD+0, 2 
	BCF         TRISD+0, 1 
	BCF         TRISD+0, 0 
	BCF         TRISC+0, 3 
	BCF         TRISC+0, 2 
	BCF         TRISC+0, 1 
	BCF         TRISC+0, 0 
	BCF         TRISA+0, 6 
;Rx.c,238 :: 		TRISA.B7=0; TRISE.B2=0; TRISC.B5=0; TRISE.B1=0; TRISD.B4=0; TRISD.B5=0;
	BCF         TRISA+0, 7 
	BCF         TRISE+0, 2 
	BCF         TRISC+0, 5 
	BCF         TRISE+0, 1 
	BCF         TRISD+0, 4 
	BCF         TRISD+0, 5 
;Rx.c,239 :: 		PORTA=0; PORTB=0; PORTC=0; PORTD=0; PORTE=0;
	CLRF        PORTA+0 
	CLRF        PORTB+0 
	CLRF        PORTC+0 
	CLRF        PORTD+0 
	CLRF        PORTE+0 
;Rx.c,241 :: 		INTCON.PEIE=1;  //Peripheral interrupt açýk
	BSF         INTCON+0, 6 
;Rx.c,242 :: 		PIE1.RCIE=1;   //Usart receive kesmesi açýk
	BSF         PIE1+0, 5 
;Rx.c,243 :: 		INTCON.GIE=1;  //Global kesmeler açýk
	BSF         INTCON+0, 7 
;Rx.c,244 :: 		RCON.IPEN=1;  //Ýnterrupt öncelikleri açýk
	BSF         RCON+0, 7 
;Rx.c,245 :: 		ADCON0.ADON=0; //ADC modülü tamamen kapatýldý
	BCF         ADCON0+0, 0 
;Rx.c,246 :: 		CM1CON0.C1ON=0;
	BCF         CM1CON0+0, 7 
;Rx.c,247 :: 		CM2CON0.C2ON=0; //Comparatorler kapatýldý
	BCF         CM2CON0+0, 7 
;Rx.c,248 :: 		T2CON = 0b011111100;              //bu biraz sýkýntýlý
	MOVLW       252
	MOVWF       T2CON+0 
;Rx.c,249 :: 		TMR2 = 0;
	CLRF        TMR2+0 
;Rx.c,250 :: 		PR2 = 0xFF; //tmr2 periyot
	MOVLW       255
	MOVWF       PR2+0 
;Rx.c,251 :: 		UART1_Init(9600);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Rx.c,253 :: 		Delay_ms(100);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_Ayarlar45:
	DECFSZ      R13, 1, 0
	BRA         L_Ayarlar45
	DECFSZ      R12, 1, 0
	BRA         L_Ayarlar45
	NOP
	NOP
;Rx.c,254 :: 		setA=0;
	BCF         PORTD+0, 4 
;Rx.c,255 :: 		setB=0;
	BCF         PORTD+0, 5 
;Rx.c,256 :: 		}
	RETURN      0
; end of _Ayarlar

_main:

;Rx.c,257 :: 		void main()
;Rx.c,259 :: 		Ayarlar();
	CALL        _Ayarlar+0, 0
;Rx.c,260 :: 		OSCCON=0b01010111;
	MOVLW       87
	MOVWF       OSCCON+0 
;Rx.c,261 :: 		OSCTUNE=0b10011111;
	MOVLW       159
	MOVWF       OSCTUNE+0 
;Rx.c,263 :: 		while(1)
L_main46:
;Rx.c,266 :: 		tmrSay++;
	INFSNZ      _tmrSay+0, 1 
	INCF        _tmrSay+1, 1 
;Rx.c,267 :: 		if(tmrSay == 20000)
	MOVF        _tmrSay+1, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L__main55
	MOVLW       32
	XORWF       _tmrSay+0, 0 
L__main55:
	BTFSS       STATUS+0, 2 
	GOTO        L_main48
;Rx.c,269 :: 		tmr2=0;
	CLRF        TMR2+0 
;Rx.c,270 :: 		tmrSay = 0;
	CLRF        _tmrSay+0 
	CLRF        _tmrSay+1 
;Rx.c,271 :: 		if(veriOk == 0)
	MOVF        _veriOk+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main49
;Rx.c,273 :: 		if(RXBUFF[5]!=64)
	MOVF        _RXBUFF+5, 0 
	XORLW       64
	BTFSC       STATUS+0, 2 
	GOTO        L_main50
;Rx.c,275 :: 		paketSay = 0; // dikkat sorun cikabilir
	CLRF        _paketSay+0 
;Rx.c,276 :: 		cikisTemizle();
	CALL        _cikisTemizle+0, 0
;Rx.c,277 :: 		}
L_main50:
;Rx.c,278 :: 		}
	GOTO        L_main51
L_main49:
;Rx.c,280 :: 		{veriOk = 0;}
	CLRF        _veriOk+0 
L_main51:
;Rx.c,281 :: 		}
L_main48:
;Rx.c,282 :: 		asm CLRWDT;
	CLRWDT
;Rx.c,283 :: 		}
	GOTO        L_main46
;Rx.c,284 :: 		}
	GOTO        $+0
; end of _main
