

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
(0024)                       096  || .equ SSEG_CNTR_ID = 0x60
(0025)                       128  || .equ SSEG_VAL_ID  = 0x80
(0026)                            || 
(0027)                            || 
(0028)                            || 
(0029)                            || .CSEG
(0030)                       016  || .ORG 0x10
(0031)                            || 
(0032)                            || 
(0033)  CS-0x010  0x1A000         || SEI
(0034)  CS-0x011  0x36100         || MOV R1,0x00   ;R1 is used to count interrupts and drive the LEDs
(0035)                            || ;MOV R2,0x00   ;Set flag to allow interrupts to be enabled
(0036)  CS-0x012  0x36201         || MOV R2, 0x01
(0037)  CS-0x013  0x34260         || OUT R2, SSEG_CNTR_ID
(0038)  CS-0x014  0x34180         || OUT  R1, SSEG_VAL_ID
(0039)                            || 
(0040)                            || 
(0041)                            ||               ;illuminate LD7 when interrupts are on
(0042)                     0x015  || MAIN:        
(0043)                            || 	          ;OR   R1, 0x80         ;illuminate LD7
(0044)                            || 	          ;OUT  R1, SSEG_VAL_ID
(0045)  CS-0x015  0x36BFF         || 	          MOV  R11, loop_count  ;set outside for loop count
(0046)  CS-0x016  0x080D0         || 	          BRN  FOR
(0047)                            || 
(0048)                            ||               ;LD7 is off when interrutps are disabled
(0049)                     0x017  || BACK1:        
(0050)                            || 			  
(0051)  CS-0x017  0x36BFF         || 	          MOV  R11, loop_count  ;set outside for loop count
(0052)  CS-0x018  0x08158         ||               BRN FOR2
(0053)  CS-0x019  0x080A8         ||               BRN MAIN
(0054)                            || 
(0055)                     0x01A  || FOR:
(0056)  CS-0x01A  0x2CB01  0x01A  || outside_for1: SUB     R11, 0x01
(0057)  CS-0x01B  0x36CFF         ||               MOV     R12, loop_count   ;set middle for loop count
(0058)  CS-0x01C  0x2CC01  0x01C  || middle_for1:  SUB     R12, 0x01
(0059)                            ||              
(0060)  CS-0x01D  0x36DFF         ||               MOV     R13, loop_count   ;set inside for loop count
(0061)  CS-0x01E  0x2CD01  0x01E  || inside_for1:  SUB     R13, 0x01
(0062)                            ||               
(0063)  CS-0x01F  0x37FFF         ||               MOV     R31,0xFF          ;empty instructions to slow things down
(0064)  CS-0x020  0x37FFF         || 	          MOV     R31,0xFF          ;when interrupts are enabled to allow
(0065)  CS-0x021  0x37FFF         ||               MOV     R31,0xFF          ;button presses
(0066)  CS-0x022  0x37FFF         ||               MOV     R31,0xFF
(0067)  CS-0x023  0x37FFF         ||               MOV     R31,0xFF
(0068)  CS-0x024  0x37FFF         ||               MOV     R31,0xFF
(0069)                            || 
(0070)  CS-0x025  0x080F3         ||               BRNE    inside_for1
(0071)                            ||              
(0072)  CS-0x026  0x22C00         ||               OR      R12, 0x00         ;load flags for middle for counter
(0073)  CS-0x027  0x080E3         ||               BRNE    middle_for1
(0074)                            ||              
(0075)  CS-0x028  0x22B00         ||               OR      R11, 0x00         ;load flags for outsde for counter value
(0076)  CS-0x029  0x080D3         ||               BRNE    outside_for1
(0077)  CS-0x02A  0x080B8         || BRN BACK1
(0078)                            || 
(0079)                     0x02B  || FOR2:
(0080)  CS-0x02B  0x2CB01  0x02B  || outside_for: SUB     R11, 0x01
(0081)  CS-0x02C  0x36CFF         ||              MOV     R12, loop_count   ;set middle for loop count
(0082)  CS-0x02D  0x2CC01  0x02D  || middle_for:  SUB     R12, 0x01
(0083)                            ||              
(0084)  CS-0x02E  0x36DFF         ||              MOV     R13, loop_count   ;set inside for loop count
(0085)  CS-0x02F  0x2CD01  0x02F  || inside_for:  SUB     R13, 0x01
(0086)  CS-0x030  0x0817B         ||              BRNE    inside_for
(0087)                            ||              
(0088)  CS-0x031  0x22C00         ||              OR      R12, 0x00         ;load flags for middle for counter
(0089)  CS-0x032  0x0816B         ||              BRNE    middle_for
(0090)                            ||              
(0091)  CS-0x033  0x22B00         ||              OR      R11, 0x00         ;load flags for outsde for counter value
(0092)  CS-0x034  0x0815B         ||              BRNE    outside_for
(0093)  CS-0x035  0x080A8         ||              BRN MAIN
(0094)                            || 
(0095)  CS-0x036  0x28101  0x036  || ISR:         ADD  R1,0x01              ;the botton 7 LEDs will should increment
(0096)                            ||                                        ;Note that 0x80 + 0x10 = 0x90, which means interrupts 
(0097)                            ||                                        ;are enabled and the 16th interrupt was counted
(0098)                            ||                                        ;so it is time to quite interrupts.
(0099)                            ||                                      
(0100)                            ||              
(0101)  CS-0x037  0x34180         || 	         OUT  R1, SSEG_VAL_ID      ;everytime an interrupt is received.
(0102)  CS-0x038  0x1A003         || 	         RETIE
(0103)                            || 
(0104)                            || 
(0105)  CS-0x039  0x081C8  0x039  || DONE:        BRN DONE                  ;ALL DONE, NO MORE INTERRUPTS!
(0106)                            || 
(0107)                            || .CSEG
(0108)                       1023  || .ORG 0x3FF
(0109)  CS-0x3FF  0x081B0  0x3FF  || VECTOR:      BRN ISR
(0110)                            || 





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
BACK1          0x017   (0049)  ||  0077 
DONE           0x039   (0105)  ||  0105 
FOR            0x01A   (0055)  ||  0046 
FOR2           0x02B   (0079)  ||  0052 
INSIDE_FOR     0x02F   (0085)  ||  0086 
INSIDE_FOR1    0x01E   (0061)  ||  0070 
ISR            0x036   (0095)  ||  0109 
MAIN           0x015   (0042)  ||  0053 0093 
MIDDLE_FOR     0x02D   (0082)  ||  0089 
MIDDLE_FOR1    0x01C   (0058)  ||  0073 
OUTSIDE_FOR    0x02B   (0080)  ||  0092 
OUTSIDE_FOR1   0x01A   (0056)  ||  0076 
VECTOR         0x3FF   (0109)  ||  


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
LOOP_COUNT     0x0FF   (0023)  ||  0045 0051 0057 0060 0081 0084 
SSEG_CNTR_ID   0x060   (0024)  ||  0037 
SSEG_VAL_ID    0x080   (0025)  ||  0038 0101 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
