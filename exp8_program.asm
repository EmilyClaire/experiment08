
.EQU LED_PORT	= 0x40	  ;Output LED port		
.EQU time_INSIDE_FOR_COUNT    = 0xFF
.EQU time_MIDDLE_FOR_COUNT    = 0xFF
.EQU time_OUTSIDE_FOR_COUNT   = 0xFF
		
					

.CSEG					  ;Code segment starts at address 0x40
.ORG	0x40				





main: CALL pause
	  MOV  R5, 0x05       ;Moves 5 into register 5
	  PUSH R5             ;Pushes the value of R5 into memory address 0xFF
	  LD   R6, 0xFF       ;Loads the value at address into R6
	  CMP  R5, R6         ;Compares R5 and R6
	  BRNE fail           ;If R5 and R6 are not the same then branches to fail

	  MOV  R7, 0x04       ;Moves 4 into R7
	  ST   R7, 0xFF       ;Stores the value of R7 into memory address 0xFF
	  POP  R8             ;Pops the value at address 0xFF off of the stack and into R7
	  CMP  R7, R8         ;Compares R7 and R8
	  BRNE fail           ;If R7 and R8 are not the same then branches to fail

	  MOV R1, 0x01        ;Sets R1 to 0x01
      OUT  R1, LED_PORT   ;If the code passes, lights an LED 
	  CALL pause          ;Runs the pause subroutine
	  MOV R1, 0x00        ;Sets R1 to 0x00
      OUT  R1, LED_PORT   ;Outputs a 0 to the LED, turns off the light
	  BRN main            ;Branches to main to repeat the process

pause:	     MOV     R29, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
outside_for: SUB     R29, 0x01

			 MOV     R28, time_MIDDLE_FOR_COUNT   ;set middle for loop count
middle_for: SUB     R28, 0x01
			 
			 MOV     R27, time_INSIDE_FOR_COUNT   ;set inside for loop count
inside_for: SUB     R27, 0x01
			 BRNE    inside_for
			 
			 OR      R28, 0x00               ;load flags for middle for counter
			 BRNE    middle_for
			 
			 OR      R29, 0x00               ;load flags for outsde for counter value
			 BRNE    outside_for
			 RET



	  
	  
	  
fail: BRN  main           ;Branches back to main

