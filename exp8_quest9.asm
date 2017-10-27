
.EQU Ram_Memory = 255			; Sets the count initializer to 255

.CSEG
.ORG 0x40

main: MOV  R30, Ram_Memory		; Uses R30 as a counter with starting value 255
	  MOV  R8,  0xFF			; Sets R8 to 0xFF (which is the value all the ram will be initialized to)
	  MOV  R5,  0xFF			; Sets R5 to -1 / 0xFF

Loop: PUSH R8					; Puts 0xFF to the stack (scratch ram)

	  SUB  R30, 0x01			; Decrements the counter
	  CMP  R30, R5				; Compares the counter with R5 (-1 / 0xFF) to see if the counter has finished
	  BRNE Loop					; Loops until the counter hits -1
	

