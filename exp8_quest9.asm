
.EQU Ram_Memory = 255

.CSEG
.ORG 0x40

main: MOV  R30, Ram_Memory
	  MOV  R8,  0xFF

Loop: PUSH R8	

	  SUB  R30, 0x01
	  MOV  R5,  0xFF
	  CMP  R30, R5
	  BRNE Loop
	


