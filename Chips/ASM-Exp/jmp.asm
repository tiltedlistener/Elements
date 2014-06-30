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
	0;JMP