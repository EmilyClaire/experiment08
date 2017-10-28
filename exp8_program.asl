

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


(0001)                            || 
(0002)                       064  || .EQU LED_PORT	= 0x40	  ;Output LED port		
(0003)                       255  || .EQU time_INSIDE_FOR_COUNT    = 0xFF
(0004)                       255  || .EQU time_MIDDLE_FOR_COUNT    = 0xFF
(0005)                       255  || .EQU time_OUTSIDE_FOR_COUNT   = 0xFF
(0006)                            || 		
(0007)                            || 					
(0008)                            || 
(0009)                            || .CSEG					  ;Code segment starts at address 0x40
(0010)                       064  || .ORG	0x40				
(0011)                            || 
(0012)                            || 
(0013)                            || 
(0014)                            || 
(0015)                            || 
(0016)  CS-0x040  0x08289  0x040  || main: CALL pause
(0017)  CS-0x041  0x36505         || 	  MOV  R5, 0x05       ;Moves 5 into register 5
(0018)  CS-0x042  0x12501         || 	  PUSH R5             ;Pushes the value of R5 into memory address 0xFF
(0019)  CS-0x043  0x386FF         || 	  LD   R6, 0xFF       ;Loads the value at address into R6
(0020)  CS-0x044  0x04530         || 	  CMP  R5, R6         ;Compares R5 and R6
(0021)  CS-0x045  0x082EB         || 	  BRNE fail           ;If R5 and R6 are not the same then branches to fail
(0022)                            || 
(0023)  CS-0x046  0x36704         || 	  MOV  R7, 0x04       ;Moves 4 into R7
(0024)  CS-0x047  0x3A7FF         || 	  ST   R7, 0xFF       ;Stores the value of R7 into memory address 0xFF
(0025)  CS-0x048  0x12802         || 	  POP  R8             ;Pops the value at address 0xFF off of the stack and into R7
(0026)  CS-0x049  0x04740         || 	  CMP  R7, R8         ;Compares R7 and R8
(0027)  CS-0x04A  0x082EB         || 	  BRNE fail           ;If R7 and R8 are not the same then branches to fail
(0028)                            || 
(0029)  CS-0x04B  0x36101         || 	  MOV R1, 0x01        ;Sets R1 to 0x01
(0030)  CS-0x04C  0x34140         ||       OUT  R1, LED_PORT   ;If the code hasn't branched to fail, lights an LED 
(0031)  CS-0x04D  0x08289         || 	  CALL pause
(0032)  CS-0x04E  0x36100         || 	  MOV R1, 0x00
(0033)  CS-0x04F  0x34140         ||       OUT  R1, LED_PORT
(0034)  CS-0x050  0x08200         || 	  BRN main
(0035)                            || 
(0036)  CS-0x051  0x37DFF  0x051  || pause:	     MOV     R29, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
(0037)  CS-0x052  0x2DD01  0x052  || outside_for: SUB     R29, 0x01
(0038)                            || 
(0039)  CS-0x053  0x37CFF         || 			 MOV     R28, time_MIDDLE_FOR_COUNT   ;set middle for loop count
(0040)  CS-0x054  0x2DC01  0x054  || middle_for: SUB     R28, 0x01
(0041)                            || 			 
(0042)  CS-0x055  0x37BFF         || 			 MOV     R27, time_INSIDE_FOR_COUNT   ;set inside for loop count
(0043)  CS-0x056  0x2DB01  0x056  || inside_for: SUB     R27, 0x01
(0044)  CS-0x057  0x082B3         || 			 BRNE    inside_for
(0045)                            || 			 
(0046)  CS-0x058  0x23C00         || 			 OR      R28, 0x00               ;load flags for middle for counter
(0047)  CS-0x059  0x082A3         || 			 BRNE    middle_for
(0048)                            || 			 
(0049)  CS-0x05A  0x23D00         || 			 OR      R29, 0x00               ;load flags for outsde for counter value
(0050)  CS-0x05B  0x08293         || 			 BRNE    outside_for
(0051)  CS-0x05C  0x18002         || 			 RET
(0052)                            || 
(0053)                            || 
(0054)                            || 
(0055)                            || 	  
(0056)                            || 	  
(0057)                            || 	  
(0058)  CS-0x05D  0x08200  0x05D  || fail: BRN  main           ;Branches back to main
(0059)                            || 





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
FAIL           0x05D   (0058)  ||  0021 0027 
INSIDE_FOR     0x056   (0043)  ||  0044 
MAIN           0x040   (0016)  ||  0034 0058 
MIDDLE_FOR     0x054   (0040)  ||  0047 
OUTSIDE_FOR    0x052   (0037)  ||  0050 
PAUSE          0x051   (0036)  ||  0016 0031 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
LED_PORT       0x040   (0002)  ||  0030 0033 
TIME_INSIDE_FOR_COUNT 0x0FF   (0003)  ||  0042 
TIME_MIDDLE_FOR_COUNT 0x0FF   (0004)  ||  0039 
TIME_OUTSIDE_FOR_COUNT 0x0FF   (0005)  ||  0036 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
