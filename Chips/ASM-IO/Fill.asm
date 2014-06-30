// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

(START)
@24576
D=M

@SETVALUE
D;JGT
@CLEARVALUE
0;JMP

// Setup to set value to 1
(SETVALUE)
@SCREEN
M=1
@START
0;JMP

// Clear value to zero
(CLEARVALUE)
@SCREEN
M=0
@START
0;JMP