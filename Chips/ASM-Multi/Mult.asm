// File name: projects/04/Mult.asm
// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[3], respectively.)

// Sets A to be equal to Address one then stores that in D
// Then load the second value into M

	// Resets value to R2
	@2
	M = 0

(LOOP)
	@0
	D=M
	@END
	D;JEQ

	// Load up R1
	@1
	D=M

	@2
	M=M+D

	// Decrement and loop
	@0
	M=M-1
	@LOOP
	0;JMP
(END)
	@END
	0;JEQ