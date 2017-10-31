

List FileKey 
----------------------------------------------------------------------
C1      C2      C3      C4    || C5
--------------------------------------------------------------
C1:  Address (decimal) of instruction in source file. 
C2:  Segment (code or data) and address (in code or data segment) 
       of inforation associated with current linte. Note that not all
       source lines will contain information in this field.  
C3:  Opcode bits (this field only appears for valid instructions.
C4:  Data field; lists data for labels and assorted directives. 
C5:  Raw line from source code.
----------------------------------------------------------------------


(0001)                            || ; **************************************************************************************
(0002)                            || ; Updated on 2-23-2016
(0003)                            || ; This program tests the SEI, CLI, RETIE, and RETID instructions and uses OUT, MOV, 
(0004)                            || ; ADD, SUB, AND, OR, CMP, BRN, and BRNE.
(0005)                            || ;
(0006)                            || ; How you initiate the inturrupt is up to the user.
(0007)                            || ; 
(0008)                            || ; LED7 is used to indicate of interrupts are enabled.  The program cycles between
(0009)                            || ; interrupts being enabled and not, with LED7 flashing on and off.  LED3 downto LED0 
(0010)                            || ; serve as a counter to count interrupts generated.
(0011)                            || ;
(0012)                            || ; Normal program operation is to watch LED7, generate interrupts when LED7 is
(0013)                            || ; illuminated, and see those interrupts counted in binary on the bottom four LEDs.  
(0014)                            || ; once the 16th interrupt (interrupt 0x10) is received, interrupts will be disabled
(0015)                            || ; for the rest of the program and LD6 will come on in addition to the count of 16 
(0016)                            || ; interrupts.
(0017)                            || ; **************************************************************************************
(0018)                            || 
(0019)                            || 
(0020)                            || .DSEG
(0021)                       000  || .ORG 0x00
(0022)                            || 
(0023)                       255  || .equ loop_count = 0xFF     ; extend the loop count
(0024)                       064  || .equ led_port   = 0x40
(0025)                            || 
(0026)                            || .CSEG
(0027)                       016  || .ORG 0x10
(0028)  CS-0x010  0x36100         || MOV R1,0x00   ;R1 is used to count interrupts and drive the LEDs
(0029)  CS-0x011  0x36200         || MOV R2,0x00   ;Set flag to allow interrupts to be enabled
(0030)                            || 
(0031)                            ||               ;illuminate LD7 when interrupts are on
(0032)  CS-0x012  0x302FF  0x012  || MAIN:         CMP  R2,0xFF
(0033)  CS-0x013  0x08222         ||               BREQ DONE
(0034)  CS-0x014  0x1A000         ||               SEI
(0035)  CS-0x015  0x22180         || 	          OR   R1, 0x80         ;illuminate LD7
(0036)  CS-0x016  0x34140         || 	          OUT  R1, led_port
(0037)  CS-0x017  0x36BFF         || 	          MOV  R11, loop_count  ;set outside for loop count
(0038)  CS-0x018  0x080F8         || 	          BRN  FOR
(0039)                            || 
(0040)                            ||               ;LD7 is off when interrutps are disabled
(0041)  CS-0x019  0x1A001  0x019  || BACK1:        CLI                   
(0042)  CS-0x01A  0x2017F         ||               AND  R1,0x7F          ;extinguish LD7
(0043)  CS-0x01B  0x34140         || 	          OUT  R1, led_port
(0044)  CS-0x01C  0x36BFF         || 	          MOV  R11, loop_count  ;set outside for loop count
(0045)  CS-0x01D  0x08180         ||               BRN FOR2
(0046)  CS-0x01E  0x08090         ||               BRN MAIN
(0047)                            || 
(0048)                     0x01F  || FOR:
(0049)  CS-0x01F  0x2CB01  0x01F  || outside_for1: SUB     R11, 0x01
(0050)  CS-0x020  0x36CFF         ||               MOV     R12, loop_count   ;set middle for loop count
(0051)  CS-0x021  0x2CC01  0x021  || middle_for1:  SUB     R12, 0x01
(0052)                            ||              
(0053)  CS-0x022  0x36DFF         ||               MOV     R13, loop_count   ;set inside for loop count
(0054)  CS-0x023  0x2CD01  0x023  || inside_for1:  SUB     R13, 0x01
(0055)                            ||               
(0056)  CS-0x024  0x37FFF         ||               MOV     R31,0xFF          ;empty instructions to slow things down
(0057)  CS-0x025  0x37FFF         || 	          MOV     R31,0xFF          ;when interrupts are enabled to allow
(0058)  CS-0x026  0x37FFF         ||               MOV     R31,0xFF          ;button presses
(0059)  CS-0x027  0x37FFF         ||               MOV     R31,0xFF
(0060)  CS-0x028  0x37FFF         ||               MOV     R31,0xFF
(0061)  CS-0x029  0x37FFF         ||               MOV     R31,0xFF
(0062)                            || 
(0063)  CS-0x02A  0x0811B         ||               BRNE    inside_for1
(0064)                            ||              
(0065)  CS-0x02B  0x22C00         ||               OR      R12, 0x00         ;load flags for middle for counter
(0066)  CS-0x02C  0x0810B         ||               BRNE    middle_for1
(0067)                            ||              
(0068)  CS-0x02D  0x22B00         ||               OR      R11, 0x00         ;load flags for outsde for counter value
(0069)  CS-0x02E  0x080FB         ||               BRNE    outside_for1
(0070)  CS-0x02F  0x080C8         || BRN BACK1
(0071)                            || 
(0072)                     0x030  || FOR2:
(0073)  CS-0x030  0x2CB01  0x030  || outside_for: SUB     R11, 0x01
(0074)  CS-0x031  0x36CFF         ||              MOV     R12, loop_count   ;set middle for loop count
(0075)  CS-0x032  0x2CC01  0x032  || middle_for:  SUB     R12, 0x01
(0076)                            ||              
(0077)  CS-0x033  0x36DFF         ||              MOV     R13, loop_count   ;set inside for loop count
(0078)  CS-0x034  0x2CD01  0x034  || inside_for:  SUB     R13, 0x01
(0079)  CS-0x035  0x081A3         ||              BRNE    inside_for
(0080)                            ||              
(0081)  CS-0x036  0x22C00         ||              OR      R12, 0x00         ;load flags for middle for counter
(0082)  CS-0x037  0x08193         ||              BRNE    middle_for
(0083)                            ||              
(0084)  CS-0x038  0x22B00         ||              OR      R11, 0x00         ;load flags for outsde for counter value
(0085)  CS-0x039  0x08183         ||              BRNE    outside_for
(0086)  CS-0x03A  0x08090         ||              BRN MAIN
(0087)                            || 
(0088)  CS-0x03B  0x28101  0x03B  || ISR:         ADD  R1,0x01              ;the botton 7 LEDs will should increment
(0089)  CS-0x03C  0x30190         ||              CMP  R1,0x90              ;Note that 0x80 + 0x10 = 0x90, which means interrupts 
(0090)                            ||                                        ;are enabled and the 16th interrupt was counted
(0091)                            ||                                        ;so it is time to quite interrupts.
(0092)                            ||                                      
(0093)  CS-0x03D  0x08202         ||              BREQ DISABLE_INTS
(0094)  CS-0x03E  0x34140         || 	         OUT  R1,led_port          ;everytime an interrupt is received.
(0095)  CS-0x03F  0x1A003         || 	         RETIE
(0096)                            || 
(0097)                     0x040  || DISABLE_INTS:
(0098)  CS-0x040  0x22140         ||              OR   R1,0x40              ;illuminate LD4 indicating interrupts disabled
(0099)  CS-0x041  0x34140         ||              OUT  R1,led_port
(0100)  CS-0x042  0x362FF         ||              MOV  R2,0xFF              ;set flag to disallow interrupts from being 
(0101)                            ||                                        ;enabled again in the main program
(0102)  CS-0x043  0x1A002         ||              RETID
(0103)                            || 
(0104)  CS-0x044  0x08220  0x044  || DONE:        BRN DONE                  ;ALL DONE, NO MORE INTERRUPTS!
(0105)                            || 
(0106)                            || .CSEG
(0107)                       1023  || .ORG 0x3FF
(0108)  CS-0x3FF  0x081D8  0x3FF  || VECTOR:      BRN ISR
(0109)                            || 





Symbol Table Key 
----------------------------------------------------------------------
C1             C2     C3      ||  C4+
-------------  ----   ----        -------
C1:  name of symbol
C2:  the value of symbol 
C3:  source code line number where symbol defined
C4+: source code line number of where symbol is referenced 
----------------------------------------------------------------------


-- Labels
------------------------------------------------------------ 
BACK1          0x019   (0041)  ||  0070 
DISABLE_INTS   0x040   (0097)  ||  0093 
DONE           0x044   (0104)  ||  0033 0104 
FOR            0x01F   (0048)  ||  0038 
FOR2           0x030   (0072)  ||  0045 
INSIDE_FOR     0x034   (0078)  ||  0079 
INSIDE_FOR1    0x023   (0054)  ||  0063 
ISR            0x03B   (0088)  ||  0108 
MAIN           0x012   (0032)  ||  0046 0086 
MIDDLE_FOR     0x032   (0075)  ||  0082 
MIDDLE_FOR1    0x021   (0051)  ||  0066 
OUTSIDE_FOR    0x030   (0073)  ||  0085 
OUTSIDE_FOR1   0x01F   (0049)  ||  0069 
VECTOR         0x3FF   (0108)  ||  


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
LED_PORT       0x040   (0024)  ||  0036 0043 0094 0099 
LOOP_COUNT     0x0FF   (0023)  ||  0037 0044 0050 0053 0074 0077 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
