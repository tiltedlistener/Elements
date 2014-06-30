// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/01/Not.tst

load Demultiplexor.hdl,
output-file Demultiplexor.out,
compare-to Demultiplexor.cmp,
output-list in%B3.1.3 sel%B3.1.3 a%B3.1.3 b%B3.1.3;

set in 0,
set sel 0,
eval,
output;

set in 0,
set sel 1,
eval,
output;

set in 1,
set sel 0,
eval,
output;

set in 1,
set sel 1,
eval,
output;