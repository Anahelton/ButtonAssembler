
; PIC18F4550 Configuration Bit Settings
; Assembly source line config statements

#include "p18f4550.inc"


  CONFIG  FOSC = XT_XT ; Oscillator com Cristal de 4 MHz
  CONFIG  WDT = OFF    ; Watchdog Timer Enable bit (WDT enabled)
  CONFIG  LVP = OFF    ; Single-Supply ICSP Enable bit

VARIAVEIS UDATA_ACS 0
  CONTA1s   RES 1 ; Variavel auxiliar para contagem de 1 s
  AUX	RES 1 ; VARIAVEL 8 BITS
  ATRASO2 RES 1
  ATRASO500 RES 1	
	    
RES_VECT  CODE    0x0000 ; processor reset vector
  GOTO    START          ; go to beginning of program

MAIN_PROG CODE ; let linker place main program
 
START
    MOVLW b'11111111'; CONFIGURA TODOS AS PORTAS B COMO ENTRADA
    MOVWF TRISB
    MOVLW 0 ; CONFIGURA TODOS AS PORTAS D COMO SAIDA
    MOVWF TRISD
    GOTO LOOP
    
LOOP    
    BTFSC PORTB,7    ; VERIFICA SE SW1 = 1, ENTÃO EXECUTA INCREMENTO
    INCF AUX ; ROTINA DE INCREMENTO
    BTFSC PORTB,6    ; VERIFICA SE SW2 = 1, ENTÃO EXECUTA DECREMENTO
    DECF AUX ; ROTINA DE DECREMENTO
    CALL ATRASO_1s; ESPERA 500ms
    CALL ATRASO_1s; ESPERA +500ms
    MOVFF AUX,PORTD
    GOTO LOOP ; SE SW2 NAO ESTIVER PRESSIONADA VOLTA PARA O INICIO DO LOOP

ATRASO_1s 
    MOVLW .200
    MOVWF CONTA1s 
LOOP_500
    CALL ATRASO_2ms
    DECFSZ ATRASO500
    GOTO LOOP_500
    RETURN
ATRASO_2ms 
    MOVLW .200
    MOVWF CONTA1s 
LOOP2
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    DECFSZ CONTA1s
    GOTO LOOP2
    RETURN
;REPETE_500   ; Inicio d92o loop
    
    
 ;   DECFSZ CONTA1s
  ;  GOTO REPETE_500 ; Repete interações até que CONTA500 = 0
   ; RETURN

    
    END
    