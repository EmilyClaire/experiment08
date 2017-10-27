
.EQU Ram_Memory = 255

.CSEG
.ORG 0x40

main: MOV R30, Ram_Memory
	Mov R8, 0x01

Loop: ST R8, (R30)

	

	SUB R30, 0x01
	MOV R5, 0xFF
	CMP R30, R5
	BRNE Loop
	


