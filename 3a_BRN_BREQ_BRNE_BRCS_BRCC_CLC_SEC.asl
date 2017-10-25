

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


(0001)                            || ;- Programmers: Abesh Mubaraki and Vince Jison
(0002)                            || ;- Date: 26 Feb 2011
(0003)                            || ;- Version: 1a
(0004)                            || ;--------------------------------------------------------------------
(0005)                            || ;-######## Case #3 - BRN, BREQ, BRNE, BRCS, BRCC, CLC, SEC ########-;
(0006)                            || ;--------------------------------------------------------------------
(0007)                            || ;-
(0008)                            || ;- Version 1a update: TABs were removed and replaced with spaces
(0009)                            || ;- 
(0010)                            || ;- 
(0011)                            || ;- This test case switches on the LEDs on the Nexys2 from right to 
(0012)                            || ;- left (LD0 to LD7) for each successful test.
(0013)                            || ;- There is about half a second delay in between each test.
(0014)                            || ;- The correspondence between the test and LEDs is as follows:
(0015)                            || ;- 	BRN	LD0
(0016)                            || ;- 	BREQ	LD1
(0017)                            || ;- 	BRNE	LD2
(0018)                            || ;- 	BRCS	LD3
(0019)                            || ;- 	BRCC	LD4
(0020)                            || ;- 	CLC	LD5
(0021)                            || ;- 	SEC	LD6 and LD7
(0022)                            || ;- 
(0023)                            || ;- Some other operations that are used in this test case are
(0024)                            || ;- 	ADD	CALL	EXOR	LSR	MOV	OUT	OR
(0025)                            || ;- 	RET	SUB
(0026)                            || ;- 
(0027)                            || ;- LEDs must turn on from 0 to 7 to indicate a successful test.
(0028)                            || ;- 
(0029)                            || ;--------------------------------------------------------------------
(0030)                            || 
(0031)                            || ;--------------------------------------------------------------------
(0032)                            || ;- Port Constants
(0033)                            || ;--------------------------------------------------------------------
(0034)                       032  || .EQU SWITCH_PORT = 0x20       ; port for switches ----- INPUT
(0035)                       064  || .EQU LED_PORT    = 0x40         ; port for LED output --- OUTOUT
(0036)                       255  || .EQU BTN_PORT    = 0xFF         ; port for button input - INPUT
(0037)                            || ;--------------------------------------------------------------------
(0038)                            || 
(0039)                            || ;--------------------------------------------------------------------
(0040)                            || ;- Misc Constants
(0041)                            || ;--------------------------------------------------------------------
(0042)                            || 
(0043)                       001  || .EQU B0_MASK = 0x01             ; mask all but bit0
(0044)                       002  || .EQU B1_MASK = 0x02             ; mask all but bit1
(0045)                       004  || .EQU B2_MASK = 0x04             ; mask all but bit2
(0046)                       008  || .EQU B3_MASK = 0x08             ; mask all but bit3
(0047)                       016  || .EQU B4_MASK = 0x10             ; mask all but bit4
(0048)                       032  || .EQU B5_MASK = 0x20             ; mask all but bit5
(0049)                       064  || .EQU B6_MASK = 0x40             ; mask all but bit6
(0050)                       128  || .EQU B7_MASK = 0x80             ; mask all but bit7
(0051)                            ||  
(0052)                       001  || .EQU INSIDE_FOR_COUNT  = 1;0xFF   ; These three contestants set the 
(0053)                       001  || .EQU MIDDLE_FOR_COUNT  = 1;0xFF   ; amount of delay between each test.
(0054)                       001  || .EQU OUTSIDE_FOR_COUNT = 1;0x60   ; Current time delay is about 503 mS.
(0055)                            || ;- 	Setting the last constant to FF will give a 1.3 sec delay.
(0056)                            || 
(0057)                            || ;--------------------------------------------------------------------    
(0058)                            || 
(0059)                            || ;--------------------------------------------------------------------
(0060)                            || 
(0061)                            || .DSEG
(0062)                       000  || .ORG   0x00
(0063)                            || 
(0064)                            || ;--------------------------------------------------------------------
(0065)                            || 
(0066)                            || ;--------------------------------------------------------------------
(0067)                            || 
(0068)                            || .CSEG
(0069)                       064  || .ORG   0x40
(0070)                            || 
(0071)                            || 
(0072)  CS-0x040  0x36A00  0x040  || Main:         MOV R10, 0x00             ; R10 used to outputs to LEDs
(0073)  CS-0x041  0x36B00         ||               MOV R11, 0x00             ; 
(0074)  CS-0x042  0x08650         ||               BRN 0xCA                  ; 
(0075)  CS-0x043  0x28B00  0x043  || Zero_Down:    ADD R11, 0x00             ; Zero flag set
(0076)  CS-0x044  0x082F2         ||               BREQ Check_One            ; 
(0077)  CS-0x045  0x28B01  0x045  || One_Down:     ADD R11, 0x01             ; Zero flag cleared
(0078)  CS-0x046  0x08313         ||               BRNE Check_Two            ; 
(0079)  CS-0x047  0x28BFF  0x047  || Two_Down:     ADD R11, 0xFF             ; Carry flag set
(0080)  CS-0x048  0x0A330         ||               BRCS Check_Three          ; 
(0081)  CS-0x049  0x36B00  0x049  || Three_Down:   MOV R11, 0x00             ; 
(0082)  CS-0x04A  0x28B01         ||               ADD R11, 0x01             ; Carry flag cleared
(0083)  CS-0x04B  0x0A351         ||               BRCC Check_Four           ;
(0084)  CS-0x04C  0x28BFF  0x04C  || Four_Down:    ADD R11, 0xFF             ; Carry flag set & R1 = 0x00
(0085)  CS-0x04D  0x18000         ||               CLC                       ; Carry flag cleared
(0086)  CS-0x04E  0x10B01         ||               LSR R11                   ; Moving the C value in
(0087)  CS-0x04F  0x10B01         ||               LSR R11                   ; 	proper location to
(0088)  CS-0x050  0x10B01         ||               LSR R11                   ; 	test it.
(0089)  CS-0x051  0x24B20         ||               EXOR R11, B5_MASK         ; 
(0090)  CS-0x052  0x00A5A         ||               EXOR R10, R11             ; Entering the test result 
(0091)  CS-0x053  0x34A40         ||               OUT R10, LED_PORT         ; 	to R10
(0092)  CS-0x054  0x08371         ||               CALL Pause                ; 
(0093)  CS-0x055  0x36B00  0x055  || Five_down:    MOV R11, 0x00             ;		
(0094)  CS-0x056  0x18001         ||               SEC                       ;
(0095)  CS-0x057  0x10B01         ||               LSR R11                   ; 
(0096)  CS-0x058  0x00A5A         ||               EXOR R10, R11             ; 
(0097)  CS-0x059  0x10B01         ||               LSR R11                   ; 
(0098)  CS-0x05A  0x00A5A         ||               EXOR R10, R11             ; 
(0099)  CS-0x05B  0x34A40         ||               OUT R10, LED_PORT         ; 
(0100)  CS-0x05C  0x08371         ||               CALL Pause                ; 
(0101)  CS-0x05D  0x082E8  0x05D  || Six_down:     Brn Six_down                 ; 
(0102)                            ||                                         ; 
(0103)                            ||                                         ;<-Code dies when it crosses 
(0104)                            ||                                         ;	this border 
(0105)                            ||                                         ; 
(0106)                            ||                                         ; Step aside Janet Napolitano 
(0107)                            || ;--------------------------------------------------------------------
(0108)                            || 
(0109)  CS-0x05E  0x22A02  0x05E  || Check_One:    OR R10, B1_MASK
(0110)  CS-0x05F  0x34A40         ||               OUT R10, LED_PORT
(0111)  CS-0x060  0x08371         ||               CALL Pause
(0112)  CS-0x061  0x08228         ||               BRN One_Down		
(0113)                            ||                 
(0114)  CS-0x062  0x22A04  0x062  || Check_Two:    OR R10, B2_MASK
(0115)  CS-0x063  0x34A40         ||               OUT R10, LED_PORT 
(0116)  CS-0x064  0x08371         ||               CALL Pause
(0117)  CS-0x065  0x08238         ||               BRN Two_Down
(0118)                            ||               
(0119)  CS-0x066  0x22A08  0x066  || Check_Three:  OR R10, B3_MASK
(0120)  CS-0x067  0x34A40         ||               OUT R10, LED_PORT
(0121)  CS-0x068  0x08371         ||               CALL Pause
(0122)  CS-0x069  0x08248         ||               BRN Three_Down
(0123)                            || 
(0124)  CS-0x06A  0x22A10  0x06A  || Check_Four:   OR R10, B4_MASK
(0125)  CS-0x06B  0x34A40         ||               OUT R10, LED_PORT
(0126)  CS-0x06C  0x08371         ||               CALL Pause
(0127)  CS-0x06D  0x08260         ||               BRN Four_Down		
(0128)                            || 
(0129)  CS-0x06E  0x36101  0x06E  || Pause:        MOV R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
(0130)  CS-0x06F  0x2C101  0x06F  || outside_for:  SUB R1, 0x01
(0131)  CS-0x070  0x36201         ||               MOV R2, MIDDLE_FOR_COUNT	 ;set middle for loop count
(0132)  CS-0x071  0x2C201  0x071  || middle_for:   SUB R2, 0x01
(0133)  CS-0x072  0x36301         ||               MOV R3, INSIDE_FOR_COUNT   ;set inside for loop count
(0134)  CS-0x073  0x2C301  0x073  || inside_for:   SUB R3, 0x01
(0135)  CS-0x074  0x0839B         ||               BRNE inside_for
(0136)  CS-0x075  0x22200         ||               OR R2, 0x00           ;load flags for middle for counter
(0137)  CS-0x076  0x0838B         ||               BRNE middle_for
(0138)  CS-0x077  0x22100         ||               OR R1, 0x00           ;load flags for outsde for counter value
(0139)  CS-0x078  0x0837B         ||               BRNE outside_for
(0140)  CS-0x079  0x18002         ||               RET
(0141)                            || 
(0142)                            || ;--------------------------------------------------------------------
(0143)                            || .CSEG
(0144)                       202  || .ORG   0xCA
(0145)                            || 
(0146)  CS-0x0CA  0x22A01  0x0CA  || Check_Zero:   OR R10, B0_MASK
(0147)  CS-0x0CB  0x34A40         ||               OUT R10, LED_PORT
(0148)  CS-0x0CC  0x08371         ||               CALL Pause
(0149)  CS-0x0CD  0x08218         ||               BRN Zero_down;
RT





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
CHECK_FOUR     0x06A   (0124)  ||  0083 
CHECK_ONE      0x05E   (0109)  ||  0076 
CHECK_THREE    0x066   (0119)  ||  0080 
CHECK_TWO      0x062   (0114)  ||  0078 
CHECK_ZERO     0x0CA   (0146)  ||  
FIVE_DOWN      0x055   (0093)  ||  
FOUR_DOWN      0x04C   (0084)  ||  0127 
INSIDE_FOR     0x073   (0134)  ||  0135 
MAIN           0x040   (0072)  ||  
MIDDLE_FOR     0x071   (0132)  ||  0137 
ONE_DOWN       0x045   (0077)  ||  0112 
OUTSIDE_FOR    0x06F   (0130)  ||  0139 
PAUSE          0x06E   (0129)  ||  0092 0100 0111 0116 0121 0126 0148 
SIX_DOWN       0x05D   (0101)  ||  0101 
THREE_DOWN     0x049   (0081)  ||  0122 
TWO_DOWN       0x047   (0079)  ||  0117 
ZERO_DOWN      0x043   (0075)  ||  0149 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
B0_MASK        0x001   (0043)  ||  0146 
B1_MASK        0x002   (0044)  ||  0109 
B2_MASK        0x004   (0045)  ||  0114 
B3_MASK        0x008   (0046)  ||  0119 
B4_MASK        0x010   (0047)  ||  0124 
B5_MASK        0x020   (0048)  ||  0089 
B6_MASK        0x040   (0049)  ||  
B7_MASK        0x080   (0050)  ||  
BTN_PORT       0x0FF   (0036)  ||  
INSIDE_FOR_COUNT 0x001   (0052)  ||  0133 
LED_PORT       0x040   (0035)  ||  0091 0099 0110 0115 0120 0125 0147 
MIDDLE_FOR_COUNT 0x001   (0053)  ||  0131 
OUTSIDE_FOR_COUNT 0x001   (0054)  ||  0129 
SWITCH_PORT    0x020   (0034)  ||  


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
