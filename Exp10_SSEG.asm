; **************************************************************************************
; Updated on 2-23-2016
; This program tests the SEI, CLI, RETIE, and RETID instructions and uses OUT, MOV, 
; ADD, SUB, AND, OR, CMP, BRN, and BRNE.
;
; How you initiate the inturrupt is up to the user.
; 
; LED7 is used to indicate of interrupts are enabled.  The program cycles between
; interrupts being enabled and not, with LED7 flashing on and off.  LED3 downto LED0 
; serve as a counter to count interrupts generated.
;
; Normal program operation is to watch LED7, generate interrupts when LED7 is
; illuminated, and see those interrupts counted in binary on the bottom four LEDs.  
; once the 16th interrupt (interrupt 0x10) is received, interrupts will be disabled
; for the rest of the program and LD6 will come on in addition to the count of 16 
; interrupts.
; **************************************************************************************


.DSEG
.ORG 0x00

.equ loop_count = 0xFF     ; extend the loop count
.equ SSEG_CNTR_ID = 0x60
.equ SSEG_VAL_ID  = 0x80



.CSEG
.ORG 0x10


SEI
MOV R1,0x00   ;R1 is used to count interrupts and drive the LEDs
;MOV R2,0x00   ;Set flag to allow interrupts to be enabled
MOV R2, 0x81
OUT R2, SSEG_CNTR_ID
OUT  R1, SSEG_VAL_ID


              ;illuminate LD7 when interrupts are on
MAIN:        
	          ;OR   R1, 0x80         ;illuminate LD7
	          ;OUT  R1, SSEG_VAL_ID
	          MOV  R11, loop_count  ;set outside for loop count
	          BRN  FOR

              ;LD7 is off when interrutps are disabled
BACK1:        
			  
	          MOV  R11, loop_count  ;set outside for loop count
              BRN FOR2
              BRN MAIN

FOR:
outside_for1: SUB     R11, 0x01
              MOV     R12, loop_count   ;set middle for loop count
middle_for1:  SUB     R12, 0x01
             
              MOV     R13, loop_count   ;set inside for loop count
inside_for1:  SUB     R13, 0x01
              
              MOV     R31,0xFF          ;empty instructions to slow things down
	          MOV     R31,0xFF          ;when interrupts are enabled to allow
              MOV     R31,0xFF          ;button presses
              MOV     R31,0xFF
              MOV     R31,0xFF
              MOV     R31,0xFF

              BRNE    inside_for1
             
              OR      R12, 0x00         ;load flags for middle for counter
              BRNE    middle_for1
             
              OR      R11, 0x00         ;load flags for outsde for counter value
              BRNE    outside_for1
BRN BACK1

FOR2:
outside_for: SUB     R11, 0x01
             MOV     R12, loop_count   ;set middle for loop count
middle_for:  SUB     R12, 0x01
             
             MOV     R13, loop_count   ;set inside for loop count
inside_for:  SUB     R13, 0x01
             BRNE    inside_for
             
             OR      R12, 0x00         ;load flags for middle for counter
             BRNE    middle_for
             
             OR      R11, 0x00         ;load flags for outsde for counter value
             BRNE    outside_for
             BRN MAIN

ISR:         ADD  R1,0x01              ;the botton 7 LEDs will should increment
                                       ;Note that 0x80 + 0x10 = 0x90, which means interrupts 
                                       ;are enabled and the 16th interrupt was counted
                                       ;so it is time to quite interrupts.
                                     
             
	         OUT  R1, SSEG_VAL_ID      ;everytime an interrupt is received.
	         RETIE


DONE:        BRN DONE                  ;ALL DONE, NO MORE INTERRUPTS!

.CSEG
.ORG 0x3FF
VECTOR:      BRN ISR

