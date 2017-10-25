

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


(0001)                            || ;------------------------------------------------------------------------------------------------------
(0002)                       064  || .EQU LED_PORT		=   	0X40		;port for LED outputs
(0003)                       032  || .EQU SWITCH_PORT	=   	0X20		;port for switch inputs
(0004)                            || ;------------------------------------------------------------------------------------------------------
(0005)                            || 
(0006)                            || ;------------------------------------------------------------------------------------------------------
(0007)                            || ; - Other Constants
(0008)                            || ;------------------------------------------------------------------------------------------------------
(0009)                       001  || .EQU BIT_0_MASK = 0X01
(0010)                       002  || .EQU BIT_1_MASK = 0X02
(0011)                       004  || .EQU BIT_2_MASK = 0X04
(0012)                       008  || .EQU BIT_3_MASK = 0X08
(0013)                       016  || .EQU BIT_4_MASK = 0X10
(0014)                       032  || .EQU BIT_5_MASK = 0X20
(0015)                       064  || .EQU BIT_6_MASK = 0X40
(0016)                       128  || .EQU BIT_7_MASK = 0X80
(0017)                            || 
(0018)                       001  || .EQU INSIDE_FOR_COUNT    = 1;0xB4
(0019)                       001  || .EQU MIDDLE_FOR_COUNT    = 1;0xCA
(0020)                       001  || .EQU OUTSIDE_FOR_COUNT   = 1;0xAA
(0021)                            || 
(0022)                            || ;------------------------------------------------------------------------------------------------------
(0023)                            || 
(0024)                            || ;------------------------------------------------------------------------------------------------------
(0025)                            || ; - Memory Designation Constants
(0026)                            || ;------------------------------------------------------------------------------------------------------
(0027)                            || ;- .DESG
(0028)                            || ;- .ORG	0x00
(0029)                            || ;------------------------------------------------------------------------------------------------------
(0030)                            || 
(0031)                            || ;------------------------------------------------------------------------------------------------------
(0032)                            || ;- Main Program - FIVE DIFFERENT TEST CASES
(0033)                            || ;------------------------------------------------------------------------------------------------------
(0034)                            || 
(0035)                            || .CSEG
(0036)                       048  || .ORG		0x30
(0037)                            || 
(0038)  CS-0x030  0x37400  0x030  || INIT:		MOV 	R20,	0x00	;output register
(0039)  CS-0x031  0x36A00         || 			MOV 	R10, 	0x00	;used to set carry flag
(0040)  CS-0x032  0x36B01         || 			MOV 	R11, 	0x01	;used to set carry flag
(0041)  CS-0x033  0x3610F         || 			MOV 	R1, 	0x0F	;used for logic operations
(0042)  CS-0x034  0x362AA         || 			MOV 	R2, 	0xAA	;used for logic operations
(0043)                            || 
(0044)                            || ;---------------------------------------------------------------
(0045)  CS-0x035  0x37101  0x035  || timedelay0:    	MOV     R17, OUTSIDE_FOR_COUNT  
(0046)  CS-0x036  0x2D101  0x036  || outside_for0: 	SUB     R17, 0x01
(0047)                            || 
(0048)  CS-0x037  0x37201         ||              	MOV     R18, MIDDLE_FOR_COUNT   
(0049)  CS-0x038  0x2D201  0x038  || middle_for0:  	SUB     R18, 0x01
(0050)                            ||              
(0051)  CS-0x039  0x37301         ||              	MOV     R19, INSIDE_FOR_COUNT   
(0052)  CS-0x03A  0x2D301  0x03A  || inside_for0:  	SUB     R19, 0x01
(0053)  CS-0x03B  0x081D3         ||              	BRNE    inside_for0
(0054)                            ||              
(0055)  CS-0x03C  0x23200         ||              	OR      R18, 0x00              
(0056)  CS-0x03D  0x081C3         ||              	BRNE    middle_for0
(0057)                            ||              
(0058)  CS-0x03E  0x23100         ||              	OR      R17, 0x00               
(0059)  CS-0x03F  0x081B3         ||              	BRNE    outside_for0
(0060)                            || 
(0061)                            || ;---------------------------------------------------------------
(0062)  CS-0x040  0x04309  0x040  || ANDTest: 		MOV 	R3, R1
(0063)  CS-0x041  0x00310         || 			AND 	R3, R2
(0064)  CS-0x042  0x3030A         || 			CMP 	R3, 0x0A
(0065)  CS-0x043  0x08233         || 			BRNE 	timedelay1
(0066)                            || 
(0067)  CS-0x044  0x23401         || 			OR 	R20,  BIT_0_MASK  ; sets r20 to 1
(0068)  CS-0x045  0x35440         || 			OUT 	R20, LED_PORT ;sends 1 to LED_PORT
(0069)                            || 
(0070)                            || 
(0071)  CS-0x046  0x37101  0x046  || timedelay1:    	MOV     R17, OUTSIDE_FOR_COUNT  
(0072)  CS-0x047  0x2D101  0x047  || outside_for1: 	SUB     R17, 0x01
(0073)                            || 
(0074)  CS-0x048  0x37201         ||              	MOV     R18, MIDDLE_FOR_COUNT   
(0075)  CS-0x049  0x2D201  0x049  || middle_for1:  	SUB     R18, 0x01
(0076)                            ||              
(0077)  CS-0x04A  0x37301         ||              	MOV     R19, INSIDE_FOR_COUNT   
(0078)  CS-0x04B  0x2D301  0x04B  || inside_for1:  	SUB     R19, 0x01
(0079)  CS-0x04C  0x0825B         ||              	BRNE    inside_for1
(0080)                            ||              
(0081)  CS-0x04D  0x23200         ||              	OR      R18, 0x00              
(0082)  CS-0x04E  0x0824B         ||              	BRNE    middle_for1
(0083)                            ||              
(0084)  CS-0x04F  0x23100         ||              	OR      R17, 0x00               
(0085)  CS-0x050  0x0823B         ||              	BRNE    outside_for1
(0086)                            || 
(0087)                            || ;---------------------------------------------------------------
(0088)  CS-0x051  0x04409  0x051  || ORTest:			MOV 	R4, R1; puts 0f in r4
(0089)  CS-0x052  0x00411         || 			OR 	R4, R2 ;compares 0f and aa
(0090)  CS-0x053  0x304AF         || 			CMP 	R4, 0XAF
(0091)  CS-0x054  0x082BB         || 			BRNE 	timedelay2
(0092)                            || 
(0093)  CS-0x055  0x23402         || 			OR 	R20, BIT_1_MASK		;
(0094)  CS-0x056  0x35440         || 			OUT 	R20, LED_PORT
(0095)                            || 
(0096)  CS-0x057  0x37101  0x057  || timedelay2:    	MOV     R17, OUTSIDE_FOR_COUNT  
(0097)  CS-0x058  0x2D101  0x058  || outside_for2: 	SUB     R17, 0x01
(0098)                            || 
(0099)  CS-0x059  0x37201         ||              	MOV     R18, MIDDLE_FOR_COUNT   
(0100)  CS-0x05A  0x2D201  0x05A  || middle_for2:  	SUB     R18, 0x01
(0101)                            ||              
(0102)  CS-0x05B  0x37301         ||              	MOV     R19, INSIDE_FOR_COUNT   
(0103)  CS-0x05C  0x2D301  0x05C  || inside_for2:  	SUB     R19, 0x01
(0104)  CS-0x05D  0x082E3         ||              	BRNE    inside_for2
(0105)                            ||              
(0106)  CS-0x05E  0x23200         ||              	OR      R18, 0x00              
(0107)  CS-0x05F  0x082D3         ||              	BRNE    middle_for2
(0108)                            ||              
(0109)  CS-0x060  0x23100         ||              	OR      R17, 0x00               
(0110)  CS-0x061  0x082C3         ||              	BRNE    outside_for2
(0111)                            || 
(0112)                            || ;---------------------------------------------------------------
(0113)  CS-0x062  0x04509  0x062  || EXORTest:		MOV 	R5, R1
(0114)  CS-0x063  0x00512         || 			EXOR 	R5, R2
(0115)  CS-0x064  0x305A5         || 			CMP 	R5, 0XA5
(0116)  CS-0x065  0x08343         || 			BRNE 	timedelay3
(0117)                            || 
(0118)  CS-0x066  0x23404         || 			OR 	R20,  BIT_2_MASK
(0119)  CS-0x067  0x35440         || 			OUT 	R20, LED_PORT
(0120)                            || 
(0121)  CS-0x068  0x37101  0x068  || timedelay3:    	MOV     R17, OUTSIDE_FOR_COUNT  
(0122)  CS-0x069  0x2D101  0x069  || outside_for3: 	SUB     R17, 0x01
(0123)                            || 
(0124)  CS-0x06A  0x37201         ||              	MOV     R18, MIDDLE_FOR_COUNT   
(0125)  CS-0x06B  0x2D201  0x06B  || middle_for3:  	SUB     R18, 0x01
(0126)                            ||              
(0127)  CS-0x06C  0x37301         ||              	MOV     R19, INSIDE_FOR_COUNT   
(0128)  CS-0x06D  0x2D301  0x06D  || inside_for3:  	SUB     R19, 0x01
(0129)  CS-0x06E  0x0836B         ||              	BRNE    inside_for3
(0130)                            ||              
(0131)  CS-0x06F  0x23200         ||              	OR      R18, 0x00              
(0132)  CS-0x070  0x0835B         ||              	BRNE    middle_for3
(0133)                            ||              
(0134)  CS-0x071  0x23100         ||              	OR      R17, 0x00               
(0135)  CS-0x072  0x0834B         ||              	BRNE    outside_for3
(0136)                            || 
(0137)                            || ;---------------------------------------------------------------
(0138)  CS-0x073  0x04609  0x073  || LSLTest:		MOV 	R6, R1
(0139)  CS-0x074  0x04A58         || 			CMP	R10, R11
(0140)  CS-0x075  0x10600         || 			LSL 	R6
(0141)  CS-0x076  0x3061F         || 			CMP 	R6, 0X1F
(0142)  CS-0x077  0x083D3         || 			BRNE 	timedelay4
(0143)                            || 
(0144)  CS-0x078  0x23408         || 			OR 	R20,  BIT_3_MASK
(0145)  CS-0x079  0x35440         || 			OUT 	R20, LED_PORT
(0146)                            || 
(0147)  CS-0x07A  0x37101  0x07A  || timedelay4:    	MOV     R17, OUTSIDE_FOR_COUNT  
(0148)  CS-0x07B  0x2D101  0x07B  || outside_for4: 	SUB     R17, 0x01
(0149)                            || 
(0150)  CS-0x07C  0x37201         ||              	MOV     R18, MIDDLE_FOR_COUNT   
(0151)  CS-0x07D  0x2D201  0x07D  || middle_for4:  	SUB     R18, 0x01
(0152)                            ||              
(0153)  CS-0x07E  0x37301         ||              	MOV     R19, INSIDE_FOR_COUNT   
(0154)  CS-0x07F  0x2D301  0x07F  || inside_for4:  	SUB     R19, 0x01
(0155)  CS-0x080  0x083FB         ||              	BRNE    inside_for4
(0156)                            ||              
(0157)  CS-0x081  0x23200         ||              	OR      R18, 0x00              
(0158)  CS-0x082  0x083EB         ||              	BRNE    middle_for4
(0159)                            ||              
(0160)  CS-0x083  0x23100         ||              	OR      R17, 0x00               
(0161)  CS-0x084  0x083DB         ||              	BRNE    outside_for4
(0162)                            || 
(0163)                            || ;---------------------------------------------------------------
(0164)  CS-0x085  0x04709  0x085  || LSRTest:		MOV 	R7, R1
(0165)  CS-0x086  0x04A58         || 			CMP	R10, R11
(0166)  CS-0x087  0x10701         || 			LSR 	R7
(0167)  CS-0x088  0x30787         || 			CMP 	R7, 0X87
(0168)  CS-0x089  0x08463         || 			BRNE 	timedelay5
(0169)                            || 
(0170)  CS-0x08A  0x23410         || 			OR 	R20,  BIT_4_MASK
(0171)  CS-0x08B  0x35440         || 			OUT 	R20, LED_PORT
(0172)                            || 
(0173)  CS-0x08C  0x37101  0x08C  || timedelay5:    	MOV     R17, OUTSIDE_FOR_COUNT  
(0174)  CS-0x08D  0x2D101  0x08D  || outside_for5: 	SUB     R17, 0x01
(0175)                            || 
(0176)  CS-0x08E  0x37201         ||              	MOV     R18, MIDDLE_FOR_COUNT   
(0177)  CS-0x08F  0x2D201  0x08F  || middle_for5:  	SUB     R18, 0x01
(0178)                            ||              
(0179)  CS-0x090  0x37301         ||              	MOV     R19, INSIDE_FOR_COUNT   
(0180)  CS-0x091  0x2D301  0x091  || inside_for5:  	SUB     R19, 0x01
(0181)  CS-0x092  0x0848B         ||              	BRNE    inside_for5
(0182)                            ||              
(0183)  CS-0x093  0x23200         ||              	OR      R18, 0x00              
(0184)  CS-0x094  0x0847B         ||              	BRNE    middle_for5
(0185)                            ||              
(0186)  CS-0x095  0x23100         ||              	OR      R17, 0x00               
(0187)  CS-0x096  0x0846B         ||              	BRNE    outside_for5
(0188)                            || 
(0189)                            || ;---------------------------------------------------------------
(0190)                            || ;LightLEDs:		OR	R20, 0xE0
(0191)                            || ;				OUT R20, LED_PORT
(0192)                            || 
(0193)                            || ;---------------------------------------------------------------
(0194)  CS-0x097  0x37F00  0x097  || endless_loop:	MOV R31, 0x00
(0195)  CS-0x098  0x084B8         || 				BRN	endless_loop
(0196)                            || 		
	BRN	endless_loop
(0197)  CS-0x099  0x084B8         || 		
	BRN	endless_loop





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
ANDTEST        0x040   (0062)  ||  
ENDLESS_LOOP   0x097   (0194)  ||  0195 0197 
EXORTEST       0x062   (0113)  ||  
INIT           0x030   (0038)  ||  
INSIDE_FOR0    0x03A   (0052)  ||  0053 
INSIDE_FOR1    0x04B   (0078)  ||  0079 
INSIDE_FOR2    0x05C   (0103)  ||  0104 
INSIDE_FOR3    0x06D   (0128)  ||  0129 
INSIDE_FOR4    0x07F   (0154)  ||  0155 
INSIDE_FOR5    0x091   (0180)  ||  0181 
LSLTEST        0x073   (0138)  ||  
LSRTEST        0x085   (0164)  ||  
MIDDLE_FOR0    0x038   (0049)  ||  0056 
MIDDLE_FOR1    0x049   (0075)  ||  0082 
MIDDLE_FOR2    0x05A   (0100)  ||  0107 
MIDDLE_FOR3    0x06B   (0125)  ||  0132 
MIDDLE_FOR4    0x07D   (0151)  ||  0158 
MIDDLE_FOR5    0x08F   (0177)  ||  0184 
ORTEST         0x051   (0088)  ||  
OUTSIDE_FOR0   0x036   (0046)  ||  0059 
OUTSIDE_FOR1   0x047   (0072)  ||  0085 
OUTSIDE_FOR2   0x058   (0097)  ||  0110 
OUTSIDE_FOR3   0x069   (0122)  ||  0135 
OUTSIDE_FOR4   0x07B   (0148)  ||  0161 
OUTSIDE_FOR5   0x08D   (0174)  ||  0187 
TIMEDELAY0     0x035   (0045)  ||  
TIMEDELAY1     0x046   (0071)  ||  0065 
TIMEDELAY2     0x057   (0096)  ||  0091 
TIMEDELAY3     0x068   (0121)  ||  0116 
TIMEDELAY4     0x07A   (0147)  ||  0142 
TIMEDELAY5     0x08C   (0173)  ||  0168 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BIT_0_MASK     0x001   (0009)  ||  0067 
BIT_1_MASK     0x002   (0010)  ||  0093 
BIT_2_MASK     0x004   (0011)  ||  0118 
BIT_3_MASK     0x008   (0012)  ||  0144 
BIT_4_MASK     0x010   (0013)  ||  0170 
BIT_5_MASK     0x020   (0014)  ||  
BIT_6_MASK     0x040   (0015)  ||  
BIT_7_MASK     0x080   (0016)  ||  
INSIDE_FOR_COUNT 0x001   (0018)  ||  0051 0077 0102 0127 0153 0179 
LED_PORT       0x040   (0002)  ||  0068 0094 0119 0145 0171 
MIDDLE_FOR_COUNT 0x001   (0019)  ||  0048 0074 0099 0124 0150 0176 
OUTSIDE_FOR_COUNT 0x001   (0020)  ||  0045 0071 0096 0121 0147 0173 
SWITCH_PORT    0x020   (0003)  ||  


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
