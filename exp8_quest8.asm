
.EQU Ram_Memory = 255

.CSEG
.ORG 0x40

main: MOV  R30, Ram_Memory ;Moves the number of memory adddresses to register 30
	  MOV  R8,  0x00       ;Moves 0 into R8
	  MOV  R5,  0xFF       ;Moves 0xFF into register 5

Loop: ST   R8,  (R30)      ;Stores the current value of R30 into R8
	  SUB  R30, 0x01       ;Subtracts 1 from R30 to move to the next lowest memory address
	  CMP  R30, R5         ;Compares R5 and R30
	  BRNE Loop            ;Branches if not equal to loop
	


