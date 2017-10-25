;- Programmers: Abesh Mubaraki and Vince Jison
;- Date: 26 Feb 2011
;- Version: 1a
;--------------------------------------------------------------------
;-######## Case #3 - BRN, BREQ, BRNE, BRCS, BRCC, CLC, SEC ########-;
;--------------------------------------------------------------------
;-
;- Version 1a update: TABs were removed and replaced with spaces
;- 
;- 
;- This test case switches on the LEDs on the Nexys2 from right to 
;- left (LD0 to LD7) for each successful test.
;- There is about half a second delay in between each test.
;- The correspondence between the test and LEDs is as follows:
;- 	BRN	LD0
;- 	BREQ	LD1
;- 	BRNE	LD2
;- 	BRCS	LD3
;- 	BRCC	LD4
;- 	CLC	LD5
;- 	SEC	LD6 and LD7
;- 
;- Some other operations that are used in this test case are
;- 	ADD	CALL	EXOR	LSR	MOV	OUT	OR
;- 	RET	SUB
;- 
;- LEDs must turn on from 0 to 7 to indicate a successful test.
;- 
;--------------------------------------------------------------------

;--------------------------------------------------------------------
;- Port Constants
;--------------------------------------------------------------------
.EQU SWITCH_PORT = 0x20       ; port for switches ----- INPUT
.EQU LED_PORT    = 0x40         ; port for LED output --- OUTOUT
.EQU BTN_PORT    = 0xFF         ; port for button input - INPUT
;--------------------------------------------------------------------

;--------------------------------------------------------------------
;- Misc Constants
;--------------------------------------------------------------------

.EQU B0_MASK = 0x01             ; mask all but bit0
.EQU B1_MASK = 0x02             ; mask all but bit1
.EQU B2_MASK = 0x04             ; mask all but bit2
.EQU B3_MASK = 0x08             ; mask all but bit3
.EQU B4_MASK = 0x10             ; mask all but bit4
.EQU B5_MASK = 0x20             ; mask all but bit5
.EQU B6_MASK = 0x40             ; mask all but bit6
.EQU B7_MASK = 0x80             ; mask all but bit7
 
.EQU INSIDE_FOR_COUNT  = 1;0xFF   ; These three contestants set the 
.EQU MIDDLE_FOR_COUNT  = 1;0xFF   ; amount of delay between each test.
.EQU OUTSIDE_FOR_COUNT = 1;0x60   ; Current time delay is about 503 mS.
;- 	Setting the last constant to FF will give a 1.3 sec delay.

;--------------------------------------------------------------------    

;--------------------------------------------------------------------

.DSEG
.ORG   0x00

;--------------------------------------------------------------------

;--------------------------------------------------------------------

.CSEG
.ORG   0x40


Main:         MOV R10, 0x00             ; R10 used to outputs to LEDs
              MOV R11, 0x00             ; 
              BRN 0xCA                  ; 
Zero_Down:    ADD R11, 0x00             ; Zero flag set
              BREQ Check_One            ; 
One_Down:     ADD R11, 0x01             ; Zero flag cleared
              BRNE Check_Two            ; 
Two_Down:     ADD R11, 0xFF             ; Carry flag set
              BRCS Check_Three          ; 
Three_Down:   MOV R11, 0x00             ; 
              ADD R11, 0x01             ; Carry flag cleared
              BRCC Check_Four           ;
Four_Down:    ADD R11, 0xFF             ; Carry flag set & R1 = 0x00
              CLC                       ; Carry flag cleared
              LSR R11                   ; Moving the C value in
              LSR R11                   ; 	proper location to
              LSR R11                   ; 	test it.
              EXOR R11, B5_MASK         ; 
              EXOR R10, R11             ; Entering the test result 
              OUT R10, LED_PORT         ; 	to R10
              CALL Pause                ; 
Five_down:    MOV R11, 0x00             ;		
              SEC                       ;
              LSR R11                   ; 
              EXOR R10, R11             ; 
              LSR R11                   ; 
              EXOR R10, R11             ; 
              OUT R10, LED_PORT         ; 
              CALL Pause                ; 
Six_down:     Brn Six_down                 ; 
                                        ; 
                                        ;<-Code dies when it crosses 
                                        ;	this border 
                                        ; 
                                        ; Step aside Janet Napolitano 
;--------------------------------------------------------------------

Check_One:    OR R10, B1_MASK
              OUT R10, LED_PORT
              CALL Pause
              BRN One_Down		
                
Check_Two:    OR R10, B2_MASK
              OUT R10, LED_PORT 
              CALL Pause
              BRN Two_Down
              
Check_Three:  OR R10, B3_MASK
              OUT R10, LED_PORT
              CALL Pause
              BRN Three_Down

Check_Four:   OR R10, B4_MASK
              OUT R10, LED_PORT
              CALL Pause
              BRN Four_Down		

Pause:        MOV R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
outside_for:  SUB R1, 0x01
              MOV R2, MIDDLE_FOR_COUNT	 ;set middle for loop count
middle_for:   SUB R2, 0x01
              MOV R3, INSIDE_FOR_COUNT   ;set inside for loop count
inside_for:   SUB R3, 0x01
              BRNE inside_for
              OR R2, 0x00           ;load flags for middle for counter
              BRNE middle_for
              OR R1, 0x00           ;load flags for outsde for counter value
              BRNE outside_for
              RET

;--------------------------------------------------------------------
.CSEG
.ORG   0xCA

Check_Zero:   OR R10, B0_MASK
              OUT R10, LED_PORT
              CALL Pause
              BRN Zero_down;